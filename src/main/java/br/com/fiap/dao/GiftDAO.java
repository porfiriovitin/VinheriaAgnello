package br.com.fiap.dao;

import br.com.fiap.infra.ConnectionFactory;
import br.com.fiap.infra.DbCollections;
import br.com.fiap.model.Gift;
import br.com.fiap.util.CastUtils;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

/**
 * Read-only gateway for gift catalog data.
 *
 * <p>Catalog currently stores only immutable gift identity and price; user-authored metadata
 * (for example letter text) belongs to cart/user documents, not this collection.</p>
 */
public class GiftDAO {
    private final MongoCollection<Document> gifts;

    public GiftDAO() {
        MongoDatabase db = ConnectionFactory.getDatabase();
        this.gifts = db.getCollection(DbCollections.GIFTS.getCollectionName());
    }

    public List<Gift> findAll() {
        List<Gift> giftList = new ArrayList<>();
        for (Document doc : gifts.find()) {
            String id = doc.getObjectId("_id").toHexString();

            Gift gift = new Gift();
            gift.setId(id);
            gift.setPrice(CastUtils.getDouble(doc, "price"));
            giftList.add(gift);
        }

        return giftList;
    }

    /**
     * Loads gift price data by ObjectId string.
     *
     * <p>Returns null for invalid ids, missing records, or query errors so action layer can map
     * to the appropriate API response.</p>
     */
    public Gift getGiftById(String id) {
        if (id == null) return null;

        String cleanId = id.trim();
        if (!ObjectId.isValid(cleanId)) {
            System.err.println("GiftDAO.getGiftById: id inválido: [" + id + "]");
            return null;
        }

        try {
            Document doc = gifts.find(Filters.eq("_id", new ObjectId(cleanId))).first();
            if (doc == null) return null;

            Gift gift = new Gift();
            gift.setId(doc.getObjectId("_id").toHexString());
            gift.setPrice(CastUtils.getDouble(doc, "price"));
            return gift;
        } catch (Exception e) {
            // Log details for operators while keeping DAO contract simple for callers.
            System.err.println("GiftDAO.getGiftById: erro buscando id [" + cleanId + "]: " + e.getMessage());
            return null;
        }
    }
}
