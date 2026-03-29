package webdesign.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
             int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("articleId", id);
        

        request.getRequestDispatcher("/WEB-INF/views/front-office/test.jsp")
               .forward(request, response);
    }
}