--"MasterView" erstellen mit allen Rechnungsdaten:
USE Northwind
CREATE VIEW vMaster AS

SELECT 
Customers.CompanyName, Customers.CustomerID, 
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Employees.LastName, 
Products.ProductName, 
[Order Details].Quantity, [Order Details].UnitPrice, [Order Details].Discount, 
Categories.CategoryName,
CAST(SUM([Order Details].UnitPrice * Quantity * (1 - Discount)) as decimal(10,2)) as SummeBestellPosi
FROM Customers INNER JOIN
Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
[Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Customers.CompanyName, Customers.CustomerID, 
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Employees.LastName, 
Products.ProductName, 
[Order Details].Quantity, [Order Details].UnitPrice, [Order Details].Discount, 
Categories.CategoryName

--VIEW erstellen mit CREATE VIEW; �ndern mit ALTER VIEW; L�schen mit DROP VIEW

--Views k�nnen wie normale Tabellen behandelt werden:
SELECT * FROM vMaster
SELECT CompanyName, Country FROM vMaster

SELECT * FROM vMaster
JOIN Orders ON vMaster.OrderID = Orders.OrderID

--Wichtig: Eine View ist eine abgespeicherte Abfrage, d.h. jedesmal wenn die View aufgerufen wird, 
--wird die gesamte Abfrage dahinter ausgef�hrt!
--Vorteil: View immer mit aktuellen Daten (wenn neu ausgef�hrt wird)
--Nachteil: Verleitet zu "Faulheit" und unn�tiger Ressourcenveschwendung (Performance Probleme)

--N�tzlich f�r Rechteverwaltung: Auf Views k�nnen andere Zugriffsrechte vergeben werden als auf die Ursprungstabellen

--mit STRG+SHIFT+R werden Datenbankobjekte "aktualisiert" (f�r IntelliSense etc.)



CREATE VIEW vMaster AS

SELECT 
Customers.CompanyName, Customers.CustomerID, Customers.Country, Customers.City,
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Employees.LastName, 
Products.ProductName, 
[Order Details].Quantity, [Order Details].UnitPrice, [Order Details].Discount, 
Categories.CategoryName,
CAST(SUM([Order Details].UnitPrice * Quantity * (1 - Discount)) as decimal(10,2)) as SummeBestellPosi
FROM Customers INNER JOIN
Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
[Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Customers.CompanyName, Customers.CustomerID, Customers.Country, Customers.City,
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Employees.LastName, 
Products.ProductName, 
[Order Details].Quantity, [Order Details].UnitPrice, [Order Details].Discount, 
Categories.CategoryName