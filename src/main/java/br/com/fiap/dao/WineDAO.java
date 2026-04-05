package br.com.fiap.dao;

import br.com.fiap.model.Wine;
import br.com.fiap.infra.ConnectionFactory;
import br.com.fiap.infra.DbCollections;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;

public class WineDAO {

    private final MongoCollection<Document> wines;

    public WineDAO() {
        MongoDatabase db = ConnectionFactory.getDatabase();
        this.wines = db.getCollection(DbCollections.WINES.getCollectionName());
    }

    public List<Wine> findAll() {
        List<Wine> wineList = new ArrayList<>();
        for (Document doc : wines.find()) {
            Wine wine = new Wine(
                    doc.getString("name"),
                    doc.getString("country"),
                    doc.getString("region"),
                    doc.getInteger("price"),
                    doc.getString("grape"),
                    doc.getString("imageUrl") // Corrigido aqui
            );
            wineList.add(wine);
        }
        return wineList;
    }

}
