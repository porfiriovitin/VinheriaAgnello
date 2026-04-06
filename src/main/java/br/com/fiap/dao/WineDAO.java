package br.com.fiap.dao;

import br.com.fiap.infra.ConnectionFactory;
import br.com.fiap.infra.DbCollections;
import br.com.fiap.model.Wine;
import br.com.fiap.util.CastUtils;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.types.ObjectId;

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
            String id = doc.getObjectId("_id").toHexString();

            Wine wine = new Wine(
                    id,
                    doc.getString("name"),
                    doc.getString("country"),
                    doc.getString("region"),
                    CastUtils.getDouble(doc, "price"),
                    doc.getString("grape"),
                    doc.getString("imageUrl"),
                    doc.getString("type")
            );
            wineList.add(wine);
        }
        return wineList;
    }

    public Wine getWineById(String id) {
        if (id == null) return null;

        String cleanId = id.trim();
        if (!ObjectId.isValid(cleanId)) {
            System.err.println("WineDAO.getWineById: id inválido: [" + id + "]");
            return null;
        }

        try {
            Document doc = wines.find(Filters.eq("_id", new ObjectId(cleanId))).first();
            if (doc == null) return null;

            Wine wine = new Wine();
            wine.setId(doc.getObjectId("_id").toHexString());
            wine.setName(doc.getString("name"));
            wine.setCountry(doc.getString("country"));
            wine.setRegion(doc.getString("region"));
            wine.setPrice(CastUtils.getDouble(doc, "price"));
            wine.setGrape(doc.getString("grape"));
            wine.setImageURL(doc.getString("imageUrl"));

            wine.type = doc.getString("type");
            wine.origin = doc.getString("origin");

            wine.userRatings = CastUtils.getDouble(doc, "user_ratings");
            wine.amountRatings = CastUtils.getInteger(doc, "amount_ratings");
            wine.alcoholPercentage = CastUtils.getDouble(doc, "alcohol_percentage");

            wine.productorLore = doc.getString("productor_lore");

            @SuppressWarnings("unchecked")
            List<Document> aromaticNotesDocs = (List<Document>) doc.get("aromatic_notes");
            if (aromaticNotesDocs != null) {
                List<Wine.AromaticNote> aromaticNotes = new ArrayList<>();
                for (Document noteDoc : aromaticNotesDocs) {
                    Wine.AromaticNote note = new Wine.AromaticNote();
                    note.setTitle(noteDoc.getString("title"));
                    note.setMaterialSymbol(noteDoc.getString("material_symbol"));
                    aromaticNotes.add(note);
                }
                wine.aromaticNotes = aromaticNotes;
            }

            Document flavorProfileDoc = (Document) doc.get("flavor_profile");
            if (flavorProfileDoc != null) {
                Wine.FlavorProfile flavorProfile = new Wine.FlavorProfile();
                flavorProfile.setAcidity(CastUtils.getInteger(flavorProfileDoc, "acidity"));
                flavorProfile.setTannins(CastUtils.getInteger(flavorProfileDoc, "tannins"));
                flavorProfile.setBody(CastUtils.getInteger(flavorProfileDoc, "body"));
                wine.flavorProfile = flavorProfile;
            }

            @SuppressWarnings("unchecked")
            List<Document> harmonizationDocs = (List<Document>) doc.get("harmonization");
            if (harmonizationDocs != null) {
                List<Wine.Harmonization> harmonizations = new ArrayList<>();
                for (Document harmDoc : harmonizationDocs) {
                    Wine.Harmonization harm = new Wine.Harmonization();
                    harm.setTitle(harmDoc.getString("title"));
                    harm.setMaterialSymbol(harmDoc.getString("material_symbol"));
                    harmonizations.add(harm);
                }
                wine.harmonization = harmonizations;
            }

            Document specificationsDoc = (Document) doc.get("especifications");
            if (specificationsDoc != null) {
                Wine.Specifications specs = new Wine.Specifications();
                specs.setGrape(specificationsDoc.getString("grape"));
                specs.setRipening(specificationsDoc.getString("ripening"));
                specs.setTemperature(specificationsDoc.getString("temperature"));
                specs.setKeeper(specificationsDoc.getString("keeper"));
                wine.specifications = specs;
            }

            return wine;
        } catch (Exception e) {
            System.err.println("WineDAO.getWineById: erro buscando id [" + cleanId + "]: " + e.getMessage());
            return null;
        }
    }
}
