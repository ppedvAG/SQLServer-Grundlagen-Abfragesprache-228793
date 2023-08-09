/*************************************/

--CASE Statement

/*************************************/

--Ein "CASE Block" prüft Bedingungen und gibt einen Wert abhängig davon aus
--CASE einleiten, mit END schließen; Mindestens eine WHEN ... THEN ... Bedingung nötig

SELECT *,
CASE
	WHEN UnitsInStock = 0 THEN 'Nachbestellen!'
	WHEN UnitsInStock > 0 THEN 'Passt'
END as BestellNachricht,
UnitsInStock
FROM Products

--Wenn ein Fall nicht definiert wurde, ist die Ausgabe NULL
SELECT *,
CASE
	WHEN UnitsInStock < 0 THEN 'Nachbestellen!'
	WHEN UnitsInStock > 0 THEN 'Passt'
END as BestellNachricht,
UnitsInStock
FROM Products

--Optional: Mit ELSE am Ende werden nicht definierte Fälle abgedeckt (statt NULL als Ausgabe)
SELECT *,
CASE
	WHEN UnitsInStock < 0 THEN 'Nachbestellen!'
	WHEN UnitsInStock > 0 THEN 'Passt'
	ELSE 'Nicht definiert'
END as BestellNachricht,
UnitsInStock
FROM Products


--Übung: ABC-Analyse erstellen zu Produkten nach GesamtUmsatz
--A > 50.000; C < 10.000 und B zwischen 10 & 50k

SELECT ProductName, SUM(SummeBestellPosi) as GesamtUmsatz,
CASE
	WHEN SUM(SummeBestellPosi) > 50000 THEN 'A'
	WHEN SUM(SummeBestellPosi) BETWEEN 10000 AND 50000 THEN 'B'
	ELSE 'C'
END as Kategorie
FROM vMaster
GROUP BY ProductName
ORDER BY Kategorie, GesamtUmsatz DESC

--Anzahl an Produkten in Kategorien: Lösung über #Table
SELECT ProductName, SUM(SummeBestellPosi) as GesamtUmsatz,
CASE
	WHEN SUM(SummeBestellPosi) > 50000 THEN 'A'
	WHEN SUM(SummeBestellPosi) BETWEEN 10000 AND 50000 THEN 'B'
	ELSE 'C'
END as Kategorie
INTO #t1
FROM vMaster
GROUP BY ProductName
ORDER BY Kategorie, GesamtUmsatz DESC

SELECT Kategorie, COUNT(Kategorie) as AnzProdukte FROM #t1
GROUP BY Kategorie