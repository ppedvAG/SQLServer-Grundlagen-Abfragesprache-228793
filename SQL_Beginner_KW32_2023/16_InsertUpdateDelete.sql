/*************************************/

--INSERT

/*************************************/

--SELECT INTO NeuerTabellenName "kopiert" die Ergebnisse in eine neue Tabelle auf der DB
SELECT * INTO BackupCustomers FROM Customers
SELECT * FROM BackupCustomers

--INSERT werden neue Datensätze zu einer vorhandenen Tabelle hinzugefügt

--INSERT INTO Tabelle (Spalten die befüllt werden sollen
--VALUES (Wert1, 2, usw...)
INSERT INTO Customers (CustomerID, CompanyName, Country)
VALUES ('PPEDV', 'ppedv AG', 'Germany')

SELECT * FROM Customers
WHERE CustomerID = 'ppedv'

INSERT INTO Customers (CustomerID, CompanyName, Country)
VALUES 
('LIDL ', 'Lidl', 'Germany'),
('ALDI ', 'Aldi', 'Germany')

--Ergebnisse einer Abfrage direkt in eine Tabelle überschreiben:

INSERT INTO BackupCustomers 
SELECT * FROM Customers --Ergebnisse der Abfrage werden, wenn möglich, in eine Tabelle Inserted
WHERE Country = 'Germany'

INSERT INTO BackupCustomers (CustomerID, CompanyName, Country, Phone)
SELECT CustomerID, CompanyName, Country, Phone FROM Customers

INSERT INTO BackupCustomers (CustomerID, CompanyName, Country, City)
SELECT CustomerID, CompanyName, City , Country FROM Customers


/*************************************/

--Transaction Exkurs

/*************************************/

--SQL Server ist ein transaktionales Datenbanksystem
--JEDE Abfrage ist eine "Transaktion", wir bekommen das normalerweise nur nicht mit, da sehr schnell
--Manuell in eine Transaktion begeben:

BEGIN TRANSACTION --Öffnet eine Transaktion
BEGIN TRAN --Kurzform

SELECT @@TRANCOUNT --Gibt Transaktionlevel zurück (0 = keine Transaktion)

DELETE FROM Customers
WHERE CustomerID IN ('ALDI ', 'LIDL ', 'PPEDV')
SELECT * FROM BackupCustomers

ROLLBACK --Macht alles im aktuellen Transaktionslevel rückgängig, und schließt die Transaktion
COMMIT --Bestätigt alle Vorgänge während der Transaktion und schreibt Ergebnisse in die DB; schließt Transaktion



/*************************************/

--DELETE

/*************************************/

--löscht komplette Datensätze in einer Tabelle

DELETE FROM BackupCustomers
WHERE CustomerID = 'ALFKI'

--Wichtig: WHERE Bedingung nicht vergessen, sonst werden ALLE Datensätze gelöscht!

TRUNCATE TABLE BackupCustomers --Löscht ebenfalls ALLE Datensätze einer Tabelle


/*************************************/

--DROP

/*************************************/

DROP TABLE BackupCustomers
DROP VIEW vMaster
DROP DATABASE Northwind

/*************************************/

--UPDATE

/*************************************/

--Werte in einem vorhandenen Datensatz ändern

UPDATE Customers
SET City = 'Burghausen'
WHERE CustomerID = 'PPEDV'

--Werte "löschen" mit SET = NULL:
UPDATE Customers
SET City = NULL
WHERE CustomerID = 'PPEDV'

--Wie bei DELETE, WHERE Bedingung nicht vergessen, sonst ganze Tabelle!

--Funktionieren bspw. auch mit CASE:
UPDATE Customers
SET Fax = 
CASE 
	WHEN Fax IS NULL THEN 'n/a'
	ELSE Fax
END


/*************************************/

--CREATE TABLE

/*************************************/

--Mit PK & FK direkt:
CREATE TABLE Fuhrpark 
(
AutoID int NOT NULL PRIMARY KEY, --Wenn wir keine NULL Einstellung definieren, ist der Default NULL (darf NULL sein)
Hersteller varchar(50),
EmployeeID int FOREIGN KEY REFERENCES Employees (EmployeeID)
)

--Mit PK & FK nachträglich:
CREATE TABLE Fuhrpark2
(
AutoID int NOT NULL,
Hersteller varchar(50),
EmployeeID int
--,CONSTRAINT FK_namevergeben FOREIGN KEY: Alternative zu ALTER TABLE ADD CONSTRAINT
)

--Für PK:
--Möglichkeit 1:
ALTER TABLE Fuhrpark2
ADD PRIMARY KEY (AutoID)

--Möglichkeit 2 über CONSTRAINT:
ALTER TABLE Fuhrpark2
ADD CONSTRAINT PK_Fuhrpark_AutoID PRIMARY KEY (AutoID)

--Für FK:
--Möglichkeit 1:
ALTER TABLE Fuhrpark2
ADD FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)

--Möglichkeit 2 über CONSTRAINT:
ALTER TABLE Fuhrpark2
ADD CONSTRAINT FK_Fuhrpark_EmployeeID_Employees_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Employees (EmployeeID)

--Nachträglich Spalten hinzufügen:
ALTER TABLE FuhrPark2
ADD Farbe varchar(20)
ALTER TABLE FuhrPark2
ADD PS int

--CHECK CONSTRAINT: Prüft Eingabewerte:
ALTER TABLE Fuhrpark2
ADD CONSTRAINT CHK_PS_Positive CHECK (PS > 0) --PS Wert muss größer 0 sein, sonst Fehlermeldung

INSERT INTO Fuhrpark2
VALUES (1, 'Audi', 2, 'blau', 50)

SELECT * FROM Fuhrpark2

--Auto increment bei ID Spalte anlegen:
CREATE TABLE Fuhrpark3 
(
AutoID int identity(10000, 1) NOT NULL,
Hersteller varchar(50),
EmployeeID int
)

INSERT INTO Fuhrpark3
VALUES ('BMW', 3)

SELECT * FROM Fuhrpark3



