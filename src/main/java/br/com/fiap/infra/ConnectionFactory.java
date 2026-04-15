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
            String uri = Global.MONGO_CONNECTION_STRING;
            mongoClient = MongoClients.create(uri);
        }
        return mongoClient.getDatabase("vinheriaagnello");
    }
}
