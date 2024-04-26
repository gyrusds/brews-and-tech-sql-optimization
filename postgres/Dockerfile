FROM postgres:13

COPY init.sql /docker-entrypoint-initdb.d/
COPY data/empleados.csv /docker-entrypoint-initdb.d/empleados.csv
COPY data/contratos.csv /docker-entrypoint-initdb.d/contratos.csv