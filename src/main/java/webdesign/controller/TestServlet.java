package webdesign.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Récupérer le "slug" de l'URL (ex: /guerre-iran)
        String pathInfo = request.getPathInfo(); 
        
        // 2. Transmettre l'info à la JSP pour vérification
        request.setAttribute("slugDetecte", pathInfo);

        // 3. Forward vers la JSP de test dans le dossier Front-Office 
        // Le chemin part de la racine de 'webapp'
        request.getRequestDispatcher("/WEB-INF/views/front-office/test.jsp")
               .forward(request, response);
    }
}