<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="webdesign.model.Categorie" %>
<%@ page import="webdesign.model.Article" %>
<%@ page import="webdesign.model.Image" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        Categorie categorie = (Categorie) request.getAttribute("categorie");
        List<Article> articles = (List<Article>) request.getAttribute("articles");
        Map<Integer, Image> imagesMap = (Map<Integer, Image>) request.getAttribute("imagesMap");
        List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy", new java.util.Locale("fr"));
    %>
    <meta name="description" content="Articles sur <%= categorie.getDesignation() %> — Guerre en Iran">
    <title><%= categorie.getDesignation() %> — Guerre en Iran</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/categorie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/footer.css">
</head>
<body>

<%@ include file="/WEB-INF/views/front-office/navbar.jsp" %>

<!-- EN-TÊTE CATÉGORIE -->
<div class="categorie-header">
    <span class="categorie-badge"
          style="background:<%= categorie.getCouleurFond() %>;
                 color:<%= categorie.getCouleurTexte() %>;">
        <%= categorie.getDesignation() %>
    </span>
    <div>
        <div class="categorie-titre">Articles — <%= categorie.getDesignation() %></div>
        <div class="categorie-count">
            <%= articles.size() %> article<%= articles.size() > 1 ? "s" : "" %> dans cette catégorie
        </div>
    </div>
</div>

<div class="main">
    <div class="articles">

        <div class="section-title">Articles de la catégorie</div>
        <a href="${pageContext.request.contextPath}/accueil" class="btn-retour">← Retour à l'accueil</a>

        <!-- CAS : AUCUN ARTICLE -->
        <% if (articles == null || articles.isEmpty()) { %>
        <div class="empty-state">
            Aucun article dans cette catégorie pour le moment.
        </div>

        <!-- CAS : ARTICLES TROUVÉS -->
        <% } else {
            for (Article art : articles) {
                Image img = imagesMap.get(art.getId());
        %>
        <div class="article-card">
            <div class="article-img">
                <% if (img != null) { %>
                <img src="${pageContext.request.contextPath}/assets/uploads/<%= img.getFichier() %>"
                     alt="<%= img.getAlt() %>"/>
                <% } else { %>
                <div class="img-placeholder"></div>
                <% } %>
            </div>
            <div class="article-body">
                <div class="article-meta">
                    <span class="badge"
                          style="background:<%= categorie.getCouleurFond() %>;
                                 color:<%= categorie.getCouleurTexte() %>;">
                        <%= categorie.getDesignation() %>
                    </span>
                    <span class="article-date"><%= sdf.format(art.getDatePublication()) %></span>
                </div>
                <div class="article-title"><%= art.getTitre() %></div>
                <div class="article-excerpt">
                    <%= art.getContenu().replaceAll("<[^>]*>", "").substring(0,
                        Math.min(200, art.getContenu().replaceAll("<[^>]*>", "").length())) %>...
                </div>
                <a href="${pageContext.request.contextPath}/article/<%= art.getId() %>-<%= art.getTitre().toLowerCase().replace(" ", "-") %>"
                   class="read-more">Lire l'article →</a>
            </div>
        </div>
        <% } } %>

    </div>

    <!-- SIDEBAR -->
    <%@ include file="/WEB-INF/views/front-office/sidebar.jsp" %>
</div>

<%@ include file="/WEB-INF/views/front-office/footer.jsp" %>
</body>
</html>