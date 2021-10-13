SELECT date_format(date, "%Y-%M"), company_id, count(order_id) AS orders
FROM(
SELECT DATE_FORMAT(FROM_UNIXTIME(TIMESTAMP),'%Y-%m-%d') AS DATE, company_id, order_id
FROM cscart_orders
WHERE status = 'C'
GROUP BY date, company_id, order_id
) AS t
GROUP BY date_format(date, "%Y-%M"), company_id