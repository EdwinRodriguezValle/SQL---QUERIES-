-- Edwin Rodriguez Valle 
-- SQL views

use basketbal;

-- 1. Maak een view Apollohalteams, met daarin de teamgegevens van die teams die de Apollohal 
-- als thuishal hebben.

create view Apollohalteams as
select	*
from 	Team
where	thuishal = 'Apollohal'


-- 2. Wedstrijden worden altijd gespeeld in de hal van het thuis spelende team. Gebruik de view 
-- Apollohalteams (zie opgave 1) om de wedstrijden in de Apollohal weer te geven. Zet de laatst 
-- gespeelde wedstrijd boven aan de lijst.
select	* 
from	wedstrijd
where	teamthuis in
(	select	teamcode
	from	Apollohalteams
)
order by datum desc;


-- 3. Maak een view van leden, gesorteerd op lidnummer, voor wie minstens 1 boete is 
-- geregistreerd. Geef ook de gegevens van deze boete (betalingnummer, type, bedrag en 
-- datum).
create view Boeteleden as
select	L.*, B.betalingnummer, B.boetetype, B.datumovertreding, B.bedrag 
from	Lid L
join	Boete B ON L.lidnr = B.lidnummer
order by L.lidnr;



-- 4. Geef voor elk lid voor wie minstens 1 boete is geregistreerd (gebruik de view uit opgave 3) het 
-- lidnummer, de gemiddelde boete (2 decimalen) en het aantal boetes.

select	lidnr, round(avg(bedrag),2) GemiddeldeBoete, count(*) AantalBoetes
from	Boeteleden
group by lidnr;

