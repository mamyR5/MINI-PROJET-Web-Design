<%@ page contentType="text/html;charset=UTF-8" %>
<div class="sidebar">
    <div class="sidebar-logo">
        <h2>News Web Site</h2>
    </div>

    <nav class="sidebar-nav">
        <ul>
            <li>
                <a href="<%=request.getContextPath()%>/home" class="active">
                    <svg xmlns="http://www.w3.org/2000/svg" class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="3" width="7" height="7"></rect>
                        <rect x="14" y="3" width="7" height="7"></rect>
                        <rect x="14" y="14" width="7" height="7"></rect>
                        <rect x="3" y="14" width="7" height="7"></rect>
                    </svg>
                    Dashboard
                </a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/admin/article">
                    <!-- Icône Journal / Articles -->
                    <svg xmlns="http://www.w3.org/2000/svg" class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"><path d="M4 22h16a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H8a2 2 0 0 0-2 2v16a2 2 0 0 1-2 2Zm0 0a2 2 0 0 1-2-2v-9c0-1.1.9-2 2-2h2"></path><path d="M18 14h-8"></path><path d="M15 18h-5"></path><path d="M10 6h8v4h-8Z"></path></svg>
                    Tous les articles
                </a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/admin/redaction">
                    <!-- Icône Plume / Rédaction -->
                    <svg xmlns="http://www.w3.org/2000/svg" class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                    Nouvelle rédaction
                </a>
            </li>
        </ul>
    </nav>

    <div class="sidebar-footer">
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="btn-logout">
                <!-- L'icône SVG reste identique -->
                <svg xmlns="http://www.w3.org/2000/svg" class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                    <polyline points="16 17 21 12 16 7"></polyline>
                    <line x1="21" y1="12" x2="9" y2="12"></line>
                </svg>
                Déconnexion
            </button>
        </form>
    </div>
</div>