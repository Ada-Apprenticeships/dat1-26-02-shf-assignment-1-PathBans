.open fittrackpro.db
.mode column

-- 3.1
SELECT equipment_id, name,next_maintenance_date FROM equipment WHERE next_maintenance_date LIKE '2025-01-__';

-- 3.2
SELECT type as equipment_type, COUNT(type) AS count FROM equipment WHERE type IN (SELECT DISTINCT type from equipment) GROUP BY equipment_type;

-- 3.3

