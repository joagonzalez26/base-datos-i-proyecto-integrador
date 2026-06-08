-- Proyecto Integrador Base de Datos I
-- Sistema de Gestión Académica para un Instituto de Cursos
-- Autor: Joaquín Lorenzo González

USE instituto_db;

-- =====================================================
-- Limpieza previa de tablas
-- =====================================================

DROP TABLE IF EXISTS auditoria;
DROP TABLE IF EXISTS asistencia;
DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS horario;
DROP TABLE IF EXISTS inscripcion;
DROP TABLE IF EXISTS materia;
DROP TABLE IF EXISTS aula;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS profesor;
DROP TABLE IF EXISTS alumno;

-- =====================================================
-- Tabla: alumno
-- =====================================================

CREATE TABLE alumno (
    id_alumno INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(30),
    fecha_nacimiento DATE,
    fecha_alta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activo', 'inactivo') NOT NULL DEFAULT 'activo',

    CONSTRAINT alumno_pk PRIMARY KEY (id_alumno),
    CONSTRAINT alumno_dni_uq UNIQUE (dni),
    CONSTRAINT alumno_email_uq UNIQUE (email)
);

-- =====================================================
-- Tabla: profesor
-- =====================================================

CREATE TABLE profesor (
    id_profesor INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(30),
    especialidad VARCHAR(100),
    estado ENUM('activo', 'inactivo') NOT NULL DEFAULT 'activo',

    CONSTRAINT profesor_pk PRIMARY KEY (id_profesor),
    CONSTRAINT profesor_dni_uq UNIQUE (dni),
    CONSTRAINT profesor_email_uq UNIQUE (email)
);

-- =====================================================
-- Tabla: curso
-- =====================================================

CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion_meses INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    estado ENUM('activo', 'inactivo') NOT NULL DEFAULT 'activo',

    CONSTRAINT curso_pk PRIMARY KEY (id_curso),
    CONSTRAINT curso_nombre_uq UNIQUE (nombre),
    CONSTRAINT curso_duracion_chk CHECK (duracion_meses > 0),
    CONSTRAINT curso_precio_chk CHECK (precio >= 0)
);

-- =====================================================
-- Tabla: aula
-- =====================================================

CREATE TABLE aula (
    id_aula INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    ubicacion VARCHAR(100),
    estado ENUM('disponible', 'no disponible') NOT NULL DEFAULT 'disponible',

    CONSTRAINT aula_pk PRIMARY KEY (id_aula),
    CONSTRAINT aula_nombre_uq UNIQUE (nombre),
    CONSTRAINT aula_capacidad_chk CHECK (capacidad > 0)
);

-- =====================================================
-- Tabla: materia
-- =====================================================

CREATE TABLE materia (
    id_materia INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    carga_horaria INT NOT NULL,
    id_curso INT NOT NULL,
    id_profesor INT,
    estado ENUM('activa', 'inactiva') NOT NULL DEFAULT 'activa',

    CONSTRAINT materia_pk PRIMARY KEY (id_materia),
    CONSTRAINT materia_carga_horaria_chk CHECK (carga_horaria > 0),

    CONSTRAINT materia_curso_fk
        FOREIGN KEY (id_curso)
        REFERENCES curso(id_curso)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT materia_profesor_fk
        FOREIGN KEY (id_profesor)
        REFERENCES profesor(id_profesor)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- =====================================================
-- Tabla: inscripcion
-- =====================================================

CREATE TABLE inscripcion (
    id_inscripcion INT AUTO_INCREMENT,
    id_alumno INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activa', 'finalizada', 'cancelada') NOT NULL DEFAULT 'activa',

    CONSTRAINT inscripcion_pk PRIMARY KEY (id_inscripcion),

    CONSTRAINT inscripcion_alumno_curso_uq
        UNIQUE (id_alumno, id_curso),

    CONSTRAINT inscripcion_alumno_fk
        FOREIGN KEY (id_alumno)
        REFERENCES alumno(id_alumno)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT inscripcion_curso_fk
        FOREIGN KEY (id_curso)
        REFERENCES curso(id_curso)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================
-- Tabla: pago
-- =====================================================

CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT,
    id_inscripcion INT NOT NULL,
    fecha_pago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('efectivo', 'transferencia', 'tarjeta', 'otro') NOT NULL,
    estado_pago ENUM('pagado', 'pendiente', 'anulado') NOT NULL DEFAULT 'pagado',

    CONSTRAINT pago_pk PRIMARY KEY (id_pago),
    CONSTRAINT pago_monto_chk CHECK (monto > 0),

    CONSTRAINT pago_inscripcion_fk
        FOREIGN KEY (id_inscripcion)
        REFERENCES inscripcion(id_inscripcion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================
-- Tabla: asistencia
-- =====================================================

CREATE TABLE asistencia (
    id_asistencia INT AUTO_INCREMENT,
    id_inscripcion INT NOT NULL,
    fecha_clase DATE NOT NULL,
    presente BOOLEAN NOT NULL,
    observacion VARCHAR(255),

    CONSTRAINT asistencia_pk PRIMARY KEY (id_asistencia),

    CONSTRAINT asistencia_inscripcion_fecha_uq
        UNIQUE (id_inscripcion, fecha_clase),

    CONSTRAINT asistencia_inscripcion_fk
        FOREIGN KEY (id_inscripcion)
        REFERENCES inscripcion(id_inscripcion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================
-- Tabla: horario
-- =====================================================

CREATE TABLE horario (
    id_horario INT AUTO_INCREMENT,
    id_materia INT NOT NULL,
    id_aula INT NOT NULL,
    dia_semana ENUM('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,

    CONSTRAINT horario_pk PRIMARY KEY (id_horario),
    CONSTRAINT horario_horas_chk CHECK (hora_fin > hora_inicio),

    CONSTRAINT horario_materia_fk
        FOREIGN KEY (id_materia)
        REFERENCES materia(id_materia)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT horario_aula_fk
        FOREIGN KEY (id_aula)
        REFERENCES aula(id_aula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================
-- Tabla: auditoria
-- =====================================================

CREATE TABLE auditoria (
    id_auditoria INT AUTO_INCREMENT,
    tabla_afectada VARCHAR(50) NOT NULL,
    accion VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT auditoria_pk PRIMARY KEY (id_auditoria)
);