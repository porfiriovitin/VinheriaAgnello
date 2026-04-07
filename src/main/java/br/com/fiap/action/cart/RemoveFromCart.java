package br.com.fiap.action.cart;

import br.com.fiap.action.Action;
import br.com.fiap.dao.AccessoryDAO;
import br.com.fiap.dao.GiftDAO;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dao.WineDAO;
import br.com.fiap.dto.ApiResponse;
import br.com.fiap.dto.cart.Cart;
import br.com.fiap.dto.cart.CartAccessoryItem;
import br.com.fiap.dto.cart.CartWineItem;
import br.com.fiap.dto.cart.CartRequest;
import br.com.fiap.dto.cart.CartResponse;
import br.com.fiap.model.Gift;
import br.com.fiap.util.JsonUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;

/**
 * Removes or decrements items from the persisted cart using the same trust model as AddToCart.
 *
 * <p>Client identifies target ids/quantities; existence is verified against catalog DAOs before
 * cart mutation to keep behavior consistent with add flow.</p>
 */
public class RemoveFromCart implements Action {
    /**
     * Validates request payload, applies removals in-memory, then persists the resulting cart.
     *
     * <p>Business rules:
     * 1. Wines/accessories decrement quantity and are removed when quantity reaches zero.
     * 2. Gifts are removed by id.</p>
     */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String email = "test@agnello.com";
        if (isBlank(email)) {
            JsonUtil.sendJson(response, new ApiResponse("error", "User email is missing."), HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        CartRequest payload = JsonUtil.fromJson(request, CartRequest.class);
        if (payload == null || payload.getCartItems() == null || !hasAnyRemovalItems(payload.getCartItems())) {
            JsonUtil.sendJson(response, new ApiResponse("error", "A lista de itens está vazia ou o JSON é inválido."), HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        WineDAO wineDAO = new WineDAO();
        AccessoryDAO accessoryDAO = new AccessoryDAO();
        GiftDAO giftDAO = new GiftDAO();
        UserDAO userDAO = new UserDAO();
        Cart incomingCartItems = payload.getCartItems();
        Cart currentCart = userDAO.getCart(email);
        if (currentCart == null) currentCart = new Cart();
        ensureCartLists(currentCart);

        if (!decrementValidatedWines(currentCart, incomingCartItems.getWines(), wineDAO, response)) return null;
        if (!decrementValidatedAccessories(currentCart, incomingCartItems.getAccessories(), accessoryDAO, response)) return null;
        if (!removeValidatedGift(currentCart, incomingCartItems.getGifts(), giftDAO, response)) return null;

        userDAO.updateCart(email, currentCart);
        CartResponse apiResponse = new CartResponse("success", "Itens removidos do carrinho com sucesso!", userDAO.getCart(email));
        JsonUtil.sendJson(response, apiResponse);
        return null;
    }

    private boolean decrementValidatedWines(
            Cart currentCart,
            List<CartWineItem> incomingWines,
            WineDAO wineDAO,
            HttpServletResponse response
    ) throws Exception {
        if (incomingWines == null || incomingWines.isEmpty()) return true;

        for (CartWineItem incomingWineItem : incomingWines) {
            if (incomingWineItem == null || isBlank(incomingWineItem.getId())) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Item de vinho inválido no payload."), HttpServletResponse.SC_BAD_REQUEST);
                return false;
            }

            int quantityToRemove = validateRemovalQuantity(incomingWineItem.getQuantity(), response, "Quantidade inválida para vinho.");
            if (quantityToRemove < 0) return false;

            String incomingWineId = incomingWineItem.getId().trim();
            if (wineDAO.getWineById(incomingWineId) == null) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Vinho não encontrado no catálogo."), HttpServletResponse.SC_NOT_FOUND);
                return false;
            }

            Iterator<CartWineItem> iterator = currentCart.getWines().iterator();
            while (iterator.hasNext()) {
                CartWineItem existingItem = iterator.next();
                if (Objects.equals(existingItem.getId(), incomingWineId)) {
                    // Persisted carts may come from older states; treat missing quantity as one unit.
                    int existingQuantity = existingItem.getQuantity() == null ? 1 : existingItem.getQuantity();
                    int updatedQuantity = existingQuantity - quantityToRemove;
                    if (updatedQuantity <= 0) {
                        iterator.remove();
                    } else {
                        existingItem.setQuantity(updatedQuantity);
                    }
                    break;
                }
            }
        }

        return true;
    }

    private boolean decrementValidatedAccessories(
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

            int quantityToRemove = validateRemovalQuantity(incomingAccessoryItem.getQuantity(), response, "Quantidade inválida para acessório.");
            if (quantityToRemove < 0) return false;

            String incomingAccessoryId = incomingAccessoryItem.getId().trim();
            if (accessoryDAO.getAccesoryById(incomingAccessoryId) == null) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Acessório não encontrado no catálogo."), HttpServletResponse.SC_NOT_FOUND);
                return false;
            }

            Iterator<CartAccessoryItem> iterator = currentCart.getAccessories().iterator();
            while (iterator.hasNext()) {
                CartAccessoryItem existingItem = iterator.next();
                if (Objects.equals(existingItem.getId(), incomingAccessoryId)) {
                    int existingQuantity = existingItem.getQuantity() == null ? 1 : existingItem.getQuantity();
                    int updatedQuantity = existingQuantity - quantityToRemove;
                    if (updatedQuantity <= 0) {
                        iterator.remove();
                    } else {
                        existingItem.setQuantity(updatedQuantity);
                    }
                    break;
                }
            }
        }

        return true;
    }

    private boolean removeValidatedGift(
            Cart currentCart,
            List<Gift> incomingGifts,
            GiftDAO giftDAO,
            HttpServletResponse response
    ) throws Exception {
        if (incomingGifts == null || incomingGifts.isEmpty()) return true;

        for (Gift incomingGift : incomingGifts) {
            if (incomingGift == null || isBlank(incomingGift.getId())) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Item de presente inválido no payload."), HttpServletResponse.SC_BAD_REQUEST);
                return false;
            }

            String incomingGiftId = incomingGift.getId().trim();
            if (giftDAO.getGiftById(incomingGiftId) == null) {
                JsonUtil.sendJson(response, new ApiResponse("error", "Presente não encontrado no catálogo."), HttpServletResponse.SC_NOT_FOUND);
                return false;
            }

            // removeIf keeps code idempotent when client retries the same delete request.
            currentCart.getGifts().removeIf(existingGift -> Objects.equals(existingGift.getId(), incomingGiftId));
        }

        return true;
    }

    private void ensureCartLists(Cart cart) {
        // Normalization keeps mutation code branch-free.
        if (cart.getWines() == null) cart.setWines(new ArrayList<>());
        if (cart.getAccessories() == null) cart.setAccessories(new ArrayList<>());
        if (cart.getGifts() == null) cart.setGifts(new ArrayList<>());
    }

    private boolean hasAnyRemovalItems(Cart incomingCartItems) {
        return (incomingCartItems.getWines() != null && !incomingCartItems.getWines().isEmpty())
                || (incomingCartItems.getAccessories() != null && !incomingCartItems.getAccessories().isEmpty())
                || (incomingCartItems.getGifts() != null && !incomingCartItems.getGifts().isEmpty());
    }

    private int validateRemovalQuantity(Integer quantity, HttpServletResponse response, String errorMessage) throws Exception {
        // Missing quantity defaults to one, mirroring AddToCart semantics.
        int quantityToRemove = quantity == null ? 1 : quantity;
        if (quantityToRemove < 1) {
            JsonUtil.sendJson(response, new ApiResponse("error", errorMessage), HttpServletResponse.SC_BAD_REQUEST);
            return -1;
        }
        return quantityToRemove;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
