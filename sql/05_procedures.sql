-- Proyecto Integrador Base de Datos I
-- Sistema de Gestión Académica para un Instituto de Cursos
-- Autor: Joaquín Lorenzo González

USE instituto_db;

-- =====================================================
-- Procedimientos almacenados
-- =====================================================

DELIMITER //

-- =====================================================
-- 1. Procedimiento: inscribir alumno a un curso
-- =====================================================

DROP PROCEDURE IF EXISTS sp_inscribir_alumno//

CREATE PROCEDURE sp_inscribir_alumno(
    IN p_id_alumno INT,
    IN p_id_curso INT
)
BEGIN
    DECLARE v_existe_alumno INT DEFAULT 0;
    DECLARE v_existe_curso INT DEFAULT 0;
    DECLARE v_existe_inscripcion INT DEFAULT 0;

    SELECT COUNT(*) INTO v_existe_alumno
    FROM alumno
    WHERE id_alumno = p_id_alumno;

    SELECT COUNT(*) INTO v_existe_curso
    FROM curso
    WHERE id_curso = p_id_curso;

    SELECT COUNT(*) INTO v_existe_inscripcion
    FROM inscripcion
    WHERE id_alumno = p_id_alumno
      AND id_curso = p_id_curso;

    IF v_existe_alumno = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El alumno no existe.';
    END IF;

    IF v_existe_curso = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;

    IF v_existe_inscripcion > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El alumno ya está inscripto en ese curso.';
    END IF;

    INSERT INTO inscripcion (id_alumno, id_curso, estado)
    VALUES (p_id_alumno, p_id_curso, 'activa');
END//

-- =====================================================
-- 2. Procedimiento: registrar pago
-- =====================================================

DROP PROCEDURE IF EXISTS sp_registrar_pago//

CREATE PROCEDURE sp_registrar_pago(
    IN p_id_inscripcion INT,
    IN p_monto DECIMAL(10,2),
    IN p_metodo_pago VARCHAR(30)
)
BEGIN
    DECLARE v_existe_inscripcion INT DEFAULT 0;

    SELECT COUNT(*) INTO v_existe_inscripcion
    FROM inscripcion
    WHERE id_inscripcion = p_id_inscripcion;

    IF v_existe_inscripcion = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La inscripción no existe.';
    END IF;

    IF p_monto <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El monto del pago debe ser mayor a cero.';
    END IF;

    IF p_metodo_pago NOT IN ('efectivo', 'transferencia', 'tarjeta', 'otro') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Método de pago inválido.';
    END IF;

    INSERT INTO pago (id_inscripcion, monto, metodo_pago, estado_pago)
    VALUES (p_id_inscripcion, p_monto, p_metodo_pago, 'pagado');
END//

-- =====================================================
-- 3. Procedimiento: cambiar estado de inscripción
-- =====================================================

DROP PROCEDURE IF EXISTS sp_cambiar_estado_inscripcion//

CREATE PROCEDURE sp_cambiar_estado_inscripcion(
    IN p_id_inscripcion INT,
    IN p_estado VARCHAR(30)
)
BEGIN
    DECLARE v_existe_inscripcion INT DEFAULT 0;

    SELECT COUNT(*) INTO v_existe_inscripcion
    FROM inscripcion
    WHERE id_inscripcion = p_id_inscripcion;

    IF v_existe_inscripcion = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La inscripción no existe.';
    END IF;

    IF p_estado NOT IN ('activa', 'finalizada', 'cancelada') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado de inscripción inválido.';
    END IF;

    UPDATE inscripcion
    SET estado = p_estado
    WHERE id_inscripcion = p_id_inscripcion;
END//

-- =====================================================
-- 4. Procedimiento: consultar deuda de un alumno
-- =====================================================

DROP PROCEDURE IF EXISTS sp_consultar_deuda_alumno//

CREATE PROCEDURE sp_consultar_deuda_alumno(
    IN p_id_alumno INT
)
BEGIN
    SELECT 
        a.id_alumno,
        CONCAT(a.nombre, ' ', a.apellido) AS alumno,
        c.nombre AS curso,
        c.precio AS precio_curso,
        COALESCE(SUM(CASE WHEN p.estado_pago = 'pagado' THEN p.monto ELSE 0 END), 0) AS total_pagado,
        c.precio - COALESCE(SUM(CASE WHEN p.estado_pago = 'pagado' THEN p.monto ELSE 0 END), 0) AS saldo_pendiente
    FROM alumno a
    INNER JOIN inscripcion i ON a.id_alumno = i.id_alumno
    INNER JOIN curso c ON i.id_curso = c.id_curso
    LEFT JOIN pago p ON i.id_inscripcion = p.id_inscripcion
    WHERE a.id_alumno = p_id_alumno
    GROUP BY 
        a.id_alumno,
        a.nombre,
        a.apellido,
        c.nombre,
        c.precio;
END//

-- =====================================================
-- 5. Procedimiento: consultar alumnos de un curso
-- =====================================================

DROP PROCEDURE IF EXISTS sp_alumnos_por_curso//

CREATE PROCEDURE sp_alumnos_por_curso(
    IN p_id_curso INT
)
BEGIN
    SELECT 
        c.nombre AS curso,
        a.id_alumno,
        CONCAT(a.nombre, ' ', a.apellido) AS alumno,
        a.dni,
        a.email,
        i.fecha_inscripcion,
        i.estado AS estado_inscripcion
    FROM inscripcion i
    INNER JOIN alumno a ON i.id_alumno = a.id_alumno
    INNER JOIN curso c ON i.id_curso = c.id_curso
    WHERE c.id_curso = p_id_curso
    ORDER BY a.apellido, a.nombre;
END//

DELIMITER ;

-- =====================================================
-- Ejemplos de uso
-- =====================================================

-- CALL sp_inscribir_alumno(2, 4);
-- CALL sp_registrar_pago(1, 10000.00, 'transferencia');
-- CALL sp_cambiar_estado_inscripcion(6, 'finalizada');
-- CALL sp_consultar_deuda_alumno(1);
-- CALL sp_alumnos_por_curso(3);