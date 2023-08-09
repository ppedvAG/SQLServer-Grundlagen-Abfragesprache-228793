/*************************************/

--Unterabfragen/Subqueries/nested Queries

/*************************************/

--Eine Abfrage kann sogennante Unterabfragen enthalten, die vom Prozess zuerst ausgeführt werden
--Eine Unterabfrage ist "in Klammern" und muss eigenständig fehlerfrei ausführbar sein
--Es können mehrere Subqueries ineinander verschachtelt sein, aufgelöst wird "vom innersten zum äußersten"

--Alle Bestellungen über Durchschnitt von Freight:
SELECT * FROM Orders
WHERE Freight > AVG(Freight)

--Lösung über Subquery:

SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) 
--Wert für AVG(Freight) wird "zuerst" berechnet, und dann eingesetzt in die äußere Abfrage


--Können im SELECT, WHERE, FROM usw..., quasi überall eingebaut werden


--Subquery im FROM:

SELECT CompanyName 
FROM 
(
SELECT * FROM Customers WHERE Country IN ('France', 'Spain')
) as TollesAlias --Im FROM muss der Subquery ein "Tabellenalias" vergeben werden; keine Tabellen ohne Namen aufrufbar!

