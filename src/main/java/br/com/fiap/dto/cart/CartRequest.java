package br.com.fiap.dto.cart;

import com.google.gson.annotations.SerializedName;

public class CartRequest {
    @SerializedName("CartItems")
    private Cart cartItems;

    public Cart getCartItems() {
        return cartItems;
    }

    public void setCartItems(Cart cartItems) {
        this.cartItems = cartItems;
    }
}
