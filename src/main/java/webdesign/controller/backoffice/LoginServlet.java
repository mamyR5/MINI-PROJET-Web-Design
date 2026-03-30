package webdesign.controller.backoffice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import webdesign.dao.backoffice.UtilisateurDAO;
import webdesign.database.DbConnection;
import webdesign.model.Role;
import webdesign.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/back-office/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            UtilisateurDAO userDAO = new UtilisateurDAO();
            Utilisateur user = userDAO.authentifier(username, password);

            if (user != null) {
                System.out.println("username = " + username + " password = " + password);
                Role userRole = userDAO.getRolesByUtilisateurId(user.getId()).get(0);

                System.out.println("Role = " + userRole.getDesignation());

                if (userRole.getDesignation().equals("Admin")) {
                    response.sendRedirect(request.getContextPath() + "/admin/home");
                } else {
                    throw new Exception("Utilisateur non autorisé.");
                }

            } else {
                throw new Exception("Utilisateur non authentifié.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/login?error=" + ex.getMessage());
        }
    }

}
