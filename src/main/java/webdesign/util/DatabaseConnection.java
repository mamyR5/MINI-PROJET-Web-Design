package webdesign.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    
    private static final String URL = "jdbc:postgresql://localhost:5433/web_design_db";
    //                                                    ^^
    //                                nom du service dans docker-compose.yml
    private static final String USER = "user_admin";
    private static final String PASSWORD = "password123";
    static {
        try {
            // Charge explicitement le driver PostgreSQL
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver PostgreSQL introuvable", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}