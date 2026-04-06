package br.com.fiap.action.cart;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dao.WineDAO;
import br.com.fiap.dto.ApiResponse;
import br.com.fiap.dto.cart.CartItem;
import br.com.fiap.dto.cart.CartRequest;
import br.com.fiap.dto.cart.CartResponse;
import br.com.fiap.model.Wine;
import br.com.fiap.util.JsonUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.ArrayList;
import java.util.Objects;

/**
 * Action: Add Items to Shopping Cart
 * 
 * Purpose: Securely adds wine items to user's cart by validating against the catalog.
 * 
 * Security Model:
 * - Client sends ONLY wine ID + quantity (no prices, names, etc.)
 * - Server fetches authoritative wine data from database to prevent price tampering
 * - Cart items are merged/updated in memory before single database write
 * 
 * Flow:
 * 1. Parse JSON request (wine IDs + quantities)
 * 2. Load current cart from database
 * 3. For each incoming item:
 *    - If already in cart → increment quantity
 *    - If new → fetch full wine details from catalog, create lightweight cart version
 * 4. Persist updated cart
 * 5. Return success with complete cart state
 */
public class AddToCart implements Action {

    /**
     * Executes the add-to-cart workflow.
     * 
     * @param request  HTTP request containing JSON body: { items: [{ wine: { id }, quantity }] }
     * @param response HTTP response to write JSON result
     * @return null (JSON APIs don't forward to JSP; they write directly to response)
     * @throws Exception if database or JSON parsing fails
     */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // TEMPORARY: Hardcoded user email until session management is implemented
        // TODO: Extract from session: (String) request.getSession().getAttribute("userEmail")
        String email = "test@agnello.com";

        // Guard: Validate user identity exists
        if (email == null || email.trim().isEmpty()) {
            JsonUtil.sendJson(response, new ApiResponse("error", "User email is missing."), HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        // Parse incoming JSON request
        CartRequest payload = JsonUtil.fromJson(request, CartRequest.class);

        // Guard: Reject malformed or empty requests early
        if (payload == null || payload.items == null || payload.items.isEmpty()) {
            JsonUtil.sendJson(response, new ApiResponse("error", "A lista de itens está vazia ou o JSON é inválido."), HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        UserDAO userDAO = new UserDAO();
        WineDAO wineDAO = new WineDAO();

        // === CART MUTATION LOGIC ===

        // Step 1: Load current cart state from database
        List<CartItem> currentCart = userDAO.getCartItems(email);
        if (currentCart == null) currentCart = new ArrayList<>();

        // Step 2: Merge incoming items with existing cart
        for (CartItem incomingItem : payload.items) {

            // Guard: Skip malformed items from client (defense in depth)
            if (incomingItem.getWine() == null || incomingItem.getWine().getId() == null) {
                continue;
            }

            String incomingWineId = incomingItem.getWine().getId();
            boolean itemExists = false;

            // Check if wine is already in cart
            for (CartItem existingItem : currentCart) {
                if (Objects.equals(existingItem.getWine().getId(), incomingWineId)) {
                    // Business Rule: Item exists → add to quantity (don't duplicate)
                    // Existing wine data (price, name) is already trusted and stays unchanged
                    int newQtd = existingItem.getQuantity() + incomingItem.getQuantity();
                    existingItem.setQuantity(newQtd);

                    itemExists = true;
                    break;
                }
            }

            // Step 3: For new items, fetch authoritative wine details from catalog
            if (!itemExists) {
                // CRITICAL SECURITY: Never trust wine data from client
                // Fetch from database to prevent price/data tampering
                Wine realWineDetails = wineDAO.getWineById(incomingWineId);

                if (realWineDetails == null) {
                    JsonUtil.sendJson(response, new ApiResponse("error", "Vinho não encontrado no catálogo."), HttpServletResponse.SC_NOT_FOUND);
                    return null;
                }

                // Create lightweight Wine object for cart storage
                // Only include fields needed for cart/checkout (avoids bloat from reviews, pairings, etc.)
                // Unset fields remain null and are omitted from JSON serialization
                Wine cartWine = new Wine();
                cartWine.setId(realWineDetails.getId());
                cartWine.setName(realWineDetails.getName());
                cartWine.setCountry(realWineDetails.getCountry());
                cartWine.setRegion(realWineDetails.getRegion());
                cartWine.setPrice(realWineDetails.getPrice());
                cartWine.setImageURL(realWineDetails.getImageURL());

                // Attach validated wine data to cart item
                incomingItem.setWine(cartWine);

                currentCart.add(incomingItem);
            }
        }

        // Step 4: Persist updated cart to database (full replacement strategy)
        userDAO.updateCart(email, currentCart);

        // === END CART MUTATION ===

        // Return success with full updated cart state
        CartResponse apiResponse = new CartResponse("success", "Carrinho atualizado com sucesso!", currentCart);
        JsonUtil.sendJson(response, apiResponse);

        // Returning null signals: "Don't forward to JSP, JSON response already sent"
        return null;
    }
}