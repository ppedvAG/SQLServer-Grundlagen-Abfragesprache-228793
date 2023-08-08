/* �ffnet einen
Kommentarblock �ber mehrere Zeilen
bis geschlossen wird mit */

--Einzeiliger Kommentar

--USE Datenbankname wechselt angesprochene Datenbank
USE Northwind


SELECT 100 --numerische Werte m�ssen nicht speziell formatiert werden
SELECT 'Hallo' --Strings (Charakterdatentypen) immer in einzelnen Hockommas (rot) formatieren

--Wenn Code markiert wird, wird auch nur der markierte Bereich ausgef�hrt
--(F5, oder STRG+E)

SELECT 100, 5, 'Hallo'
SELECT 100+5
SELECT 5+7*3 --auch mathematische Formeln k�nnen errechnet werden


--SQL ist nicht case-sensitive; keine Formatierung notwendig:
select * from Customers
SeLeCt * FRoM cUSTOmerS 
SelECT
		*
		    FROm
	 CusTOMERS;

--in eckigen Klammern beudeutet: Name eines Datenbankobjekts
SELECT * FROM [Order Details]

--vorhandene Daten aufrufen:

SELECT * FROM Customers --FROM "Tabellenname"
SELECT * FROM Orders

SELECT CustomerID, City, Country FROM Customers --mehrere Spalten mit , trennen
SELECT City, Country, CustomerID FROM Customers --Reihenfolge ist benutzerdefiniert


/*************************************/

--Aliase: ver�ndern den angezeigten Spaltennamen

/*************************************/

SELECT 100 as Nummer
SELECT CustomerID as KundenID, City as Stadt, Country Land FROM Customers --as ist optional

--Aliase auch f�r Tabellennamen:
SELECT * FROM Customers as Kunden

/*************************************/

-- TOP X

/*************************************/

--Nur X Zeilen im Ergebnis anzeigen mit SELECT TOP X:

SELECT TOP 10 * FROM Customers
SELECT TOP 10 PERCENT * FROM Orders

--SELECT BOT/BOTTOM existiert nicht, f�r unterste X Zeilen m�ssen wir die Sortierung "umdrehen":

/*************************************/

--ORDER BY

/*************************************/

SELECT * FROM Customers
ORDER BY Country --ORDER BY Spaltenname(n); steht IMMER ganz am Ende einer Abfrage

--ORDER BY ist standardm��ig aufsteigend (ascending), f�r absteigend m�ssen wir DESC (descending) dazuschreiben:

SELECT * FROM Customers
ORDER BY Country DESC

SELECT TOP 10 * FROM Customers
ORDER BY CustomerID DESC

SELECT CompanyName, City, Country FROM Customers
ORDER BY Country DESC, City --mehrere Spalten m�glich; DESC/ASC muss f�r jede Spalte definiert werden


/*************************************/

--DISTINCT

/*************************************/

--Identische Datens�tze rausfiltern mit SELECT DISTINCT:
SELECT DISTINCT Country FROM Customers

SELECT DISTINCT * FROM Customers

SELECT DISTINCT Country, City FROM Customers

--DISTINCT & TOP zusammen:
SELECT DISTINCT TOP 10 Country FROM Customers

