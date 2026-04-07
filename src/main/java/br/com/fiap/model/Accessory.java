package br.com.fiap.model;

public class Accessory {
    private String id;
    private String name;
    private String imageURL;
    private Double price;

    public Accessory() {
    }

    public Accessory(String id, String name, String imageURL, Double price) {
        this.id = id;
        this.name = name;
        this.imageURL = imageURL;
        this.price = price;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
