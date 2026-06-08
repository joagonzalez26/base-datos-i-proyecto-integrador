# Análisis de Requerimientos

## Proyecto Integrador Base de Datos I  
### Sistema de Gestión Académica para un Instituto de Cursos

## 1. Descripción del problema

Un instituto de formación necesita organizar la información relacionada con alumnos, profesores, cursos, materias, inscripciones, pagos, asistencias, aulas y horarios.

Actualmente, esta información podría encontrarse dispersa o administrarse manualmente, lo que puede generar errores, duplicación de datos y dificultad para obtener reportes confiables.

Por este motivo, se propone diseñar una base de datos relacional en MySQL que permita almacenar, relacionar y consultar la información de manera ordenada, segura y eficiente.

---

## 2. Objetivo general

Diseñar e implementar una base de datos relacional para un sistema de gestión académica, aplicando análisis de requerimientos, modelo entidad-relación, normalización y lenguaje SQL.

---

## 3. Alcance del sistema

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

## 4. Requerimientos funcionales

- Registrar alumnos con sus datos personales.
- Registrar profesores con sus datos personales y especialidad.
- Registrar cursos ofrecidos por el instituto.
- Registrar materias asociadas a cada curso.
- Asignar profesores a materias.
- Inscribir alumnos a cursos.
- Registrar pagos asociados a una inscripción.
- Registrar asistencias de los alumnos.
- Asignar aulas y horarios para el dictado de clases.
- Consultar alumnos inscriptos por curso.
- Consultar pagos pendientes.
- Consultar asistencia de un alumno.
- Calcular ingresos por curso.
- Registrar auditoría de cambios importantes.

---

## 5. Requerimientos de datos

El sistema deberá almacenar:

- Datos personales de alumnos.
- Datos personales de profesores.
- Información de cursos y materias.
- Inscripciones de alumnos a cursos.
- Pagos realizados o pendientes.
- Asistencias por clase.
- Aulas disponibles.
- Horarios de cursado.
- Registros de auditoría.

---

## 6. Reglas de negocio

- Un alumno puede inscribirse a varios cursos.
- Un curso puede tener muchos alumnos inscriptos.
- Una inscripción pertenece a un solo alumno y a un solo curso.
- Un curso puede tener varias materias.
- Una materia pertenece a un curso.
- Un profesor puede dictar varias materias.
- Una inscripción puede tener varios pagos.
- Una inscripción puede tener muchas asistencias.
- Un aula puede utilizarse en varios horarios.
- No debe existir una inscripción duplicada para el mismo alumno en el mismo curso activo.
- Los pagos deben tener un monto mayor a cero.
- Los alumnos, profesores, cursos y materias pueden tener estado activo o inactivo.