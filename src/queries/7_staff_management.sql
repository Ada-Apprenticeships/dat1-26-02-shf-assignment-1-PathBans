.open fittrackpro.db
.mode column

-- 7.1 
SELECT
    staff_id,
    first_name,
    last_name,
    position AS role
FROM
    staff
ORDER BY
    role;

-- 7.2
--Same logic to 1.6 using HAVING and GROUP BY, using concatenation for trainer name
SELECT
    s.staff_id AS trainer_id,
    s.first_name || ' ' || s.last_name AS trainer_name,
    Count(p.session_id) AS session_count
FROM
    staff AS s
    INNER JOIN personal_training_sessions AS p ON s.staff_id = p.staff_id
WHERE
    p.session_date BETWEEN '2025-01-20' AND '2025-02-20'
GROUP BY
    s.staff_id
HAVING
    Count(session_id) >= 1;