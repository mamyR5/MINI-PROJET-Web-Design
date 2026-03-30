package webdesign.controller.backoffice;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(LoginServlet.verifySession(request, response)) {
            request.getRequestDispatcher("/WEB-INF/views/back-office/home.jsp")
                .forward(request, response);
        }

        
    }
}
