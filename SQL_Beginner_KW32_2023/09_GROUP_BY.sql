/*************************************/

--(System-) Aggregatfunktionen: grunds�tzlich 5 St�ck in SQL

/*************************************/

SELECT SUM(Freight), AVG(Freight), COUNT(Freight), COUNT(*), MIN(Freight), MAX(Freight) FROM Orders

-- Summe, Durchschnitt, Anzahl-Werte, kleinster/gr��ter Wert

SELECT AVG(Freight), SUM(Freight) / COUNT(Freight) FROM Orders


--"Problem": F�r jeden Kunden die gesamten Freightkosten auswerten:
SELECT CustomerID, SUM(Freight) as FreightSumme FROM Orders

--L�sung: GROUP BY 

/*************************************/

--GROUP BY - syntaktisch immer nach dem WHERE
--Merke: Alles was im SELECT steht, und keine Aggregatfunktion ist, MUSS ins GROUP BY

/*************************************/


SELECT CustomerID, SUM(Freight) as FreightSumme FROM Orders
--WHERE
GROUP BY CustomerID

SELECT CustomerID, SUM(Freight) as FreightSumme, AVG(Freight) as AvgFreight FROM Orders
GROUP BY CustomerID

-- Wie oft wurde jedes Produkt verkauft?

SELECT ProductName, SUM(Quantity) FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName
ORDER BY SUM(Quantity) DESC

-- Wie viele Bestellungen hat King bearbeitet?

SELECT LastName, COUNT(OrderID) as AnzBestellungen FROM Orders as o
JOIN Employees as e ON o.EmployeeID = e.EmployeeID
WHERE LastName = 'King'
GROUP BY LastName

--Alternativ ohne GROUP BY:
SELECT COUNT(OrderID) as AnzBestellungen FROM Orders as o
JOIN Employees as e ON o.EmployeeID = e.EmployeeID
WHERE LastName = 'King'


--Wieviele Bestellungen hat jeder Kunde aufgegeben?

SELECT CompanyName, Country, COUNT(OrderID) as AnzBest FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
GROUP BY CompanyName, Country

--Funktioniert nur sinnvoll, wenn keine Spalten ausgegeben werden, deren Werte einzigartig sind
SELECT CompanyName, Country, City, Address, Phone, OrderID, COUNT(OrderID) as AnzBest FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
GROUP BY CompanyName, Country, City, Address, Phone, OrderID


--Wert der Bestellpositionen berechnen:

SELECT OrderID, 
CAST(SUM(UnitPrice * Quantity * (1 - Discount)) as decimal(10,2)) as SummeBestPosi,
ROUND(SUM(UnitPrice * Quantity * (1 - Discount)),2) as RoundWert
FROM [Order Details]
GROUP BY OrderID


--Ergebnisse filtern: Nur "Rechnungen" �ber 1000� anzeigen:

--Mit WHERE nicht m�glich:
SELECT OrderID, 
CAST(SUM(UnitPrice * Quantity * (1 - Discount)) as decimal(10,2)) as SummeBestPosi,
ROUND(SUM(UnitPrice * Quantity * (1 - Discount)),2) as RoundWert
FROM [Order Details]
WHERE SUM(UnitPrice * Quantity * (1 - Discount)) > 1000
GROUP BY OrderID

--L�sung:

/*************************************/

--HAVING
--Filtern von gruppierten Werten nur im HAVING m�glich; syntaktisch direkt nach GROUP BY
--Funktioniert ansonsten genauso wie WHERE (>,<,!= usw..)

/*************************************/

SELECT OrderID, 
CAST(SUM(UnitPrice * Quantity * (1 - Discount)) as decimal(10,2)) as SummeBestPosi,
ROUND(SUM(UnitPrice * Quantity * (1 - Discount)),2) as RoundWert
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity * (1 - Discount)) > 1000
ORDER BY SummeBestPosi DESC

--Wichtig: HAVING nur verwenden, wenn WHERE nicht m�glich!

SELECT CompanyName, Country, COUNT(OrderID) as AnzBest FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
GROUP BY CompanyName, Country
HAVING Country = 'Germany' --h�tte auch im WHERE gefiltert werden k�nnen, macht unn�tig Arbeit f�r den Server


