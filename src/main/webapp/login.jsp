<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesion - ObsteCare</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="topbar">
    <div class="logo">ObsteCare</div>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
    </nav>
</header>

<div class="login-wrap">
    <div class="login-caja">
        <h2>Iniciar sesion</h2>
        <p class="subtitulo">Consultorio Obstetrico</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-msg"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="campo">
                <label for="nombreUsuario">Usuario</label>
                <input type="text" id="nombreUsuario" name="nombreUsuario" required autofocus>
            </div>
            <div class="campo">
                <label for="password">Contrasena</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn" style="width:100%;">Ingresar</button>
        </form>

        <p class="credenciales-demo">Usuario de prueba: admin &middot; Contrasena: admin123</p>
    </div>
</div>

</body>
</html>
