package webdesign.controller.backoffice;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import webdesign.util.*;
import java.util.List;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import webdesign.dao.*;
import webdesign.model.*;

public class RedactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

        try(Connection conn = DatabaseConnection.getConnection()) {
            
            if(LoginServlet.verifySession(request, response)){


                String idArticle = request.getParameter("idArticle");
                String slug = request.getParameter("slug");
                
                if(idArticle!=null && slug!=null){

                    ArticleDao articleDAO = new ArticleDao();
                    Article article = articleDAO.findByIdAndSlug(conn, Integer.parseInt(idArticle), slug);
                    ImageDao imageDAO = new ImageDao();
                    List<Image> images = imageDAO.findByArticleId(conn,Integer.parseInt(idArticle));
                    request.setAttribute("images", images);
                    request.setAttribute("article", article);
                    request.setAttribute("articleId", idArticle);
                    request.setAttribute("articleSlug", slug);
                }
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

        String idArticle = request.getParameter("id_article");
        String title = request.getParameter("titre");
        String content = request.getParameter("contenu");
        String idCategorie = request.getParameter("id_categorie");
        String idutilisateur = request.getParameter("id_utilisateur");
        String altImage = request.getParameter("alt_image");
        
        // 1. Définir le patron (Pattern) pour le titre H1
        Pattern pattern = Pattern.compile("<h1>(.*?)</h1>", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(content);

        

        String urlArticle = "";
        String slug = "";

        if (matcher.find()) {
            // 2. Récupérer le texte capturé
            String rawTitle = matcher.group(1); 
            
            // 3. Transformer en slug (minuscules, pas d'accents, tirets)
            slug = rawTitle.toLowerCase()
                        .replaceAll("[^a-z0-9 ]", "") 
                        .trim()
                        .replaceAll("\\s+", "-");
        }
        
        
        System.out.println("Titre: " + title);
        System.out.println("Contenu: " + content);
        System.out.println("idCatégorie: " + idCategorie);
        System.out.println("idUtilisateur: " + idutilisateur);
        System.out.println("Description de l'image: " + altImage);
        System.out.println("Slug: " + slug);

        Part filePart = request.getPart("image"); 
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = "article_" + System.currentTimeMillis() + ".jpg";
            String uploadPath = "/uploads_data/" + fileName;
            System.out.println("Chemin de sauvegarde de l'image: " + uploadPath);
            try (Connection conn = DatabaseConnection.getConnection()){
                
                ImageUtil imageUtil = new ImageUtil();
                InputStream is = filePart.getInputStream();
                imageUtil.saveAndResizeImage(is, uploadPath);  

                Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

                CategorieDao categorieDAO = new CategorieDao();
                Categorie categorie = categorieDAO.findById(conn,Integer.parseInt(idCategorie));
                Article article = new Article(0, title, content, currentTimestamp, categorie, Integer.parseInt(idutilisateur));

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String dateFormatee = sdf.format(article.getDatePublication());

                article.setSlug(slug);

                ArticleDao articleDAO = new ArticleDao();
                int idArticle = articleDAO.save(article, conn);

                urlArticle = idArticle+"-"+slug+"-"+dateFormatee;

                System.out.println("url article: " + urlArticle);
                articleDAO.updateUrl(idArticle, urlArticle, conn);
                Image image = new Image(0, uploadPath, altImage, idArticle);
                ImageDao imageDAO = new ImageDao();
                imageDAO.save(image, conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/home");
    }

}
