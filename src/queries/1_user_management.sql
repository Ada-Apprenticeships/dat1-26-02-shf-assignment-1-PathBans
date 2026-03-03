.open fittrackpro.db
.mode column

-- 1.1
SELECT
    member_id,
    first_name,
    last_name,
    email,
    join_date
FROM
    members;

-- 1.2
UPDATE members
SET
    phone_number = '07000 100005',
    email = 'emily.jones.updated@email.com'
WHERE
    member_id = 5;

-- 1.3
SELECT
    COUNT(*)
FROM
    members AS total_members;

-- 1.4
--Ordering via descending and then limiting to 1 to get the top most value
SELECT
    members.member_id,
    members.first_name,
    members.last_name,
    COUNT(class_attendance.attendance_status) AS registration_count
FROM
    members
    INNER JOIN class_attendance ON members.member_id = class_attendance.member_id
WHERE
    class_attendance.attendance_status = 'Registered'
GROUP BY
    members.member_id
ORDER BY
    registration_count DESC
LIMIT
    1;

-- 1.5
--Same logic as 1.4 just with ascending ordering to get bottom value
SELECT
    members.member_id,
    members.first_name,
    members.last_name,
    COUNT(class_attendance.attendance_status) AS registration_count
FROM
    members
    INNER JOIN class_attendance ON members.member_id = class_attendance.member_id
WHERE
    class_attendance.attendance_status = 'Registered'
GROUP BY
    members.member_id
ORDER BY
    registration_count
LIMIT
    1;

-- 1.6
--Using a HAVING statement to check if the count of 'Registered' values of a member id is bigger than 2.
SELECT
    Count(member_id) AS Count
FROM
    class_attendance
WHERE
    attendance_status = 'Registered'
GROUP BY
    member_id
HAVING
    Count(attendance_status) >= 2;