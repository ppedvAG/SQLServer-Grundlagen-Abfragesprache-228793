/*************************************/

--INSERT

/*************************************/

--SELECT INTO NeuerTabellenName "kopiert" die Ergebnisse in eine neue Tabelle auf der DB
SELECT * INTO BackupCustomers FROM Customers
SELECT * FROM BackupCustomers

--INSERT werden neue Datens�tze zu einer vorhandenen Tabelle hinzugef�gt

--INSERT INTO Tabelle (Spalten die bef�llt werden sollen
--VALUES (Wert1, 2, usw...)
INSERT INTO Customers (CustomerID, CompanyName, Country)
VALUES ('PPEDV', 'ppedv AG', 'Germany')

SELECT * FROM Customers
WHERE CustomerID = 'ppedv'

INSERT INTO Customers (CustomerID, CompanyName, Country)
VALUES 
('LIDL ', 'Lidl', 'Germany'),
('ALDI ', 'Aldi', 'Germany')

--Ergebnisse einer Abfrage direkt in eine Tabelle �berschreiben:

INSERT INTO BackupCustomers 
SELECT * FROM Customers --Ergebnisse der Abfrage werden, wenn m�glich, in eine Tabelle Inserted
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

BEGIN TRANSACTION --�ffnet eine Transaktion
BEGIN TRAN --Kurzform

SELECT @@TRANCOUNT --Gibt Transaktionlevel zur�ck (0 = keine Transaktion)

DELETE FROM Customers
WHERE CustomerID IN ('ALDI ', 'LIDL ', 'PPEDV')
SELECT * FROM BackupCustomers

ROLLBACK --Macht alles im aktuellen Transaktionslevel r�ckg�ngig, und schlie�t die Transaktion
COMMIT --Best�tigt alle Vorg�nge w�hrend der Transaktion und schreibt Ergebnisse in die DB; schlie�t Transaktion



/*************************************/

--DELETE

/*************************************/

--l�scht komplette Datens�tze in einer Tabelle

DELETE FROM BackupCustomers
WHERE CustomerID = 'ALFKI'

--Wichtig: WHERE Bedingung nicht vergessen, sonst werden ALLE Datens�tze gel�scht!

TRUNCATE TABLE BackupCustomers --L�scht ebenfalls ALLE Datens�tze einer Tabelle


/*************************************/

--DROP

/*************************************/

DROP TABLE BackupCustomers
DROP VIEW vMaster
DROP DATABASE Northwind

/*************************************/

--UPDATE

/*************************************/

--Werte in einem vorhandenen Datensatz �ndern

UPDATE Customers
SET City = 'Burghausen'
WHERE CustomerID = 'PPEDV'

--Werte "l�schen" mit SET = NULL:
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

--Mit PK & FK nachtr�glich:
CREATE TABLE Fuhrpark2
(
AutoID int NOT NULL,
Hersteller varchar(50),
EmployeeID int
--,CONSTRAINT FK_namevergeben FOREIGN KEY: Alternative zu ALTER TABLE ADD CONSTRAINT
)

--F�r PK:
--M�glichkeit 1:
ALTER TABLE Fuhrpark2
ADD PRIMARY KEY (AutoID)

--M�glichkeit 2 �ber CONSTRAINT:
ALTER TABLE Fuhrpark2
ADD CONSTRAINT PK_Fuhrpark_AutoID PRIMARY KEY (AutoID)

--F�r FK:
--M�glichkeit 1:
ALTER TABLE Fuhrpark2
ADD FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)

--M�glichkeit 2 �ber CONSTRAINT:
ALTER TABLE Fuhrpark2
ADD CONSTRAINT FK_Fuhrpark_EmployeeID_Employees_EmployeeID FOREIGN KEY (EmployeeID)
REFERENCES Employees (EmployeeID)

--Nachtr�glich Spalten hinzuf�gen:
ALTER TABLE FuhrPark2
ADD Farbe varchar(20)
ALTER TABLE FuhrPark2
ADD PS int

--CHECK CONSTRAINT: Pr�ft Eingabewerte:
ALTER TABLE Fuhrpark2
ADD CONSTRAINT CHK_PS_Positive CHECK (PS > 0) --PS Wert muss gr��er 0 sein, sonst Fehlermeldung

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



