.open fittrackpro.db
.mode column

-- 3.1
--Using LIKE statement to get dates from that month, as 30 days from 1st Jan goes up to 31st Jan
SELECT
    equipment_id,
    name,
    next_maintenance_date
FROM
    equipment
WHERE
    next_maintenance_date LIKE '2025-01-__';

-- 3.2
--Using DISTINCT and GROUP to prevent duplicates and get the right number for each type
SELECT
    type as equipment_type,
    COUNT(type) AS count
FROM
    equipment
WHERE
    type IN (
        SELECT DISTINCT
            type
        from
            equipment
    )
GROUP BY
    equipment_type;

-- 3.3
--Using julianday to arithmetically subtract dates
SELECT
    type as equipment_type,
    AVG(
        julianday (next_maintenance_date) - julianday (last_maintenance_date)
    ) as avg_age_days
FROM
    equipment
GROUP BY
    equipment_type;