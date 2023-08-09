/*************************************/

--WHILE

/*************************************/

WHILE 1 = 1 --WHILE + Bedingung die geprüft werden soll
BEGIN --BEGIN startet die Schleifenanweisung

SELECT 'Hallo!'

END --END schließt die Schleifenanweisung


--Variablen als Bedingung:
DECLARE @Counter int = 0

WHILE @Counter < 5
BEGIN

SELECT @Counter
SET @Counter = @Counter + 1 --selbe wie: @Counter += 1
END

SELECT 'Habe fertig gezählt'

--WHILE Schleifen können andere WHILE Schleifen beinhalten


--Übung:
--Freight Wert in Orders bei allen Bestellungen in 10% Schritten erhöhen, dabei
--darf der größte Freight Wert 1500 nicht übersteigen, und der Durchschnitt darf nicht über 100
DROP TABLE BackupOrders
SELECT * INTO BackupOrders FROM Orders

WHILE 
(SELECT AVG(freight)*1.1 FROM BackupOrders) < 100 AND 
(SELECT MAX(Freight)*1.1 FROM BackupOrders) < 1500
BEGIN
UPDATE BackupOrders
SET Freight = Freight*1.1;
END


SELECT AVG(Freight), MAX(Freight) FROM BackupOrders

declare @Counter1 int = 0;
declare @Counter2 int = 0;
while max(@Counter1) < 1500 and avg(@Counter2)    <= 100                                    
BEGIN    

    Update dbo.BackupOrders set Freight = Freight * 1.1;
	set @Counter1 = (select max(Freight) from dbo.BackupOrders);
    set @Counter2 = (select avg(Freight) from dbo.BackupOrders);
END
UPDATE BackupOrders
SET Freight = Freight/1.1