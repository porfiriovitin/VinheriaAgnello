package br.com.fiap.action.checkout;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.dto.cart.Cart;
import br.com.fiap.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowCheckoutFinalize implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userEmail = CheckoutFlowSupport.requireLoggedUserEmail(request, response);
        if (userEmail == null) return null;

        Cart cart = CheckoutFlowSupport.loadCart(userEmail);
        User user = CheckoutFlowSupport.loadCurrentUser(userEmail);
        boolean simulateConfirm = "true".equalsIgnoreCase(request.getParameter("simulateConfirm"));

        request.setAttribute("orderSummaryCart", cart);
        request.setAttribute("orderSummaryGiftTotal", CheckoutFlowSupport.calculateGiftTotal(cart));

        if (simulateConfirm) {
            new UserDAO().updateCart(userEmail, new Cart());
            cart = new Cart();
        }

        CheckoutFlowSupport.bindCommonCheckoutAttributes(request, cart, user);
        request.setAttribute("checkoutStep", "payment");

        bindField(request, "deliveryName", user != null ? user.getName() : "");
        bindField(request, "deliveryEmail", user != null ? user.getEmail() : userEmail);
        bindField(request, "deliveryPhone", user != null ? user.getCellphone() : "");
        bindField(request, "deliveryCep", "");
        bindField(request, "deliveryStreet", "");
        bindField(request, "deliveryNumber", "");
        bindField(request, "deliveryComplement", "");
        bindField(request, "deliveryNeighborhood", "");
        bindField(request, "deliveryCity", "");
        bindField(request, "deliveryState", "");
        bindField(request, "deliveryReference", "");
        bindField(request, "shippingMethod", "express");
        bindField(request, "paymentMethod", "pix");
        bindField(request, "cardHolderName", "");
        bindField(request, "cardNumber", "");
        bindField(request, "cardExpiry", "");
        bindField(request, "cardCvv", "");
        bindField(request, "cardInstallments", "1");

        request.setAttribute("checkoutPreviewConfirmed", simulateConfirm);

        return "/checkout-finalization.jsp";
    }

    private void bindField(HttpServletRequest request, String name, String fallback) {
        String submittedValue = request.getParameter(name);
        request.setAttribute(name, isBlank(submittedValue) ? fallback : submittedValue.trim());
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
