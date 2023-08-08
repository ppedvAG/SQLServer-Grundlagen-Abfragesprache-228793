/*
Temporäre Tabellen/Temp Tables/#Tables

Werden "erstellt" indem man vor dem FROM einer Abfrage ein INTO #TempTableName schreibt
--> Die Abfrageergebnisse werde in dieser Tabelle gespeichert
Nachteil: u.U. veraltete Daten, da Abfrage nicht wie bei einer View neu ausgeführt wird
Vorteil: Performancetechnisch sehr schnell, da Ergebnisse nur einmal generiert werden müssen
Sind nur innerhalb der Session (SkriptFenster) existent

Auch nützlich um komplexe Abfragen zu "zerstückeln" --> Zwischenergebnisse in #Table wegspeichern
*/

SELECT * INTO #TempTable FROM Customers
WHERE Country = 'Brazil'

SELECT * FROM #TempTable

--manuell löschen it DROP TABLE:
DROP TABLE #TempTable


--Für viele "komplizierte" Fälle nützlich, bspw. Aggregat von Aggregat bilden:
SELECT CompanyName, SUM(SummeBestellPosi) as Summe INTO #Avg FROM vMaster
GROUP BY CompanyName

SELECT AVG(Summe) FROM #Avg


-- #Table ist "lokal"
-- ##Table ist "global": auch in anderen Sessions verfügbar; bis manuell gelöscht wird, oder Server tempdb wiped

SELECT * INTO ##GlobaleTempTable FROM Customers