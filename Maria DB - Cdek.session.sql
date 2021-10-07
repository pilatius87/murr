WITH cta AS(
SELECT DATE_FORMAT(FROM_UNIXTIME(o.TIMESTAMP),'%Y-%m-%d') AS DATE, o.order_id, o.status, det.product_id, des.product, det.price, det.amount
FROM cscart_orders AS o
LEFT JOIN cscart_order_details AS det ON det.order_id = o.order_id
LEFT JOIN (SELECT * FROM cscart_product_descriptions WHERE lang_code = 'ru') AS des ON des.product_id = det.product_id
WHERE o.status = 'c'
)
SELECT *
FROM cta
WHERE date BETWEEN '2021-09-01' AND '2021-09-30'


