package br.com.fiap.infra;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import br.com.fiap.Global;

public class ConnectionFactory {

    private static MongoClient mongoClient;

    private ConnectionFactory(){}

    public static MongoDatabase getDatabase() {
        if (mongoClient == null) {
            String uri = "mongodb://" + Global.MONGO_INITDB_ROOT_USERNAME + ":" +
                    Global.MONGO_INITDB_ROOT_PASSWORD + "@localhost:27017";
            mongoClient = MongoClients.create(uri);
        }
        return mongoClient.getDatabase(Global.MONGO_DB_NAME);
    }
}
