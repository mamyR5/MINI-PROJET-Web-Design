<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
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
        Article article = (Article) request.getAttribute("article");
        List<Image> images = (List<Image>) request.getAttribute("images");
        List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy", new java.util.Locale("fr"));
    %>
    <meta name="description" content="<%= article.getTitre() %>">
    <title><%= article.getTitre() %> — Guerre en Iran</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/article.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/footer.css">
</head>
<body>

<!-- NAVBAR -->
<%@ include file="/WEB-INF/views/front-office/navbar.jsp" %>

<!-- CONTENU PRINCIPAL -->
<div class="main">
    <div class="article-container">

        <!-- EN-TÊTE DE L'ARTICLE -->
        <div class="article-header">
            <div class="article-meta">
                <span class="badge"
                      style="background:<%= article.getCategorie().getCouleurFond() %>;
                             color:<%= article.getCategorie().getCouleurTexte() %>;">
                    <%= article.getCategorie().getDesignation() %>
                </span>
                <span class="article-date">
                    <%= sdf.format(article.getDatePublication()) %>
                </span>
            </div>
            <h1 class="article-title"><%= article.getTitre() %></h1>
        </div>

        <!-- IMAGES DE L'ARTICLE -->
        <% if (images != null && !images.isEmpty()) { %>
        <div class="article-images">
            <% for (Image img : images) { %>
            <figure class="article-figure">
                <img src="${pageContext.request.contextPath}/assets/uploads/<%= img.getFichier() %>"
                     alt="<%= img.getAlt() %>"
                     class="article-img"/>
                <figcaption class="article-figcaption"><%= img.getAlt() %></figcaption>
            </figure>
            <% } %>
        </div>
        <% } %>

        <!-- CONTENU DE L'ARTICLE (HTML généré par TinyMCE) -->
        <div class="article-content">
            <%= article.getContenu() %>
        </div>

        <!-- LIEN RETOUR -->
        <div class="article-footer">
            <a href="${pageContext.request.contextPath}/accueil" class="btn-retour">
                ← Retour à l'accueil
            </a>
        </div>

    </div>

    <!-- SIDEBAR -->
    <%@ include file="/WEB-INF/views/front-office/sidebar.jsp" %>

<%@ include file="/WEB-INF/views/front-office/footer.jsp" %>
</body>
</html>