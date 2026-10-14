<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pacientes - ObsteCare</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jspf/header.jsp"/>

<div class="contenedor-app">

    <div class="barra-superior-modulo">
        <h1>Gestion de pacientes</h1>
        <a class="btn" href="${pageContext.request.contextPath}/pacientes?accion=nuevo">+ Registrar paciente</a>
    </div>

    <form class="form-busqueda" action="${pageContext.request.contextPath}/pacientes" method="get" style="margin-bottom:16px;">
        <input type="hidden" name="accion" value="buscar">
        <input type="text" name="q" placeholder="Buscar por nombre, apellido o DNI" value="${terminoBusqueda}">
        <button type="submit" class="btn btn-secundario">Buscar</button>
    </form>

    <p style="margin-bottom:8px; color:#666; font-size:13px;">
        Total: ${fn:length(pacientes)} paciente(s)
    </p>

    <table class="tabla-datos">
        <thead>
        <tr>
            <th>DNI</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Telefono</th>
            <th>Fecha de nacimiento</th>
            <th>Registrada el</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${pacientes}">
            <tr>
                <td><c:out value="${p.dni}"/></td>
                <td><c:out value="${p.nombres}"/></td>
                <td><c:out value="${p.apellidos}"/></td>
                <td><c:out value="${p.telefono}"/></td>
                <td><fmt:formatDate value="${p.fechaNacimiento}" pattern="dd/MM/yyyy"/></td>
                <td><fmt:formatDate value="${p.fechaRegistro}" pattern="dd/MM/yyyy HH:mm"/></td>
                <td class="acciones-tabla">
                    <a href="<c:url value='/paciente-detalle'><c:param name='id' value='${p.idPaciente}'/></c:url>">Ver</a>
                    <a href="${pageContext.request.contextPath}/pacientes?accion=editar&id=${p.idPaciente}">Editar</a>
                    <a href="${pageContext.request.contextPath}/pacientes?accion=eliminar&id=${p.idPaciente}"
                       onclick="return confirm('¿Eliminar a ${p.nombres} ${p.apellidos}?');">Eliminar</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty pacientes}">
            <tr>
                <td colspan="7" style="text-align:center; color:#888;">No hay pacientes registradas.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

</body>
</html>
