-- Edwin Rodriguez Valle
-- Subqueries

use basketbal;

-- 1. Geef de leden die in dezelfde plaats wonen als het lid met nummer 83.
SELECT achternaam, woonplaats 
FROM Lid 
WHERE woonplaats = (SELECT woonplaats 
FROM Lid 
WHERE lidnr = 83);


-- 2. Geef een overzicht van de boetes van de leden die in Amsterdam wonen. (TIP: gebruik WHERE 
-- …. in…..)
SELECT * 
FROM boete 
WHERE lidnummer IN (SELECT lidnr 
FROM Lid 
WHERE woonplaats = 'Amsterdam');


-- 3. Geef de thuiswedstrijden en de uitslag van de thuiswedstrijden van de teams met als thuishal 
-- de Apollohal.
SELECT datum, tijd, teamthuis,teamuit, concat_ws('-', scorethuis, scoreuit) AS uitslag 
FROM wedstrijd 
WHERE teamthuis in  (SELECT teamcode 
FROM team 
WHERE thuishal='Apollohal');

-- 4. Geef een overzicht van de boetes van de leden die voor team LEAMD1 hebben gespeeld.
SELECT * 
FROM boete 
WHERE lidnummer IN (SELECT lidnr 
FROM Lid 
WHERE speelt_in = 'LEAMD1');



-- 5. Geef de namen van de leden die de hoogste boete hebben betaald.
SELECT achternaam 
FROM Lid 
WHERE lidnr IN (SELECT lidnummer 
FROM boete 
WHERE bedrag = (SELECT MAX(bedrag) 
FROM boete));


-- 6a. Geef een lijst van leden en het aantal boetes dat ze hebben betaald, laat de naam van 
-- het lid en het aantal boetes zien.
SELECT achternaam, count(*) 
FROM Lid JOIN Boete 
ON Lid.lidnr = Boete.lidnummer
GROUP BY Lid.lidnr;


-- b. Geef de namen van de leden die meer dan 2 boetes hebben betaald.
SELECT achternaam, count(*) 
FROM Lid JOIN Boete 
ON Lid.lidnr = Boete.lidnummer
GROUP BY Lid.lidnr
HAVING count(*) > 2;



-- c. Geef de naam van het lid dat meer boetes heeft betaald dan het lid met lidnummer 201
SELECT achternaam
FROM Lid
WHERE lidnr IN (
	SELECT lidnummer
	FROM Boete 
	GROUP BY lidnummer
	HAVING count(*) > (
		SELECT count(*) 
		FROM Boete 
		WHERE lidnummer = 201));

	
-- 	of
	
SELECT achternaam, count(*) 
FROM Lid JOIN Boete 
ON Lid.lidnr = Boete.lidnummer
GROUP BY Lid.lidnr
HAVING count(*) > (	SELECT count(*) 
				FROM Boete 
				WHERE lidnummer = 201);










