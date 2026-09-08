package com.obstecare.servlet;

import com.obstecare.dao.UsuarioDAO;
import com.obstecare.model.Usuario;
import com.obstecare.util.ClaveUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String nombreUsuario = req.getParameter("nombreUsuario");
        String password = req.getParameter("password");

        if (nombreUsuario == null || password == null
                || nombreUsuario.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "Debes ingresar usuario y contrasena.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        try {
            String hash = ClaveUtil.hash(password);
            Usuario usuario = usuarioDAO.buscarPorCredenciales(nombreUsuario.trim(), hash);

            if (usuario == null) {
                req.setAttribute("error", "Usuario o contrasena incorrectos.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("usuario", usuario);
            resp.sendRedirect(req.getContextPath() + "/dashboard");

        } catch (SQLException e) {
            req.setAttribute("error", "No se pudo conectar con la base de datos. Intenta nuevamente.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
