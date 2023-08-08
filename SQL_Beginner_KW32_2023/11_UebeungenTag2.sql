--1. Gesamtumsatz pro Land (Country in Customers)
SELECT Country, SUM(SummeBestellPosi) FROM vMaster
GROUP BY Country
ORDER BY 2

SELECT 
Country,
CAST(SUM((Quantity*UnitPrice) * (1-Discount)) as decimal(10,2))
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY Country
ORDER BY 2

--2. Gesamtanzahl an Produkten die noch im Lager sind (UnitsInStock), aber nicht mehr verkauft werden (Discontinued)
--Wieviel "Geld" macht das aus?
SELECT SUM(UnitPrice*UnitsInStock) as LagerWert, SUM(UnitsInStock) as RestPostenMenge FROM Products
WHERE Discontinued = 1 AND UnitsInStock != 0


--3. Haben wir im Dezember 1997 mehr oder weniger Umsatz gemacht als 1996?

--Lösung 1:
select Sum(summebestellposi) , Year(Orderdate) as Jahr, Month(Orderdate) as Monat from vmaster
WHERE (Year(Orderdate) = 1997 or Year(Orderdate) = 1996) and Month(orderdate) = 12
group by YEAR(OrderDate), MONTH(OrderDate)

--Lösung 2:
select sum(amountMoney)
from
(
    select UnitPrice * Quantity as AmountMoney from orders o
    inner join [Order Details] od on o.OrderID = od.OrderID
    where Datename(MONTH, ShippedDate) = 'Dezember' and Datename(YEAR, ShippedDate) = '1997'
) as TableNew
UNION ALL
select sum(amountMoney)
from
(
    select UnitPrice * Quantity as AmountMoney from orders o
    inner join [Order Details] od on o.OrderID = od.OrderID
    where Datename(MONTH, ShippedDate) = 'Dezember' and Datename(YEAR, ShippedDate) = '1996'
) as TableNew;

--Lösung 3:
Select '1997', CAST(SUM(UnitPrice*Quantity*(1-Discount)) as decimal(10,2)) as SummerBestellungsPos from [Order Details] od
join Orders o on od.OrderID=o.OrderID
where DATEPART(YEAR, ShippedDate)=1997 and
DATEPART(Month, ShippedDate)=12
UNION
Select '1996', CAST(SUM(UnitPrice*Quantity*(1-Discount)) as decimal(10,2)) as SummerBestellungsPos from [Order Details] od
join Orders o on od.OrderID=o.OrderID
where DATEPART(YEAR, ShippedDate)=1996 and
DATEPART(Month, ShippedDate)=12
order by SummerBestellungsPos desc

--4. Übersicht aller Spediteure (Shippers) für jedes Geschäftsjahr:  (ShipVia & ShipperID)
--Anzahl Lieferungen, Summe Lieferkosten, Durchschn. Lieferkosten
/*
Ergebnis in etwa so:
ShipperCompanyName	Geschäftsjahr	AnzOrder	SumFreight	AvgFreight
Speedyexpress		1996			x			y			z
Speedyexpress		1997			x			y			z
usw...
*/

SELECT
CompanyName, 
YEAR(OrderDate) as Geschäftsjahr,
COUNT(OrderID) as AnzOrder, SUM(Freight) as SumFreight, CAST(AVG(Freight) as decimal(10,2)) as AvgFreight
FROM Orders o
JOIN Shippers s ON s.ShipperID = o.ShipVia
GROUP BY CompanyName, YEAR(OrderDate)
