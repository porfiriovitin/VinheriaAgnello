package br.com.fiap.action.product;

import br.com.fiap.action.Action;
import br.com.fiap.dao.WineDAO;
import br.com.fiap.model.Wine;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowProductDetails implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String id = request.getParameter("id");

        if (id == null || id.isBlank()) {
            WineDAO wineDAO = new WineDAO();
            request.setAttribute("wineList", wineDAO.findAll());
            return "catalog.jsp";
        }

        WineDAO wineDAO = new WineDAO();
        Wine wine = wineDAO.getWineById(id);

        if (wine == null) {
            return "catalog.jsp";
        }

        request.setAttribute("wine", wine);
        return "product-details.jsp";
    }
}
