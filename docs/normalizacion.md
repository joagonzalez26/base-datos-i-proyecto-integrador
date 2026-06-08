# Normalización

## Proyecto Integrador Base de Datos I  
### Sistema de Gestión Académica para un Instituto de Cursos

La normalización es un proceso que permite organizar las tablas de una base de datos para evitar datos repetidos, mejorar la integridad de la información y reducir errores al insertar, modificar o eliminar registros.

En este proyecto se busca que el modelo relacional cumpla, como mínimo, con la **Primera Forma Normal**, **Segunda Forma Normal** y **Tercera Forma Normal**.

---

## 1. Primera Forma Normal 1FN

Una tabla está en Primera Forma Normal cuando todos sus campos contienen valores atómicos, es decir, valores simples que no se repiten dentro de una misma celda.

### Aplicación en el proyecto

En este modelo no se guardan listas dentro de una columna.

Ejemplo incorrecto:

```text
alumno(
    id_alumno,
    nombre,
    telefonos
)
```

Donde `telefonos` podría tener varios números en una misma celda.

Ejemplo correcto aplicado al proyecto:

```text
alumno(
    id_alumno,
    nombre,
    apellido,
    dni,
    email,
    telefono
)
```

Cada atributo guarda un solo dato.

---

## 2. Segunda Forma Normal 2FN

Una tabla está en Segunda Forma Normal cuando cumple con la 1FN y todos los atributos que no son clave dependen completamente de la clave primaria.

La 2FN es especialmente importante cuando una tabla tiene una clave primaria compuesta.

### Aplicación en el proyecto

La relación entre alumnos y cursos se resuelve con la tabla `inscripcion`.

```text
inscripcion(
    id_inscripcion,
    id_alumno,
    id_curso,
    fecha_inscripcion,
    estado
)
```

Los datos propios del alumno se guardan en `alumno`.

Los datos propios del curso se guardan en `curso`.

La tabla `inscripcion` solo guarda información relacionada con la inscripción.

Esto evita repetir datos del alumno o del curso innecesariamente.

---

## 3. Tercera Forma Normal 3FN

Una tabla está en Tercera Forma Normal cuando cumple con la 2FN y ningún atributo no clave depende de otro atributo no clave.

Es decir, cada dato debe depender de la clave primaria de su tabla y no de otro campo secundario.

### Aplicación en el proyecto

Ejemplo incorrecto:

```text
inscripcion(
    id_inscripcion,
    id_alumno,
    nombre_alumno,
    id_curso,
    nombre_curso
)
```

En este caso, `nombre_alumno` depende de `id_alumno`, no de `id_inscripcion`.

Ejemplo correcto:

```text
alumno(
    id_alumno,
    nombre,
    apellido
)

curso(
    id_curso,
    nombre
)

inscripcion(
    id_inscripcion,
    id_alumno,
    id_curso,
    fecha_inscripcion,
    estado
)
```

De esta manera, los datos de alumnos, cursos e inscripciones quedan separados correctamente.

---

## 4. Ventajas de la normalización en el proyecto

La normalización permite:

- Evitar datos duplicados.
- Reducir errores al actualizar información.
- Evitar problemas al eliminar registros.
- Mejorar la organización de las tablas.
- Mantener la integridad de los datos.
- Facilitar consultas SQL más claras.
- Hacer que el modelo sea más profesional y mantenible.

---

## 5. Conclusión

El modelo propuesto para el sistema de gestión académica se encuentra normalizado porque separa correctamente las entidades principales del sistema.

Los datos de alumnos, profesores, cursos, materias, inscripciones, pagos, asistencias, aulas y horarios se almacenan en tablas independientes, relacionadas mediante claves primarias y claves foráneas.

Esto permite construir una base de datos ordenada, flexible y preparada para consultas, procedimientos almacenados y triggers.