package br.com.fiap.action.cart;

import br.com.fiap.action.Action;
import br.com.fiap.dao.AccessoryDAO;
import br.com.fiap.dao.GiftDAO;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dao.WineDAO;
import br.com.fiap.dto.ApiResponse;
import br.com.fiap.dto.cart.Cart;
import br.com.fiap.dto.cart.CartAccessoryItem;
import br.com.fiap.dto.cart.CartRequest;
import br.com.fiap.dto.cart.CartResponse;
import br.com.fiap.dto.cart.CartWineItem;
import br.com.fiap.model.Accessory;
import br.com.fiap.model.Gift;
import br.com.fiap.model.Wine;
import br.com.fiap.util.JsonUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Adds items to the persisted cart using server-authoritative catalog data.
 *
 * <p>Security boundary: product identity comes from client, but product details and price are always
 * resolved from DAO/catalog to avoid payload tampering.</p>
 */
public class AddToCart implements Action {
    /**
     * Validates payload, merges cart lines, and persists the resulting cart atomically via UserDAO.updateCart.
     *
     * <p>Business rules:
     * 1. Wines are accumulative by id.
     * 2. Accessories allow at most one unit per id.
     * 3. Gifts are single-entry; if already present, only letter text is updated.</p>
     */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userEmail = (String) request.getSession().getAttribute("usuarioLogado");
        if (isBlank(userEmail)) {
            //JsonUtil.sendJson(response, new ApiResponse("error", "User email is missing."), HttpServletResponse.SC_BAD_REQUEST);
            response.sendRedirect("controller?action=ShowLogin");
            return null;
        }

        CartRequest payload = JsonUtil.fromJson(request, CartRequest.class);
        Cart incomingCartItems = payload != null ? payload.getCartItems() : null;
        if (incomingCartItems == null || !hasAnyIncomingItems(incomingCartItems)) {
            JsonUtil.sendJson(response, new ApiResponse("error", "A lista de itens está vazia ou o JSON é inválido."), HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        WineDAO wineDAO = new WineDAO();
        AccessoryDAO accessoryDAO = new AccessoryDAO();
        GiftDAO giftDAO = new GiftDAO();
        UserDAO userDAO = new UserDAO();
        Cart currentCart = userDAO.getCart(userEmail);
        if (currentCart == null) currentCart = new Cart();
        ensureCartLists(currentCart);

        if (!addValidatedWines(currentCart, incomingCartItems.getWines(), wineDAO, response)) return null;
        if (!addValidatedAccessories(currentCart, incomingCartItems.getAccessories(), accessoryDAO, response)) return null;
        if (!addAcceptedGift(currentCart, incomingCartItems.getGifts(), giftDAO, response)) return null;

        userDAO.updateCart(userEmail, currentCart);
        CartResponse apiResponse = new CartResponse("success", "Carrinho atualizado com sucesso!", userDAO.getCart(userEmail));
        JsonUtil.sendJson(response, apiResponse);
        return null;
    }

    private boolean addValidatedWines(
            Cart currentCart,
            List<CartWineItem> incomingWines,
            WineDAO wineDAO,
            HttpServletResponse response
    ) throws Exception {
        // Empty section is valid: endpoint supports partial cart updates.
        if (incomingWines == null || incomingWines.isEmpty()) return true;

        for (CartWineItem incomingWineItem : incomingWines) {
            if (incomingWineItem == null || isBlank(incomingWineItem.getId())) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Item de vinho inválido no payload."), HttpServletResponse.SC_BAD_REQUEST);
                return false;
            }

            int requestedQuantity = validateAddQuantity(incomingWineItem.getQuantity(), response, "Quantidade inválida para vinho.");
            if (requestedQuantity < 0) return false;

            String incomingWineId = incomingWineItem.getId().trim();
            CartWineItem existingItem = findWineItemById(currentCart, incomingWineId);
            if (existingItem != null) {
                // Existing line increments quantity instead of duplicating entries.
                existingItem.setQuantity(existingItem.getQuantity() + requestedQuantity);
            } else {
                Wine realWineDetails = wineDAO.getWineById(incomingWineId);
                if (realWineDetails == null) {
                    JsonUtil.sendJson(response, new ApiResponse("error", "Vinho não encontrado no catálogo."), HttpServletResponse.SC_NOT_FOUND);
                    return false;
                }

                // New lines are always materialized from trusted catalog data.
                CartWineItem cartWineItem = buildCartWineItem(realWineDetails);
                cartWineItem.setQuantity(requestedQuantity);
                currentCart.getWines().add(cartWineItem);
            }
        }

        return true;
    }

    private boolean addValidatedAccessories(
            Cart currentCart,
            List<CartAccessoryItem> incomingAccessories,
            AccessoryDAO accessoryDAO,
            HttpServletResponse response
    ) throws Exception {
        if (incomingAccessories == null || incomingAccessories.isEmpty()) return true;

        for (CartAccessoryItem incomingAccessoryItem : incomingAccessories) {
            if (incomingAccessoryItem == null || isBlank(incomingAccessoryItem.getId())) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Item de acessório inválido no payload."), HttpServletResponse.SC_BAD_REQUEST);
                return false;
            }

            String incomingAccessoryId = incomingAccessoryItem.getId().trim();
            CartAccessoryItem existingItem = findAccessoryItemById(currentCart, incomingAccessoryId);
            if (existingItem != null) {
                // Business rule: accessory quantity is capped at one per accessory id.
                existingItem.setQuantity(1);
            } else {
                Accessory realAccessory = accessoryDAO.getAccesoryById(incomingAccessoryId);
                if (realAccessory == null) {
                    JsonUtil.sendJson(response, new ApiResponse("error", "Acessório não encontrado no catálogo."), HttpServletResponse.SC_NOT_FOUND);
                    return false;
                }

                CartAccessoryItem cartAccessoryItem = buildCartAccessoryItem(realAccessory);
                cartAccessoryItem.setQuantity(1);
                currentCart.getAccessories().add(cartAccessoryItem);
            }
        }

        return true;
    }

    private boolean addAcceptedGift(
            Cart currentCart,
            List<Gift> incomingGifts,
            GiftDAO giftDAO,
            HttpServletResponse response
    ) throws Exception {
        if (incomingGifts == null || incomingGifts.isEmpty()) return true;
        if (hasGiftInCart(currentCart)) {
            // Gift text is user-authored content; allow editing without replacing the existing gift line.
            Gift incomingGift = getFirstIncomingGift(incomingGifts);
            if (incomingGift != null) {
                currentCart.getGifts().get(0).setLetterText(incomingGift.getLetterText());
            }
            return true;
        }

        for (Gift incomingGift : incomingGifts) {
            if (incomingGift == null || !Boolean.TRUE.equals(incomingGift.getApplied())) continue;

            if (isBlank(incomingGift.getId())) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Item de presente inválido no payload."), HttpServletResponse.SC_BAD_REQUEST);
                return false;
            }

            Gift catalogGift = giftDAO.getGiftById(incomingGift.getId().trim());
            if (catalogGift == null) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Presente não encontrado no catálogo."), HttpServletResponse.SC_NOT_FOUND);
                return false;
            }

            Gift cartGift = new Gift();
            cartGift.setId(catalogGift.getId());
            cartGift.setPrice(catalogGift.getPrice());
            cartGift.setApplied(true);
            cartGift.setLetterText(incomingGift.getLetterText());

            currentCart.getGifts().add(cartGift);
            return true;
        }
        return true;
    }

    private void ensureCartLists(Cart cart) {
        // Defensive normalization: avoids null checks across merge code.
        if (cart.getWines() == null) cart.setWines(new ArrayList<>());
        if (cart.getAccessories() == null) cart.setAccessories(new ArrayList<>());
        if (cart.getGifts() == null) cart.setGifts(new ArrayList<>());
    }

    private boolean hasAnyIncomingItems(Cart incomingCartItems) {
        return (incomingCartItems.getWines() != null && !incomingCartItems.getWines().isEmpty())
                || (incomingCartItems.getAccessories() != null && !incomingCartItems.getAccessories().isEmpty())
                || (incomingCartItems.getGifts() != null && !incomingCartItems.getGifts().isEmpty());
    }

    private CartWineItem findWineItemById(Cart currentCart, String incomingWineId) {
        for (CartWineItem existingItem : currentCart.getWines()) {
            if (Objects.equals(existingItem.getId(), incomingWineId)) {
                if (existingItem.getQuantity() == null || existingItem.getQuantity() < 1) {
                    existingItem.setQuantity(1);
                }
                return existingItem;
            }
        }
        return null;
    }

    private CartWineItem buildCartWineItem(Wine realWineDetails) {
        CartWineItem cartWineItem = new CartWineItem();
        cartWineItem.setId(realWineDetails.getId());
        cartWineItem.setName(realWineDetails.getName());
        cartWineItem.setCountry(realWineDetails.getCountry());
        cartWineItem.setRegion(realWineDetails.getRegion());
        cartWineItem.setPrice(realWineDetails.getPrice());
        cartWineItem.setImageUrl(realWineDetails.getImageURL());
        return cartWineItem;
    }

    private CartAccessoryItem findAccessoryItemById(Cart currentCart, String incomingAccessoryId) {
        for (CartAccessoryItem existingItem : currentCart.getAccessories()) {
            if (Objects.equals(existingItem.getId(), incomingAccessoryId)) {
                if (existingItem.getQuantity() == null || existingItem.getQuantity() < 1) {
                    existingItem.setQuantity(1);
                }
                return existingItem;
            }
        }
        return null;
    }

    private CartAccessoryItem buildCartAccessoryItem(Accessory realAccessory) {
        CartAccessoryItem cartAccessoryItem = new CartAccessoryItem();
        cartAccessoryItem.setId(realAccessory.getId());
        cartAccessoryItem.setName(realAccessory.getName());
        cartAccessoryItem.setImageURL(realAccessory.getImageURL());
        cartAccessoryItem.setPrice(realAccessory.getPrice());
        return cartAccessoryItem;
    }

    private int validateAddQuantity(Integer quantity, HttpServletResponse response, String errorMessage) throws Exception {
        // Missing quantity means "single add", matching existing frontend behavior.
        int requestedQuantity = quantity == null ? 1 : quantity;
        if (requestedQuantity < 1) {
            JsonUtil.sendJson(response, new ApiResponse("error", errorMessage), HttpServletResponse.SC_BAD_REQUEST);
            return -1;
        }
        return requestedQuantity;
    }

    private boolean hasGiftInCart(Cart currentCart) {
        return currentCart.getGifts() != null && !currentCart.getGifts().isEmpty();
    }

    private Gift getFirstIncomingGift(List<Gift> incomingGifts) {
        for (Gift incomingGift : incomingGifts) {
            if (incomingGift != null) return incomingGift;
        }
        return null;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
