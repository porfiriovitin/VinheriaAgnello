package br.com.fiap.dao;

import br.com.fiap.dto.cart.CartItem;
import br.com.fiap.model.User;
import br.com.fiap.infra.ConnectionFactory;
import br.com.fiap.infra.DbCollections;
import br.com.fiap.model.Wine;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.mindrot.jbcrypt.BCrypt;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * DAO: User Management and Cart Persistence
 * 
 * Purpose: Handles all MongoDB operations for users, including:
 * - User registration with bcrypt password hashing
 * - Authentication with secure password verification
 * - Shopping cart persistence (embedded as array in user document)
 * 
 * Data Model:
 * User document structure in MongoDB:
 * {
 *   "name": "...",
 *   "email": "..." (unique identifier),
 *   "password": "..." (bcrypt hash),
 *   "role": "...",
 *   "cellphone": "...",
 *   "cart": [
 *     { "_id": "wine123", "name": "...", "price": 99.99, "quantity": 2, ... }
 *   ]
 * }
 * 
 * Design Decision: Cart is embedded (not separate collection) for:
 * - Atomic read/write of user+cart in single operation
 * - Simpler data access (no joins needed)
 * - Acceptable since carts are small (<100 items typically)
 */
public class UserDAO {

    private final MongoCollection<Document> users;

    /**
     * Initializes DAO with MongoDB connection.
     * Connection pooling is handled by ConnectionFactory.
     */
    public UserDAO() {
        MongoDatabase db = ConnectionFactory.getDatabase();
        this.users = db.getCollection(DbCollections.USERS.getCollectionName());
    }

    /**
     * Registers a new user with secure password hashing.
     * 
     * Security: Password is hashed using bcrypt before storage.
     * BCrypt automatically generates a unique salt per user.
     * 
     * @param user User object containing plaintext password (will be hashed)
     * @throws com.mongodb.MongoWriteException if email already exists (duplicate key)
     */
    public void create(User user) {
        // Hash password with bcrypt (auto-generated salt, default cost factor 10)
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        
        Document doc = new Document("name", user.getName())
                .append("email", user.getEmail())
                .append("password", hashed)
                .append("role", user.getRole())
                .append("cellphone", user.getCellphone());
        users.insertOne(doc);
    }

    /**
     * Checks if a user account exists for the given email.
     * 
     * Use Case: Pre-registration validation to prevent duplicate accounts.
     * 
     * @param email user email to check
     * @return true if email is already registered
     */
    public boolean existsByEmail(String email) {
        return users.find(new Document("email", email)).first() != null;
    }

    /**
     * Authenticates user credentials.
     * 
     * Security: Uses bcrypt's constant-time comparison to prevent timing attacks.
     * 
     * @param email    user's email address
     * @param password plaintext password to verify
     * @return true if user exists AND password matches the stored hash
     */
    public boolean login(String email, String password) {
        Document userDoc = users.find(new Document("email", email)).first();
        if (userDoc == null) return false;
        
        String hashed = userDoc.getString("password");
        // BCrypt.checkpw performs constant-time comparison (secure against timing attacks)
        return BCrypt.checkpw(password, hashed);
    }


    /**
     * Replaces user's entire cart with new item list.
     * 
     * Strategy: Full replacement (not incremental update) for simplicity.
     * Controller layer handles merge logic; DAO just persists final state.
     * 
     * Atomicity: MongoDB updateOne is atomic - cart is never in partial state.
     * 
     * @param email       user identifier (lookup key in MongoDB)
     * @param newCartList complete cart state to persist (pre-validated by caller)
     */
    public void updateCart(String email, List<CartItem> newCartList) {

        // Convert Java DTOs to MongoDB BSON documents
        List<Document> cartBson = new ArrayList<>();

        for (CartItem item : newCartList) {
            // Map cart item to document structure
            // Only stores fields needed for cart/checkout (lightweight representation)
            Document doc = new Document("_id", item.wine.getId())
                    .append("name", item.wine.getName())
                    .append("country", item.wine.getCountry())
                    .append("region", item.wine.getRegion())
                    .append("price", item.wine.getPrice())
                    .append("imageURL", item.wine.getImageURL())
                    .append("quantity", item.quantity);
            cartBson.add(doc);
        }

        // Atomically replace entire cart array in user document
        // Using $set with full array ensures clean replacement (no orphaned items)
        users.updateOne(
                new Document("email", email),
                new Document("$set", new Document("cart", cartBson))
        );
    }

    /**
     * Fetches all items in user's shopping cart.
     * 
     * Return Value:
     * - Empty list if user doesn't exist or cart is empty (safe default)
     * - List of CartItem DTOs reconstructed from MongoDB documents
     * 
     * Design Note: Returns DTOs (not Mongo Documents) to decouple persistence
     * layer from application layer. Allows switching databases without affecting callers.
     * 
     * @param email user identifier (lookup key)
     * @return user's cart items; never null, returns empty list if cart doesn't exist
     */
    public List<CartItem> getCartItems(String email) {

        // Fetch user document by email
        Document userDoc = users.find(new Document("email", email)).first();
        if (userDoc == null) return new ArrayList<>();

        // Extract cart array from user document
        // Returns null if "cart" field doesn't exist (new user who hasn't added items)
        List<Document> currentCart = userDoc.getList("cart", Document.class);
        if (currentCart == null || currentCart.isEmpty()) {
            return new ArrayList<>();
        }

        // Transform MongoDB documents back into application DTOs
        // This decouples the application from MongoDB's Document structure
        List<CartItem> cartList = new ArrayList<>();
        for (Document doc : currentCart) {
            CartItem dto = new CartItem();
            Wine wine = new Wine();

            // Reconstruct Wine object from stored fields
            wine.setId(doc.getString("_id"));
            wine.setName(doc.getString("name"));
            wine.setCountry(doc.getString("country"));
            wine.setRegion(doc.getString("region"));
            wine.setPrice(doc.getDouble("price"));
            wine.setImageURL(doc.getString("imageURL"));

            dto.wine = wine;
            dto.quantity = doc.getInteger("quantity");

            cartList.add(dto);
        }

        return cartList;
    }
}
