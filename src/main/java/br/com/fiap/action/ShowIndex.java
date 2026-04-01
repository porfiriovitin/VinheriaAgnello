package br.com.fiap.action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowIndex implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // You can load featured products, user info, etc., here before showing the home page.
        System.out.println("Loading home page data...");

        return "home.jsp";
    }
}
