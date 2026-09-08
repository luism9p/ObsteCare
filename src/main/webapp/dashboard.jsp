<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - ObsteCare</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="topbar">
    <div class="logo">ObsteCare</div>
    <nav>
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/pacientes">Pacientes</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesion (${sessionScope.usuario.nombreCompleto})</a>
    </nav>
</header>

<div class="contenedor-app">
    <div class="dashboard-header">
        <h1>Bienvenido(a), ${sessionScope.usuario.nombreCompleto}</h1>
        <p>${fechaActual} &middot; Rol: ${sessionScope.usuario.rol}</p>
    </div>

    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <div class="tarjetas-resumen">
        <div class="tarjeta-resumen">
            <div class="numero">${totalPacientes}</div>
            <div class="etiqueta">Pacientes registradas</div>
        </div>
        <div class="tarjeta-resumen">
            <div class="numero">0</div>
            <div class="etiqueta">Citas programadas hoy</div>
        </div>
        <div class="tarjeta-resumen">
            <div class="numero">0</div>
            <div class="etiqueta">Controles pendientes</div>
        </div>
    </div>

    <div class="tarjeta">
        <h3>Accesos rapidos</h3>
        <p style="margin-top:10px;">
            <a class="btn" href="${pageContext.request.contextPath}/pacientes">Ver pacientes</a>
            <a class="btn btn-secundario" href="${pageContext.request.contextPath}/pacientes?accion=nuevo">Registrar paciente</a>
        </p>
    </div>
</div>

<footer>
    ObsteCare &mdash; Sistema Web de Gestion para Consultorio Obstetrico
</footer>

</body>
</html>
