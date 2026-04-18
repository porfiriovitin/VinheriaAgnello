package br.com.fiap.action.auth;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Locale;

public class SignUp implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String cellphone = request.getParameter("phone");



        if (isBlank(firstName) || isBlank(lastName) || isBlank(email) || isBlank(password) || isBlank(confirmPassword)) {
            request.setAttribute("erro", "Todos os campos obrigatórios devem ser preenchidos.");
            return "signup.jsp";
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("erro", "As senhas informadas não coincidem.");
            return "signup.jsp";
        }

        if (!isBlank(cellphone) && !isValidBrazilianPhone(cellphone)) {
            request.setAttribute("erro", "Telefone inválido.");
            return "signup.jsp";
        }

        firstName = firstName.trim();
        lastName = lastName.trim();
        email = normalizeEmail(email);
        cellphone = cellphone == null ? null : cellphone.trim();

        String name = firstName + " " + lastName;
        User user = new User(name, email, password, "USER", cellphone);

        UserDAO userDAO = new UserDAO();

        if (userDAO.existsByEmail(email)) {
            request.setAttribute("erro", "E-mail já cadastrado.");
            return "signup.jsp";
        }

        userDAO.create(user);
        request.getSession().setAttribute("usuarioLogado", email);
        AuthFlowSupport.clearPostLoginRedirect(request);
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

    private boolean isValidBrazilianPhone(String phone) {
        if (phone == null) return false;
        return phone.matches("^\\(?[1-9]{2}\\)? ?9?[0-9]{4}-?[0-9]{4}$");
    }
}