package br.com.fiap.dto.cart;

import br.com.fiap.dto.ApiResponse;

public class CartResponse extends ApiResponse {
    private Cart cart;

    public CartResponse(String status, String message, Cart cart) {
        super(status, message);
        this.cart = cart;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }
}
