/* 
WHERE Keyword
- steht immer nach dem FROM
- über boolsche Vergleichsoperatoren wird Ergebnismenge gefiltert
- möglich sind =, <, >, <=, >=, != (ungleich)
*/

SELECT * FROM Customers
WHERE Country = 'Germany'

--mit = nur EXAKTE Treffer:
SELECT * FROM Customers
WHERE Country = ' Germany'

SELECT * FROM Orders
WHERE Freight = 65.83

SELECT * FROM Orders
WHERE Freight > 100

SELECT * FROM Customers
WHERE Country > 'Germany'

SELECT * FROM Customers
WHERE Country != 'Germany'

--mehrere Filter mit AND oder OR verknüpfen:

SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'Germany' OR City = 'Berlin'

--AND "ist stärker bindent"; vergleiche "Punkt vor Strich" (AND ist Punkt, OR ist Strich):
SELECT * FROM Customers
WHERE (Country = 'France') OR (Country = 'Germany' AND City = 'Berlin')

SELECT * FROM Customers
WHERE (Country = 'France' AND City = 'Paris') OR (Country = 'Germany' AND City = 'Berlin')

--Klammern setzen ist möglich!

SELECT * FROM Customers
WHERE (Country = 'France' OR Country = 'Germany') AND City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'France' OR Country = 'Germany' OR Country = 'Spain'
--Einfacher:
SELECT * FROM Customers
WHERE Country IN ('France', 'Germany', 'Spain') --Anstatt vieler OR Verknüpfungen

SELECT * FROM Orders
WHERE Freight >= 50 AND Freight <= 100

--Alternativ mit BETWEEN:
SELECT * FROM Orders
WHERE Freight BETWEEN 50 AND 100 --BETWEEN mit >= und <= !

SELECT * FROM Customers
WHERE Country BETWEEN 'B' AND 'G'
ORDER BY Country

--Nach NULL Filtern:
SELECT * FROM Customers
WHERE Fax IS NOT NULL

SELECT * FROM Customers
WHERE Fax IS NULL

--NULL bedeutet kein Wert vorhanden; nicht das selbe wie '', ' ' (Leerzeichen/Whitespace)

