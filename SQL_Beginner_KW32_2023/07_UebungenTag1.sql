--1. Welcher Kunde (CompanyName) hatte die Bestellung mit den größten Lieferkosten (Freight)
SELECT TOP 1 CompanyName, Freight FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
ORDER BY Freight DESC

--2. Hat Andrew Fuller (Employees) schon mal ein Produkt aus der Kategorie "Dairy" (Categories) verkauft?
SELECT *
FROM Employees INNER JOIN
Orders ON Employees.EmployeeID = Orders.EmployeeID INNER JOIN
[Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
Categories ON Products.CategoryID = Categories.CategoryID
WHERE LastName = 'Fuller' AND CategoryName LIKE '%Dairy%'

--3. In welchen Produktkategorien gibt es Produkte, die nicht mehr geführt werden (Discontinued = 1)?
SELECT DISTINCT CategoryName FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Discontinued = 1

/*
Bonus 4.: Stellvertreterliste erstellen:
Welcher Mitarbeiter kann für welche(n) Kollegen einspringen? 
(Stadt (City in Employees) in der sie wohnen ist die selbe)
Ergebnis in etwa so:
Vertreter	CityVertreter	Kollege		CityKollege
Buchanan	London			Suyama		London
Buchanan	London			King		London
Buchanan	London			Dodsworth	London
Suyama		London			Buchanan	London
Suyama ....

Problem (vermutlich): Mitarbeiter kann nicht für sich selbst einspringen
"Tipp": ON Vergleich kann mit AND/OR erweitert werden. Tabellenalias
*/

/*************************************/

--SELF JOIN: Tabelle kann mit sich selbst gejoint werden, dafür brauchen sie allerdings ein Tabellenalias:

/*************************************/

SELECT Vertreter.LastName, Vertreter.City, Kollege.LastName, Kollege.City 
FROM Employees as Vertreter LEFT JOIN Employees as Kollege 
ON Vertreter.City = Kollege.City AND Vertreter.EmployeeID != Kollege.EmployeeID
--WHERE Vertreter.EmployeeID != Kollege.EmployeeID

/*
UNION
SELECT Vertreter.LastName, Vertreter.City, Kollege.LastName, Kollege.City 
FROM Employees as Vertreter LEFT JOIN Employees as Kollege 
ON Vertreter.City = Kollege.City AND Vertreter.EmployeeID != Kollege.EmployeeID
*/





SELECT * FROM Employees