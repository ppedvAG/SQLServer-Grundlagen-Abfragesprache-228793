/*

Arten von Datentypen:

/*************************************/

Numerische:

/*************************************/

Ganzzahlen:
tinyint = bis 255
smallint = bis ca. 32000
int (integer) = bis ca. 2,3 Mrd
bigint

(money, smallmoney, real)

decimal(10,2) = Zahl darf insgesamt 10 Stellen haben, 2 davon sind Nachkommastellen
float

bit: 1/0

binary: Binärzahl

/*************************************/

String/Charakter-Datentypen:

/*************************************/

char(10) = 'Otto      '
nchar()
varchar(20) = 'Otto'; maximal 8000
nvarchar(); maximal 4000

Sogenannte LOB Datentypen, bis zu 2GB
varchar(MAX)
nvarchar(MAX)

text (legacy), image (legacy)

/*************************************/

Datum/Zeit:

/*************************************/

date: YYYY.MM.DD
time: HH:MM:SS.MS
datetime: date + time, bis MS Bereich
smalldatetime: Präzision bis Sek.
(datetime2: date + time, bis NS Bereich)


Andere:
XML
JSON
geometry
geography