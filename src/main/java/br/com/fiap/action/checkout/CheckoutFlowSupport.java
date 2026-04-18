package br.com.fiap.action.checkout;

import br.com.fiap.action.auth.AuthFlowSupport;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dto.cart.Cart;
import br.com.fiap.dto.cart.CartAccessoryItem;
import br.com.fiap.dto.cart.CartWineItem;
import br.com.fiap.model.Gift;
import br.com.fiap.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Shared checkout helpers used to keep the three-step flow consistent.
 */
public final class CheckoutFlowSupport {
    private CheckoutFlowSupport() {
    }

    public static String requireLoggedUserEmail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userEmail = (String) request.getSession().getAttribute("usuarioLogado");
        if (isBlank(userEmail)) {
            AuthFlowSupport.rememberActionRedirect(request, request.getParameter("action"));
            response.sendRedirect(request.getContextPath() + "/controller?action=ShowLogin&loginContext=checkout");
            return null;
        }
        return userEmail;
    }

    public static Cart loadCart(String userEmail) {
        UserDAO userDAO = new UserDAO();
        Cart cart = userDAO.getCart(userEmail);
        return cart == null ? new Cart() : cart;
    }

    public static User loadCurrentUser(String userEmail) {
        return new UserDAO().findByEmail(userEmail);
    }

    public static void bindCommonCheckoutAttributes(HttpServletRequest request, Cart cart, User user) {
        double subtotal = calculateSubtotal(cart);
        double giftTotal = calculateGiftTotal(cart);

        request.setAttribute("activeMenu", "cart");
        request.setAttribute("cart", cart);
        request.setAttribute("currentUser", user);
        request.setAttribute("cartSubtotal", subtotal);
        request.setAttribute("giftTotal", giftTotal);
        request.setAttribute("shippingTotal", 0d);
        request.setAttribute("cartTotal", subtotal + giftTotal);
        request.setAttribute("cartItemCount", countItems(cart));
    }

    public static double calculateSubtotal(Cart cart) {
        if (cart == null) return 0d;

        double total = 0d;

        if (cart.getWines() != null) {
            for (CartWineItem wine : cart.getWines()) {
                if (wine == null) continue;
                int quantity = wine.getQuantity() == null || wine.getQuantity() < 1 ? 1 : wine.getQuantity();
                double price = wine.getPrice() == null ? 0d : wine.getPrice();
                total += price * quantity;
            }
        }

        if (cart.getAccessories() != null) {
            for (CartAccessoryItem accessory : cart.getAccessories()) {
                if (accessory == null) continue;
                int quantity = accessory.getQuantity() == null || accessory.getQuantity() < 1 ? 1 : accessory.getQuantity();
                double price = accessory.getPrice() == null ? 0d : accessory.getPrice();
                total += price * quantity;
            }
        }

        return total;
    }

    public static double calculateGiftTotal(Cart cart) {
        if (cart == null || cart.getGifts() == null || cart.getGifts().isEmpty()) return 0d;

        Gift gift = cart.getGifts().get(0);
        if (gift == null || !Boolean.TRUE.equals(gift.getApplied())) return 0d;
        return gift.getPrice() == null ? 0d : gift.getPrice();
    }

    private static int countItems(Cart cart) {
        if (cart == null) return 0;

        int totalItems = 0;

        if (cart.getWines() != null) {
            for (CartWineItem wine : cart.getWines()) {
                if (wine == null) continue;
                totalItems += wine.getQuantity() == null || wine.getQuantity() < 1 ? 1 : wine.getQuantity();
            }
        }

        if (cart.getAccessories() != null) {
            for (CartAccessoryItem accessory : cart.getAccessories()) {
                if (accessory == null) continue;
                totalItems += accessory.getQuantity() == null || accessory.getQuantity() < 1 ? 1 : accessory.getQuantity();
            }
        }

        if (cart.getGifts() != null && !cart.getGifts().isEmpty()) {
            Gift gift = cart.getGifts().get(0);
            if (gift != null && Boolean.TRUE.equals(gift.getApplied())) {
                totalItems += 1;
            }
        }

        return totalItems;
    }

    private static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
