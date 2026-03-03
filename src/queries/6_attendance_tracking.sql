.open fittrackpro.db
.mode column

-- 6.1 
--No check out time provided so NULL is used
INSERT INTO
    attendance (
        attendance_id,
        member_id,
        location_id,
        check_in_time,
        check_out_time
    )
VALUES
    (4, 7, 1, '2025-02-14 16:30:00', NULL);

-- 6.2
--No need for date when selecting the times, hence use of substring function
SELECT
    substr (check_in_time, 1, 10) AS visit_date,
    substr (check_in_time, 12, 19) AS check_in_time,
    substr (check_out_time, 12, 19) AS check_out_time
FROM
    attendance
WHERE
    member_id = 5;

-- 6.3
--Using strftime to extract the day of the week as a number
SELECT
    strftime ('%w', check_in_time) AS day_of_week,
    COUNT(attendance_id) as visit_count
FROM
    attendance
GROUP BY
    day_of_week
ORDER BY
    visit_count DESC
LIMIT
    1;

-- 6.4
SELECT l.name AS location_name,AVG(a.attendance_id) AS avg FROM locations AS l 
INNER JOIN attendance AS a ON l.location_id = a.location_id
GROUP BY l.location_id, strftime('%w', a.check_in_time);

COUNT(a.attendance_id) GROUP BY strftime('%w', check_in_time)
AVG(COUNT(a.attendance_id) GROUP BY strftime('%w', check_in_time))
SELECT DISTINCT l.name, (SELECT COUNT(strftime('%w', check_in_time)) FROM attendance) AS avg_daily_attendance FROM attendance AS a 
INNER JOIN locations as l ON l.location_id = a.location_id;