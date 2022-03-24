-- Edwin Rodriguez Valle
-- Sub-Queries

use werknemer;


-- 1. Welke werknemer verdient het laagste salaris?
SELECT wnaam, salaris
FROM werknemer
WHERE salaris = (SELECT MIN(salaris)
FROM werknemer);


-- 2. Welke werknemers verdienen meer dan het gemiddelde salaris?
SELECT wnaam, salaris
FROM werknemer
WHERE salaris > (SELECT AVG(salaris)
FROM werknemer);


-- 3. Welke werknemers werken op dezelfde afdeling als Smith?
SELECT wnaam, anr
FROM werknemer
WHERE anr = (SELECT anr
FROM werknemer
WHERE wnaam = 'SMITH');


-- 4. In welke afdeling wordt het hoogste salaris verdiend?
SELECT anr
FROM werknemer
WHERE salaris = (SELECT MAX(salaris)
FROM werknemer);

-- 5. Welke werknemers verdienen meer dan het gemiddelde salaris van hun afdeling

SELECT w1.wnr, w1.salaris
FROM werknemer w1 JOIN (	SELECT anr, AVG(salaris) avgsal 
						FROM werknemer 
						GROUP BY anr) AS afdavgsal 
ON w1.anr = afdavgsal.anr
WHERE w1.salaris > avgsal;


