package webdesign.dao;

import webdesign.model.Article;
import webdesign.model.Categorie;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticleDao {

    public int save(Article article, Connection con) throws SQLException {
        String sql = "INSERT INTO article (titre, contenu, id_categorie, id_utilisateur,date_publication,slug) VALUES (?, ?, ?, ?, ?, ?) RETURNING id";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, article.getTitre());
            ps.setString(2, article.getContenu());
            ps.setInt(3, article.getCategorie().getId());
            ps.setInt(4, article.getIdUtilisateur());
            ps.setTimestamp(5, article.getDatePublication());
            ps.setString(6, article.getSlug());

            // On utilise executeQuery() car RETURNING id renvoie un ResultSet
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // On récupère l'ID généré
            }
        }
        return -1;
    }

    public void updateUrl(int idArticle, String url, Connection con) throws SQLException {
        String sql = "UPDATE article SET url = ? WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, url);
            ps.setInt(2, idArticle);
            ps.executeUpdate();
        }
    }

    public List<Article> findAll(Connection conn) {
        List<Article> articles = new ArrayList<>();
        String sql = "SELECT a.id,a.titre,a.slug,a.url,a.date_publication,c.designation,c.couleur_fond,c.couleur_texte,a.id_categorie FROM article a JOIN categorie c ON c.id = a.id_categorie ORDER BY date_publication DESC";

        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Article article = new Article();
                article.setId(rs.getInt("id"));
                article.setTitre(rs.getString("titre"));
                article.setSlug(rs.getString("slug"));
                article.setUrl(rs.getString("url"));
                article.setDatePublication(rs.getTimestamp("date_publication"));
                Categorie categorie = new Categorie();
                categorie.setId(rs.getInt("id_categorie"));
                categorie.setDesignation(rs.getString("designation"));
                categorie.setCouleurFond(rs.getString("couleur_fond"));
                categorie.setCouleurTexte(rs.getString("couleur_texte"));
                article.setCategorie(categorie);
                articles.add(article);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return articles;
    }

    public void update(Article article, Connection conn) throws SQLException {
        String sql = "UPDATE article SET titre = ?, contenu = ?, id_categorie = ?, slug = ?, url = ? WHERE id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, article.getTitre());
            pstmt.setString(2, article.getContenu());
            pstmt.setInt(3, article.getCategorie().getId());
            pstmt.setString(4, article.getSlug());
            pstmt.setString(5, article.getUrl());

            // C'est ici qu'on précise quel article modifier
            pstmt.setInt(6, article.getId());

            pstmt.executeUpdate();
        }
    }

    public Article findByIdAndSlug(Connection conn, int id, String slug) {
        Article article = null;
        String sql = "SELECT a.id, titre, contenu, date_publication, "
                + "id_categorie, id_utilisateur, designation, couleur_fond, couleur_texte "
                + "FROM article a "
                + "JOIN categorie c "
                + "ON c.id = a.id_categorie "
                + "WHERE a.id = ? AND a.slug = ?";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, slug);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                article = mapArticle(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return article;
    }

    // Récupérer les 10 derniers articles pour l'accueil
    public List<Article> findLatest(Connection conn) {
        List<Article> articles = new ArrayList<>();
        String sql = "SELECT a.id, titre, contenu, date_publication, "
                + "id_categorie, id_utilisateur,designation,couleur_fond,couleur_texte "
                + "FROM article a "
                + "JOIN  categorie c "
                + "ON c.id = a.id_categorie "
                + "ORDER BY date_publication DESC LIMIT 10";

        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                articles.add(mapArticle(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return articles;
    }

    // Récupérer un article par son id (page détail)
    public Article findById(Connection conn, int id) {
        Article article = null;
        String sql = "SELECT a.id, titre, contenu, date_publication, "
                + "id_categorie, id_utilisateur, designation, couleur_fond, couleur_texte "
                + "FROM article a "
                + "JOIN categorie c "
                + "ON c.id = a.id_categorie "
                + "WHERE a.id = ?";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                article = mapArticle(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return article;
    }

    // Récupérer les articles d'une catégorie
    public List<Article> findByCategorie(Connection conn, int idCategorie) {
        List<Article> articles = new ArrayList<>();
        String sql = "SELECT a.id, titre, contenu, date_publication, "
                + "id_categorie, id_utilisateur, designation, couleur_fond, couleur_texte "
                + "FROM article a "
                + "JOIN categorie c "
                + "ON c.id = a.id_categorie "
                + "WHERE a.id_categorie = ? "
                + "ORDER BY date_publication DESC";

        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCategorie);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                articles.add(mapArticle(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articles;
    }

    // Méthode utilitaire pour éviter la répétition
    // Transforme une ligne SQL en objet Article
    private Article mapArticle(ResultSet rs) throws SQLException {
        Article article = new Article();
        Categorie categorie = new Categorie();
        article.setId(rs.getInt("id"));
        article.setTitre(rs.getString("titre"));
        article.setContenu(rs.getString("contenu"));
        article.setDatePublication(rs.getTimestamp("date_publication"));
        article.setCategorie(categorie);
        categorie.setId(rs.getInt("id_categorie"));
        if (rs.getString("designation") != null) {
            categorie.setDesignation(rs.getString("designation"));
        }
        if (rs.getString("couleur_fond") != null) {
            categorie.setCouleurFond(rs.getString("couleur_fond"));
        }
        if (rs.getString("couleur_texte") != null) {
            categorie.setCouleurTexte(rs.getString("couleur_texte"));
        }
        article.setIdUtilisateur(rs.getInt("id_utilisateur"));
        return article;
    }
}
