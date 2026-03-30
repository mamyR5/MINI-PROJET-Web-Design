<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="webdesign.model.*" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Liste des Articles | News Web Site</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/dashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/list-article.css">
    </head>
    <body>
        <%
            List<Article> articles = (List<Article>) request.getAttribute("articles");
        %>

        <div class="dashboard-layout">
            <jsp:include page="/WEB-INF/fragments/sidebar.jsp" />

            <main class="main-content">
                <!-- HEADER (NON TOUCHÉ) -->
                <header class="header-main">
                    <div>
                        <h1>Liste des Rédactions</h1>
                    </div>
                    <div class="date-now">
                        <%= new java.text.SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date()) %>
                    </div>
                </header>

                <!-- SECTION LISTE -->
                <div class="list-section">
                    <div class="list-header">
                        <h3>Toutes les rédactions</h3>
                    </div>

                    <table class="article-table">
                        <thead>
                            <tr>
                                <th>Titre de l'article</th>
                                <th>Catégorie</th>
                                <th>Auteur</th>
                                <th>Date</th>
                                <th style="text-align: right;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Article article : articles) { %>
                            <tr class="clickable-row" onclick="window.location.href='${pageContext.request.contextPath}/admin/article/detail?id=<%= article.getId() %>'">
                                <td class="title-cell">
                                    <a href="${pageContext.request.contextPath}/admin/article/detail?id=<%= article.getId() %>" class="article-link">
                                        <%= article.getTitre() %>
                                    </a>
                                </td>
                                <td><span class="badge"><%= article.getCategorie().getDesignation() %></span></td>
                                <td>Admin</td>
                                <%
                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy", java.util.Locale.FRENCH);
                                    String dateFormatee = sdf.format(article.getDatePublication());
                                %>
                                <td class="date-cell"><%= dateFormatee %></td>
                                <td class="actions-cell">
                                    <a href="${pageContext.request.contextPath}/admin/article/detail?id=<%= article.getId() %>" class="btn-action" title="Voir la fiche">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

            </main>
        </div>

    </body>
</html>