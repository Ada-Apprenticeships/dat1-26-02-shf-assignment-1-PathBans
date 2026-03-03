.open fittrackpro.db
.mode column

-- 2.1 
INSERT INTO
    payments (
        payment_id,
        member_id,
        amount,
        payment_date,
        payment_method,
        payment_type
    )
VALUES
    (
        8,
        11,
        50.00,
        DATETIME ('now'),
        'Credit Card',
        'Monthly membership fee'
    );

-- 2.2
--Using strftime to extract month and then using the LIKE statement to check if month is 01,02, 11 or 12 as specified
SELECT
    strftime ('%m', payment_date) AS month,
    SUM(amount) AS total_revenue
FROM
    payments
WHERE
    month LIKE '_1'
    or month LIKE '_2'
GROUP BY
    month;

-- 2.3 
SELECT
    payment_id,
    amount,
    payment_date,
    payment_method
FROM
    payments
WHERE
    payment_type = 'Day pass';