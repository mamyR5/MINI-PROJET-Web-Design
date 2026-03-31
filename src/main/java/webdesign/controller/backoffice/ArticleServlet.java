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
import webdesign.model.Article;
import java.util.List;


public class ArticleServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try(Connection conn = DatabaseConnection.getConnection()) {

            if(LoginServlet.verifySession(request, response)) {
                String id = request.getParameter("id");
                String slug = request.getParameter("slug");
                String date = request.getParameter("date");

                System.out.println("id = " + id);
                System.out.println("slug = " + slug);
                System.out.println("date = " + date);

                ArticleDao articleDAO = new ArticleDao();
                if(id==null || slug==null || date==null) {
                    
                    List<Article> articles = articleDAO.findAll(conn);
                    request.setAttribute("articles", articles);
                    request.getRequestDispatcher("/WEB-INF/views/back-office/article/list.jsp")
                    .forward(request, response);
                }else{
                    Article article = articleDAO.findByIdAndSlug(Integer.parseInt(id), slug , conn);
                    ImageDao imageDAO = new ImageDao();
                    List<Image> images = imageDAO.findImagesByArticleId(Integer.parseInt(id), conn);
                    request.setAttribute("images", images);
                    request.setAttribute("article", article);
                    request.setAttribute("articleId", id);
                    request.setAttribute("articleSlug", slug);
                    request.setAttribute("articleDate", date);

                    request.getRequestDispatcher("/WEB-INF/views/back-office/article/fiche.jsp")
                    .forward(request, response);
                }
                
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/home");
        }

       
    }

}
