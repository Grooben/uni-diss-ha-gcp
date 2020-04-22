--- Haversine
SELECT name, lng, lat,distance
FROM (

SELECT z.name, z.lng, z.lat, p.radius, p.distance_unit * DEGREES( ACOS( COS( RADIANS( p.latpoint ) ) * COS( RADIANS( z.lat ) ) * COS( RADIANS( p.longpoint - z.lng ) ) + SIN( RADIANS( p.latpoint ) ) * SIN( RADIANS( z.lat ) ) ) ) AS distance
FROM evac_routes AS z
JOIN (
/* these are the query parameters */
SELECT 53.340909 AS latpoint, 0.125512 AS longpoint, 50.0 AS radius, 69 AS distance_unit
) AS p ON 1 =1
WHERE z.lat
BETWEEN p.latpoint - ( p.radius / p.distance_unit ) 
AND p.latpoint + ( p.radius / p.distance_unit ) 
AND z.lng
BETWEEN p.longpoint - ( p.radius / ( p.distance_unit * COS( RADIANS( p.latpoint ) ) ) ) 
AND p.longpoint + ( p.radius / ( p.distance_unit * COS( RADIANS( p.latpoint ) ) ) )
) AS d
WHERE distance <= radius
ORDER BY distance
LIMIT 1
