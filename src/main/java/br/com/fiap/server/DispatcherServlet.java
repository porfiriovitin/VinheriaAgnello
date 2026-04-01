package br.com.fiap.server;

import br.com.fiap.action.Action;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// All requests will point to controller - A brief test of the Spring architecture
@WebServlet("/controller")
public class DispatcherServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Gets the action name from the URL. Ex: localhost:8080/app/controller?action=ShowCatalog
        String actionParam = request.getParameter("action");

        // Builds the full class path. (Adjust the package to your project)
        String className = "br.com.fiap.action." + actionParam;
        String jspName;

        try {
            // Dynamically instantiates the action class
            Class<?> actionClass = Class.forName(className);
            Action action = (Action) actionClass.getDeclaredConstructor().newInstance();

            // Executes the class business logic and gets the destination JSP
            jspName = action.execute(request, response);

        } catch (ClassNotFoundException e) {
            throw new ServletException("Action not found: " + actionParam, e);
        } catch (Exception e) {
            throw new ServletException("Error executing action", e);
        }

        // Forwards the request to render the JSP chosen by the action
        request.getRequestDispatcher(jspName).forward(request, response);
    }
}