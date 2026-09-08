-- ObsteCare - Sistema Web de Gestion para Consultorio Obstetrico
-- Script de creacion de base de datos (PostgreSQL)
-- Ejecutar en pgAdmin (Query Tool) sobre la base de datos "obstecare"

CREATE TABLE usuarios (
    id_usuario       SERIAL PRIMARY KEY,
    nombre_usuario   VARCHAR(50) NOT NULL UNIQUE,
    password_hash    VARCHAR(255) NOT NULL,
    nombre_completo  VARCHAR(120) NOT NULL,
    rol              VARCHAR(20) NOT NULL CHECK (rol IN ('ADMINISTRADOR', 'OBSTETRA', 'RECEPCIONISTA')),
    activo           BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion   TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE pacientes (
    id_paciente      SERIAL PRIMARY KEY,
    dni              VARCHAR(15) NOT NULL UNIQUE,
    nombres          VARCHAR(80) NOT NULL,
    apellidos        VARCHAR(80) NOT NULL,
    fecha_nacimiento DATE,
    telefono         VARCHAR(20),
    direccion        VARCHAR(150),
    antecedentes     TEXT,
    fecha_registro   TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Usuario administrador inicial
-- Usuario: admin  /  Contrasena: admin123
-- (password_hash generado con SHA-256, ver ClaveUtil.java)
INSERT INTO usuarios (nombre_usuario, password_hash, nombre_completo, rol)
VALUES ('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Administrador del Sistema', 'ADMINISTRADOR');

-- Datos de ejemplo para el dashboard y el modulo de pacientes
INSERT INTO pacientes (dni, nombres, apellidos, fecha_nacimiento, telefono, direccion, antecedentes)
VALUES
('45678912', 'Maria Fernanda', 'Torres Quispe', '1996-03-14', '987654321', 'Av. Los Alamos 245, Lima', 'Sin antecedentes relevantes.'),
('41235678', 'Lucia', 'Ramirez Gomez', '1993-08-02', '956123478', 'Jr. Las Flores 112, Lima', 'Hipertension controlada.'),
('48521369', 'Carla Beatriz', 'Mendoza Rojas', '1999-11-27', '912345678', 'Calle Real 88, Lima', 'Primer embarazo.');
