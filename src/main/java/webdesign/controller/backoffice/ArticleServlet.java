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

                ArticleDao articleDAO = new ArticleDao();
                if(id==null || slug==null || date==null) {
                    
                    List<Article> articles = articleDAO.findAll(conn);
                    request.setAttribute("articles", articles);
                    request.getRequestDispatcher("/WEB-INF/views/back-office/article/list.jsp")
                    .forward(request, response);
                }else{
                    Article article = articleDAO.findByIdAndSlug(Integer.parseInt(id), slug , conn);
                    request.setAttribute("article", article);
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
