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
import webdesign.model.Image;
import webdesign.util.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/accueil")
public class AccueilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArticleDao articleDao = new ArticleDao();
        CategorieDao categorieDao = new CategorieDao();
        ImageDao imageDao = new ImageDao();
        
         try (Connection c = DatabaseConnection.getConnection();){
            // Récupère les 10 derniers articles
            List<Article> articles = articleDao.findLatest(c);
    
            // Récupère la première image de chaque article
            // Map<idArticle, Image>
            Map<Integer, Image> imagesMap = new HashMap<>();
            for (Article article : articles) {
                Image img = imageDao.findFirstByArticleId(c,article.getId());
                if (img != null) {
                    imagesMap.put(article.getId(), img);
                }
            }
            System.out.println("taille articles: "+articles.size());
             // Récupère toutes les catégories pour le menu
             request.setAttribute("articles", articles);
             request.setAttribute("imagesMap", imagesMap);
            request.setAttribute("categories", categorieDao.findAll(c));
    
             request.getRequestDispatcher("/WEB-INF/views/front-office/accueil.jsp")
                    .forward(request, response);
    }  catch (Exception e) {
        //     // Affiche l'erreur dans les logs Tomcat
             e.printStackTrace();
             // Renvoie une erreur 500 au navigateur
             throw new ServletException("Erreur dans AccueilServlet", e);
         }
    }
}
