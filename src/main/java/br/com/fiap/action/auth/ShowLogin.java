package br.com.fiap.action.auth;

import br.com.fiap.action.Action;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowLogin implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String loggedUser = (String) request.getSession().getAttribute("usuarioLogado");
        boolean preserveRedirect = "checkout".equalsIgnoreCase(request.getParameter("loginContext"));

        if (loggedUser != null && !loggedUser.trim().isEmpty() && !preserveRedirect) {
            response.sendRedirect(request.getContextPath() + "/controller?action=ShowIndex");
            return null;
        }

        if (!preserveRedirect) {
            AuthFlowSupport.clearPostLoginRedirect(request);
        }

        request.setAttribute("activeMenu", "login");
        return "login.jsp";
    }
}
