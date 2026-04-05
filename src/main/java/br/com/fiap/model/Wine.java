package br.com.fiap.model;

import java.util.List;

public class Wine {
    public String id;
    public String name;
    public String country;
    public String region;
    public Double price;
    public String grape;
    public String imageURL;
    public String type;
    public String origin;
    public Double userRatings;
    public Integer amountRatings;
    public Double alcoholPercentage;
    public List<AromaticNote> aromaticNotes;
    public FlavorProfile flavorProfile;
    public List<Harmonization> harmonization;
    public String productorLore;
    public Specifications specifications;

    public Wine() {
    }

    public Wine(String name, String country, String region, Double price, String grape, String imageURL) {
        this.name = name;
        this.country = country;
        this.region = region;
        this.price = price;
        this.grape = grape;
        this.imageURL = imageURL;
    }

    public Wine(String id, String name, String country, String region, Double price, String grape, String imageURL) {
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getGrape() {
        return grape;
    }

    public void setGrape(String grape) {
        this.grape = grape;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public Double getUserRatings() {
        return userRatings;
    }

    public void setUserRatings(Double userRatings) {
        this.userRatings = userRatings;
    }

    public Integer getAmountRatings() {
        return amountRatings;
    }

    public void setAmountRatings(Integer amountRatings) {
        this.amountRatings = amountRatings;
    }

    public Double getAlcoholPercentage() {
        return alcoholPercentage;
    }

    public void setAlcoholPercentage(Double alcoholPercentage) {
        this.alcoholPercentage = alcoholPercentage;
    }

    public List<AromaticNote> getAromaticNotes() {
        return aromaticNotes;
    }

    public void setAromaticNotes(List<AromaticNote> aromaticNotes) {
        this.aromaticNotes = aromaticNotes;
    }

    public FlavorProfile getFlavorProfile() {
        return flavorProfile;
    }

    public void setFlavorProfile(FlavorProfile flavorProfile) {
        this.flavorProfile = flavorProfile;
    }

    public List<Harmonization> getHarmonization() {
        return harmonization;
    }

    public void setHarmonization(List<Harmonization> harmonization) {
        this.harmonization = harmonization;
    }

    public String getProductorLore() {
        return productorLore;
    }

    public void setProductorLore(String productorLore) {
        this.productorLore = productorLore;
    }

    public Specifications getSpecifications() {
        return specifications;
    }

    public void setSpecifications(Specifications specifications) {
        this.specifications = specifications;
    }

    public static class AromaticNote {
        private String title;
        private String materialSymbol;

        public AromaticNote() {}

        public AromaticNote(String title, String materialSymbol) {
            this.title = title;
            this.materialSymbol = materialSymbol;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getMaterialSymbol() {
            return materialSymbol;
        }

        public void setMaterialSymbol(String materialSymbol) {
            this.materialSymbol = materialSymbol;
        }
    }

    public static class FlavorProfile {
        private Integer acidity;
        private Integer tannins;
        private Integer body;

        public FlavorProfile() {}

        public FlavorProfile(Integer acidity, Integer tannins, Integer body) {
            this.acidity = acidity;
            this.tannins = tannins;
            this.body = body;
        }

        public Integer getAcidity() {
            return acidity;
        }

        public void setAcidity(Integer acidity) {
            this.acidity = acidity;
        }

        public Integer getTannins() {
            return tannins;
        }

        public void setTannins(Integer tannins) {
            this.tannins = tannins;
        }

        public Integer getBody() {
            return body;
        }

        public void setBody(Integer body) {
            this.body = body;
        }
    }

    public static class Harmonization {
        private String title;
        private String materialSymbol;

        public Harmonization() {}

        public Harmonization(String title, String materialSymbol) {
            this.title = title;
            this.materialSymbol = materialSymbol;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getMaterialSymbol() {
            return materialSymbol;
        }

        public void setMaterialSymbol(String materialSymbol) {
            this.materialSymbol = materialSymbol;
        }
    }

    public static class Specifications {
        private String grape;
        private String ripening;
        private String temperature;
        private String keeper;

        public Specifications() {}

        public Specifications(String grape, String ripening, String temperature, String keeper) {
            this.grape = grape;
            this.ripening = ripening;
            this.temperature = temperature;
            this.keeper = keeper;
        }

        public String getGrape() {
            return grape;
        }

        public void setGrape(String grape) {
            this.grape = grape;
        }

        public String getRipening() {
            return ripening;
        }

        public void setRipening(String ripening) {
            this.ripening = ripening;
        }

        public String getTemperature() {
            return temperature;
        }

        public void setTemperature(String temperature) {
            this.temperature = temperature;
        }

        public String getKeeper() {
            return keeper;
        }

        public void setKeeper(String keeper) {
            this.keeper = keeper;
        }
    }
}
