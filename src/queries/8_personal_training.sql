.open fittrackpro.db
.mode column

-- 8.1 
SELECT
    p.session_id,
    m.first_name AS member_name,
    p.session_date,
    p.start_time,
    p.end_time
FROM
    personal_training_sessions AS p
    INNER JOIN members AS m ON p.member_id = m.member_id
WHERE
    p.staff_id IN (
        SELECT
            staff_id
        FROM
            staff
        WHERE
            first_name = 'Ivy'
            AND last_name = 'Irwin'
    );