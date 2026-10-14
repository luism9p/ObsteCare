package com.obstecare.servlet;

import com.obstecare.dao.PacienteDAO;
import com.obstecare.model.Paciente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet simple que recibe un parametro (?id=...) y muestra el detalle de un paciente.
 */
@WebServlet("/paciente-detalle")
public class DetallePacienteServlet extends HttpServlet {

    private final PacienteDAO pacienteDAO = new PacienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");

        try {
            Paciente paciente = pacienteDAO.buscarPorId(Integer.parseInt(idParam));
            if (paciente == null) {
                req.setAttribute("error", "No existe un paciente con ese id.");
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("paciente", paciente);
            req.getRequestDispatcher("/pacientes/detalle.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "El id del paciente no es valido.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Error al consultar la base de datos.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}
