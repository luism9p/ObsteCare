package com.obstecare.servlet;

import com.obstecare.dao.PacienteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final PacienteDAO pacienteDAO = new PacienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int totalPacientes = pacienteDAO.contarPacientes();
            req.setAttribute("totalPacientes", totalPacientes);
        } catch (SQLException e) {
            req.setAttribute("totalPacientes", 0);
            req.setAttribute("error", "No se pudo obtener informacion de la base de datos.");
        }

        LocalDate hoy = LocalDate.now();
        DateTimeFormatter formateador = DateTimeFormatter.ofPattern("dd 'de' MMMM 'de' yyyy", new Locale("es", "PE"));
        req.setAttribute("fechaActual", hoy.format(formateador));

        req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
    }
}
