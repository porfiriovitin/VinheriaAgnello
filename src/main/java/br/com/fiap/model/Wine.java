package br.com.fiap.model;

public class Wine {
    public int id;
    public String name;
    public String country;
    public String region;
    public Integer price;
    public String grape;
    public String imageURL;

    public Wine() {
    }

    public Wine(String name, String country, String region, Integer price, String grape, String imageURL) {
        this.name = name;
        this.country = country;
        this.region = region;
        this.price = price;
        this.grape = grape;
        this.imageURL = imageURL;
    }

    public Wine(int id, String name, String country, String region, Integer price, String grape, String imageURL) {
        this.id = id;
        this.name = name;
        this.country = country;
        this.region = region;
        this.price = price;
        this.grape = grape;
        this.imageURL = imageURL;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getGrape() {
        return grape;
    }

    public void setGrape(String grape) {
        this.grape = grape;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
