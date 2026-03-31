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
    <meta name="description" content="Suivez les dernières actualités sur la guerre en Iran — analyses, reportages et décryptages.">
    <title>Actualités sur la guerre en Iran</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/accueil.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/frontoffice/footer.css">
</head>
<body>
<%
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
    List<Article> articles = (List<Article>) request.getAttribute("articles");
    Map<Integer, Image> imagesMap = (Map<Integer, Image>) request.getAttribute("imagesMap");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy", new java.util.Locale("fr"));

    // Sécurité : vérifier que la liste n'est pas vide
    Article aLaUne = (articles != null && !articles.isEmpty()) ? articles.get(0) : null;
%>

<!-- NAVBAR -->
<%@ include file="/WEB-INF/views/front-office/navbar.jsp" %>

<!-- HERO -->
<div class="hero">
    <h1>Actualités sur la guerre en Iran</h1>
    <p>Suivez les dernières informations sur le conflit — analyses, reportages et décryptages.</p>
</div>

<div class="main">
    <div class="articles">

        <!-- ARTICLE À LA UNE -->
        <% if (aLaUne != null) { %>
        <div class="section-title">À la une</div>
        <div class="article-card featured">
            <div class="article-img">
                <% Image imgUne = imagesMap.get(aLaUne.getId());
                   if (imgUne != null) { %>
                <img src="<%= imgUne.getFichier() %>"
                     alt="<%= imgUne.getAlt() %>"/>
                <% } else { %>
                <div class="img-placeholder"></div>
                <% } %>
            </div>
            <div class="article-body">
                <div class="article-meta">
                    <span class="badge"
                          style="background:<%= aLaUne.getCategorie().getCouleurFond() %>;
                                 color:<%= aLaUne.getCategorie().getCouleurTexte() %>;">
                        <%= aLaUne.getCategorie().getDesignation() %>
                    </span>
                    <span class="article-date"><%= sdf.format(aLaUne.getDatePublication()) %></span>
                </div>
                <div class="article-title"><%= aLaUne.getTitre().replaceAll("<[^>]*>", "") %></div>
                <div class="article-excerpt">
                    <!-- Extrait : on affiche le contenu sans HTML, limité à 200 caractères -->
                    <%= aLaUne.getContenu().replaceAll("<[^>]*>", "").substring(0,
                        Math.min(200, aLaUne.getContenu().replaceAll("<[^>]*>", "").length())) %>...
                </div>
                <a href="${pageContext.request.contextPath}/article/<%= aLaUne.getId() %>-<%= aLaUne.getTitre().toLowerCase().replace(" ", "-") %>"
                   class="read-more">Lire l'article →</a>
            </div>
        </div>
        <% } %>

        <!-- DERNIERS ARTICLES -->
        <div class="section-title" style="margin-top:8px;">Derniers articles</div>

        <% if (articles != null) {
            for (int i = 1; i < articles.size(); i++) {
                Article art = articles.get(i);
                Image img = imagesMap.get(art.getId());
        %>
        <div class="article-card">
            <div class="article-img">
                <% if (img != null) { %>
                <img src="<%= img.getFichier() %>"
                     alt="<%= img.getAlt() %>"/>
                <% } else { %>
                <div class="img-placeholder"></div>
                <% } %>
            </div>
            <div class="article-body">
                <div class="article-meta">
                    <span class="badge"
                          style="background:<%= art.getCategorie().getCouleurFond() %>;
                                 color:<%= art.getCategorie().getCouleurTexte() %>;">
                        <%= art.getCategorie().getDesignation() %>
                    </span>
                    <span class="article-date"><%= sdf.format(art.getDatePublication()) %></span>
                </div>
                <div class="article-title"><%= art.getTitre().replaceAll("<[^>]*>", "") %></div>
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