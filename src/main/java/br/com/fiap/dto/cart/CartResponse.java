package br.com.fiap.dto.cart;

import br.com.fiap.dto.ApiResponse;

import java.util.List;

public class CartResponse extends ApiResponse {
    private List<CartItem> items;

    public CartResponse(String status, String message, List<CartItem> items) {
        super(status, message);
        this.items = items;
    }
}
