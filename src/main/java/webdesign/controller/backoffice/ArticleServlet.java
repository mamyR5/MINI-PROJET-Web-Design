package webdesign.controller.backoffice;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ArticleServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if(LoginServlet.verifySession(request, response)) {
             request.getRequestDispatcher("/WEB-INF/views/back-office/article/list.jsp")
                .forward(request, response);
        }

       
    }

}
