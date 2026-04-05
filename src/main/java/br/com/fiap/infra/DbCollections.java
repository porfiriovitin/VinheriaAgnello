package br.com.fiap.infra;

public enum DbCollections {
    USERS("users"),
    WINES("wines");

    private final String collectionName;

    DbCollections(String collectionName) {
        this.collectionName = collectionName;
    }

    public String getCollectionName() {
        return collectionName;
    }
}
