package com.obstecare.servlet;

import com.obstecare.dao.PacienteDAO;
import com.obstecare.model.Paciente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/pacientes")
public class PacienteServlet extends HttpServlet {

    private final PacienteDAO pacienteDAO = new PacienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "nuevo":
                    req.getRequestDispatcher("/pacientes/form.jsp").forward(req, resp);
                    break;

                case "editar":
                    int idEditar = Integer.parseInt(req.getParameter("id"));
                    Paciente paciente = pacienteDAO.buscarPorId(idEditar);
                    req.setAttribute("paciente", paciente);
                    req.getRequestDispatcher("/pacientes/form.jsp").forward(req, resp);
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(req.getParameter("id"));
                    pacienteDAO.eliminar(idEliminar);
                    resp.sendRedirect(req.getContextPath() + "/pacientes");
                    break;

                case "buscar":
                    String termino = req.getParameter("q");
                    List<Paciente> resultados = (termino == null || termino.trim().isEmpty())
                            ? pacienteDAO.listarTodos()
                            : pacienteDAO.buscarPorNombreODni(termino.trim());
                    req.setAttribute("pacientes", resultados);
                    req.setAttribute("terminoBusqueda", termino);
                    req.getRequestDispatcher("/pacientes/lista.jsp").forward(req, resp);
                    break;

                case "listar":
                default:
                    req.setAttribute("pacientes", pacienteDAO.listarTodos());
                    req.getRequestDispatcher("/pacientes/lista.jsp").forward(req, resp);
                    break;
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Error al comunicarse con la base de datos: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("idPaciente");

        Paciente paciente = new Paciente();
        paciente.setDni(req.getParameter("dni"));
        paciente.setNombres(req.getParameter("nombres"));
        paciente.setApellidos(req.getParameter("apellidos"));
        paciente.setTelefono(req.getParameter("telefono"));
        paciente.setDireccion(req.getParameter("direccion"));
        paciente.setAntecedentes(req.getParameter("antecedentes"));

        String fechaNacimientoStr = req.getParameter("fechaNacimiento");
        if (fechaNacimientoStr != null && !fechaNacimientoStr.trim().isEmpty()) {
            paciente.setFechaNacimiento(Date.valueOf(fechaNacimientoStr));
        }

        try {
            if (idParam != null && !idParam.trim().isEmpty()) {
                paciente.setIdPaciente(Integer.parseInt(idParam));
                pacienteDAO.actualizar(paciente);
            } else {
                pacienteDAO.insertar(paciente);
            }
            resp.sendRedirect(req.getContextPath() + "/pacientes");

        } catch (SQLException e) {
            req.setAttribute("error", "No se pudo guardar el paciente: " + e.getMessage());
            req.setAttribute("paciente", paciente);
            req.getRequestDispatcher("/pacientes/form.jsp").forward(req, resp);
        }
    }
}
