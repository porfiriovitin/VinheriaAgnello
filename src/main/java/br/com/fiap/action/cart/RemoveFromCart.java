package br.com.fiap.action.cart;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dto.ApiResponse;
import br.com.fiap.dto.cart.CartItem;
import br.com.fiap.dto.cart.CartRequest;
import br.com.fiap.dto.cart.CartResponse;
import br.com.fiap.util.JsonUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;

/**
 * Action: Remove Items from Shopping Cart
 * 
 * Purpose: Handles cart item removal/quantity reduction safely and atomically.
 * 
 * Flow:
 * 1. Parse JSON request (wine IDs + quantities to remove)
 * 2. Load current cart from database
 * 3. For each removal request:
 *    - Find matching item by wine ID
 *    - Reduce quantity by requested amount
 *    - If quantity ≤ 0 → remove item entirely
 * 4. Persist updated cart
 * 5. Return success with updated cart state
 * 
 * Edge Cases:
 * - Removing more than exists → item removed completely (no negative quantities)
 * - Removing non-existent item → silently ignored (idempotent behavior)
 */
public class RemoveFromCart implements Action {

    /**
     * Executes the remove-from-cart workflow.
     * 
     * @param request  HTTP request containing JSON: { items: [{ wine: { id }, quantity }] }
     * @param response HTTP response to write JSON result
     * @return null (JSON response written directly, no JSP forwarding)
     * @throws Exception if database access or JSON parsing fails
     */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // TEMPORARY: Hardcoded user email until session auth is implemented
        // TODO: Replace with session.getAttribute("userEmail")
        String email = "test@agnello.com";

        // Guard: Validate user identity
        if (email == null || email.trim().isEmpty()) {
            JsonUtil.sendJson(response, new ApiResponse("error", "User email is missing."), HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        // Parse removal request from JSON
        CartRequest payload = JsonUtil.fromJson(request, CartRequest.class);

        // Guard: Reject malformed/empty requests to maintain deterministic behavior
        if (payload == null || payload.items == null || payload.items.isEmpty()) {
            JsonUtil.sendJson(response, new ApiResponse("error", "A lista de itens está vazia ou o JSON é inválido."), HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        UserDAO userDAO = new UserDAO();

        // === CART REMOVAL LOGIC ===

        // Step 1: Load current cart state
        List<CartItem> currentCart = userDAO.getCartItems(email);
        if (currentCart == null) currentCart = new ArrayList<>();

        // Step 2: Process removals in memory
        for (CartItem itemToRemove : payload.items) {

            // Guard: Skip malformed removal requests (defense in depth)
            if (itemToRemove.getWine() == null || itemToRemove.getWine().getId() == null) {
                continue;
            }

            String incomingWineId = itemToRemove.getWine().getId();

            // IMPORTANT: Use Iterator to safely remove items during iteration
            // Using for-each + list.remove() would throw ConcurrentModificationException
            Iterator<CartItem> iterator = currentCart.iterator();

            while (iterator.hasNext()) {
                CartItem existingItem = iterator.next();

                // Match by wine ID (null-safe comparison)
                if (Objects.equals(existingItem.getWine().getId(), incomingWineId)) {

                    int newQtd = existingItem.getQuantity() - itemToRemove.getQuantity();

                    if (newQtd <= 0) {
                        // Business Rule: Quantity reached zero → remove item completely
                        // This handles both exact matches and over-removal gracefully
                        iterator.remove();
                    } else {
                        // Reduce quantity but keep item in cart
                        existingItem.setQuantity(newQtd);
                    }

                    // OPTIMIZATION: Stop after first match (wine IDs are unique in cart)
                    // Prevents accidental double-removal if cart somehow had duplicates
                    break;
                }
            }
        }

        // Step 3: Persist updated cart to database
        userDAO.updateCart(email, currentCart);

        // === END REMOVAL LOGIC ===

        // Return success with updated cart state
        CartResponse apiResponse = new CartResponse("success", "Itens removidos do carrinho com sucesso!", currentCart);
        JsonUtil.sendJson(response, apiResponse);

        // Returning null signals: "JSON response already sent, don't forward to JSP"
        return null;
    }
}