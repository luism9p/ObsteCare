<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Cabecera reutilizable: se incluye con <jsp:include page="/WEB-INF/jspf/header.jsp"/> --%>
<header class="topbar">
    <div class="logo">ObsteCare</div>
    <nav>
        <a href="<c:url value='/dashboard'/>">Dashboard</a>
        <a href="<c:url value='/pacientes'/>">Pacientes</a>
        <a href="<c:url value='/logout'/>">Cerrar sesion (<c:out value="${sessionScope.usuario.nombreCompleto}"/>)</a>
    </nav>
</header>
