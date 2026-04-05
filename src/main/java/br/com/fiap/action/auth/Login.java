package br.com.fiap.action.auth;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Login implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("erro", "E-mail e senha são obrigatórios.");
            return "login.jsp";
        }

        UserDAO userDAO = new UserDAO();
        boolean authenticated = userDAO.login(email, password);

        if (!authenticated) {
            request.setAttribute("erro", "E-mail ou senha inválidos.");
            return "login.jsp";
        }

        System.out.println("Usuário autenticado: " + email);

        // To do: Implementar sistema de sessão para manter o usuário logado
        //:: request.getSession().setAttribute("usuarioLogado", email);

        return "home.jsp";
    }
}
