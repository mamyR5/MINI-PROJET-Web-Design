<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | News Web Site</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

    <div class="login-container">
        <div class="header">
            <h1>
                News Web Site
            </h1>
            <p>Espace réservé à la rédaction numérique</p>
        </div>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Nom d'utilisateur</label>
                <input type="text" id="username" name="username" placeholder="Votre nom" required>
            </div>

            <div class="form-group">
                <label for="password">Mot de passe</label>
                <input type="password" id="password" name="password" placeholder="Saisissez votre code" required>
            </div>

            <button type="submit" class="btn-submit">S'identifier</button>
        </form>

    </div>

</body>
</html>