# Modelo Relacional

## Proyecto Integrador Base de Datos I  
### Sistema de Gestión Académica para un Instituto de Cursos

En esta etapa se transforma el análisis realizado previamente en un modelo relacional compuesto por tablas, atributos, claves primarias y claves foráneas.

El modelo relacional representa la información mediante tablas, donde cada entidad se convierte en una tabla, cada atributo en una columna y cada relación se resuelve mediante claves foráneas o tablas intermedias.

---

## 1. Tablas principales del sistema

Las tablas principales del sistema serán:

- alumno
- profesor
- curso
- materia
- inscripcion
- pago
- asistencia
- aula
- horario
- auditoria

---

## 2. Tabla: alumno

Almacena los datos personales de los alumnos del instituto.

```text
alumno(
    id_alumno PK,
    nombre,
    apellido,
    dni,
    email,
    telefono,
    fecha_nacimiento,
    fecha_alta,
    estado
)
```

### Clave primaria

```text
id_alumno
```

---

## 3. Tabla: profesor

Almacena los datos de los profesores.

```text
profesor(
    id_profesor PK,
    nombre,
    apellido,
    dni,
    email,
    telefono,
    especialidad,
    estado
)
```

### Clave primaria

```text
id_profesor
```

---

## 4. Tabla: curso

Almacena los cursos ofrecidos por el instituto.

```text
curso(
    id_curso PK,
    nombre,
    descripcion,
    duracion_meses,
    precio,
    estado
)
```

### Clave primaria

```text
id_curso
```

---

## 5. Tabla: materia

Almacena las materias que pertenecen a cada curso.

```text
materia(
    id_materia PK,
    nombre,
    descripcion,
    carga_horaria,
    id_curso FK,
    id_profesor FK,
    estado
)
```

### Clave primaria

```text
id_materia
```

### Claves foráneas

```text
id_curso → curso(id_curso)
id_profesor → profesor(id_profesor)
```

---

## 6. Tabla: inscripcion

Representa la inscripción de un alumno a un curso.

Esta tabla resuelve la relación muchos a muchos entre alumnos y cursos, ya que un alumno puede inscribirse a varios cursos y un curso puede tener muchos alumnos.

```text
inscripcion(
    id_inscripcion PK,
    id_alumno FK,
    id_curso FK,
    fecha_inscripcion,
    estado
)
```

### Clave primaria

```text
id_inscripcion
```

### Claves foráneas

```text
id_alumno → alumno(id_alumno)
id_curso → curso(id_curso)
```

---

## 7. Tabla: pago

Almacena los pagos realizados por los alumnos en relación con una inscripción.

```text
pago(
    id_pago PK,
    id_inscripcion FK,
    fecha_pago,
    monto,
    metodo_pago,
    estado_pago
)
```

### Clave primaria

```text
id_pago
```

### Clave foránea

```text
id_inscripcion → inscripcion(id_inscripcion)
```

---

## 8. Tabla: asistencia

Registra la asistencia de los alumnos a las clases.

```text
asistencia(
    id_asistencia PK,
    id_inscripcion FK,
    fecha_clase,
    presente,
    observacion
)
```

### Clave primaria

```text
id_asistencia
```

### Clave foránea

```text
id_inscripcion → inscripcion(id_inscripcion)
```

---

## 9. Tabla: aula

Almacena las aulas disponibles del instituto.

```text
aula(
    id_aula PK,
    nombre,
    capacidad,
    ubicacion,
    estado
)
```

### Clave primaria

```text
id_aula
```

---

## 10. Tabla: horario

Registra los horarios en los que se dictan las materias.

```text
horario(
    id_horario PK,
    id_materia FK,
    id_aula FK,
    dia_semana,
    hora_inicio,
    hora_fin
)
```

### Clave primaria

```text
id_horario
```

### Claves foráneas

```text
id_materia → materia(id_materia)
id_aula → aula(id_aula)
```

---

## 11. Tabla: auditoria

Registra cambios importantes realizados en el sistema.

```text
auditoria(
    id_auditoria PK,
    tabla_afectada,
    accion,
    descripcion,
    fecha_hora
)
```

### Clave primaria

```text
id_auditoria
```

---

## 12. Relaciones y cardinalidades

```text
alumno 1 --- N inscripcion
curso 1 --- N inscripcion
curso 1 --- N materia
profesor 1 --- N materia
inscripcion 1 --- N pago
inscripcion 1 --- N asistencia
materia 1 --- N horario
aula 1 --- N horario
```

---

## 13. Explicación de las relaciones

### Alumno e inscripción

Un alumno puede tener muchas inscripciones, pero cada inscripción pertenece a un solo alumno.

```text
alumno 1 --- N inscripcion
```

---

### Curso e inscripción

Un curso puede tener muchos alumnos inscriptos, pero cada inscripción pertenece a un solo curso.

```text
curso 1 --- N inscripcion
```

---

### Alumno y curso

La relación entre alumno y curso es muchos a muchos, pero se resuelve mediante la tabla intermedia `inscripcion`.

```text
alumno N --- N curso
```

Se transforma en:

```text
alumno 1 --- N inscripcion N --- 1 curso
```

---

### Curso y materia

Un curso puede tener muchas materias, pero cada materia pertenece a un solo curso.

```text
curso 1 --- N materia
```

---

### Profesor y materia

Un profesor puede dictar muchas materias, pero cada materia está asignada a un profesor.

```text
profesor 1 --- N materia
```

---

### Inscripción y pago

Una inscripción puede tener muchos pagos, pero cada pago pertenece a una sola inscripción.

```text
inscripcion 1 --- N pago
```

---

### Inscripción y asistencia

Una inscripción puede tener muchas asistencias, pero cada asistencia pertenece a una sola inscripción.

```text
inscripcion 1 --- N asistencia
```

---

### Materia, aula y horario

Una materia puede tener varios horarios y un aula puede utilizarse en distintos horarios.

```text
materia 1 --- N horario
aula 1 --- N horario
```

---

## 14. Resumen del modelo

Este modelo permite representar de forma ordenada la información principal de un instituto de cursos.

Las tablas están relacionadas mediante claves primarias y claves foráneas, respetando las reglas del modelo relacional.

La tabla `inscripcion` cumple un rol central porque permite vincular alumnos con cursos, resolviendo una relación muchos a muchos.

Además, las tablas `pago` y `asistencia` dependen de la inscripción, ya que los pagos y asistencias se registran en relación con un alumno inscripto en un curso.