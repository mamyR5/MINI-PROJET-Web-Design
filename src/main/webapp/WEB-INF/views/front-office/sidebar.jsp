<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="webdesign.model.Categorie" %>
<div class="sidebar">
        <div class="sidebar-block">
            <h3>Catégories</h3>
            <div class="cat-list">
                <% if (categories != null) {
                    for (Categorie c : categories) { %>
                <a href="${pageContext.request.contextPath}/categorie/<%= c.getId() %>-<%= c.getDesignation().toLowerCase().replace(" ", "-") %>"
                   class="cat-item">
                    <%= c.getDesignation() %>
                </a>
                <% } } %>
            </div>
        </div>

        <div class="sidebar-block">
            <h3>À propos</h3>
            <p style="font-size:13px; line-height:1.6;">
                Ce site propose un suivi journalistique indépendant du conflit en Iran,
                avec des analyses et reportages réguliers.
            </p>
        </div>
</div>