CREATE DATABASE EXAMEN_FINAL202546

CREATE TABLE HOSPITAL (
    Referencia INT PRIMARY KEY,
    FechaIngreso DATE NOT NULL,
    TipoHospital VARCHAR(50) NOT NULL,
    Operacion VARCHAR(100) NOT NULL,
    Ubicacion VARCHAR(255) NOT NULL,
    CapacidadCamas INT NOT NULL,
    PresupuestoAnual DECIMAL(15,2) NOT NULL,
    FechaUltimaInspeccion DATE NOT NULL,
    Director VARCHAR(100) NOT NULL,
    Estatus VARCHAR(50) NOT NULL,
    PersonalTotal INT NOT NULL,
    PorcentajeOcupacion DECIMAL(5,2) NOT NULL
);

USE EXAMEN_FINAL202546

SELECT*
FROM HOSPITAL

--- Limpieza de PresupuestoAnual
UPDATE HOSPITAL
SET PresupuestoAnual = REPLACE(PresupuestoAnual, '$', '');


--- Limpieza de Estatus
SELECT 
    RIGHT(Estatus, LEN(Estatus) - 4) AS EstatusLimpio
FROM HOSPITAL;

--- Limpieza de PorcentajeOcupacion
SELECT 
    CAST(REPLACE(PorcentajeOcupacion, '%', '') AS DECIMAL(5,2)) / 100 AS PorcentajeLimpio
FROM HOSPITAL;

UPDATE HOSPITAL
SET Estatus = 
    CASE 
        WHEN Estatus LIKE 'C = %' THEN REPLACE(Estatus, 'C = ', '')
		WHEN Estatus LIKE 'C-=-%' THEN REPLACE(Estatus, 'C-=-', '')
        WHEN Estatus LIKE 'F = %' THEN REPLACE(Estatus, 'F = ', '')
		WHEN Estatus LIKE 'F-=-%' THEN REPLACE(Estatus, 'F-=-', '')
        WHEN Estatus LIKE 'M = %' THEN REPLACE(Estatus, 'M = ', '')
		WHEN Estatus LIKE 'M-=-%' THEN REPLACE(Estatus, 'M-=-', '') 
        ELSE Estatus 
    END;


--- Limpieza de PorcentajeOcupación
SELECT 
    CAST(REPLACE(PorcentajeOcupacion, '%', '') AS DECIMAL(5,2)) / 100 AS PorcentajeLimpio
FROM HOSPITAL;

UPDATE HOSPITAL
SET PorcentajeOcupacion = CAST(REPLACE(PorcentajeOcupacion, '%', '') AS DECIMAL(5,2)) / 100;


--- Limpieza de Fechas
SELECT FORMAT(FechaIngreso, 'dd/MM/yyyy') AS FechaLimpia
FROM HOSPITAL;

UPDATE HOSPITAL
SET FechaIngreso = FORMAT(FechaIngreso, 'dd/MM/yyyy'),
    FechaUltimaInspeccion = FORMAT(FechaUltimaInspeccion, 'dd/MM/yyyy');

	UPDATE HOSPITAL
SET FechaIngreso = CONVERT(DATE, FechaIngreso, 103),
    FechaUltimaInspeccion = CONVERT(DATE, FechaUltimaInspeccion, 103);

	SELECT FechaIngreso, TRY_CONVERT(DATE, FechaIngreso, 103) AS FechaLimpia
FROM HOSPITAL;


--- Limpieza Ubicacion
ALTER TABLE HOSPITAL
ADD Ubicacion1 VARCHAR(100),
    Ubicacion2 VARCHAR(100),
    Ubicacion3 VARCHAR(100);

UPDATE HOSPITAL
SET Ubicacion1 = LEFT(Ubicacion, CHARINDEX('|', Ubicacion) - 1), 
    Ubicacion2 = SUBSTRING(Ubicacion, CHARINDEX('|', Ubicacion) + 1, CHARINDEX('|', Ubicacion, CHARINDEX('|', Ubicacion) + 1) - CHARINDEX('|', Ubicacion) - 1), 
    Ubicacion3 = RIGHT(Ubicacion, LEN(Ubicacion) - CHARINDEX('|', Ubicacion, CHARINDEX('|', Ubicacion) + 1));


ALTER TABLE HOSPITAL DROP COLUMN Ubicacion;



