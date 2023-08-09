/*************************************/

--Variablen

/*************************************/

--Müssen mit DECLARE definiert werden --> DECLARE muss immer mit ausgeführt werden!
--Werden mit @ Zeichen definiert

DECLARE @Variable1 int, @Var2 int, @var3 varchar(50) = 'Germany'

--SELECT * FROM Customers
--WHERE Country = @var3

SET @Variable1 = 1 --Mit SET kann der Wert geändert werden
--SELECT @Variable1, @Var2, @var3

SET @var3 = (SELECT DISTINCT TOP 1 Country FROM Customers) --Funktioniert auch mit Subqueries
SELECT @var3


/*************************************/

--Stored Procedure/gespeicherte Prozedur

/*************************************/

--Abgespeicherte SQL Statements, nicht nur SELECT Anweisungen, sondern auch inserts, creates usw...

GO --Batchtrennzeichen

CREATE PROCEDURE spCustomersByCountry @Country varchar(30)
AS
SELECT * FROM Customers
WHERE Country = @Country

--Default Wert kann für Variablen angegeben werden:
ALTER PROCEDURE [dbo].[spCustomersByCountry] @Country varchar(30) = 'France'
AS
SELECT * FROM Customers
WHERE Country = @Country

--Verwenden von Procedures:
EXEC spCustomersByCountry Germany

--Nützlich für:
--Performance, da Abfrageplan "recycled" wird
--Können mit "Zeitschaltern" versehen werden für Wartungstasks etc.
--Komplexe Statements können einfach wiederverwendet werden, ohne den Code groß ändern zu müssen