/*
JOINs "verbinden" Tabellen miteinander, anhand eines Filters
werden horizontal verbunden (Datensätze werden miteinander verknüpft)
es können soviele Tabellen miteinander gejoint werden wie wir wollen

Syntax:
SELECT Spalten FROM TabelleA
JOIN TabelleB ON TabelleA.SpalteA = TabelleB.SpalteB
*/

--INNER JOINs:

SELECT CompanyName, Orders.* FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT CompanyName, Customers.CustomerID, Orders.CustomerID, OrderID, OrderDate, Freight FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID

--Mit Tabellenaliasen sparen wir viel Schreibarbeit:
SELECT * FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID

--Reihenfolge der Joins spielt quasi keine Rolle:
SELECT * FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID

SELECT * FROM Orders as O
JOIN Customers as c ON o.CustomerID = c.CustomerID

--Mehrere Tabellenen joinen:
SELECT * FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN [Order Details] as od ON o.OrderID = od.OrderID


--OUTER JOINs:

--LEFT JOIN

SELECT * 
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT * 
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL

--RIGHT JOIN

SELECT * 
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerID IS NULL

--LEFT = RIGHT, wenn wir die Tabellen andersherum aufrufen:

SELECT * 
FROM Orders RIGHT JOIN Customers ON Customers.CustomerID = Orders.CustomerID
SELECT * 
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID


--FULL OUTER JOIN (left + right kombiniert)

SELECT * 
FROM Customers FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


--CROSS JOIN (AxB) (91*830)
SELECT * FROM Customers
CROSS JOIN Orders


--Übungen:

--1. Alle Bestellungen von Kunden aus Brasilien
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Brazil'

--2. Welche Bestellungen hat Mitarbeiter "King" bearbeitet?
SELECT OrderID FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
WHERE LastName = 'King'

--3. Aus wievielen verschiedenen Ländern (Country in Customers)
--   wurde "Chai" bestellt? (Products) (16)
SELECT DISTINCT Country
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE ProductName = 'Chai'

--4. Was war die größte Bestellmenge (Quantity in Order Details) 
--   einer Bestellposition (Order Details)? Welches Produkt war das? 130, verte chateuse, Semmelknödl
SELECT TOP 1 WITH TIES * FROM Products as p -- TOP WITH TIES (= mit Gleichstand)
JOIN [Order Details] as od ON p.ProductID = od.ProductID
ORDER BY Quantity DESC



