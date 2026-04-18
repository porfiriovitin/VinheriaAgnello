package br.com.fiap.action.cart;

import br.com.fiap.action.Action;
import br.com.fiap.action.checkout.CheckoutFlowSupport;
import br.com.fiap.dao.AccessoryDAO;
import br.com.fiap.dao.GiftDAO;
import br.com.fiap.dto.cart.Cart;
import br.com.fiap.model.Accessory;
import br.com.fiap.model.Gift;
import br.com.fiap.model.User;

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
     * <p>The current authenticated user comes from session.
     * If identity is missing, the checkout flow redirects to login before rendering protected pages.</p>
     */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userEmail = CheckoutFlowSupport.requireLoggedUserEmail(request, response);
        if (userEmail == null) return null;

        AccessoryDAO accessoryDAO = new AccessoryDAO();
        GiftDAO giftDAO = new GiftDAO();
        Cart cart = CheckoutFlowSupport.loadCart(userEmail);
        User user = CheckoutFlowSupport.loadCurrentUser(userEmail);
        List<Accessory> accessories = accessoryDAO.findAll();
        List<Gift> giftsCatalog = giftDAO.findAll();

        CheckoutFlowSupport.bindCommonCheckoutAttributes(request, cart, user);
        request.setAttribute("checkoutStep", "cart");
        request.setAttribute("accessories", accessories);
        request.setAttribute("giftsCatalog", giftsCatalog);
        return "/cart-checkout.jsp";
    }
}
