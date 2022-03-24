-- Edwin Rodriguez Valle
-- Exercices with GROUP BY


use basketbal;

SET sql_mode=ONLY_FULL_GROUP_BY;

-- 1. Geef per jaar van toetreding het aantal leden dat in dat jaar is toegetreden.
SELECT jaartoe, count(*)
FROM lid
GROUP BY jaartoe;

-- 2. Geef het aantal mannelijke en het aantal vrouwelijk leden.
SELECT geslacht, count(*)
FROM lid
GROUP BY geslacht;

-- 3.	Geef voor elk lid voor wie minstens 1 boete is betaald, het lidnummer, de gemiddelde boete (2 decimalen) en het aantal boetes.
select *
from boete;

SELECT lidnummer, round(AVG(bedrag),2) AS gemiddelde_boete, COUNT(*) AS aantal_boetes 
FROM Boete
GROUP BY lidnummer;


-- 4. Geef van elk lid het lidnummer, de achternaam en het totaal aan boetebedragen die voor 
-- hem of haar geregistreerd zijn. Alle leden komen precies één keer in de lijst voor en bij 
-- leden waarvoor geen boete is geregistreerd moet het getal 0 getoond worden. (Tip: zoek 
-- op wat de ifnull() functie doet.)
SELECT l.lidnr, l.achternaam, ifnull(SUM(b.bedrag),"geen boete")
FROM lid l LEFT JOIN boete b 
ON l.lidnr = b.lidnummer
GROUP BY l.lidnr;

-- 5. Geef het lidnummer van elke speler voor wie in totaal meer dan €15.- aan boetesis
-- geregistreerd.
SELECT lidnummer, SUM(bedrag) AS totaal_boetes 
FROM Boete 
GROUP BY lidnummer 
HAVING SUM(bedrag) > 15;

-- 6. Geef de voorletters, tussenvoegsel en achternaam en het aantal boetes van elk lid voor
-- wie meer dan één boete is geregistreerd.
SELECT l.voorletters, l.tussenvoegsel, l.achternaam, COUNT(*) AS aantal_boetes 
FROM Lid l JOIN Boete b 
ON l.lidnr = b.lidnummer 
GROUP BY l.lidnr  
HAVING COUNT(*) > 1;

-- 7. Geef van de leden met boetes de hoogste en de laagste boete die geregistreerd is.
SELECT l.voorletters, l.tussenvoegsel, l.achternaam, MAX(bedrag), MIN(bedrag)
FROM Lid l JOIN Boete b 
ON l.lidnr = b.lidnummer 
GROUP BY l.lidnr;


-- 8. Geef van elk team de teamcode en het totaal aantal thuis gewonnen wedstrijden.
SELECT teamthuis, count(scorethuis) AS thuisgewonnen 
FROM Wedstrijd 
WHERE scorethuis > scoreuit 
GROUP BY teamthuis;
-- of 
SELECT teamthuis, sum(if(scorethuis > scoreuit,1,0)) as aantal_thuis_gewonnen_wedstrijden
FROM wedstrijd 
GROUP BY teamthuis;

-- 9. Geef per klasse het aantal teams in die klasse.
SELECT Klasse, count(*) 
FROM Team 
Group by Klasse;


-- 10. Geef de sporthallen die door meer dan 1 team gebruikt worden als thuishal
SELECT thuishal, count(*)
FROM Team
GROUP BY thuishal
HAVING count(*) > 1;





