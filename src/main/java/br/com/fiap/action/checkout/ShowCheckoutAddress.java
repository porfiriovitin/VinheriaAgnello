package br.com.fiap.action.checkout;

import br.com.fiap.action.Action;
import br.com.fiap.dto.cart.Cart;
import br.com.fiap.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowCheckoutAddress implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userEmail = CheckoutFlowSupport.requireLoggedUserEmail(request, response);
        if (userEmail == null) return null;

        Cart cart = CheckoutFlowSupport.loadCart(userEmail);
        User user = CheckoutFlowSupport.loadCurrentUser(userEmail);

        CheckoutFlowSupport.bindCommonCheckoutAttributes(request, cart, user);
        request.setAttribute("checkoutStep", "delivery");

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

        return "/checkout-address.jsp";
    }

    private void bindField(HttpServletRequest request, String name, String fallback) {
        String submittedValue = request.getParameter(name);
        request.setAttribute(name, isBlank(submittedValue) ? fallback : submittedValue.trim());
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
