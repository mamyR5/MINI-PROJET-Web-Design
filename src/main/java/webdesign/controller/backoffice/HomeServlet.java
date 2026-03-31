package webdesign.controller.backoffice;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import webdesign.dao.ArticleDao;
import webdesign.model.Article;
import java.util.List;
import webdesign.util.DatabaseConnection;
import java.sql.Connection;

public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(Connection conn = DatabaseConnection.getConnection()) {
        if(LoginServlet.verifySession(request, response)) {

            ArticleDao articleDAO = new ArticleDao();
            List<Article> articles = articleDAO.findAll(conn);
            request.setAttribute("articles", articles);
            request.setAttribute("articleCount", articles.size());
            request.getRequestDispatcher("/WEB-INF/views/back-office/home.jsp")
                .forward(request, response);
        }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/home");
        }

        
    }
}
