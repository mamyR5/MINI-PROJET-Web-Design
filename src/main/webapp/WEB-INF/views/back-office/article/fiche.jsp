<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="webdesign.model.*" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Fiche Article | News Web Site</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/dashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/fiche-article.css">
    </head>
    <body>
        <%
            // Récupération des données du Servlet
            Article article = (Article) request.getAttribute("article");
            List<Image> images = (List<Image>) request.getAttribute("images");
            String dateStr = (String) request.getAttribute("articleDate");
        %>

        <div class="dashboard-layout">
            <jsp:include page="/WEB-INF/fragments/sidebar.jsp" />

            <main class="main-content">
                <!-- Fil d'ariane / Retour -->
                <div class="top-actions">
                    <a href="${pageContext.request.contextPath}/admin/home" class="btn-back">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
                        Retour à la liste
                    </a>
                    <div class="action-group">
                        <a href="${pageContext.request.contextPath}/admin/redaction/<%= article.getId() %>-<%=article.getSlug()%>"
                            class="action-item edit"
                            title="Modifier"
                            onclick="event.stopPropagation();">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                            </svg>
                        </a>
                    </div>
                </div>

                <article class="fiche-container">
                    <!-- En-tête de la fiche -->
                    <header class="fiche-header">
                        <span class="category-badge"><%= article.getCategorie().getDesignation() %></span>
                        <h1 class="article-title"><%= article.getTitre() %></h1>
                        <div class="article-meta">
                            <span class="meta-item">Publié le <%= dateStr %></span>
                        </div>
                    </header>

                    <!-- Galerie d'images -->
                    <% if (images != null && !images.isEmpty()) { %>
                    <div class="fiche-gallery">
                        <div class="main-image">
                            <!-- On affiche la première image en grand -->
                            <img src="<%= images.get(0).getFichier() %>"
                            alt="<%= images.get(0).getAlt() %>">
                            <p class="image-caption"><%= images.get(0).getAlt() %></p>
                        </div>

                        <% if (images.size() > 1) { %>
                        <div class="thumbnail-grid">
                            <% for (int i = 1; i < images.size(); i++) { %>
                            <img src="<%= images.get(i).getFichier() %>"
                            alt="<%= images.get(i).getAlt() %>" class="thumb">
                            <% } %>
                        </div>
                        <% } %>
                    </div>
                    <% } %>

                    <!-- Corps de l'article -->
                    <div class="fiche-content">
                        <div class="content-label">Contenu de la rédaction</div>
                        <div class="inner-html">
                            <%= article.getContenu() %>
                        </div>
                    </div>
                </article>
            </main>
        </div>
    </body>
</html>