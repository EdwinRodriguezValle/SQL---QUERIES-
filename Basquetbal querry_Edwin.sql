-- Basics SQL Querry 
-- Edwin Rodriguez Valle
-- Date: 20-03-2022
-------------------------------------------------------------------------------------------------

use basketbal;

-- Opdrachten 
-- 1. Toon alle records van de tabel Lid. 
select * 
from lid; 

-- 2. Geef alle gegevens van de leden die voor 2011 bij de club zijn toegetreden.
select *
from lid 
where jaartoe > '2011';

-- 3. Geef van de vrouwelijke leden de achternaam, de geboortedatum en hun lidnummer. 
select achternaam, geb_datum, lidnr, geslacht 
from lid 
where geslacht   = 'v';


-- 4. Geef alle leden die geen emailadres hebben. 
select*
from lid 
where emailadres is null; 

-- 5. Geef alleen de leden die wel een emailadres hebben. 
select *
from lid
where emailadres is not null;

-- 6. Geef de namen (met voorletters en tussenvoegsel) van de leden uit Zoetermeer. 
select achternaam, voorletters, tussenvoegsel, woonplaats 
from lid
where woonplaats = "Zoetermeer";

-- 7. Geef de uitslagen (teamthuis, teamuit, scorethuis, scoreuit) van de wedstrijden uit klasse
-- B2000 die tussen 15u en 19u gespeeld zijn. (NB Hoe noteer je een tijdstip?)
 select teamthuis, teamuit, scorethuis, scoreuit, klasse, tijd 
 from wedstrijd
 where klasse = 'B2000'
 and tijd between "15:00" and "19:00";
 

-- 8. Verwijder de leden die in Leiden wonen. 
delete * 
from lid 
where woonplaats = 'Leiden';


-- 9. Voeg je zelf toe als lid sinds 2022 met lidnr 400. 
-- (NB Hoe laat je een veld leeg, hoe voer je de datum in?) 
insert into lid (lidnr, achternaam, voorletters, tussenvoegsel, geb_datum, geslacht, jaartoe, straat, huisnr, toevoeging, postcode, woonplaats, telefoon, emailadres, speelt_in, bank)
values(400, 'Rodriguez', 'E', null, '1978-08-10', 'v', 2022, 'Camera Obscuradreef', 45, null, '3561XL', 'Utrecht', '0638497646', 'rodriguez.valle.edwin@gmail.com', 'AMSTH1', null);


-- 10. Geef alle boetes hoger dan 10 euro van het type A. 
select *
from boete 
where bedrag > 10;

-- 11. Verhoog de boetes van speler 109 met 10. 
update boete
set bedrag = 10
where lidnummer = 109;



-- 12. Schrijf een create-script om de tabel Bestuurslid toe te voegen. Deze tabel bevat informatie 
-- over de bestuursfuncties die leden van de club hebben bekleed. De primaire sleutel bestaat 
-- uit de kolommen lidnummer en begin_datum. De tabel is hieronder gegeven.
create table Bestuurslid
(lidnummer int not null, 
begin_datum date not null , 
eind_datum date, 
Functie varchar(45) not null, 
primary key (lidnummer, begin_datum));

-- 13. insert data into tabela bestuurdlid
insert into bestuurslid (lidnummer, begin_datum, eind_datum, Functie) values(107, '2017-01-01', '2017-12-31', 'Secretaris');
INSERT INTO bestuurslid (lidnummer, begin_datum, eind_datum, functie) VALUES (107, '2018-01-01', '2018-12-31', 'Lid');
INSERT INTO bestuurslid (lidnummer, begin_datum, eind_datum, functie) VALUES (107, '2019-01-01', '2019-12-31', 'Penningmeester');
INSERT INTO bestuurslid (lidnummer, begin_datum, eind_datum, functie) VALUES (107, '2020-01-01', NULL, 'Voorzitter');
INSERT INTO bestuurslid (lidnummer, begin_datum, eind_datum, functie) VALUES (108, '2017-01-01', '2018-12-31', 'Voorzitter');

select*
from bestuurslid;

-- 14. Geef alle gegevens van de sporthallen waarvan de naam begint met een S. 
select*
from sporthal
where sporthalnaam like "S%";

select*
from sporthal
where sporthalnaam regexp  "^S";


-- 15. Geef de gegevens van de thuiswedstrijden van Dames 1 teams. Daarvan eindigt de code op 
-- D1.
select *
from wedstrijd
where teamthuis like "%D1";

select *
from wedstrijd
where teamthuis regexp "D1$";

