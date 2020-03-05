--
create database partdb
GO
---zuerst die Funktion
use partdb;
GO
create partition function fzahl(int)
as
RANGE LEFT FOR VALUES (100,200)

-----------100]-------------200]-----------------
--   1              2                  3

select $partition.fzahl(117)--gibt nur den Bereich zurück


--nun das Part Scheme
create partition scheme schZahl
as
partition fzahl to (bis100, bis200, rest)
-----------------      1.     2.     3.

--die Tabelle auf scheme legen
create table parttab 
	(id int identity, nummer int, spx char(4100)) on schZahl(nummer)


declare @i int=0

while @i < 50000
begin
	insert into parttab values( @i, 'xy')
	set @i+=1
end



--Mannipulieren
--Grenze dazunehmen

--neue DGR
--F() anpassen.. neue Grenze definieren
--schema anpassen.. nimm neue DGR her

alter partition scheme schzahl next used bis5000;
GO

alter partition function fzahl() split range (5000);
GO

--Grenze entfernen
---f() + scheme

alter partition function fzahl() merge range (100);
GO

select	 $partition.fzahl(nummer) ,
		 min(nummer), 
		 max(nummer), 
		 count(*)
from parttab 
group by $partition.fzahl(nummer)

--???

CREATE PARTITION SCHEME [schZahl]
 AS PARTITION [fzahl] TO ([bis200], [bis5000], [Rest])
GO

CREATE PARTITION FUNCTION [fzahl](int) 
AS 
RANGE LEFT FOR VALUES (200, 5000)
GO







--

















