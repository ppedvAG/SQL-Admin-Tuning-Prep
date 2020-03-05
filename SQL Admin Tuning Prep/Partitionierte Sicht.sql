--Partitionierte Sicht
--statt einer sehr groﬂen Tabelle lieber viele kleinere

--Umsatztabelle w‰chst von Jahr zu Jahr



create table u2017 (id int identity, jahr int, spx char(4100)) --theoretisch auf andere DGR
create table u2016 (id int identity, jahr int, spx char(4100))
create table u2015 (id int identity, jahr int, spx char(4100))


create view Umsatz 
as
select * from u2017
UNION ALL--nicht nach doppelten Zeilen suchen..UNION alleine macht distinct
Select * from u2016
UNION ALL
select * from u2015


ALTER TABLE dbo.u2015 ADD CONSTRAINT
	CK_u2015 CHECK ((jahr=2015))

ALTER TABLE dbo.u2016 ADD CONSTRAINT
	CK_u2016 CHECK ((jahr=2016))

ALTER TABLE dbo.u2017 ADD CONSTRAINT
	CK_u2017 CHECK ((jahr=2017))










