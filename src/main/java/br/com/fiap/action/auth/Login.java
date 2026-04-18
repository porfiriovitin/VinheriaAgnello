package br.com.fiap.action.auth;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Locale;

public class Login implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        email = normalizeEmail(email);
        password = password == null ? null : password.trim();

        if (isBlank(email) || isBlank(password)) {
            request.setAttribute("erro", "E-mail e senha são obrigatórios.");
            return "login.jsp";
        }

        UserDAO userDAO = new UserDAO();
        boolean authenticated = userDAO.login(email, password);

        if (!authenticated) {
            request.setAttribute("erro", "E-mail ou senha inválidos.");
            return "login.jsp";
        }

        request.getSession().setAttribute("usuarioLogado", email);
        String redirectTarget = AuthFlowSupport.consumePostLoginRedirect(request);
        if (redirectTarget != null) {
            response.sendRedirect(redirectTarget);
            return null;
        }

        response.sendRedirect(request.getContextPath() + "/controller?action=ShowIndex");
        return null;
    }

    private String normalizeEmail(String value) {
        if (value == null) return null;
        String normalized = value.trim().toLowerCase(Locale.ROOT);
        return normalized.isEmpty() ? null : normalized;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}