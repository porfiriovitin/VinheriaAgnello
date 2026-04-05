package br.com.fiap.server;

import br.com.fiap.action.*;
import br.com.fiap.action.auth.Login;
import br.com.fiap.action.auth.ShowLogin;
import br.com.fiap.action.auth.ShowSignup;
import br.com.fiap.action.auth.SignUp;
import br.com.fiap.action.cart.ShowCartCheckout;
import br.com.fiap.action.favorite.AddFavorite;
import br.com.fiap.action.favorite.RemoveFavorite;
import br.com.fiap.action.home.ShowIndex;
import br.com.fiap.action.product.ShowCatalog;
import br.com.fiap.action.product.ShowProductDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

// All requests will point to controller - A brief test of the Spring architecture
@WebServlet("/controller")
public class DispatcherServlet extends HttpServlet {
    private final Map<String, Action> actionRegistry = new HashMap<>();

    @Override
    public void init() throws ServletException {
        actionRegistry.put("AddFavorite", new AddFavorite());
        actionRegistry.put("RemoveFavorite", new RemoveFavorite());
        actionRegistry.put("ShowCartCheckout", new ShowCartCheckout());
        actionRegistry.put("ShowCatalog", new ShowCatalog());
        actionRegistry.put("ShowIndex", new ShowIndex());
        actionRegistry.put("ShowLogin", new ShowLogin());
        actionRegistry.put("ShowProductDetails", new ShowProductDetails());
        actionRegistry.put("ShowSignup", new ShowSignup());
        actionRegistry.put("ShowSommelier", new AddFavorite());
        actionRegistry.put("SignUp", new SignUp());
        actionRegistry.put("Login", new Login());
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String actionParam = request.getParameter("action");

        Action action = actionRegistry.get(actionParam);

        if (action == null) {
            throw new ServletException("Action not registered: " + actionParam);
        }

        try {
            String jspName = action.execute(request, response);

            if (jspName != null) {
                request.getRequestDispatcher(jspName).forward(request, response);
            }

        } catch (ServletException e) {
            System.err.println("Missing required data or object: " + e.getMessage());
        } catch (IOException e) {
            System.err.println("Network or I/O error occurred: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Unexpected Internal Server Error: " + e.getMessage());
        }
    }
}