package br.com.fiap.dto.home;

import br.com.fiap.model.Wine;

import java.util.List;

public class ShopWindow {
    List<Wine> wines;

    public ShopWindow() {

    }

    public List<Wine> getWines() {
        return wines;
    }

    public void setWines(List<Wine> wines) {
        this.wines = wines;
    }

    public  ShopWindow(List<Wine> wines) {
        this.wines = wines;
    }
}
