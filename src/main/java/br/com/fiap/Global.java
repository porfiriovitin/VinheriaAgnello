package br.com.fiap;

import io.github.cdimascio.dotenv.Dotenv;

public class Global {

    private static final Dotenv dotenv = Dotenv.load();

    public static final String MONGO_INITDB_ROOT_USERNAME = dotenv.get("MONGO_INITDB_ROOT_USERNAME");
    public static final String MONGO_INITDB_ROOT_PASSWORD = dotenv.get("MONGO_INITDB_ROOT_PASSWORD");
    public static final String MONGO_DB_NAME = dotenv.get("MONGO_DB_NAME");

    public static final String MONGO_CONNECTION_STRING =
            "mongodb+srv://" + MONGO_INITDB_ROOT_USERNAME + ":" + MONGO_INITDB_ROOT_PASSWORD
                    + "@fiap.lcuvyoq.mongodb.net/" + MONGO_DB_NAME;

    private Global() {
    }
}