package br.com.fiap.action.product;

import br.com.fiap.action.Action;
import br.com.fiap.dao.WineDAO;
import br.com.fiap.model.Wine;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public class ShowCatalog implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        WineDAO wineDAO = new WineDAO();
        List<Wine> wineList = wineDAO.findAll();
        request.setAttribute("wineList", wineList);

        request.setAttribute("activeMenu", "catalog");
        return "catalog.jsp";
    }
}
