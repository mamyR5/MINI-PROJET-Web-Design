<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | News Web Site</title>
    <!-- On lie le nouveau CSS du Dashboard -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/backoffice/dashboard.css">
</head>
<body>

    <div class="dashboard-layout">
        <!-- Sidebar incluse -->
        <jsp:include page="/WEB-INF/fragments/sidebar.jsp" />

        <!-- Contenu principal -->
        <main class="main-content">
            <header class="header-main">
                <div>
                    <h1>Liste des Rédactions</h1>
                </div>
                <div class="date-now">
                    <%= new java.text.SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date()) %>
                </div>
            </header>
            
            <div class="content-grid">
                <div class="card">
                    <h3>Articles en attente</h3>
                    <p>Vous avez 4 articles qui attendent une validation éditoriale avant publication.</p>
                </div>
                <div class="card">
                    <h3>Dernière édition</h3>
                    <p>L'article sur "Le nouveau building de la presse" a été modifié il y a 2 heures.</p>
                </div>
                <div class="card">
                    <h3>Notes de service</h3>
                    <p>Réunion de rédaction prévue à 10h30 dans la salle de conférence Nord.</p>
                </div>
            </div>
        </main>
    </div>

</body>
</html>