package webdesign.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import webdesign.database.*;
import webdesign.model.*;

import java.util.ArrayList;
import java.util.List;

public class UtilisateurDao {

    public Utilisateur authentifier(String login, String mdp) {
        Utilisateur user = null;
        String sql = "SELECT id, nom, login , mot_de_passe FROM utilisateur WHERE login = ? AND mot_de_passe = ?";

        // Le "try-with-resources" ferme la connexion et le statement automatiquement
        try (Connection conn = DbConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // On remplace les "?" par les vraies valeurs
            pstmt.setString(1, login);
            pstmt.setString(2, mdp);

            // On exécute la lecture
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Si on trouve une ligne, on crée l'objet Utilisateur
                    user = new Utilisateur();
                    user.setId(rs.getInt("id"));
                    user.setNom(rs.getString("nom"));
                    user.setLogin(rs.getString("login"));
                    user.setMotDePasse(rs.getString("mot_de_passe"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user; // Retourne null si l'utilisateur n'est pas trouvé
    }

    public List<Role> getRolesByUtilisateurId(int idUtilisateur) {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT r.id,r.designation FROM role r "
                + "JOIN utilisateur_role ur ON r.id = ur.id_role "
                + "WHERE ur.id_utilisateur = ?";

        try (Connection conn = DbConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idUtilisateur);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Role role = new Role(rs.getInt("id"),rs.getString("designation"));
                    roles.add(role);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }
}
