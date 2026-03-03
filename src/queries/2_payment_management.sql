.open fittrackpro.db
.mode column

-- 2.1 
INSERT INTO payments (payment_id,member_id,amount,payment_date,payment_method,payment_type) VALUES (8,11,50.00,DATETIME('now'),'Credit Card','Monthly membership fee');

-- 2.2 
SELECT month, SUM(amount) AS total_revenue FROM payments WHERE 

-- 2.3 
SELECT payment_id, amount, payment_date, payment_method FROM payments WHERE payment_type = 'Day pass';
