SELECT date_format(date, "%Y-%M"), company_id, company, phone, email, order_id, category_id, category, 
SUM(if(oc_status IN ('A','B','F','I'),1,0)) AS Отмены,



FROM(
SELECT DATE_FORMAT(FROM_UNIXTIME(o.TIMESTAMP),'%Y-%m-%d') AS DATE, com.company, com.phone, com.email, o.order_id,  oc.status AS oc_status, sd.description, o.company_id,
cvpc.category_id,  cd.category
FROM cscart_orders AS o
LEFT JOIN cscart_cdek_orders_cancel AS oc ON o.order_id = oc.order_id
LEFT JOIN (SELECT * FROM cscart_statuses WHERE TYPE = 'd') AS s ON s.status = oc.status
LEFT JOIN (SELECT * FROM cscart_status_descriptions WHERE lang_code = 'ru') AS sd ON sd.status_id = s.status_id
LEFT JOIN cscart_companies AS com ON o.company_id = com.company_id
LEFT JOIN (SELECT * FROM cscart_category_vendor_product_count AS cvpc WHERE product_count = (select max(product_count) FROM cscart_category_vendor_product_count as cvpc2 WHERE cvpc.company_id = cvpc2.company_id) GROUP BY company_id) AS cvpc ON cvpc.company_id = com.company_id
LEFT JOIN (SELECT category_id, SUBSTRING_INDEX(id_path, '/', 1) as main_cat_id FROM cscart_categories) AS cat ON cat.category_id = cvpc.category_id
LEFT JOIN (SELECT * FROM cscart_category_descriptions WHERE lang_code = 'RU') AS cd ON cd.category_id = cat.main_cat_id
WHERE oc.status IN ('A','B','F','I')
) AS aa
WHERE DATE BETWEEN '2021-01-01' AND '2021-09-30'
GROUP BY date_format(date, "%Y-%m"),company