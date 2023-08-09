/*
Tempor�re Tabellen/Temp Tables/#Tables

Werden "erstellt" indem man vor dem FROM einer Abfrage ein INTO #TempTableName schreibt
--> Die Abfrageergebnisse werde in dieser Tabelle gespeichert
Nachteil: u.U. veraltete Daten, da Abfrage nicht wie bei einer View neu ausgef�hrt wird
Vorteil: Performancetechnisch sehr schnell, da Ergebnisse nur einmal generiert werden m�ssen
Sind nur innerhalb der Session (SkriptFenster) existent
Werden in Systemdatenbank "tempdb" abgelegt

Auch n�tzlich um komplexe Abfragen zu "zerst�ckeln" --> Zwischenergebnisse in #Table wegspeichern
*/

SELECT * INTO #TempTable FROM Customers
WHERE Country = 'Brazil'

SELECT * FROM #TempTable

--manuell l�schen it DROP TABLE:
DROP TABLE #TempTable


--F�r viele "komplizierte" F�lle n�tzlich, bspw. Aggregat von Aggregat bilden:
SELECT CompanyName, SUM(SummeBestellPosi) as Summe INTO #Avg FROM vMaster
GROUP BY CompanyName

SELECT AVG(Summe) FROM #Avg


-- #Table ist "lokal"
-- ##Table ist "global": auch in anderen Sessions verf�gbar; bis manuell gel�scht wird, oder Server tempdb wiped

SELECT * INTO ##GlobaleTempTable FROM Customers


--#Table verh�lt sich genauso wie ein "normaler" Table, d.h. INSERT/UPDATE/DELETE JOINS etc alles m�glich

SELECT * INTO #t FROM Customers
WHERE Country = 'Germany'

INSERT INTO #t 
SELECT * FROM Customers
WHERE Country = 'France'

SELECT * FROM #t

/**************************/

USE Northwind

DROP TABLE IF EXISTS #t1 --IF EXISTS erst seit SQL SERVER Version 2019
DROP TABLE IF EXISTS #t2
DROP TABLE IF EXISTS #t3
SELECT * INTO #t2 FROM Customers

SELECT * FROM #t2
