/*************************************/

--Unterabfragen/Subqueries/nested Queries

/*************************************/

--Eine Abfrage kann sogennante Unterabfragen enthalten, die vom Prozess zuerst ausgef�hrt werden
--Eine Unterabfrage ist "in Klammern" und muss eigenst�ndig fehlerfrei ausf�hrbar sein
--Es k�nnen mehrere Subqueries ineinander verschachtelt sein, aufgel�st wird "vom innersten zum �u�ersten"

--Alle Bestellungen �ber Durchschnitt von Freight:
SELECT * FROM Orders
WHERE Freight > AVG(Freight)

--L�sung �ber Subquery:

SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) 
--Wert f�r AVG(Freight) wird "zuerst" berechnet, und dann eingesetzt in die �u�ere Abfrage


--K�nnen im SELECT, WHERE, FROM usw..., quasi �berall eingebaut werden


--Subquery im FROM:

SELECT CompanyName 
FROM 
(
SELECT * FROM Customers WHERE Country IN ('France', 'Spain')
) as TollesAlias --Im FROM muss der Subquery ein "Tabellenalias" vergeben werden; keine Tabellen ohne Namen aufrufbar!

