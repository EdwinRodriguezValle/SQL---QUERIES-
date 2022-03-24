-- Edwin Rodriguez Valle
-- Solving recursive queries

use werknemer;

-- 1. Geef de namen van de werknemers die op locatie Chicago werken. 
select *
from werknemer;

select *
from afdeling;

SELECT w.wnaam, locatie 
FROM werknemer w JOIN afdeling a
ON w.anr = a.anr
WHERE a.locatie = 'CHICAGO';



-- 2. Geef van alle werknemers de naam, de functie en de salarisschaal. (Hint: als het salaris van een 
-- werknemer tussen de ondergrens en de bovengrens van een salarisschaal zit, dan weet je de 
-- juiste schaal. Gebruik een BETWEEN …. AND …. als JOIN voorwaarde.)
select *
from s_schaal;

SELECT w.wnaam, w.functie, s.schaal
FROM werknemer w JOIN s_schaal s
ON w.salaris BETWEEN s.ondergrens AND s.bovengrens;


-- 3. Geef de naam van de verkopers die in salarisschaal 3 zitten.
SELECT w.wnaam, schaal , functie 
FROM werknemer w JOIN s_schaal s
ON w.salaris BETWEEN s.ondergrens AND s.bovengrens
WHERE s.schaal = 3 AND w.functie = 'VERKOPER';


-- 4. Geef van alle salarisschalen het nummer en van de bijbehorende werknemers het nummer, de 
-- naam en het salaris. Sorteer de uitkomst op salarisschaal.
SELECT s.schaal, w.wnr, w.wnaam, w.salaris
FROM s_schaal s LEFT JOIN werknemer w 
ON s.ondergrens < w.salaris AND  w.salaris <= s.bovengrens
ORDER BY s.schaal;


-- 5. Geef nummer en naam van de werknemers en vermeld ook het nummer en de naam van hun 
-- chef. Zorg dat alle werknemers in de lijst staan.
SELECT w.wnr, w.wnaam, c.wnr chefnr, c.wnaam chefnaam
FROM werknemer w LEFT JOIN werknemer c 
ON w.chef = c.wnr;


-- 6. Geef een overzicht van de hiërarchie in het bedrijf. Toon van elke werknemer de chef, de chef 
-- van de chef en tenslotte de chef van de chef van de chef.
SELECT w.wnr, w.wnaam, c1.wnr chef, c1.wnaam naam_chef,
       c2.wnr chef_van_chef, c2.wnaam naam_chef_van_chef, 
       c3.wnr chef_van_chef_van_chef, c3.wnaam naam_chef_van_chef_van_chef
FROM werknemer w 
LEFT JOIN werknemer c1 ON w.chef = c1.wnr 
LEFT JOIN werknemer c2 ON c1.chef = c2.wnr
LEFT JOIN werknemer c3 ON c2.chef = c3.wnr;


-- 7. Laat het aantal werknemers per functie zien.
SELECT functie, COUNT(functie) AS aantal_werknemers
FROM werknemer
GROUP BY functie;

-- 8. Geef alle functies die door minstens drie werknemers wordt uitgeoefend.
SELECT functie, COUNT(functie) AS aantal_werknemers
FROM werknemer
GROUP BY functie
HAVING COUNT(functie) >= 3;

-- 9. Laat per afdeling zien wat het hoogste salaris van de afdeling is.
SELECT anr, MAX(salaris) AS hoogste_salaris
FROM  werknemer 
GROUP BY anr;


-- 10. Laat per afdeling de naam van de afdeling en het gemiddelde salaris zien.
SELECT anaam, AVG(salaris) AS gemiddeld_salaris
FROM werknemer W JOIN afdeling A 
ON W.anr = A.anr
GROUP BY W.anr, anaam;

-- 11. Welke afdelingen hebben een gemiddeld salaris van meer dan 2000?
SELECT anr, AVG(salaris) AS gemiddeld_salaris
FROM werknemer
GROUP BY anr
HAVING AVG(salaris) > 2000;


-- 12. In welke plaatsen woont meer dan één werknemer?
select*
from prive;

SELECT woonplaats, count(woonplaats) as amout
FROM  prive 
GROUP BY woonplaats
HAVING COUNT(woonplaats) > 1;


-- 13. Geef van alle werknemers die chef zijn het aantal werknemers waar ze chef van zijn
SELECT w.chef, COUNT(w.wnr) AS aantal_werknemers
FROM werknemer w
WHERE w.chef IS NOT NULL
GROUP BY w.chef;

-- 14 Wil je ook nog aanvullende informatie over de chef, dan moet je recursief joinen:
SELECT w.chef, c.wnaam, COUNT(w.wnr) AS aantal_werknemers
FROM werknemer w JOIN werknemer c
ON w.chef = c.wnr
GROUP BY w.chef, c.wnaam;




