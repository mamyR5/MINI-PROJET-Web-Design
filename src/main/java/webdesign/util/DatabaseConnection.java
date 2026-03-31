package webdesign.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://db:5432/web_design_db";
    private static final String USER = "user_admin";
    private static final String PASSWORD = "password123";

    public static Connection getConnection() throws SQLException {
        try {
            // 1. Charger explicitement le driver PostgreSQL
            Class.forName("org.postgresql.Driver");
            
            // 2. Créer et retourner la connexion
            return DriverManager.getConnection(URL, USER, PASSWORD);
            
        } catch (ClassNotFoundException e) {
            throw new SQLException("Pilote PostgreSQL non trouvé", e);
        }
    }
}
