--1. Wieviel Umsatz hat jeder Mitarbeiter in seinem Heimatland gemacht? 
--(Heimatland: EmployeeCountry = CustomerCountry/OrdersShipCountry)

--Im Where Filter:
SELECT
LastName,
SUM(UnitPrice*Quantity*(1-Discount)) as Summe
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE o.ShipCountry = e.Country
GROUP BY LastName

--Im Join Filter:
SELECT
LastName,
SUM(UnitPrice*Quantity*(1-Discount)) as Summe
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID AND o.ShipCountry = e.Country
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY LastName


--2. Hatten wir Bestellungen an Wochenendtagen? Wenn ja wieviele?
--SELECT DISTINCT DATENAME(weekday, OrderDate) FROM Orders
SELECT COUNT(OrderID) as AnzBest FROM Orders
WHERE DATEPART(DW, OrderDate) IN (6,7)

SELECT DATENAME(WEEKDAY, OrderDate) as Wochentag, COUNT(OrderID) as AnzBest FROM Orders
GROUP BY DATENAME(WEEKDAY, OrderDate)
UNION
SELECT 'Samstag', COUNT(OrderID) FROM Orders
WHERE DATENAME(WEEKDAY, OrderDate) IN ('Samstag')
UNION
SELECT 'Sonntag', COUNT(OrderID) FROM Orders
WHERE DATENAME(WEEKDAY, OrderDate) IN ('Sonntag')

--3. Was war das meistverkaufte (Quantity) Produkt am 04.Juli jedes Geschäftsjahres?

SELECT OrderDate, SUM(Quantity) as Summe 
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
WHERE DATENAME(month,OrderDate)='Juli' and day(orderdate)=4
GROUP BY OrderDate
ORDER BY 1 DESC
--Problem: ProductName noch mit anzeigen lassen & MAX(Quantity) u.U. falsch!

select orderdate, ProductName, sum(Quantity) as Summe 
from vmaster
where DATENAME(month,OrderDate)='Juli' and day(orderdate)=4
group by orderdate, ProductName

--Schwierig
