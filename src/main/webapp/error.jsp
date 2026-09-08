<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error - ObsteCare</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="topbar">
    <div class="logo">ObsteCare</div>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
    </nav>
</header>

<div class="contenedor-app">
    <h1 style="color:#b3302c;">Ocurrio un error</h1>
    <p style="margin-top:10px;">
        ${empty error ? "No se pudo procesar tu solicitud. Intenta nuevamente." : error}
    </p>
    <p style="margin-top:20px;">
        <a class="btn" href="${pageContext.request.contextPath}/dashboard">Volver al dashboard</a>
    </p>
</div>

</body>
</html>
