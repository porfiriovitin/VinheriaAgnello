package br.com.fiap.action.home;

import br.com.fiap.action.Action;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowIndex implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setAttribute("activeMenu", "home");
        return "home.jsp";
    }
}
