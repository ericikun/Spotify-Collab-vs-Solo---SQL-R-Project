SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;


SELECT *
FROM spotify_raw
LIMIT 5;


SELECT COUNT(*) AS total_rows
FROM spotify_raw;
