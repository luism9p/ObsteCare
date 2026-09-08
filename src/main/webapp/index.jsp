<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>ObsteCare - Consultorio Obstetrico</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="topbar">
    <div class="logo">ObsteCare</div>
    <nav>
        <a href="${pageContext.request.contextPath}/login">Iniciar sesion</a>
    </nav>
</header>

<section class="hero">
    <h1>Sistema Web de Gestion para Consultorio Obstetrico</h1>
    <p>
        ObsteCare centraliza el registro de pacientes, la programacion de citas y el seguimiento
        de controles obstetricos e historias clinicas del consultorio.
    </p>
    <a class="btn" href="${pageContext.request.contextPath}/login">Ingresar al sistema</a>
</section>

<section class="contenido">
    <h2>Servicios que gestiona el sistema</h2>
    <div class="servicios">
        <div class="tarjeta">
            <h3>Registro de pacientes</h3>
            <p>Datos personales, antecedentes y busqueda rapida de cada paciente.</p>
        </div>
        <div class="tarjeta">
            <h3>Gestion de citas</h3>
            <p>Programacion, reprogramacion y consulta de citas obstetricas.</p>
        </div>
        <div class="tarjeta">
            <h3>Controles obstetricos</h3>
            <p>Seguimiento de semanas de gestacion, signos vitales y observaciones.</p>
        </div>
        <div class="tarjeta">
            <h3>Historia clinica</h3>
            <p>Consulta cronologica de antecedentes y atenciones realizadas.</p>
        </div>
    </div>
</section>

<footer>
    ObsteCare &mdash; Proyecto academico, Integrador I: Sistemas - Software &mdash; Universidad Tecnologica del Peru
</footer>

</body>
</html>
