package br.com.fiap.dto.cart;

import br.com.fiap.model.Gift;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    @SerializedName("wines")
    private List<CartWineItem> wines;

    @SerializedName("accessories")
    private List<CartAccessoryItem> accessories;

    @SerializedName("gifts")
    private List<Gift> gifts;

    public Cart() {
        this.wines = new ArrayList<>();
        this.accessories = new ArrayList<>();
        this.gifts = new ArrayList<>();
    }

    public List<CartWineItem> getWines() {
        return wines;
    }

    public void setWines(List<CartWineItem> wines) {
        this.wines = wines;
    }

    public List<CartAccessoryItem> getAccessories() {
        return accessories;
    }

    public void setAccessories(List<CartAccessoryItem> accessories) {
        this.accessories = accessories;
    }

    public List<Gift> getGifts() {
        return gifts;
    }

    public void setGifts(List<Gift> gifts) {
        this.gifts = gifts;
    }
}
