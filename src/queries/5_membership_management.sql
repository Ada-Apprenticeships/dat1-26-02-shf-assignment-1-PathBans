.open fittrackpro.db
.mode column

-- 5.1 
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    ms.type AS membership_type,
    m.join_date
FROM
    members as m
    INNER JOIN memberships as ms ON m.member_id = ms.member_id
WHERE
    ms.status = 'Active';

-- 5.2
--Using unixepoch to get difference between times in seconds and then dividing by 60 to get value in minutes
SELECT
    m.type AS membership_type,
    AVG(
        (
            unixepoch (a.check_out_time) - unixepoch (a.check_in_time)
        ) / 60
    ) AS avg_visit_duration_minutes
FROM
    memberships AS m
    INNER JOIN attendance AS a ON m.member_id = a.member_id
GROUP BY
    membership_type;

-- 5.3 
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    ms.end_date
FROM
    members AS m
    INNER JOIN memberships AS ms ON m.member_id = ms.member_id
WHERE
    ms.end_date LIKE '2025-__-__';