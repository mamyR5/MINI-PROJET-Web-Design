package webdesign.dao;

import webdesign.model.Utilisateur;
import webdesign.util.DatabaseConnection;

import java.sql.*;

public class UtilisateurDao {

    // Utilisé pour la connexion au backoffice
    public Utilisateur findByLoginAndPassword(Connection conn,String login, String motDePasse) {
        Utilisateur utilisateur = null;
        String sql = "SELECT id, nom, login, mot_de_passe " +
                     "FROM utilisateur " +
                     "WHERE login = ? AND mot_de_passe = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, login);
            ps.setString(2, motDePasse);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                utilisateur = new Utilisateur();
                utilisateur.setId(rs.getInt("id"));
                utilisateur.setNom(rs.getString("nom"));
                utilisateur.setLogin(rs.getString("login"));
                utilisateur.setMotDePasse(rs.getString("mot_de_passe"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return utilisateur;
    }
}
