<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${empty paciente ? "Registrar paciente" : "Editar paciente"} - ObsteCare</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jspf/header.jsp"/>

<div class="contenedor-app">
    <div class="barra-superior-modulo">
        <h1>${empty paciente ? "Registrar paciente" : "Editar paciente"}</h1>
    </div>

    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <div class="tarjeta">
        <form action="${pageContext.request.contextPath}/pacientes" method="post">
            <c:if test="${not empty paciente}">
                <input type="hidden" name="idPaciente" value="${paciente.idPaciente}">
            </c:if>

            <div class="fila-form">
                <div class="campo">
                    <label for="dni">DNI</label>
                    <input type="text" id="dni" name="dni" value="${paciente.dni}" required maxlength="15">
                </div>
                <div class="campo">
                    <label for="fechaNacimiento">Fecha de nacimiento</label>
                    <input type="date" id="fechaNacimiento" name="fechaNacimiento"
                           value="<fmt:formatDate value="${paciente.fechaNacimiento}" pattern="yyyy-MM-dd"/>">
                </div>
            </div>

            <div class="fila-form">
                <div class="campo">
                    <label for="nombres">Nombres</label>
                    <input type="text" id="nombres" name="nombres" value="${paciente.nombres}" required maxlength="80">
                </div>
                <div class="campo">
                    <label for="apellidos">Apellidos</label>
                    <input type="text" id="apellidos" name="apellidos" value="${paciente.apellidos}" required maxlength="80">
                </div>
            </div>

            <div class="fila-form">
                <div class="campo">
                    <label for="telefono">Telefono</label>
                    <input type="text" id="telefono" name="telefono" value="${paciente.telefono}" maxlength="20">
                </div>
                <div class="campo">
                    <label for="direccion">Direccion</label>
                    <input type="text" id="direccion" name="direccion" value="${paciente.direccion}" maxlength="150">
                </div>
            </div>

            <div class="campo">
                <label for="antecedentes">Antecedentes</label>
                <textarea id="antecedentes" name="antecedentes">${paciente.antecedentes}</textarea>
            </div>

            <button type="submit" class="btn">Guardar</button>
            <a class="btn btn-secundario" href="${pageContext.request.contextPath}/pacientes">Cancelar</a>
        </form>
    </div>
</div>

</body>
</html>
