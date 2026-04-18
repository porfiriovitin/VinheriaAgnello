package br.com.fiap.action.club;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowClub implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userEmail = (String) request.getSession().getAttribute("usuarioLogado");
        int cartItemCount = 0;
        if (userEmail != null && !userEmail.trim().isEmpty()) {
            cartItemCount = new UserDAO().countCartItems(userEmail);
        }

        request.setAttribute("activeMenu", "club");
        request.setAttribute("cartItemCount", cartItemCount);
        return "/club.jsp";
    }
}
