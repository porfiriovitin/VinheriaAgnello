package br.com.fiap.action.cart;

import br.com.fiap.action.Action;
import br.com.fiap.dao.AccessoryDAO;
import br.com.fiap.dao.GiftDAO;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dto.cart.Cart;
import br.com.fiap.model.Accessory;
import br.com.fiap.model.Gift;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Prepares checkout view data from the persisted cart.
 *
 * <p>This action intentionally stays read-only: it never mutates cart state and only binds
 * data required by JSP rendering.</p>
 */
public class ShowCartCheckout implements Action {
    /**
     * Loads the current cart and exposes it to the checkout page.
     *
     * <p>Current user identity is temporary hardcoded until session-based auth is wired.
     * If identity is missing, redirecting to catalog avoids rendering a checkout page without context.</p>
     */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userEmail = (String) request.getSession().getAttribute("usuarioLogado");
        if (isBlank(userEmail)) {
            response.sendRedirect("controller?action=ShowLogin");
            return null;
        }

        UserDAO userDAO = new UserDAO();
        AccessoryDAO accessoryDAO = new AccessoryDAO();
        GiftDAO giftDAO = new GiftDAO();
        Cart cart = userDAO.getCart(userEmail);
        if (cart == null) cart = new Cart();
        List<Accessory> accessories = accessoryDAO.findAll();
        List<Gift> giftsCatalog = giftDAO.findAll();

        request.setAttribute("activeMenu", "cart");
        request.setAttribute("cart", cart);
        request.setAttribute("accessories", accessories);
        request.setAttribute("giftsCatalog", giftsCatalog);
        return "cart-checkout.jsp";
    }

    /** Small local guard used to keep endpoint-style validation semantics explicit. */
    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
