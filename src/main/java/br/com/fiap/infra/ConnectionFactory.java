package br.com.fiap.infra;

import br.com.fiap.Global;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    private ConnectionFactory(){}

    public static Connection getConnection(){
        try{
            return DriverManager.getConnection(Global.DB_URL, Global.DB_USER, Global.DB_PASSWORD);
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

}
