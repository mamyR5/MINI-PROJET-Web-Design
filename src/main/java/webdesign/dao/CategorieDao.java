package webdesign.dao;

import webdesign.model.Categorie;
import webdesign.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategorieDao {

    // Récupérer toutes les catégories (pour le menu de navigation)
    public List<Categorie> findAll(Connection conn) {
        List<Categorie> categories = new ArrayList<>();
        String sql = "SELECT id, designation FROM categorie";

        try (
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categorie c = new Categorie();
                c.setId(rs.getInt("id"));
                c.setDesignation(rs.getString("designation"));
                categories.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Récupérer une catégorie par son id
    public Categorie findById(Connection conn,int id) {
        Categorie categorie = null;
        String sql = "SELECT id, designation FROM categorie WHERE id = ?";

        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                categorie = new Categorie();
                categorie.setId(rs.getInt("id"));
                categorie.setDesignation(rs.getString("designation"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorie;
    }

}