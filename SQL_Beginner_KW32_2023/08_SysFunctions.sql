--Verwenden von Systemfunktionen

/*************************************/

--String-/Characterfunctions:

/*************************************/

SELECT LTRIM(), RTRIM(), TRIM()
--Entfernen Whitespaces links/rechts bzw. links & rechts
SELECT LTRIM('                            Hallo')

SELECT LEFT(CompanyName, 5), RIGHT(CompanyName, 5), CompanyName FROM Customers
--"linken" oder "rechten" X Zeichen eines Strings

SELECT SUBSTRING(CompanyName, 4, 5), CompanyName FROM Customers
--X Charcater ab Position Y

SELECT LEN(CompanyName), CompanyName FROM Customers
--Länge eines Strings als integer

SELECT STUFF(Phone, 1, 5, 'XXXXX') FROM Customers
--Ersetzt Teil eines Strings ab einer Position X mit neuem Wert

--Letzten 5 Ziffern jeder Telefonnummer mit XXXXX ersetzen:
SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers
--Funktionen können ineinander verschachtelt werden

SELECT REPLICATE('X', 5)
--Wiederholt einen String X mal

SELECT REPLACE(City, ' ', ' Leerzeichen ') FROM Customers
--Sucht nach einem String und ersetzt diesen mit Customwert

SELECT PATINDEX('%Manager%', ContactTitle), ContactTitle FROM Customers
--Sucht nach einem Schema in einem String, Position als integer als Ergebnis

--Strings zusammenfügen:
SELECT CONCAT(FirstName, ' ', LastName) FROM Employees
SELECT FirstName + ' ' + LastName FROM Employees
SELECT CONCAT_WS(' ',FirstName, LastName, 'WeiteresZeug') FROM Employees


/*************************************/

--Datums-/Zeitfunktionen:

/*************************************/

SELECT GETDATE()
--aktuelle Systemzeit

SELECT DATEADD(DD, 14, GETDATE())
SELECT DATEADD(DD, -14, GETDATE())
--Addiert der subtrahiert ein Intervall von einem Datum
--DAY, MONTH, WEEK, QUARTER, YEAR, dd, mm, qq, yy

SELECT DATEDIFF(YY, '19930224' ,GETDATE())
--Differenz in beliebigem Intervall zwischen 2 Daten

SELECT DATEPART(QUARTER, OrderDate) FROM Orders
SELECT DAY(OrderDate), MONTH(OrderDate), YEAR(OrderDate) FROM Orders --Kurzform von DATEPART
SELECT DATEPART(DAYOFYEAR, OrderDate) FROM Orders --laufender Jahrestag
SELECT DATEPART(WW, OrderDate) FROM Orders --Kalenderwoche
--DATEPART gibt nur einen gewünschten Teil eines Datums aus

SELECT DATENAME(WEEKDAY, OrderDate) FROM Orders
SELECT DATENAME(MONTH, OrderDate) FROM Orders
--"Name" eines Wochentags oder Monats

--Kalenderwochen & Wochentag etc.: Format hängt von der SQL-Server Einstellung ab, nicht von SSMS
SELECT DATEPART(WEEKDAY, '20230812'), DATENAME(WEEKDAY, '20230812')


/*************************************/

--Andere:

/*************************************/

SELECT CAST(OrderDate as date), OrderDate FROM Orders
--Ändert Ausgabe in neuen Datentyp

SELECT REPLACE('19970101_001500', '_', ' ')
SELECT CAST(STUFF(STUFF(REPLACE('19970101_001500', '_', ' ') , 12,0,':'), 15, 0, ':') as datetime)
SELECT CAST('19970101 001500' as datetime)

SELECT CONVERT(date, OrderDate) FROM Orders

SELECT ISNULL(Fax, 'n/a') FROM Customers
--Ersetzt NULL Werte mit neuer Eingabe


/*************************************/

--Übungen:

/*************************************/

--1. Wieviele Bestellungen hat "King" in Q2 1997 (OrderDate) bearbeitet?
SELECT OrderID, OrderDate FROM Orders
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'King' AND 
DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER, OrderDate) = 2
--OrderDate BETWEEN '19970401' AND '19970630'

--2. Hatten wir Bestellungen mit Lieferverzögerung (RequiredDate, ShippedDate)? Wenn ja wieviele Tage?
--   Funktionen können im SELECT oder WHERE (oder sonst überall) verwendet werden; 1, 37, 37
SELECT OrderID,
DATEDIFF(DD, ISNULL(ShippedDate, GETDATE()), RequiredDate) as Lieferverzögerung,
RequiredDate, ShippedDate
FROM Orders	
WHERE DATEDIFF(DD, ISNULL(ShippedDate, GETDATE()), RequiredDate) < 0
ORDER BY Lieferverzögerung

