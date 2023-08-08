/*************************************/

--UNION: legt mehrere Ergebnistabellen vertikal aneinander

/*************************************/

SELECT * FROM Customers
UNION --hat ein eingebautes DISTINCT
SELECT * FROM Customers

SELECT * FROM Customers
UNION ALL --ohne DISTINCT
SELECT * FROM Customers

--Spaltenanzahl muss identisch sein:
SELECT * FROM Customers
UNION
SELECT Country, City FROM Customers

--Datentypen müssen kompatibel sein (einer wird umgewandelt)
SELECT Quantity FROM [Order Details] --smallint
UNION ALL
SELECT Freight FROM Orders --money

--ORDER BY nur nach der letzten Abfrage
SELECT Quantity FROM [Order Details] 
UNION ALL
SELECT Freight FROM Orders 
UNION ALL
SELECT UnitPrice FROM [Order Details]
ORDER BY Quantity

/*************************************/

--INTERSECT: "Welche Gemeinsamkeiten" haben die 2 Ergebnistabellen"

/*************************************/

SELECT Country FROM Customers
WHERE Country = 'Brazil'
INTERSECT
SELECT Country FROM Customers

/*************************************/

--EXCEPT: "Alles von Abfrage 1 AUSSER das was in Abfrage 2 ebenfalls vorkommt"

/*************************************/

SELECT Country FROM Customers
EXCEPT
SELECT Country FROM Customers
WHERE Country = 'Brazil'