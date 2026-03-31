package webdesign.controller.frontoffice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdesign.dao.ArticleDao;
import webdesign.dao.CategorieDao;
import webdesign.dao.ImageDao;
import webdesign.model.Article;
import webdesign.model.Categorie;
import webdesign.model.Image;
import webdesign.util.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/categorie")
public class CategorieDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        // Sécurité : si pas d'id, redirige vers l'accueil
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/accueil");
            return;
        }

        int id = Integer.parseInt(idParam);

        ArticleDao articleDao = new ArticleDao();
        CategorieDao categorieDao = new CategorieDao();
        ImageDao imageDao = new ImageDao();
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Récupère la catégorie
            Categorie categorie = categorieDao.findById(conn, id);

            // Sécurité : si catégorie introuvable, redirige vers l'accueil
            if (categorie == null) {
                response.sendRedirect(request.getContextPath() + "/accueil");
                return;
            }

            // Récupère les articles de cette catégorie
            List<Article> articles = articleDao.findByCategorie(conn, id);

            // Récupère la première image de chaque article
            Map<Integer, Image> imagesMap = new HashMap<>();
            for (Article article : articles) {
                Image img = imageDao.findFirstByArticleId(conn, article.getId());
                if (img != null) {
                    imagesMap.put(article.getId(), img);
                }
            }

            // Récupère toutes les catégories pour le menu
            request.setAttribute("categorie", categorie);
            request.setAttribute("articles", articles);
            request.setAttribute("imagesMap", imagesMap);
            request.setAttribute("categories", categorieDao.findAll(conn));

            request.getRequestDispatcher("/WEB-INF/views/front-office/categorie.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            throw new ServletException("erreur : "+e.getMessage());
        }
    }

}