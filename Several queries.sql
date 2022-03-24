-- Edwin Rodriguez Valle
-- 

use projectbeheer;

-- 1. Geef de klanten die in Amsterdam gevestigd zijn. 
SELECT * 
FROM klant 
WHERE locatie = 'Amsterdam';

-- 2. Geef de personeelsleden die Backend Programmeur zijn. Sorteer de personeelsleden op 
-- achternaam. 
SELECT * 
FROM personeelslid 
WHERE functie = 'Backend Programmeur' 
ORDER BY achternaam;


-- 3. Welke personeelsleden (naam bestaande uit voornaam, tussenvoegsel en achternaam) hebben in 
-- 2017 een bonus ontvangen? 
SELECT concat_ws(' ', voornaam, tussenvoegsel, achternaam) AS naam, jaarBonus 
FROM personeelslid P JOIN salaris S 
ON P.personeelsNummer = S.personeelsNummer
WHERE jaar = 2017 AND jaarBonus > 0;

-- 4. Geef een overzicht van alle hoofdprojecten (dit zijn de projecten, die geen deelproject zijn van 
-- een ander project). 
SELECT * 
FROM project 
WHERE hoofdProjectNummer IS NULL;


-- 5. Geef alle hoofdprojecten (zie de opmerking bij 4.) met de naam van de klant. 
SELECT P.projectNaam, K.klantNaam
FROM project P JOIN klant K 
ON P.klantNummer = K.klantNummer
WHERE hoofdProjectNummer IS NULL;


-- 6. Geef een overzicht van alle hoofdprojecten met deelprojecten. Toon het hoofdproject en de 
-- bijbehorende deelprojecten. 
SELECT H.projectNaam hoofdproject, D.projectNaam deelproject
FROM project H JOIN project D
ON H.projectNummer = D.hoofdProjectNummer;


-- 7. Geef een overzicht van alle hoofdprojecten met deelprojecten, ook als ze geen deelprojecten 
-- hebben. Toon het hoofdproject en de bijbehorende deelprojecten. Als een hoofdproject geen 
-- deelproject heeft, geef dan de tekst ‘Geen deelproject’. 
SELECT H.projectNaam hoofdproject, ifnull(D.projectNaam, 'Geen deelproject') deelproject
FROM project H LEFT JOIN project D
ON H.projectNummer = D.hoofdProjectNummer
WHERE h.hoofdProjectNummer IS NULL;



-- 8. Geef het gemiddelde maandsalaris van alle personeelsleden over 2017. 

SELECT AVG(maandBedrag) Gemiddelde
FROM salaris
WHERE jaar = 2017;


-- 9. Geef voor alle personeelsleden de jaarinkomsten over 2017 (let wel: salaris is per maand, en 
-- sommigen hebben een bonus gekregen). Geef de naam (zie 3.) en de jaarinkomsten. 
SELECT concat_ws(' ', voornaam, tussenvoegsel, achternaam) AS naam, 12 * maandBedrag + ifnull(jaarBonus, 0) as jaarinkomsten
FROM personeelslid P JOIN salaris S
ON P.personeelsNummer = S.personeelsNummer
WHERE jaar = 2017;



-- 10. Welke personeelsleden hebben dezelfde functie als Jan de Vries? 
SELECT * 
FROM personeelslid
WHERE functie = (SELECT functie
				FROM personeelslid
				WHERE voornaam = 'Jan' AND tussenvoegsel = 'de' AND achternaam = 'Vries');


-- 11. Welke personeelsleden verdienen in 2018 meer dan 3000 euro per maand? 
SELECT concat_ws(' ', voornaam, tussenvoegsel, achternaam) AS naam, maandBedrag 
FROM personeelslid P JOIN salaris S
ON P.personeelsNummer = S.personeelsNummer
WHERE jaar = 2018 AND maandBedrag > 3000;
			
			
-- 12. Welke personeelsleden verdienen in 2018 meer dan personeelslid 204? 
SELECT concat_ws(' ', voornaam, tussenvoegsel, achternaam) AS naam, maandBedrag 
FROM personeelslid P JOIN salaris S
ON P.personeelsNummer = S.personeelsNummer
WHERE jaar = 2018 AND maandBedrag > 
	(SELECT maandBedrag 
    FROM salaris 
    WHERE jaar = 2018 AND personeelsNummer = 204);
   
   


-- 13. Welke personeelsleden verdienen in 2018 minder dan Petra van Dalen? 
   SELECT concat_ws(' ', voornaam, tussenvoegsel, achternaam) AS naam, maandBedrag 
FROM personeelslid P JOIN salaris S
ON P.personeelsNummer = S.personeelsNummer
WHERE jaar = 2018 AND maandBedrag < 
	(SELECT maandBedrag 
    FROM salaris 
    WHERE jaar = 2018 AND personeelsNummer = 
		(SELECT personeelsNummer 
        FROM personeelslid
        WHERE voornaam = 'Petra' AND tussenvoegsel = 'van' AND achternaam = 'Dalen'));
     
   
   
-- 14. Geef per functie het maximum salaris in 2018. 
SELECT functie, max(maandbedrag) Maximum
FROM personeelslid P JOIN salaris S
ON P.personeelsNummer = S.personeelsNummer
WHERE jaar = 2018
GROUP BY functie;
       
       
-- 15. Geef per functie het gemiddelde salaris in 2018. 
SELECT functie, avg(maandbedrag) Maximum
FROM personeelslid P JOIN salaris S
ON P.personeelsNummer = S.personeelsNummer
WHERE jaar = 2018
GROUP BY functie;

-- 16. Geef voor elk project de duur in dagen en in weken. 
SELECT projectNaam, timestampdiff(day, startDatum, eindDatum) AS dagen, timestampdiff(week, startDatum, eindDatum) AS weken
FROM project;


-- 17. Geef de projecten waar een Data analist in meewerkt. 
SELECT projectNaam
FROM project P JOIN projecturentoewijzing PU 
ON P.projectNummer = PU.projectNummer
JOIN personeelslid PL 
ON PU.personeelsNummer = PL.personeelsNummer
WHERE PL.functie = 'Data analist';

-- 18. Maak een view aan, die een overzicht geeft van de klanten, hun projecten en de totale kosten per 
-- project. Let wel: de kosten worden bepaald door het aantal weken dat het project duurt, de 
-- urenPerWeek van alle projectleden en het uurTarief van het project. Tip: gebruik de functie 
-- timestampdiff() om het aantal weken te bepalen. 
CREATE VIEW klant_project_kosten AS (
    SELECT K.klantNummer, klantNaam, P.projectNummer, 
        sum(timestampdiff(week, startDatum, eindDatum) * urenPerWeek * uurTarief) projectKosten
    FROM Project P JOIN ProjectUrenToewijzing PUT ON P.projectNummer = PUT.projectNummer
    JOIN Klant K ON P.klantNummer = K.klantNummer
    GROUP BY P.projectNummer);


-- 19. Gebruik de view uit 18. om een overzicht te geven van de klanten en hun totale projectkosten, 
-- dus van alle projecten bij elkaar.
   
   SELECT klantNaam, SUM(projectKosten)
FROM klant_project_kosten
GROUP BY klantNummer;
   