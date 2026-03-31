package webdesign.dao;

import webdesign.model.Image;
import webdesign.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImageDao {

    public void save(Image image, Connection con) throws SQLException {
        String sql = "INSERT INTO image (fichier, alt, id_article) VALUES (?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, image.getFichier()); // C'est ici que tu mets ton /uploads_data/nom.jpg
            ps.setString(2, image.getAlt());     // Obligatoire pour le sujet [cite: 16]
            ps.setInt(3, image.getIdArticle());

            ps.executeUpdate();
        }
    }

    public void updateByArticle(Image image, Connection conn) throws SQLException {
    String sql = "UPDATE image SET fichier = ?, alt = ? WHERE id_article = ?";
    
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, image.getFichier());
        pstmt.setString(2, image.getAlt());
        pstmt.setInt(3, image.getIdArticle());

        pstmt.executeUpdate();
    }
    }

    // Récupérer toutes les images d'un article
    public List<Image> findByArticleId(Connection conn, int idArticle) {
        List<Image> images = new ArrayList<>();
        String sql = "SELECT id, fichier, alt, id_article "
                + "FROM image WHERE id_article = ?";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idArticle);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Image img = new Image();
                img.setId(rs.getInt("id"));
                img.setFichier(rs.getString("fichier"));
                img.setAlt(rs.getString("alt"));
                img.setIdArticle(rs.getInt("id_article"));
                images.add(img);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    // Récupérer la première image d'un article (pour la vignette sur l'accueil)
    public Image findFirstByArticleId(Connection conn, int idArticle) {
        Image image = null;
        String sql = "SELECT id, fichier, alt, id_article "
                + "FROM image WHERE id_article = ? LIMIT 1";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idArticle);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                image = new Image();
                image.setId(rs.getInt("id"));
                image.setFichier(rs.getString("fichier"));
                image.setAlt(rs.getString("alt"));
                image.setIdArticle(rs.getInt("id_article"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return image;
    }
}
