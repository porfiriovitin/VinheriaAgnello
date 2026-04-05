package br.com.fiap.action.auth;

import br.com.fiap.action.Action;
import br.com.fiap.dao.UserDAO;
import br.com.fiap.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SignUp implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cellphone = request.getParameter("phone");

        if (firstName == null || lastName == null || email == null || password == null) {
            request.setAttribute("erro", "Todos os campos obrigatórios devem ser preenchidos.");
            return "signup.jsp";
        }

        String name = firstName + " " + lastName;
        User user = new User(name, email, password, "USER", cellphone);

        UserDAO userDAO = new UserDAO();

        if (userDAO.existsByEmail(email)) {
            request.setAttribute("erro", "E-mail já cadastrado.");
            return "signup.jsp";
        }

        userDAO.create(user);

        return "login.jsp";
    }
}
