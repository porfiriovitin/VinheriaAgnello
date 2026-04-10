package br.com.fiap.action.sommelier;

import br.com.fiap.action.Action;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ShowSommelier implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setAttribute("activeMenu", "sommelier");
        return "sommelier.jsp";
    }
}
