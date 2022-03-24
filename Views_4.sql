
-- Edwin Rodriguez Valle
-- Views 2

Use werknemer;


-- 1. Maak een view die de gegevens van de verkopers weergeeft en noem deze Verkopers. 
CREATE VIEW Verkopers AS
SELECT *
FROM Werknemer
WHERE functie = 'VERKOPER';

-- 2. Gebruik de view Verkopers om de verkopers te geven (naam, salaris) die in schaal 3 zitten. 
SELECT 	V.wnaam, V.salaris
FROM	Verkopers V
JOIN	s_schaal S ON V.salaris BETWEEN S.ondergrens AND S.bovengrens
WHERE	S.schaal = 3;


-- 3. Maak een view ‘privé data’ van alle werknemers met daarin hun privé gegevens, hun functie 
-- en de locatie van de afdeling (de chef, het salaris en de commissie neem je dus niet op). 
CREATE VIEW prive_data AS
SELECT P.wnr, P.voorletter, P.wnaam, P.postcode, P.adres, P.woonplaats, W.functie, A.locatie
FROM PRIVE P JOIN Werknemer W  ON P.wnr = W.wnr 
JOIN Afdeling A ON W.anr = A.anr;


-- 4. Gebruik de view ‘privé data’ om de werknemers te laten zien die wonen en werken in dezelfde 
-- plaats. 

SELECT *
FROM prive_data
WHERE woonplaats = locatie;


-- 5. Maak een view aan van alle chefs, en noem die Chefs (alle gegevens, oplopend gesorteerd op 
-- naam). 
CREATE VIEW Chefs AS
SELECT	*
FROM 	Werknemer
WHERE 	wnr IN
( 	SELECT	chef
	FROM	Werknemer
)
ORDER BY wnaam;

select*
from Chefs;
