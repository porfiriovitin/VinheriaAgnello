package br.com.fiap.dao;

import br.com.fiap.infra.ConnectionFactory;
import br.com.fiap.infra.DbCollections;
import br.com.fiap.model.Accessory;
import br.com.fiap.util.CastUtils;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Read-only gateway for accessory catalog documents.
 *
 * <p>DAO methods return null on invalid id or lookup failures by design; callers in action layer
 * translate this into API-level responses.</p>
 */
public class AccessoryDAO {
    private final MongoCollection<Document> accessories;

    public AccessoryDAO() {
        MongoDatabase db = ConnectionFactory.getDatabase();
        this.accessories = db.getCollection(DbCollections.ACCESSORIES.getCollectionName());
    }

    public List<Accessory> findAll() {
        List<Accessory> accessoryList = new ArrayList<>();
        for (Document doc : accessories.find()) {
            String id = doc.getObjectId("_id").toHexString();

            Accessory accessory = new Accessory(
                    id,
                    doc.getString("name"),
                    doc.getString("imageUrl"),
                    CastUtils.getDouble(doc, "price")
            );
            accessoryList.add(accessory);
        }

        return accessoryList;
    }

    /**
     * Loads one accessory by Mongo ObjectId string.
     *
     * <p>Input is trimmed and validated first to avoid unnecessary DB calls and noisy stack traces.</p>
     */
    public Accessory getAccesoryById(String id) {
        if(id == null) return null;

        String cleanId = id.trim();
        if(!ObjectId.isValid(cleanId)){
            System.err.println("AccessoryDAO.getAccessoryById: id inválido: [" + id + "]");
            return null;
        }

        try {
            Document doc = accessories.find(Filters.eq("_id", new ObjectId(cleanId))).first();
            if(doc == null) return null;

            Accessory accessory = new Accessory();
            accessory.setId(doc.getObjectId("_id").toHexString());
            accessory.setName(doc.getString("name"));
            accessory.setImageURL(doc.getString("imageUrl"));
            accessory.setPrice(CastUtils.getDouble(doc, "price"));

            return accessory;
        } catch (Exception e) {
            // Keep DAO failure details in server logs; upstream layer decides the HTTP contract.
            System.err.println("AccessoryDAO.getAccessoryById: erro buscando id [" + cleanId + "]: " + e.getMessage());
            return null;
        }
    }
}
