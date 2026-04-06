package br.com.fiap.dto.cart;
import br.com.fiap.model.Wine;

public class CartItem {
    public Wine wine;
    public int quantity;

    public Wine getWine() {
        return wine;
    }

    public void setWine(Wine wine) {
        this.wine = wine;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}