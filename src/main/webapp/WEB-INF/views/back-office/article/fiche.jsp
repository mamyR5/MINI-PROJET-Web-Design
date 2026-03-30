<h1>Fiche Article</h1>
<% Article article = (Article) request.getAttribute("article"); %>
<h2><%= article.getTitre() %></h2>
<p><%= article.getContenu() %></p>