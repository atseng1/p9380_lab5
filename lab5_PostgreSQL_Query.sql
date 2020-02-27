/*Count of total number of cells in SLOSH grid*/
SELECT COUNT(*)

FROM lab5.oc_slosh;


/*Count of total number of cells in SLOSH grid INSIDE of our county of interest, Ocean County*/
SELECT COUNT(*)

FROM lab5.oc_slosh, lab5.oc_cty

WHERE ST_Intersects(oc_slosh.geom, oc_cty.geom);


/*Create Table for all SLOSH grid cells within our county of interest*/
SELECT lab5.oc_slosh.geom

FROM lab5.oc_slosh, lab5.oc_cty

WHERE ST_Intersects(oc_slosh.geom, oc_cty.geom);


/*Add hurricane variables to new table for all SLOSH grid cels within our county of interest*/
SELECT oc_slosh.geom, lab5.oc_slosh.c1_high, lab5.oc_slosh.c2_high, lab5.oc_slosh.c3_high, lab5.oc_slosh.c4_high

FROM lab5.oc_slosh , lab5.oc_cty

WHERE ST_Intersects(oc_slosh.geom, oc_cty.geom);


/*Recode Category 1 Hurricane Null Values (99.9) to 0*/
UPDATE lab5.oc_slosh

SET c1_high = 0

WHERE c1_high = 99.9;


/*Recode Category 2 Hurricane Null Values (99.9) to 0*/
UPDATE lab5.oc_slosh

SET c2_high = 0

WHERE c2_high = 99.9;


/*Recode Category 3 Hurricane Null Values (99.9) to 0*/
UPDATE lab5.oc_slosh

SET c3_high = 0

WHERE c3_high = 99.9;


/*Recode Category 4 Hurricane Null Values (99.9) to 0*/
UPDATE lab5.oc_slosh

SET c4_high = 0

WHERE c4_high = 99.9;


/*Pull SLOSH grid cells for area of interest with recoded values*/
SELECT oc_slosh.geom, lab5.oc_slosh.c1_high, lab5.oc_slosh.c2_high, lab5.oc_slosh.c3_high, lab5.oc_slosh.c4_high
FROM lab5.oc_slosh , lab5.oc_cty
WHERE ST_Intersects(oc_slosh.geom, oc_cty.geom);


/*Add Geometry to our original file from Lab 4*/
SELECT addgeometrycolumn('lab4', 'oc_prop', 'geom', 4269, 'point', 2);

UPDATE lab4.oc_prop
SET geom = st_setsrid(st_makepoint(x::double precision,y::double precision), 4269);
