-- Edwin Rodriguez Valle
-- Practicing with SQL JOINS

use basketbal;


-- 1. Geef van elk team de teamgegevens en de gegevens van de aanvoerder. 
SELECT *
FROM Team t JOIN Lid l
ON t.aanvoerder = l.lidnr;
 -- OR 
SELECT *
FROM Team t, Lid l
WHERE t.aanvoerder = l.lidnr;


-- 2. Geef van elk team de teamcode en de naam van de aanvoerder. 
SELECT t.teamcode, l.voorletters, l.tussenvoegsel, l.achternaam
FROM Team t, Lid l
WHERE t.aanvoerder = l.lidnr;
-- OF
SELECT t.teamcode, l.voorletters, l.tussenvoegsel, l.achternaam
FROM Team t JOIN Lid l
ON t.aanvoerder = l.lidnr;


-- 3. Geef van elk team uit de klasse B2000 de teamcode en de achternaam van de aanvoerder. 
SELECT t.teamcode, l.achternaam
FROM Team t, Lid l
WHERE t.aanvoerder = l.lidnr AND t.klasse = 'B2000';
-- OF
SELECT t.teamcode, l.achternaam
FROM Team t JOIN Lid l
ON t.aanvoerder = l.lidnr 
WHERE t.klasse = 'B2000';


-- 4. Geef van de leden met boetes het lidnummer, de naam en de boetebedragen die voor hem 
-- of haar geregistreerd zijn. 
SELECT b.lidnummer, l.achternaam, b.bedrag
FROM Boete b, Lid l
WHERE b.lidnummer = l.lidnr;
-- OF
SELECT b.lidnummer, l.achternaam, b.bedrag
FROM Boete b JOIN Lid l
ON b.lidnummer = l.lidnr;

-- 5. Geef van de vrouwelijke leden uit Volendam het lidnummer, de naam en de boetebedragen 
-- die voor haar geregistreerd zijn. 
SELECT l.lidnr, l.achternaam, b.bedrag
FROM Lid l JOIN Boete b
ON l.lidnr = b.lidnummer
WHERE l.woonplaats = 'Volendam' AND l.geslacht = 'v';
-- OF
SELECT l.lidnr, l.achternaam, b.bedrag
FROM Lid l, Boete b
WHERE l.lidnr = b.lidnummer
AND l.woonplaats = 'Volendam' AND l.geslacht = 'v';


-- 6. Geef van de leden, die aanvoerder van een team zijn, het lidnummer en de achternaam. 
-- Geef ook de teamcode en de klasse van het team waarvan hij of zij aanvoerder is. 
SELECT l.lidnr, l.achternaam, t.teamcode, t.klasse
FROM Team t INNER JOIN Lid l
ON t.aanvoerder = l.lidnr;
-- OF
SELECT l.lidnr, l.achternaam, t.teamcode, t.klasse
FROM Team t, Lid l
WHERE t.aanvoerder = l.lidnr;


-- 7. Geef het lidnummer, de achternaam en de woonplaats van elke vrouwelijke speler die niet in 
-- Delft woonachtig is. 
SELECT lidnr, achternaam, woonplaats 
FROM Lid 
WHERE woonplaats !='Delft' AND geslacht = 'v';

-- 8. Geef de lidnummers van de leden die in de periode 2010-2015 tot de vereniging zijn
-- toegetreden. 
SELECT lidnr
FROM Lid
WHERE jaartoe >= 2010 AND jaartoe <= 2015;
-- OF
SELECT lidnr
FROM Lid
WHERE jaartoe BETWEEN 2010 AND 2015;

-- 9. Geef een lijst van leden met de achternaam, de geboortedatum en de huidige leeftijd. 
SELECT lidnr, achternaam, geb_datum, TIMESTAMPDIFF(YEAR,geb_datum,CURDATE()) AS leeftijd 
FROM Lid;

-- 10. Geef de achternaam van de leden en het volledig adres. Het adres moet in één kolom komen 
-- te staan met als kolomkop ‘adres’. 
SELECT achternaam, concat(straat,' ',huisnr,' ',postcode,' ',woonplaats) AS adres
FROM Lid;

SELECT achternaam, concat_ws(' ', straat, huisnr, postcode, woonplaats) AS adres
FROM Lid;


11. Geef een lijst van teams met hun thuis gewonnen wedstrijden. Laat het team zien met
-- daarachter de uitslag in één kolom als volgt: 30 – 24. 
SELECT teamcode, teamnaam, concat(scorethuis,'-',scoreuit) AS uitslag 
FROM Team t JOIN Wedstrijd w 
ON t.teamcode= w.teamthuis  
where scorethuis>scoreuit;


-- 12. Geef een lijst met boetes die meer dan acht jaar geleden uitgedeeld zijn. 
-- Voorbeelden:
SELECT *
FROM Boete 
WHERE TIMESTAMPDIFF(YEAR,datumovertreding,CURDATE()) > 8;

-- 13. Geef een lijst van alle vrouwelijke leden, waarbij voorletters, tussenvoegsel en naam in één 
-- kolom verschijnt en het geslacht in de tweede. In die tweede kolom moet het woord ´vrouw´ 
-- komen te staan. (tip: gebruik concat_ws) 
SELECT CONCAT_WS(' ', voorletters, tussenvoegsel, achternaam) as naam, 'vrouw' 
AS geslacht FROM Lid
WHERE geslacht = 'v';


-- 14. Geef een lijst met leden, waarbij voorletters, tussenvoegsel en achternaam in één kolom
-- verschijnt en het geslacht in de tweede. In die tweede kolom moet het woord ´man´ of 
-- ´vrouw´ komen te staan. (tip: gebruik case when….) 
SELECT CONCAT_WS(voorletters, tussenvoegsel, achternaam) as naam, 
	case 
		when geslacht = 'm' then 'man'     
		when geslacht = 'v' then 'vrouw' 
	END as Geslacht 
from Lid;






