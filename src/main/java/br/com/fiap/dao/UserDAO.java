package br.com.fiap.dao;


import br.com.fiap.dto.cart.Cart;
import br.com.fiap.dto.cart.CartAccessoryItem;
import br.com.fiap.dto.cart.CartWineItem;
import br.com.fiap.infra.ConnectionFactory;
import br.com.fiap.infra.DbCollections;
import br.com.fiap.model.Gift;
import br.com.fiap.model.User;
import br.com.fiap.util.CastUtils;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.mindrot.jbcrypt.BCrypt;

import java.util.ArrayList;
import java.util.List;

/**
 * Persistence gateway for user identity and user-owned cart state.
 *
 * <p>Cart storage is denormalized on purpose: it snapshots product fields needed at checkout
 * together with quantity, reducing extra joins/lookups when rendering cart pages.</p>
 */
public class UserDAO {

    private final MongoCollection<Document> users;

    public UserDAO() {
        MongoDatabase db = ConnectionFactory.getDatabase();
        this.users = db.getCollection(DbCollections.USERS.getCollectionName());
    }

    public void create(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

        Document doc = new Document("name", user.getName())
                .append("email", user.getEmail())
                .append("password", hashed)
                .append("role", user.getRole())
                .append("cellphone", user.getCellphone());
        users.insertOne(doc);
    }

    public boolean existsByEmail(String email) {
        return users.find(new Document("email", email)).first() != null;
    }

    public boolean login(String email, String password) {
        Document userDoc = users.find(new Document("email", email)).first();
        if (userDoc == null) return false;

        String hashed = userDoc.getString("password");
        return BCrypt.checkpw(password, hashed);
    }

    /**
     * Replaces the full cart subtree in a single write.
     *
     * <p>Action layer is responsible for validation/merge rules; DAO focuses on serialization shape.</p>
     */
    public void updateCart(String email, Cart newCart) {
        List<CartWineItem> wines = newCart != null ? newCart.getWines() : new ArrayList<>();
        List<CartAccessoryItem> accessories = newCart != null ? newCart.getAccessories() : new ArrayList<>();
        List<Gift> gifts = newCart != null ? newCart.getGifts() : new ArrayList<>();

        List<Document> winesBson = new ArrayList<>();
        for (CartWineItem wineItem : wines) {
            if (wineItem == null) continue;
            // Null quantity defaults to one to keep persisted shape deterministic.
            Integer quantity = wineItem.getQuantity() == null ? 1 : wineItem.getQuantity();

            Document doc = new Document("id", wineItem.getId())
                    .append("name", wineItem.getName())
                    .append("country", wineItem.getCountry())
                    .append("region", wineItem.getRegion())
                    .append("price", wineItem.getPrice())
                    .append("imageUrl", wineItem.getImageUrl())
                    .append("quantity", quantity);
            winesBson.add(doc);
        }

        List<Document> accessoriesBson = new ArrayList<>();
        for (CartAccessoryItem accessoryItem : accessories) {
            if (accessoryItem == null) continue;
            Integer quantity = accessoryItem.getQuantity() == null ? 1 : accessoryItem.getQuantity();

            Document doc = new Document("id", accessoryItem.getId())
                    .append("name", accessoryItem.getName())
                    .append("imageURL", accessoryItem.getImageURL())
                    .append("price", accessoryItem.getPrice())
                    .append("quantity", quantity);
            accessoriesBson.add(doc);
        }

        List<Document> giftsBson = new ArrayList<>();
        for (Gift gift : gifts) {
            Document doc = new Document("id", gift.getId())
                    .append("applied", gift.getApplied())
                    .append("letterText", gift.getLetterText())
                    .append("price", gift.getPrice());
            giftsBson.add(doc);
        }

        Document cartDoc = new Document("wines", winesBson)
                .append("accessories", accessoriesBson)
                .append("gifts", giftsBson);

        users.updateOne(new Document("email", email), new Document("$set", new Document("cart", cartDoc)));
    }

    /**
     * Hydrates user cart from persisted BSON shape.
     *
     * <p>Returns an empty cart object (never null) to simplify caller code in actions/views.</p>
     */
    public Cart getCart(String email) {
        Document userDoc = users.find(new Document("email", email)).first();
        Cart cart = new Cart();
        if (userDoc == null) return cart;

        Document cartDoc = userDoc.get("cart", Document.class);
        if (cartDoc == null) return cart;

        List<Document> winesDoc = cartDoc.getList("wines", Document.class);
        if (winesDoc != null) {
            List<CartWineItem> wines = new ArrayList<>();
            for (Document doc : winesDoc) {
                CartWineItem wineItem = new CartWineItem();
                wineItem.setId(doc.getString("id"));
                wineItem.setName(doc.getString("name"));
                wineItem.setCountry(doc.getString("country"));
                wineItem.setRegion(doc.getString("region"));
                wineItem.setPrice(CastUtils.getDouble(doc, "price"));
                wineItem.setImageUrl(doc.getString("imageUrl"));
                Integer quantity = doc.getInteger("quantity");
                wineItem.setQuantity(quantity == null ? 1 : quantity);
                wines.add(wineItem);
            }
            cart.setWines(wines);
        }

        List<Document> accessoriesDoc = cartDoc.getList("accessories", Document.class);
        if (accessoriesDoc != null) {
            List<CartAccessoryItem> accessories = new ArrayList<>();
            for (Document doc : accessoriesDoc) {
                CartAccessoryItem accessoryItem = new CartAccessoryItem();
                accessoryItem.setId(doc.getString("id"));
                accessoryItem.setName(doc.getString("name"));
                accessoryItem.setImageURL(doc.getString("imageURL"));
                accessoryItem.setPrice(CastUtils.getDouble(doc,"price"));
                Integer quantity = doc.getInteger("quantity");
                accessoryItem.setQuantity(quantity == null ? 1 : quantity);
                accessories.add(accessoryItem);
            }
            cart.setAccessories(accessories);
        }

        List<Document> giftsDoc = cartDoc.getList("gifts", Document.class);
        if (giftsDoc != null) {
            List<Gift> gifts = new ArrayList<>();
            for (Document doc : giftsDoc) {
                Gift gift = new Gift();
                gift.setId(doc.getString("id"));
                gift.setApplied(doc.getBoolean("applied"));
                gift.setLetterText(doc.getString("letterText"));
                gift.setPrice(CastUtils.getDouble(doc,"price"));
                gifts.add(gift);
            }
            cart.setGifts(gifts);
        }

        return cart;
    }
}
