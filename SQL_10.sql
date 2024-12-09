SELECT zip, SUBSTR(zip,2,3 ),SUBSTR(zip,-4,3 ), SUBSTR(zip,1,2), SUBSTR(zip, -5, 2)
FROM customers
where customer# = 1001;
