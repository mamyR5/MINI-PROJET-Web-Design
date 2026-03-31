package webdesign.controller.backoffice;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LogOutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalider la session pour déconnecter l'utilisateur
        HttpSession session = request.getSession(false); // Récupérer la session existante sans en créer une nouvelle
        if (session != null) {
            session.invalidate(); // Invalider la session
        }
        // Rediriger vers la page de connexion ou d'accueil après la déconnexion
        response.sendRedirect(request.getContextPath() + "/admin/login");
    }
}