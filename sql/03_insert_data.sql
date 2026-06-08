-- Proyecto Integrador Base de Datos I
-- Sistema de Gestión Académica para un Instituto de Cursos
-- Autor: Joaquín Lorenzo González

USE instituto_db;

-- =====================================================
-- Limpieza previa de datos para poder ejecutar varias veces
-- =====================================================

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE auditoria;
TRUNCATE TABLE asistencia;
TRUNCATE TABLE pago;
TRUNCATE TABLE horario;
TRUNCATE TABLE inscripcion;
TRUNCATE TABLE materia;
TRUNCATE TABLE aula;
TRUNCATE TABLE curso;
TRUNCATE TABLE profesor;
TRUNCATE TABLE alumno;

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- Datos de prueba: alumno
-- =====================================================

INSERT INTO alumno (nombre, apellido, dni, email, telefono, fecha_nacimiento, estado)
VALUES
('Joaquin', 'Gonzalez', '40111222', 'joaquin.gonzalez@email.com', '3571000001', '2004-10-15', 'activo'),
('Martina', 'Perez', '42111333', 'martina.perez@email.com', '3571000002', '2002-05-20', 'activo'),
('Lucas', 'Romero', '43111444', 'lucas.romero@email.com', '3571000003', '2001-08-12', 'activo'),
('Camila', 'Fernandez', '44111555', 'camila.fernandez@email.com', '3571000004', '2003-03-07', 'activo'),
('Agustin', 'Lopez', '45111666', 'agustin.lopez@email.com', '3571000005', '2000-11-25', 'inactivo');

-- =====================================================
-- Datos de prueba: profesor
-- =====================================================

INSERT INTO profesor (nombre, apellido, dni, email, telefono, especialidad, estado)
VALUES
('Laura', 'Martinez', '30111222', 'laura.martinez@email.com', '3512000001', 'Base de Datos', 'activo'),
('Carlos', 'Suarez', '31111333', 'carlos.suarez@email.com', '3512000002', 'Programacion', 'activo'),
('Ana', 'Torres', '32111444', 'ana.torres@email.com', '3512000003', 'Analisis de Sistemas', 'activo'),
('Diego', 'Molina', '33111555', 'diego.molina@email.com', '3512000004', 'Redes y Sistemas Operativos', 'activo');

-- =====================================================
-- Datos de prueba: curso
-- =====================================================

INSERT INTO curso (nombre, descripcion, duracion_meses, precio, estado)
VALUES
('Analista de Datos Inicial', 'Curso introductorio de analisis de datos, SQL y reportes.', 6, 45000.00, 'activo'),
('Programacion Web Full Stack', 'Curso de desarrollo web con frontend, backend y base de datos.', 10, 65000.00, 'activo'),
('QA Testing Manual y Automation', 'Curso orientado a pruebas de software manuales y automatizadas.', 8, 55000.00, 'activo'),
('Administracion de Bases de Datos', 'Curso de modelado, SQL, seguridad y administracion de datos.', 7, 60000.00, 'activo');

-- =====================================================
-- Datos de prueba: aula
-- =====================================================

INSERT INTO aula (nombre, capacidad, ubicacion, estado)
VALUES
('Aula 1', 25, 'Planta baja', 'disponible'),
('Aula 2', 30, 'Primer piso', 'disponible'),
('Laboratorio Informatica', 20, 'Segundo piso', 'disponible');

-- =====================================================
-- Datos de prueba: materia
-- =====================================================

INSERT INTO materia (nombre, descripcion, carga_horaria, id_curso, id_profesor, estado)
VALUES
('Introduccion a SQL', 'Conceptos iniciales de SQL y consultas basicas.', 40, 1, 1, 'activa'),
('Modelado de Datos', 'Entidades, relaciones, DER y modelo relacional.', 45, 4, 1, 'activa'),
('HTML, CSS y JavaScript', 'Bases del desarrollo frontend.', 50, 2, 2, 'activa'),
('Backend con Base de Datos', 'Conexion entre aplicacion y base de datos.', 55, 2, 2, 'activa'),
('Testing Funcional', 'Casos de prueba, bugs y validacion de sistemas.', 40, 3, 3, 'activa'),
('Automation Testing', 'Introduccion a pruebas automatizadas.', 45, 3, 3, 'activa');

-- =====================================================
-- Datos de prueba: inscripcion
-- =====================================================

INSERT INTO inscripcion (id_alumno, id_curso, estado)
VALUES
(1, 1, 'activa'),
(1, 3, 'activa'),
(2, 2, 'activa'),
(3, 3, 'activa'),
(4, 4, 'activa'),
(5, 1, 'cancelada');

-- =====================================================
-- Datos de prueba: pago
-- =====================================================

INSERT INTO pago (id_inscripcion, monto, metodo_pago, estado_pago)
VALUES
(1, 45000.00, 'transferencia', 'pagado'),
(2, 25000.00, 'efectivo', 'pagado'),
(2, 30000.00, 'transferencia', 'pendiente'),
(3, 65000.00, 'tarjeta', 'pagado'),
(4, 55000.00, 'transferencia', 'pagado'),
(5, 30000.00, 'efectivo', 'pendiente');

-- =====================================================
-- Datos de prueba: asistencia
-- =====================================================

INSERT INTO asistencia (id_inscripcion, fecha_clase, presente, observacion)
VALUES
(1, '2026-08-05', true, 'Asistio correctamente'),
(1, '2026-08-12', true, 'Participacion activa'),
(2, '2026-08-06', true, 'Asistio correctamente'),
(2, '2026-08-13', false, 'Ausente con aviso'),
(3, '2026-08-07', true, 'Asistio correctamente'),
(4, '2026-08-08', true, 'Asistio correctamente'),
(5, '2026-08-09', false, 'Ausente');

-- =====================================================
-- Datos de prueba: horario
-- =====================================================

INSERT INTO horario (id_materia, id_aula, dia_semana, hora_inicio, hora_fin)
VALUES
(1, 1, 'lunes', '18:00:00', '20:00:00'),
(2, 2, 'martes', '18:00:00', '20:30:00'),
(3, 3, 'miercoles', '17:00:00', '19:00:00'),
(4, 3, 'jueves', '19:00:00', '21:00:00'),
(5, 1, 'viernes', '18:00:00', '20:00:00'),
(6, 2, 'sabado', '09:00:00', '12:00:00');

-- =====================================================
-- Datos de prueba: auditoria
-- =====================================================

INSERT INTO auditoria (tabla_afectada, accion, descripcion)
VALUES
('alumno', 'INSERT', 'Carga inicial de alumnos de prueba'),
('curso', 'INSERT', 'Carga inicial de cursos de prueba'),
('inscripcion', 'INSERT', 'Carga inicial de inscripciones de prueba'),
('pago', 'INSERT', 'Carga inicial de pagos de prueba');