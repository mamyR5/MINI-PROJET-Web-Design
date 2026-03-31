<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="webdesign.model.*" %>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Création d'article | News Web Site</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/dashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/form-article.css">
        <script src="https://cdn.tiny.cloud/1/1bw7nmnlty6y5zcrssongzprxzqqnhea3f1zh1k2c9ac1g1o/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

        <script>
            tinymce.init({
                selector: '#contenu',
                plugins: 'advlist autolink lists link image charmap preview anchor pagebreak',
                toolbar_mode: 'floating',
                height: 400,
                border_widths: 0,
                branding: false,
                content_style: "body { font-family: 'Inter', sans-serif; font-size: 14px; }"
            });
            
            // Fonction pour prévisualiser l'image
            function previewImage(event) {
                const reader = new FileReader();
                reader.onload = function() {
                    const output = document.getElementById('image-preview');
                    output.src = reader.result;
                    output.style.display = 'block';
                    document.getElementById('upload-placeholder').style.display = 'none';
                }
                reader.readAsDataURL(event.target.files[0]);
            }
        </script>
    </head>
    <body>

        <%
            Utilisateur userSession = (Utilisateur) session.getAttribute("userSession");
            List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
            Article article = null;
            List<Image> images = null;
            if(request.getAttribute("article")!= null) {
                article = (Article) request.getAttribute("article");
                images = (List<Image>) request.getAttribute("images");
            }
            
        %>
        <div class="dashboard-layout">
            <jsp:include page="/WEB-INF/fragments/sidebar.jsp" />

            <main class="main-content">
                <header class="header-main">
                    <div>
                        <h1>Nouvelle Rédaction</h1>
                        <p>Rédigez un article pour l'édition du jour</p>
                    </div>
                    <div class="date-now">
                        <%= new java.text.SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date()) %>
                    </div>
                </header>

                <div class="form-container">
                    <!-- AJOUT DE enctype="multipart/form-data" -->
                    <form action="${pageContext.request.contextPath}/redaction" method="post" enctype="multipart/form-data">

                        <>%-- Champ caché pour l'ID de l'article (utile pour la modification) --%>
                        <input type="hidden" name="id_article" value="<%= article != null ? article.getId() : "" %>">

                        <div class="form-group">
                            <label for="titre">Titre de l'actualité</label>
                            <input type="text" id="titre" name="titre" placeholder="Ex: Un nouveau building inauguré..."  value="<%= article != null ? article.getTitre() : "" %>" required>
                        </div>

                        <div class="form-group">
                            <label for="id_categorie">Rubrique / Catégorie</label>
                            <select id="id_categorie" name="id_categorie"  required>
                                <option value="">-- Choisir une rubrique --</option>
                                <% for (Categorie cat : categories) {
                                String selected = (article!=null && cat.getId() == article.getCategorie().getId()) ? "selected" : "";%>
                                <option value="<%= cat.getId() %>"<%= selected %> ><%= cat.getDesignation() %></option>
                                <% } %>
                            </select>
                        </div>

                        <!-- BLOC UPLOAD D'IMAGE -->
                        <div class="form-group">
                            <label>Image de couverture</label>
                            <div class="image-upload-wrapper">
                                <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)" required>
                                <div class="image-upload-design">
                                    <div id="upload-placeholder">
                                        <% if (images == null || images.isEmpty()) { %>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                            <circle cx="8.5" cy="8.5" r="1.5"></circle>
                                            <polyline points="21 15 16 10 5 21"></polyline>
                                        </svg>

                                        <p>Cliquez pour ajouter une photo de couverture</p>
                                        <% } %>
                                    </div>
                                    <img id="image-preview" src="<%= images != null ? images.get(0).getFichier() : "" %>" alt="Aperçu" style="<% if (images == null || images.isEmpty()) { %>display:none;<% } %> max-width: 100%; border-radius: 8px;">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="alt_image">Description de l'image</label>
                            <input type="text" id="alt_image" name="alt_image" value="<%= article != null ? images.get(0).getAlt() : "" %>" placeholder="Ex: Façade du nouveau building de la presse sous le soleil" required>
                        </div>

                        <div class="form-group">
                            <label for="contenu">Corps de l'article</label>
                            <textarea id="contenu" name="contenu" placeholder="Écrivez votre article ici..."><%= article != null ? article.getContenu() : "" %></textarea>
                        </div>

                        <input type="hidden" name="id_utilisateur" value="<%= userSession.getId() %>">

                        <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                            <button type="submit" class="btn-submit">Publier l'article</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>

    </body>
</html>