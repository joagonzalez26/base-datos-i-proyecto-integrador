# Proyecto Integrador Base de Datos I

## Sistema de Gestión Académica para un Instituto de Cursos

Este proyecto tiene como objetivo diseñar e implementar una base de datos relacional utilizando **MySQL**, **MySQL Workbench** y **SQL**, aplicando los contenidos principales de la materia **Base de Datos I**.

La idea es construir una base de datos completa para gestionar alumnos, profesores, cursos, materias, inscripciones, pagos, asistencias, aulas y horarios de un instituto de formación.

---

## Objetivo del proyecto

Diseñar e implementar una base de datos relacional que permita organizar la información académica de un instituto, aplicando análisis de requerimientos, modelo entidad-relación, normalización, sentencias SQL, procedimientos almacenados y triggers.

---

## Tecnologías utilizadas

- MySQL
- MySQL Workbench
- SQL
- Visual Studio Code
- Markdown
- Git y GitHub

---

## Contenidos aplicados

En este proyecto se aplican los siguientes temas de Base de Datos I:

- Modelo relacional
- Entidades, atributos y relaciones
- Claves primarias y claves foráneas
- Cardinalidades
- Diagrama Entidad-Relación
- Normalización
- Sentencias DDL
- Sentencias DML
- Consultas SQL
- Procedimientos almacenados
- Triggers
- Documentación técnica

---

## Alcance del sistema

El sistema permitirá gestionar:

- Alumnos
- Profesores
- Cursos
- Materias
- Inscripciones
- Pagos
- Asistencias
- Aulas
- Horarios
- Auditoría básica de cambios

---

## Estructura del proyecto

```text
base-datos-i-proyecto-integrador/
│
├── README.md
│
├── docs/
│   ├── requerimientos.md
│   ├── der.md
│   ├── modelo-relacional.md
│   └── normalizacion.md
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   ├── 04_queries.sql
│   ├── 05_procedures.sql
│   └── 06_triggers.sql
│
├── informe/
│   └── informe-final.md
│
└── evidencias/
```

---

## Base de datos

La base de datos del proyecto se llamará:

```sql
instituto_db
```

---

## Orden de ejecución de scripts

Los archivos SQL se ejecutarán en MySQL Workbench en el siguiente orden:

1. `01_create_database.sql`
2. `02_create_tables.sql`
3. `03_insert_data.sql`
4. `04_queries.sql`
5. `05_procedures.sql`
6. `06_triggers.sql`

---

## Estado del proyecto

Proyecto en desarrollo.

---

## Autor

**Joaquín Lorenzo González**  
Estudiante de Licenciatura en Informática  
Universidad Siglo 21  

Proyecto realizado como práctica integradora de la materia **Base de Datos I**, con el objetivo de aprender, aplicar y documentar el diseño e implementación de una base de datos relacional completa.