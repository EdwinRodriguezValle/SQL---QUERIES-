-- Edwin Rodriguez Valle
-- Exercices outer joins

use basketbal; 


-- 1. Geef van elk lid het lidnummer, de achternaam en de boetebedragen die voor hem of haar 
-- geregistreerd zijn. Dus ook alle leden zonder boetes laten zien! 

SELECT l.lidnr, l.achternaam, b.bedrag
FROM lid l LEFT JOIN boete b 
ON l.lidnr = b.lidnummer;



-- 2. Geef van elk lid het lidnummer, de achternaam en de boetebedragen die voor hem of haar 
-- geregistreerd zijn. Alle leden komen in de lijst voor en bij leden waarvoor geen boete is 
-- geregistreerd moet het getal 0 getoond worden. (Tip: zoek op wat de ifnull() functie doet.) 

SELECT l.lidnr, l.achternaam, ifnull(b.bedrag, 0)
FROM lid l LEFT JOIN boete b
ON l.lidnr = b.lidnummer;


-- 3. Geef een overzicht van alle leden. Toon het lidnummer, de achternaam, het geslacht en van 
-- de aanvoerders ook het team (teamcode en teamnaam) waar ze aanvoerder van zijn. 
SELECT lidnr, achternaam, geslacht, teamcode, teamnaam
FROM lid l LEFT JOIN team t
ON l.lidnr = t.aanvoerder;


-- 4. Geef een lijst van de leden die spelen in team ‘REDGH1’ . Toon indien mogelijk informatie over 
-- de bestuursfunctie die het lid heeft gehad (Let op: hiervoor heb je de tabel ‘Bestuurslid’ nodig, 
-- die je in opdracht 8.1 gemaakt hebt). Toon het lidnummer, de achternaam, de functie en de 
-- begindatum. 

SELECT l.lidnr, l.achternaam, b.functie, b.begin_datum
FROM lid l LEFT JOIN bestuurslid b 
ON l.lidnr = b.lidnummer
WHERE l.speelt_in = "REDGH1";