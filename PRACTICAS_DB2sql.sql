CREATE TABLE Clientes(
	IdCliente INT NOT NULL,
	FechaAlta DATE NOT NULL,
	RazonSocial VARCHAR(50) NOT NULL,
	Vendedor VARCHAR(50) NOT NULL
);


INSERT INTO Clientes (IdCliente, FechaAlta, RazonSocial, Vendedor) VALUES (1, '2024-02-15','ARSAYC', 'JUAN')
INSERT INTO Clientes (IdCliente, FechaAlta, RazonSocial, Vendedor) VALUES (2, '2024-02-17','GROUPFD', 'PEDRO')
INSERT INTO Clientes (IdCliente, FechaAlta, RazonSocial, Vendedor) VALUES (3, '2024-04-1','SOINAC', 'JOSE')
INSERT INTO Clientes (IdCliente, FechaAlta, RazonSocial, Vendedor) VALUES (4, '2024-05-5','TECLAB', 'PEPE')
INSERT INTO Clientes (IdCliente, FechaAlta, RazonSocial, Vendedor) VALUES (5, '2024-06-19','POPVAC', 'JUAN')
INSERT INTO Clientes (IdCliente, FechaAlta, RazonSocial, Vendedor) VALUES (6, '2018-08-5','JOAUM', 'ALBERTO')
INSERT INTO Clientes (IdCliente, FechaAlta, RazonSocial, Vendedor) VALUES (7, '2001-12-19','MATERIALSA', 'MARIO')

UPDATE Clientes
SET FechaAlta = '2024-05-05'
WHERE Vendedor = 'PEPE' AND FechaAlta = '2021-04-08';

SELECT *FROM Clientes 


SELECT * FROM ClientePepe

--VISTAS

CREATE VIEW Clientes2001
AS SELECT * FROM Clientes WHERE YEAR(FechaAlta) = 2001;

CREATE VIEW ClientePepe 
AS 
SELECT * 
FROM Clientes 
WHERE Vendedor = 'PEPE' AND YEAR(FechaAlta) = 2024;


DROP VIEW ClientePepe

DROP VIEW Clientes2001

--PROCEDIMIENTOS ALMACENADOS

CREATE PROCEDURE[Dbo].[PepeCliente]
AS
BEGIN
SELECT * FROM Clientes WHERE Vendedor= 'PEPE'
END

CREATE PROCEDURE [Dbo].[ClientesPepe]
@Vendedor VARCHAR(50)
AS
BEGIN
SELECT * FROM Clientes Where Vendedor = @Vendedor
END


EXEC [Dbo].[PepeCliente]

EXEC [Dbo].[ClientesPepe] @Vendedor = 'JUAN'

CREATE PROCEDURE [Dbo].[CualquierAño]
@Año INT
AS
BEGIN
SELECT * FROM Clientes WHERE YEAR(FechaAlta) = @Año
END

EXEC [Dbo].[CualquierAño] @Año = 2024;

--FUNCIONES

DECLARE @numero FLOAT = 4;
DECLARE @raizCuadrada FLOAT = SQRT(@numero);
SELECT @raizCuadrada AS RaizCuadradaDe4;

DECLARE @numero2 FLOAT = 10;
DECLARE @logaritmoNatural FLOAT = LOG(@numero2);
SELECT @logaritmoNatural AS LogaritmoNaturalDe10;


DECLARE @logaritmoBase10De25 FLOAT = LOG(25) / LOG(10);
DECLARE @logaritmoBase10De5 FLOAT = LOG(5) / LOG(10);
SELECT @logaritmoBase10De25 AS LogaritmoBase10De25, @logaritmoBase10De5 AS LogaritmoBase10De5;

DECLARE @cadena VARCHAR(10) = 'ABCDEFGHIJ';
DECLARE @5primeros VARCHAR(5);
SET @5primeros = LEFT(@cadena, 5)
SELECT @5primeros AS Primeros5Caracteres;

DECLARE @cadenamay VARCHAR(10) = 'ABCDEFGHIJ';
DECLARE @minusculas VARCHAR(10);
SET @minusculas = LOWER(@cadenamay)
SELECT @minusculas AS CadenaMinuscula;


DECLARE @fechaActual DATETIME;
SET @fechaActual = GETDATE();
SELECT @fechaActual AS FechaActual;

DECLARE @añoactual INT;
SET @añoactual = YEAR(GETDATE());
SELECT @añoactual AS AñoActual;
