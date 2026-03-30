package webdesign.controller.backoffice;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import webdesign.util.*;
import java.sql.SQLException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import webdesign.dao.CategorieDao;

public class RedactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

        try(Connection conn = DatabaseConnection.getConnection()) {
            
            if(LoginServlet.verifySession(request, response)){

                CategorieDao categorieDAO = new CategorieDao();
                
                request.setAttribute("categories", categorieDAO.findAll(conn));
                request.getRequestDispatcher("/WEB-INF/views/back-office/article/form.jsp")
                    .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/home");
        }
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        String title = request.getParameter("titre");
        String content = request.getParameter("contenu");
        String idCategorie = request.getParameter("id_categorie");
        String idutilisateur = request.getParameter("id_utilisateur");

        System.out.println("Titre: " + title);
        System.out.println("Contenu: " + content);
        System.out.println("idCatégorie: " + idCategorie);
        System.out.println("idUtilisateur: " + idutilisateur);
        
        Part filePart = request.getPart("image"); 
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = "article_" + System.currentTimeMillis() + ".jpg";
            String uploadPath = "/uploads_data/" + fileName;
            System.out.println("Chemin de sauvegarde de l'image: " + uploadPath);
            
            try {
                ImageUtil imageUtil = new ImageUtil();
                InputStream is = filePart.getInputStream();
                imageUtil.saveAndResizeImage(is, uploadPath);        
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        


        response.sendRedirect(request.getContextPath() + "/admin/home");
    }

}
