<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
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
      
    </script>
</head>
<body>

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
                <form action="${pageContext.request.contextPath}/admin/article/insert" method="post">
                    
                    <!-- Titre de l'article -->
                    <div class="form-group">
                        <label for="titre">Titre de l'actualité</label>
                        <input type="text" id="titre" name="titre" onkeyup="generateSlug()" placeholder="Ex: Un nouveau building inauguré..." required>
                    </div>

                        <!-- Catégorie -->
                        <div class="form-group">
                            <label for="id_categorie">Rubrique / Catégorie</label>
                            <select id="id_categorie" name="id_categorie" required>
                                <option value="">-- Choisir une rubrique --</option>
                                <option value="1" %>Catégorie 1</option>
                            </select>
                        </div>


                    <!-- Éditeur TinyMCE -->
                    <div class="form-group">
                        <label for="contenu">Corps de l'article</label>
                        <textarea id="contenu" name="contenu" placeholder="Écrivez votre article ici..."></textarea>
                    </div>

                    <!-- Champs cachés (ID Utilisateur depuis la session) -->
                    <input type="hidden" name="id_utilisateur" value="<%= session.getAttribute("userId") != null ? session.getAttribute("userId") : 1 %>">

                    <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                        <button type="submit" class="btn-submit">Publier l'article</button>
                    </div>

                </form>
            </div>
        </main>
    </div>

</body>
</html>