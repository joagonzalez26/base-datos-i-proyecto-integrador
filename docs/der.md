# Diagrama Entidad-Relación DER

## Proyecto Integrador Base de Datos I  
### Sistema de Gestión Académica para un Instituto de Cursos

El Diagrama Entidad-Relación permite representar gráficamente las entidades del sistema, sus atributos y las relaciones entre ellas.

En este proyecto, el DER se utiliza como paso previo al modelo relacional, para analizar cómo se relacionan los datos antes de crear las tablas en MySQL.

---

## 1. Entidades principales

Las entidades principales del sistema son:

- Alumno
- Profesor
- Curso
- Materia
- Inscripción
- Pago
- Asistencia
- Aula
- Horario
- Auditoría

---

## 2. Entidades y atributos principales

### Alumno

```text
Alumno
- id_alumno
- nombre
- apellido
- dni
- email
- telefono
- fecha_nacimiento
- fecha_alta
- estado
```

### Profesor

```text
Profesor
- id_profesor
- nombre
- apellido
- dni
- email
- telefono
- especialidad
- estado
```

### Curso

```text
Curso
- id_curso
- nombre
- descripcion
- duracion_meses
- precio
- estado
```

### Materia

```text
Materia
- id_materia
- nombre
- descripcion
- carga_horaria
- estado
```

### Inscripción

```text
Inscripcion
- id_inscripcion
- fecha_inscripcion
- estado
```

### Pago

```text
Pago
- id_pago
- fecha_pago
- monto
- metodo_pago
- estado_pago
```

### Asistencia

```text
Asistencia
- id_asistencia
- fecha_clase
- presente
- observacion
```

### Aula

```text
Aula
- id_aula
- nombre
- capacidad
- ubicacion
- estado
```

### Horario

```text
Horario
- id_horario
- dia_semana
- hora_inicio
- hora_fin
```

### Auditoría

```text
Auditoria
- id_auditoria
- tabla_afectada
- accion
- descripcion
- fecha_hora
```

---

## 3. Relaciones principales

```text
Alumno 1 --- N Inscripcion
Curso 1 --- N Inscripcion
Curso 1 --- N Materia
Profesor 1 --- N Materia
Inscripcion 1 --- N Pago
Inscripcion 1 --- N Asistencia
Materia 1 --- N Horario
Aula 1 --- N Horario
```

---

## 4. Relación muchos a muchos

La relación entre `Alumno` y `Curso` es de muchos a muchos.

Un alumno puede inscribirse a varios cursos, y un curso puede tener muchos alumnos.

Por eso se crea la entidad intermedia `Inscripcion`.

```text
Alumno 1 --- N Inscripcion N --- 1 Curso
```

---

## 5. Explicación del diseño

El DER permite visualizar cómo se organiza la información del instituto.

La entidad `Inscripcion` es una de las más importantes del modelo, porque conecta alumnos con cursos.

A partir de la inscripción se pueden registrar pagos y asistencias, ya que ambos datos dependen de que un alumno esté anotado en un curso.

Las entidades `Materia`, `Profesor`, `Aula` y `Horario` permiten representar la organización académica del instituto.

---

## 6. Versión conceptual del DER

```text
ALUMNO
  |
  | 1 --- N
  |
INSCRIPCION
  |
  | N --- 1
  |
CURSO
  |
  | 1 --- N
  |
MATERIA
  |
  | N --- 1
  |
PROFESOR

INSCRIPCION 1 --- N PAGO
INSCRIPCION 1 --- N ASISTENCIA

MATERIA 1 --- N HORARIO
AULA 1 --- N HORARIO
```

---

## 7. Conclusión

El DER propuesto representa las entidades principales del sistema académico y sus relaciones.

Este diagrama sirve como base para construir el modelo relacional, donde cada entidad será transformada en una tabla y cada relación será implementada mediante claves primarias y claves foráneas.