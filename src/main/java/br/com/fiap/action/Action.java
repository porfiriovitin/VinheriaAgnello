package br.com.fiap.action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface Action {
    // Returns the String with the destination JSP page name
    String execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
