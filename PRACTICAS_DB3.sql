CREATE TABLE Sueldos(
	IdSueldo INT PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL,
	Sueldo INT NOT NULL
);

CREATE TABLE Liquidaciones(
	IdLiquidacion INT NOT NULL,
	Nombre VARCHAR(50) PRIMARY KEY,
	Mes DATE NOT NULL,
	Liquidacion INT NOT NULL
);

INSERT INTO Sueldos (IdSueldo, Nombre, Sueldo) VALUES
(1, 'Juan Pérez', 50000),
(2, 'María González', 60000),
(3, 'Carlos Ramírez', 55000),
(4, 'Ana Rodríguez', 70000);

SELECT * FROM Sueldos

INSERT INTO Liquidaciones (IdLiquidacion, Nombre, Mes, Liquidacion) VALUES
(101, 'Juan Pérez', '2024-04-01', 1500),
(102, 'María González', '2024-03-01', 1800),
(103, 'Carlos Ramírez', '2024-02-01', 1600),
(104, 'Ana Rodríguez', '2024-01-01', 2000);

SELECT * FROM Liquidaciones

CREATE TRIGGER BorrarLiquidacion
ON Liquidaciones
AFTER DELETE
AS
BEGIN
DELETE FROM Sueldos WHERE Nombre IN (SELECT DISTINCT Nombre FROM DELETED)
END;

CREATE TRIGGER InsertarEmpleado
ON Liquidaciones
AFTER INSERT
AS 
BEGIN
INSERT INTO Sueldos(Nombre, Sueldo) SELECT Nombre, 0 FROM INSERTED
END;

CREATE TRIGGER ModificarEmpleado
ON Liquidaciones
AFTER UPDATE
AS 
BEGIN
IF UPDATE(Nombre)
	BEGIN
	UPDATE L
	SET L.Nombre = I.Nombre
        FROM Liquidaciones AS L
        INNER JOIN INSERTED AS I ON L.Nombre = I.Nombre;
    END;
END;


CREATE TABLE PERSONAL (
	IdPersonal INT PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL,
	FechaIngreso DATE NOT NULL,
	Legajo INT NOT NULL
);

INSERT INTO PERSONAL (IdPersonal, Nombre, FechaIngreso, Legajo)
VALUES (1, 'Pedro Pérez', '2022-01-15', 1001);

INSERT INTO PERSONAL (IdPersonal, Nombre, FechaIngreso, Legajo)
VALUES (2, 'Nayib Bukele', '2022-02-20', 1002);

INSERT INTO PERSONAL (IdPersonal, Nombre, FechaIngreso, Legajo)
VALUES (3, 'Carlos Menem', '2022-03-10', 1003);

INSERT INTO PERSONAL (IdPersonal, Nombre, FechaIngreso, Legajo)
VALUES (4, 'Javier Milei', '2022-04-05', 1004);

INSERT INTO PERSONAL (IdPersonal, Nombre, FechaIngreso, Legajo)
VALUES (5, 'Alberto Fernandez', '2022-05-12', 1005);

SELECT * FROM Personal

ALTER TABLE PERSONAL
ALTER COLUMN Legajo INT NULL;

UPDATE PERSONAL
SET Legajo = NULL;




DECLARE @ContadorLegajo INT = 1;
DECLARE @IdPersonal INT;
DECLARE @OrdenIngreso INT;

DECLARE CurLegajos CURSOR FOR
SELECT IdPersonal, ROW_NUMBER() OVER (ORDER BY FechaIngreso) AS OrdenIngreso
FROM PERSONAL
ORDER BY FechaIngreso;

OPEN CurLegajos;

FETCH NEXT FROM CurLegajos INTO @IdPersonal, @OrdenIngreso;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE PERSONAL
    SET Legajo = @ContadorLegajo
    WHERE IdPersonal = @IdPersonal;

    SET @ContadorLegajo = @ContadorLegajo + 1;

    FETCH NEXT FROM CurLegajos INTO @IdPersonal, @OrdenIngreso;
END

CLOSE CurLegajos;
DEALLOCATE CurLegajos;

