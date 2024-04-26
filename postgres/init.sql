CREATE DATABASE bbdd_empleados;

\c bbdd_empleados;

CREATE TABLE empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    edad INT,
    correo VARCHAR(255),
    telefono VARCHAR(255),
    direccion VARCHAR(255),
    ciudad VARCHAR(255),
    departamento VARCHAR(255));

\copy empleados (id, nombre, apellido, edad, correo, telefono, direccion, ciudad, departamento) FROM '/docker-entrypoint-initdb.d/empleados.csv' WITH CSV HEADER;

CREATE TABLE contratos (
    id INT PRIMARY KEY,
    tipo VARCHAR(255),
    cantidad INT,
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados (id) ON DELETE CASCADE);

\copy contratos (id, tipo, cantidad, id_empleado) FROM '/docker-entrypoint-initdb.d/contratos.csv' WITH CSV HEADER;

ALTER TABLE contratos ADD COLUMN id_empleado_char VARCHAR(6);

UPDATE contratos SET id_empleado_char = LEFT(CAST(id_empleado AS VARCHAR), 6);
