package br.com.fiap.util;

import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class JsonUtil {

    private static final Gson gson = new Gson();

    public static void sendJson(HttpServletResponse response, Object data, int statusCode) throws IOException {
        response.setStatus(statusCode);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String jsonString = gson.toJson(data);
        response.getWriter().write(jsonString);
    }

    public static void sendJson(HttpServletResponse response, Object data) throws IOException {
        sendJson(response, data, HttpServletResponse.SC_OK);
    }

    // :: private constructor to avoid instances - it's designed to behavior like a static class
    private JsonUtil() {
    }
}
