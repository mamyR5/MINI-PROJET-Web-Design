<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="webdesign.model.*" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard | News Web Site</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/dashboard.css">
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

                <!-- SECTION STATISTIQUES (Améliorée) -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon" style="background: #ecfdf5; color: #10b981;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                        </div>
                        <div class="stat-info">
                            <h3>Articles d'aujourd'hui</h3>
                            <p class="stat-number">01</p>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon" style="background: #eff6ff; color: #3b82f6;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="9" y1="21" x2="9" y2="9"></line></svg>
                        </div>
                        <div class="stat-info">
                            <h3>Total des publications</h3>
                            <p class="stat-number">10</p>
                        </div>
                    </div>
                </div>

                <!-- SECTION LISTE (Tableau Pro) -->
                <div class="list-section">
                    <div class="list-header">
                        <h3>Dernières rédactions</h3>
                        <a href="${pageContext.request.contextPath}/admin/redaction" class="btn-add-mini">+ Nouvel article</a>
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
                            <tr>
                                <td class="title-cell"><%= article.getTitre() %></td>
                                <td><span class="badge"><%= article.getCategorie().getDesignation() %></span></td>
                                <td>Admin</td>
                                <td><%= article.getDatePublication() %></td>
                                <td class="actions-cell">
                                    <button title="Modifier">✎</button>
                                    <button title="Supprimer" style="color: #ef4444;">✕</button>
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