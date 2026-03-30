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
import java.util.List;

@WebServlet("/article")
public class ArticleDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupère l'id depuis l'URL (/article?id=5)
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
        try (Connection conn= DatabaseConnection.getConnection()) {
            
            // Récupère l'article
            Article article = articleDao.findById(conn,id);
    
            // Sécurité : si article introuvable, redirige vers l'accueil
            if (article == null) {
                response.sendRedirect(request.getContextPath() + "/accueil");
                return;
            }
    
            // Récupère la catégorie de l'article
            Categorie categorie = categorieDao.findById(conn,article.getCategorie().getId());
    
            // Récupère toutes les images de l'article
            List<Image> images = imageDao.findByArticleId(conn,id);
    
            // Récupère toutes les catégories pour le menu
            request.setAttribute("article", article);
            request.setAttribute("categorie", categorie);
            request.setAttribute("images", images);
            request.setAttribute("categories", categorieDao.findAll(conn));
    
            request.getRequestDispatcher("/WEB-INF/views/front-office/article.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            throw new ServletException("erreur: "+e.getMessage());
        }
    }
}