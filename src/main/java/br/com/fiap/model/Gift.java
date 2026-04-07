package br.com.fiap.model;

public class Gift {
    private String id;
    private Boolean applied;
    private String letterText;
    private Double price;

    public Gift() {
    }

    public Gift(String id, Boolean applied, String letterText, Double price) {
        this.id = id;
        this.applied = applied;
        this.letterText = letterText;
        this.price = price;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Boolean getApplied() {
        return applied;
    }

    public void setApplied(Boolean applied) {
        this.applied = applied;
    }

    public String getLetterText() {
        return letterText;
    }

    public void setLetterText(String letterText) {
        this.letterText = letterText;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
