-- Proyecto Integrador Base de Datos I
-- Sistema de Gestión Académica para un Instituto de Cursos
-- Autor: Joaquín Lorenzo González

USE instituto_db;

-- =====================================================
-- Triggers
-- =====================================================

DELIMITER //

-- =====================================================
-- 1. Trigger: validar monto antes de insertar un pago
-- =====================================================

DROP TRIGGER IF EXISTS trg_pago_before_insert//

CREATE TRIGGER trg_pago_before_insert
BEFORE INSERT ON pago
FOR EACH ROW
BEGIN
    IF NEW.monto <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El monto del pago debe ser mayor a cero.';
    END IF;
END//

-- =====================================================
-- 2. Trigger: registrar auditoría al insertar un pago
-- =====================================================

DROP TRIGGER IF EXISTS trg_pago_after_insert//

CREATE TRIGGER trg_pago_after_insert
AFTER INSERT ON pago
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (
        tabla_afectada,
        accion,
        descripcion
    )
    VALUES (
        'pago',
        'INSERT',
        CONCAT(
            'Se registró un pago de $',
            NEW.monto,
            ' para la inscripción ID ',
            NEW.id_inscripcion
        )
    );
END//

-- =====================================================
-- 3. Trigger: registrar auditoría al modificar un pago
-- =====================================================

DROP TRIGGER IF EXISTS trg_pago_after_update//

CREATE TRIGGER trg_pago_after_update
AFTER UPDATE ON pago
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (
        tabla_afectada,
        accion,
        descripcion
    )
    VALUES (
        'pago',
        'UPDATE',
        CONCAT(
            'Se modificó el pago ID ',
            OLD.id_pago,
            '. Monto anterior: $',
            OLD.monto,
            ', monto nuevo: $',
            NEW.monto,
            '. Estado anterior: ',
            OLD.estado_pago,
            ', estado nuevo: ',
            NEW.estado_pago
        )
    );
END//

-- =====================================================
-- 4. Trigger: registrar auditoría al cambiar estado de inscripción
-- =====================================================

DROP TRIGGER IF EXISTS trg_inscripcion_after_update//

CREATE TRIGGER trg_inscripcion_after_update
AFTER UPDATE ON inscripcion
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO auditoria (
            tabla_afectada,
            accion,
            descripcion
        )
        VALUES (
            'inscripcion',
            'UPDATE',
            CONCAT(
                'La inscripción ID ',
                OLD.id_inscripcion,
                ' cambió de estado ',
                OLD.estado,
                ' a ',
                NEW.estado
            )
        );
    END IF;
END//

-- =====================================================
-- 5. Trigger: evitar inscripción duplicada activa
-- =====================================================

DROP TRIGGER IF EXISTS trg_inscripcion_before_insert//

CREATE TRIGGER trg_inscripcion_before_insert
BEFORE INSERT ON inscripcion
FOR EACH ROW
BEGIN
    DECLARE v_existe INT DEFAULT 0;

    SELECT COUNT(*) INTO v_existe
    FROM inscripcion
    WHERE id_alumno = NEW.id_alumno
      AND id_curso = NEW.id_curso
      AND estado = 'activa';

    IF v_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El alumno ya tiene una inscripción activa en este curso.';
    END IF;
END//

DELIMITER ;

-- =====================================================
-- Ejemplos de prueba
-- =====================================================

-- Insertar un pago válido:
-- INSERT INTO pago (id_inscripcion, monto, metodo_pago, estado_pago)
-- VALUES (1, 5000.00, 'efectivo', 'pagado');

-- Probar auditoría al modificar un pago:
-- UPDATE pago
-- SET monto = 47000.00
-- WHERE id_pago = 1;

-- Probar auditoría al cambiar estado de inscripción:
-- UPDATE inscripcion
-- SET estado = 'finalizada'
-- WHERE id_inscripcion = 1;

-- Consultar auditoría:
-- SELECT * FROM auditoria ORDER BY fecha_hora DESC;