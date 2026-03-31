package webdesign.controller.backoffice;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import webdesign.util.DatabaseConnection;
import java.sql.Connection;
import webdesign.dao.ArticleDao;
import webdesign.dao.ImageDao;
import webdesign.model.Image;
import webdesign.model.Article;
import java.util.List;
import java.sql.Timestamp;


public class ArticleServlet extends HttpServlet {
    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    try (Connection conn = DatabaseConnection.getConnection()) {
        if (LoginServlet.verifySession(request, response)) {
            
            String id = request.getParameter("id");
            String slug = request.getParameter("slug");
            String date = request.getParameter("date");
            String action = request.getParameter("action");
            
            ArticleDao articleDAO = new ArticleDao();

            // 1. PRIORITÉ : On vérifie d'abord si on veut supprimer
            if ("delete".equals(action) && id != null) {

                System.out.println("id = "+id);
                System.out.println("slug = "+slug);
                System.out.println("action = "+action);

                int idArticle = Integer.parseInt(id);
                Timestamp now = new Timestamp(System.currentTimeMillis());
                articleDAO.updateDateSuppression(idArticle, now, conn);
                
                response.sendRedirect(request.getContextPath() + "/admin/home");
                return; // Très important pour arrêter l'exécution ici
            }

            // 2. Ensuite, on vérifie si on doit afficher une fiche (id + slug + date présents)
            if (id != null && slug != null && date != null) {
                Article article = articleDAO.findByIdAndSlug(conn, Integer.parseInt(id), slug);
                ImageDao imageDAO = new ImageDao();
                List<Image> images = imageDAO.findByArticleId(conn, Integer.parseInt(id));
                
                request.setAttribute("images", images);
                request.setAttribute("article", article);
                request.getRequestDispatcher("/WEB-INF/views/back-office/article/fiche.jsp").forward(request, response);
            } 
            // 3. PAR DÉFAUT : On affiche la liste
            else {
                List<Article> articles = articleDAO.findAll(conn);
                request.setAttribute("articles", articles);
                request.getRequestDispatcher("/WEB-INF/views/back-office/article/list.jsp").forward(request, response);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/admin/home?error=true");
    }
}

}
