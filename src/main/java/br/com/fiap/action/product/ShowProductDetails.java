package br.com.fiap.action.product;

import br.com.fiap.action.Action;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowProductDetails implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        return "product-details.jsp";
    }
}
