package br.com.fiap.action.auth;

import br.com.fiap.action.Action;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Login implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println(email);
        System.out.println(password);
        return "OK";

//        String sql = "SELECT id, nome, email FROM usuario WHERE email = ? AND senha = ?";
//
//        try (Connection con = ConnectionFactory.getConnection();
//             PreparedStatement ps = con.prepareStatement(sql)) {
//
//            ps.setString(1, email);
//            ps.setString(2, password);
//
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    HttpSession session = request.getSession();
//                    session.setAttribute("usuarioId", rs.getLong("id"));
//                    session.setAttribute("usuarioNome", rs.getString("nome"));
//                    session.setAttribute("usuarioEmail", rs.getString("email"));
//
//                    return "home.jsp";
//                }
//            }
//        }
//
//        request.setAttribute("erro", "E\\-mail ou senha inválidos.");
//        return "login.jsp";
    }
}
