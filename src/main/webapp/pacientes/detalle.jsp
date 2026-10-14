<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle de paciente - ObsteCare</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

<jsp:include page="/WEB-INF/jspf/header.jsp"/>

<div class="contenedor-app">
    <div class="barra-superior-modulo">
        <h1>Detalle de paciente</h1>
    </div>

    <div class="tarjeta">
        <p><strong>DNI:</strong> <c:out value="${paciente.dni}"/></p>
        <p><strong>Nombre:</strong> <c:out value="${paciente.nombres} ${paciente.apellidos}"/></p>
        <p><strong>Fecha de nacimiento:</strong>
            <c:choose>
                <c:when test="${not empty paciente.fechaNacimiento}">
                    <fmt:formatDate value="${paciente.fechaNacimiento}" pattern="dd/MM/yyyy"/>
                </c:when>
                <c:otherwise>No registrada</c:otherwise>
            </c:choose>
        </p>
        <p><strong>Telefono:</strong> <c:out value="${paciente.telefono}" default="-"/></p>
        <p><strong>Direccion:</strong> <c:out value="${paciente.direccion}" default="-"/></p>
        <p><strong>Antecedentes:</strong> <c:out value="${paciente.antecedentes}" default="-"/></p>
        <p style="margin-top:16px;">
            <a class="btn btn-secundario" href="<c:url value='/pacientes'/>">Volver</a>
        </p>
    </div>
</div>

<jsp:include page="/WEB-INF/jspf/footer.jsp"/>

</body>
</html>
