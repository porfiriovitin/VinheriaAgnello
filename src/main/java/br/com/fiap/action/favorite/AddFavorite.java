package br.com.fiap.action.favorite;

import br.com.fiap.action.Action;
import br.com.fiap.dto.ApiResponse;
import br.com.fiap.util.JsonUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddFavorite implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String productId = request.getParameter("id");

        if (productId == null || productId.trim().isEmpty()) {
            ApiResponse error = new ApiResponse("error", "Product ID is missing.");
            JsonUtil.sendJson(response, error, HttpServletResponse.SC_BAD_REQUEST);

            return null;
        }

        System.out.println("Saving product " + productId + " to favorites...");

        ApiResponse apiResponse = new ApiResponse("success", "Item added to your favorites!");

        JsonUtil.sendJson(response, apiResponse);

        return null;
    }
}