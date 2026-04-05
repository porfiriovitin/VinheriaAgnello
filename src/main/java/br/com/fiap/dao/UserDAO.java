package br.com.fiap.dao;

import br.com.fiap.model.User;
import br.com.fiap.infra.ConnectionFactory;
import br.com.fiap.infra.DbCollections;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.mindrot.jbcrypt.BCrypt;

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
}
