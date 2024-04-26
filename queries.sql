-----------------------------------------------------------------------QUERIES BASICAS DE LOS DATOS

--SELECT * FROM pg_database;

--SELECT tablename FROM pg_tables WHERE schemaname='public';

--SELECT * FROM empleados LIMIT 5;

--SELECT * FROM contratos LIMIT 5;

--SELECT COUNT(1) FROM empleados; --vemos un poco la cantidad de registros de la tabla empleados

--SELECT COUNT(1) FROM contratos; --vemos la cantidad de registros de la tabla contratos


-----------------------------------------------------------------------QUERIES INDICES

/*
EXPLAIN ANALYZE
SELECT id
FROM empleados
WHERE id=22;
*/

/*
EXPLAIN ANALYZE
SELECT nombre
FROM empleados
WHERE nombre='Amanda';
*/

/*
CREATE INDEX idx_nombre
ON empleados (nombre);
*/

/*
EXPLAIN ANALYZE
SELECT nombre
FROM empleados
WHERE nombre='Amanda';
*/

--DROP INDEX idx_nombre;

/*
EXPLAIN ANALYZE
SELECT *
FROM empleados
WHERE departamento='Desarrollo';
*/

/*
CREATE INDEX idx_departamento
ON empleados (departamento);
*/

/*
EXPLAIN ANALYZE 
SELECT *
FROM empleados
WHERE departamento='Desarrollo';
*/

--DROP INDEX idx_departamento;

/*
SELECT
    indexname AS nombre_indice,
    pg_size_pretty(pg_indexes_size(indexname::regclass)) AS tamaño
FROM pg_indexes
WHERE tablename = 'empleados';
*/


------------------------------------------------------------------------QUERIES JOINS 

/*
EXPLAIN ANALYZE
SELECT e.id, e.nombre, c.id, c.id_empleado
FROM empleados e
JOIN contratos c
ON e.id=c.id_empleado;
*/

/*
EXPLAIN ANALYZE
SELECT e.id, e.nombre, c.id, c.id_empleado
FROM empleados e
JOIN contratos c
ON e.id = CAST(c.id_empleado_char AS INTEGER);
*/


------------------------------------------------------------------------QUERIES PREFILTRADO JOINS 

/*
EXPLAIN ANALYZE
SELECT e.nombre, c.tipo
FROM empleados e
JOIN contratos c
ON e.id = c.id_empleado
WHERE c.tipo = 'Tiempo Indefinido';
*/

/*
EXPLAIN ANALYZE
SELECT e.nombre, c.tipo
FROM empleados e
JOIN (
    SELECT id_empleado, tipo
    FROM contratos
    WHERE tipo = 'Tiempo Indefinido'
) c
ON e.id = c.id_empleado;
*/


-------------------------------------------------------------------------QUERIES FUNCIONES ANALITICAS

/*
SELECT e.id, e.nombre, e.apellido, c.tipo, c.cantidad,
       (SELECT SUM(c2.cantidad)
        FROM contratos c2
        WHERE c2.id_empleado = e.id AND c2.id <= c.id) AS salario_acumulado
FROM empleados e
JOIN contratos c ON e.id = c.id_empleado
WHERE e.id <5000
order by e.id;
*/

/*
SELECT e.id, e.nombre, e.apellido, c.tipo, c.cantidad,
       SUM(c.cantidad) OVER (PARTITION BY e.id ORDER BY c.id) AS salario_acumulado
FROM empleados e
JOIN contratos c ON e.id = c.id_empleado
WHERE e.id <5000;
*/