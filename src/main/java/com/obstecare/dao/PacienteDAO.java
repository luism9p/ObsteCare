package com.obstecare.dao;

import com.obstecare.model.Paciente;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PacienteDAO {

    public List<Paciente> listarTodos() throws SQLException {
        String sql = "SELECT * FROM pacientes ORDER BY fecha_registro DESC";
        List<Paciente> pacientes = new ArrayList<>();

        try (Connection con = ConexionBD.obtenerConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                pacientes.add(mapear(rs));
            }
        }
        return pacientes;
    }

    public List<Paciente> buscarPorNombreODni(String termino) throws SQLException {
        String sql = "SELECT * FROM pacientes "
                + "WHERE LOWER(nombres) LIKE ? OR LOWER(apellidos) LIKE ? OR dni LIKE ? "
                + "ORDER BY fecha_registro DESC";
        List<Paciente> pacientes = new ArrayList<>();
        String like = "%" + termino.toLowerCase() + "%";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    pacientes.add(mapear(rs));
                }
            }
        }
        return pacientes;
    }

    public Paciente buscarPorId(int idPaciente) throws SQLException {
        String sql = "SELECT * FROM pacientes WHERE id_paciente = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idPaciente);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }
        return null;
    }

    public int contarPacientes() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM pacientes";

        try (Connection con = ConexionBD.obtenerConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public void insertar(Paciente p) throws SQLException {
        String sql = "INSERT INTO pacientes (dni, nombres, apellidos, fecha_nacimiento, telefono, direccion, antecedentes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            asignarParametros(ps, p);
            ps.executeUpdate();
        }
    }

    public void actualizar(Paciente p) throws SQLException {
        String sql = "UPDATE pacientes SET dni = ?, nombres = ?, apellidos = ?, fecha_nacimiento = ?, "
                + "telefono = ?, direccion = ?, antecedentes = ? WHERE id_paciente = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            asignarParametros(ps, p);
            ps.setInt(8, p.getIdPaciente());
            ps.executeUpdate();
        }
    }

    public void eliminar(int idPaciente) throws SQLException {
        String sql = "DELETE FROM pacientes WHERE id_paciente = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idPaciente);
            ps.executeUpdate();
        }
    }

    private void asignarParametros(PreparedStatement ps, Paciente p) throws SQLException {
        ps.setString(1, p.getDni());
        ps.setString(2, p.getNombres());
        ps.setString(3, p.getApellidos());
        ps.setDate(4, p.getFechaNacimiento());
        ps.setString(5, p.getTelefono());
        ps.setString(6, p.getDireccion());
        ps.setString(7, p.getAntecedentes());
    }

    private Paciente mapear(ResultSet rs) throws SQLException {
        Paciente p = new Paciente();
        p.setIdPaciente(rs.getInt("id_paciente"));
        p.setDni(rs.getString("dni"));
        p.setNombres(rs.getString("nombres"));
        p.setApellidos(rs.getString("apellidos"));
        p.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
        p.setTelefono(rs.getString("telefono"));
        p.setDireccion(rs.getString("direccion"));
        p.setAntecedentes(rs.getString("antecedentes"));
        p.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        return p;
    }
}
