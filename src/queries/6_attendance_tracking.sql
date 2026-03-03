.open fittrackpro.db
.mode column

-- 6.1 
--No check out time provided so NULL is used
INSERT INTO attendance (attendance_id,member_id,location_id,check_in_time,check_out_time) VALUES (4,7,1,'2025-02-14 16:30:00',NULL);

-- 6.2
--No need for date when selecting the times, hence use of substring function
SELECT substr(check_in_time,1,10) AS visit_date, substr(check_in_time,12,19) AS check_in_time, substr(check_out_time,12,19) AS check_out_time
FROM attendance WHERE member_id = 5;

-- 6.3 


-- 6.4 

