<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="webdesign.model.Categorie" %>
<nav class="nav">
    <div class="nav-logo">Guerre en Iran — Actualités</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/accueil" class="nav-link">Accueil</a>
        <% if (categories != null) {
            for (Categorie c : categories) { %>
        <a href="${pageContext.request.contextPath}/categorie/<%= c.getId() %>-<%= c.getDesignation().toLowerCase().replace(" ", "-") %>"
           class="nav-link">
            <%= c.getDesignation() %>
        </a>
        <% } } %>
    </div>
</nav>