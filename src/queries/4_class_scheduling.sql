.open fittrackpro.db
.mode column

-- 4.1
--Use distinct to prevent classes being repeated
SELECT DISTINCT
    cs.class_id,
    c.name AS class_name,
    s.first_name AS instructor_name
FROM
    class_schedule AS cs
    INNER JOIN classes AS c ON cs.class_id = c.class_id
    INNER JOIN staff AS s ON cs.staff_id = s.staff_id;

-- 4.2 
SELECT
    s.class_id,
    c.name,
    s.start_time,
    s.end_time,
    c.capacity AS available_spots
FROM
    class_schedule AS s
    INNER JOIN classes AS c ON s.class_id = c.class_id
WHERE
    s.start_time LIKE '2025-02-01%';

-- 4.3 
INSERT INTO
    class_attendance (
        class_attendance_id,
        schedule_id,
        member_id,
        attendance_status
    )
VALUES
    (16, 1, 11, 'Registered');

-- 4.4 
DELETE FROM class_attendance
WHERE
    member_id = 3
    AND schedule_id = 7;

-- 4.5
--Using 3 tables to get relevant data, WHERE and GROUP BY prevent duplicate values
SELECT
    cs.class_id,
    c.name AS class_name,
    COUNT(a.attendance_status) AS registration_count
FROM
    class_schedule AS cs
    INNER JOIN classes AS c ON cs.class_id = c.class_id
    INNER JOIN class_attendance AS a ON cs.schedule_id = a.schedule_id
WHERE
    a.attendance_status = 'Registered'
GROUP BY
    cs.class_id
ORDER BY
    registration_count DESC;

-- 4.6 
SELECT
    COUNT(member_id)
FROM
    members
WHERE
    member_id IN (
        SELECT
            member_id
        FROM
            class_attendance
    );