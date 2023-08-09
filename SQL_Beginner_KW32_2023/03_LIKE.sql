--"ungenaue" Suche über LIKE; bspw. Anfangsbuchstaben, PLZ die mit 5 losgehen usw...

SELECT * FROM Customers
WHERE CompanyName LIKE 'b%'

--Für LIKE werden sogenannte Wildcards verwendet, quasi Platzhalter

--'%' steht für beliebige Symbole, beliebig viele davon

SELECT * FROM Customers
WHERE CompanyName LIKE '%f%'

--'_' steht für beliebiges Symbol, aber nur EINS

SELECT * FROM Customers
WHERE PostalCode LIKE '_3%'

--'[xyz]' oder [^xyz] oder [x-z]

SELECT * FROM Customers
WHERE CompanyName LIKE '[abc]%' --"wie OR Bedingung"

SELECT * FROM Customers
WHERE CompanyName LIKE '[^abc]%' --Umkehrmenge

SELECT * FROM Customers
WHERE CompanyName LIKE '[a-m]%' --"von bis"

SELECT * FROM Customers
WHERE PostalCode LIKE '[0-5]%'

SELECT * FROM Customers
WHERE ContactTitle LIKE '%Manager%'

--Hochkomma im LIKE:
SELECT * FROM Customers
WHERE CompanyName LIKE '%''%'

--%-Zeichen suchen im LIKE:
SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'


