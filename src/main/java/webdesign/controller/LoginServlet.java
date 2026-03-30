package webdesign.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import webdesign.entity.Role;
import webdesign.dao.UtilisateurDAO;
import webdesign.database.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import webdesign.entity.Utilisateur;

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

                System.out.println("Role = "+userRole.getDesignation());

                if(userRole.getDesignation().equals("Admin")){
                    response.sendRedirect(request.getContextPath() + "/admin/home");
                }else{
                    throw new Exception("Utilisateur non autoris&eacute.");
                }
                
            } else {
                throw new Exception("Utilisateur non authentifi&eacute.");
            }

        } catch (Exception ex) {
            response.sendRedirect(request.getContextPath() + "/admin/login?error=" + ex.getMessage());
        }

        /*Connection connexion = null;

        try{
            connexion = DbConnection.getConnection();
            System.out.println("Mandeha ilay connection.");
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            if(connexion!=null){
                try {
                    connexion.close(); 
                    System.out.println("Connexion fermée avec succès.");
                } catch (SQLException e) {
                    e.printStackTrace(); // Erreur lors de la fermeture
                }
            }
        }*/
    }

}
