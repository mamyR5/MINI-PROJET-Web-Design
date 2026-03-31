<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="webdesign.model.*" %>
<h1>Fiche Article</h1>
<p>id=<%=request.getAttribute("articleId")%></p>
<p>slug=<%=request.getAttribute("articleSlug")%></p>
<p>date=<%=request.getAttribute("articleDate")%></p>
<%
    Article article = (Article) request.getAttribute("article");
    if (article != null) {
        out.println("Titre : " + article.getTitre());
        out.println("Contenu : " + article.getContenu());
        out.println("Catégorie : " + article.getCategorie().getDesignation());
        out.println("Date de publication : " + article.getDatePublication());
    } else {
        out.println("Aucun article trouvé.");
    }
%>
