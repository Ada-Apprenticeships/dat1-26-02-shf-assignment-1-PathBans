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
-- 5.3 
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    ms.end_date
FROM
    members as m
    INNER JOIN memberships as ms ON m.member_id = ms.member_id
WHERE
    ms.end_date LIKE '2025-__-__';