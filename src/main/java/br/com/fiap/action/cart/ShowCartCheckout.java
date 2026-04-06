package br.com.fiap.action.cart;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dto.cart.CartItem;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Action: Display Cart Checkout Page
 * 
 * Purpose: Prepares and displays the shopping cart checkout view.
 * Retrieves user's current cart items from database and makes them 
 * available to the JSP layer for rendering.
 * 
 * Flow: User navigates to checkout → Action loads cart → JSP renders items
 */
public class ShowCartCheckout implements Action {

    /**
     * Executes the cart checkout page preparation logic.
     * 
     * Business Logic:
     * 1. Identifies user (currently hardcoded, will use session in production)
     * 2. Fetches cart items from MongoDB via UserDAO
     * 3. Binds items to request scope for JSP access via EL (${cartItems})
     * 4. Returns JSP path for rendering
     * 
     * @param request  HTTP request object
     * @param response HTTP response object
     * @return JSP file path to render; returning a string triggers view forwarding in the Front Controller
     * @throws Exception if database access fails
     */
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // TEMPORARY: Hardcoded user identification
        // TODO: Replace with HttpSession.getAttribute("userEmail") when auth module is ready
        String email = "test@agnello.com";

        // Load user's cart from database
        UserDAO userDAO = new UserDAO();
        List<CartItem> cartItems = userDAO.getCartItems(email);

        // Make cart items available to JSP via Expression Language
        request.setAttribute("cartItems", cartItems);

        return "cart-checkout.jsp";
    }
}