-- Proyecto Integrador Base de Datos I
-- Sistema de Gestión Académica para un Instituto de Cursos
-- Autor: Joaquín Lorenzo González

USE instituto_db;

-- =====================================================
-- 1. Listar todos los alumnos
-- =====================================================

SELECT 
    id_alumno,
    nombre,
    apellido,
    dni,
    email,
    telefono,
    estado
FROM alumno;

-- =====================================================
-- 2. Listar alumnos activos
-- =====================================================

SELECT 
    id_alumno,
    nombre,
    apellido,
    dni,
    email
FROM alumno
WHERE estado = 'activo'
ORDER BY apellido, nombre;

-- =====================================================
-- 3. Listar cursos activos
-- =====================================================

SELECT 
    id_curso,
    nombre,
    duracion_meses,
    precio,
    estado
FROM curso
WHERE estado = 'activo'
ORDER BY nombre;

-- =====================================================
-- 4. Listar materias con su curso y profesor
-- =====================================================

SELECT 
    m.id_materia,
    m.nombre AS materia,
    c.nombre AS curso,
    CONCAT(p.nombre, ' ', p.apellido) AS profesor,
    m.carga_horaria,
    m.estado
FROM materia m
INNER JOIN curso c ON m.id_curso = c.id_curso
LEFT JOIN profesor p ON m.id_profesor = p.id_profesor
ORDER BY c.nombre, m.nombre;

-- =====================================================
-- 5. Listar inscripciones con alumno y curso
-- =====================================================

SELECT 
    i.id_inscripcion,
    CONCAT(a.nombre, ' ', a.apellido) AS alumno,
    c.nombre AS curso,
    i.fecha_inscripcion,
    i.estado
FROM inscripcion i
INNER JOIN alumno a ON i.id_alumno = a.id_alumno
INNER JOIN curso c ON i.id_curso = c.id_curso
ORDER BY i.fecha_inscripcion DESC;

-- =====================================================
-- 6. Listar alumnos inscriptos por curso
-- =====================================================

SELECT 
    c.nombre AS curso,
    CONCAT(a.nombre, ' ', a.apellido) AS alumno,
    a.dni,
    i.estado AS estado_inscripcion
FROM inscripcion i
INNER JOIN alumno a ON i.id_alumno = a.id_alumno
INNER JOIN curso c ON i.id_curso = c.id_curso
ORDER BY c.nombre, a.apellido;

-- =====================================================
-- 7. Cantidad de alumnos inscriptos por curso
-- =====================================================

SELECT 
    c.id_curso,
    c.nombre AS curso,
    COUNT(i.id_inscripcion) AS cantidad_inscriptos
FROM curso c
LEFT JOIN inscripcion i ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre
ORDER BY cantidad_inscriptos DESC;

-- =====================================================
-- 8. Listar pagos realizados
-- =====================================================

SELECT 
    p.id_pago,
    CONCAT(a.nombre, ' ', a.apellido) AS alumno,
    c.nombre AS curso,
    p.fecha_pago,
    p.monto,
    p.metodo_pago,
    p.estado_pago
FROM pago p
INNER JOIN inscripcion i ON p.id_inscripcion = i.id_inscripcion
INNER JOIN alumno a ON i.id_alumno = a.id_alumno
INNER JOIN curso c ON i.id_curso = c.id_curso
ORDER BY p.fecha_pago DESC;

-- =====================================================
-- 9. Consultar pagos pendientes
-- =====================================================

SELECT 
    p.id_pago,
    CONCAT(a.nombre, ' ', a.apellido) AS alumno,
    c.nombre AS curso,
    p.monto,
    p.metodo_pago,
    p.estado_pago
FROM pago p
INNER JOIN inscripcion i ON p.id_inscripcion = i.id_inscripcion
INNER JOIN alumno a ON i.id_alumno = a.id_alumno
INNER JOIN curso c ON i.id_curso = c.id_curso
WHERE p.estado_pago = 'pendiente'
ORDER BY alumno;

-- =====================================================
-- 10. Calcular ingresos pagados por curso
-- =====================================================

SELECT 
    c.id_curso,
    c.nombre AS curso,
    SUM(p.monto) AS total_ingresos_pagados
FROM curso c
INNER JOIN inscripcion i ON c.id_curso = i.id_curso
INNER JOIN pago p ON i.id_inscripcion = p.id_inscripcion
WHERE p.estado_pago = 'pagado'
GROUP BY c.id_curso, c.nombre
ORDER BY total_ingresos_pagados DESC;

-- =====================================================
-- 11. Calcular saldo pendiente por inscripción
-- =====================================================

SELECT 
    i.id_inscripcion,
    CONCAT(a.nombre, ' ', a.apellido) AS alumno,
    c.nombre AS curso,
    c.precio AS precio_curso,
    COALESCE(SUM(CASE WHEN p.estado_pago = 'pagado' THEN p.monto ELSE 0 END), 0) AS total_pagado,
    c.precio - COALESCE(SUM(CASE WHEN p.estado_pago = 'pagado' THEN p.monto ELSE 0 END), 0) AS saldo_pendiente
FROM inscripcion i
INNER JOIN alumno a ON i.id_alumno = a.id_alumno
INNER JOIN curso c ON i.id_curso = c.id_curso
LEFT JOIN pago p ON i.id_inscripcion = p.id_inscripcion
GROUP BY 
    i.id_inscripcion,
    a.nombre,
    a.apellido,
    c.nombre,
    c.precio
ORDER BY saldo_pendiente DESC;

-- =====================================================
-- 12. Consultar asistencias por alumno
-- =====================================================

SELECT 
    CONCAT(a.nombre, ' ', a.apellido) AS alumno,
    c.nombre AS curso,
    asi.fecha_clase,
    CASE 
        WHEN asi.presente = 1 THEN 'Presente'
        ELSE 'Ausente'
    END AS estado_asistencia,
    asi.observacion
FROM asistencia asi
INNER JOIN inscripcion i ON asi.id_inscripcion = i.id_inscripcion
INNER JOIN alumno a ON i.id_alumno = a.id_alumno
INNER JOIN curso c ON i.id_curso = c.id_curso
ORDER BY alumno, asi.fecha_clase;

-- =====================================================
-- 13. Porcentaje de asistencia por alumno y curso
-- =====================================================

SELECT 
    CONCAT(a.nombre, ' ', a.apellido) AS alumno,
    c.nombre AS curso,
    COUNT(asi.id_asistencia) AS clases_registradas,
    SUM(CASE WHEN asi.presente = 1 THEN 1 ELSE 0 END) AS clases_presentes,
    ROUND(
        SUM(CASE WHEN asi.presente = 1 THEN 1 ELSE 0 END) * 100 / COUNT(asi.id_asistencia),
        2
    ) AS porcentaje_asistencia
FROM asistencia asi
INNER JOIN inscripcion i ON asi.id_inscripcion = i.id_inscripcion
INNER JOIN alumno a ON i.id_alumno = a.id_alumno
INNER JOIN curso c ON i.id_curso = c.id_curso
GROUP BY 
    a.id_alumno,
    a.nombre,
    a.apellido,
    c.id_curso,
    c.nombre
ORDER BY porcentaje_asistencia DESC;

-- =====================================================
-- 14. Horarios de materias con aula
-- =====================================================

SELECT 
    m.nombre AS materia,
    c.nombre AS curso,
    au.nombre AS aula,
    au.ubicacion,
    h.dia_semana,
    h.hora_inicio,
    h.hora_fin
FROM horario h
INNER JOIN materia m ON h.id_materia = m.id_materia
INNER JOIN curso c ON m.id_curso = c.id_curso
INNER JOIN aula au ON h.id_aula = au.id_aula
ORDER BY h.dia_semana, h.hora_inicio;

-- =====================================================
-- 15. Buscar cursos cuyo precio sea mayor al promedio
-- =====================================================

SELECT 
    id_curso,
    nombre,
    precio
FROM curso
WHERE precio > (
    SELECT AVG(precio)
    FROM curso
)
ORDER BY precio DESC;

-- =====================================================
-- 16. Auditoría registrada
-- =====================================================

SELECT 
    id_auditoria,
    tabla_afectada,
    accion,
    descripcion,
    fecha_hora
FROM auditoria
ORDER BY fecha_hora DESC;