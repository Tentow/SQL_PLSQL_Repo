SET SERVEROUTPUT ON;

--challenge 2-1


DECLARE
    lv_billing_date DATE := '21-OCT_12';
    lv_lastname_txt VARCHAR2 (12);
    lv_cred_bal NUMBER (6.2) :=1000;
BEGIN
    lv_lastname_txt := 'BROWN';
    DBMS_OUTPUT.PUT_LINE(lv_billing_date);
    DBMS_OUTPUT.PUT_LINE(lv_lastname_txt);
    DBMS_OUTPUT.PUT_LINE(lv_cred_bal);
END;
/
--CHALLENGE 2-2
DECLARE
    lv_mail_status VARCHAR2(1) := 'Y';
    lv_bal_owed NUMBER (4) := 1200;
    lv_min_payment_rate CONSTANT NUMBER (2,2):= .05;
    lv_min_payment_amount NUMBER (6,2);    
BEGIN
    lv_min_payment_rate:= .07;
    lv_min_payment_amount:=lv_bal_owed*lv_min_payment_rate;
    lv_mail_status:= 'N';
    DBMS_OUTPUT.PUT_LINE (lv_mail_status);
    DBMS_OUTPUT.PUT_LINE (lv_bal_owed);
    DBMS_OUTPUT.PUT_LINE (lv_min_payment_rate);
    DBMS_OUTPUT.PUT_LINE (lv_min_payment_amount);
END;
/
--CHALLENGE 2-3
DECLARE
    lv_promo_code VARCHAR2 (6) := 'A0807X';
    lv_month VARCHAR2 (4);
    lv_year VARCHAR2(4);
BEGIN
    lv_month:= SUBSTR(lv_promo_code, 2,2);
    lv_year:= SUBSTR(lv_promo_code, 4,2);
    DBMS_OUTPUT.PUT_LINE ('MONTH:' ||lv_month);
    DBMS_OUTPUT.PUT_LINE ('YEAR:' ||lv_year);
END;
/
--CHALLENGE 2-6
DECLARE
    lv_promo_code_text VARCHAR2 (1):= 'A';
    lV_order_total_num NUMBER (3) :=100;
    lv_discount_num NUMBER (6,2);
BEGIN
    if lv_promo_code_text = 'C' THEN
        lv_discount_num:= lV_order_total_num*15/100;
    ELSIF lv_promo_code_text = 'B' THEN
        lv_discount_num:= lV_order_total_num*10/100;
    ELSIF lv_promo_code_text = 'A' THEN
        lv_discount_num:= lV_order_total_num*5/100;
    ELSE
        lv_discount_num:= lV_order_total_num*2/100;
    END IF;
    DBMS_OUTPUT.PUT_LINE(lv_discount_num);
END;
/

DECLARE
    lv_promo_code_text VARCHAR2 (1):= 'A';
    lV_order_total_num NUMBER (3) :=100;
    lv_discount_num NUMBER (6,2);
BEGIN
    if lv_promo_code_text = 'E' THEN
        lv_discount_num:= lV_order_total_num*5/100;
    ELSIF lv_promo_code_text = 'D' THEN
        lv_discount_num:= lV_order_total_num*15/100;
    ELSIF lv_promo_code_text IN ('C', 'B') THEN
        lv_discount_num:= lV_order_total_num*10/100;
    ELSIF lv_promo_code_text = 'A' THEN
        lv_discount_num:= lV_order_total_num*5/100;
    ELSE
        lv_discount_num:= 0;
    END IF;
    DBMS_OUTPUT.PUT_LINE('DISCOUNT AMOUNT: '||lv_discount_num);
END;
/
--NESTED IF
DECLARE
    lv_type_txt CHAR(1) := 'E';
    lv_price_num NUMBER (6,2) := 20;
    lv_disc_num NUMBER (6,2);
BEGIN
IF lv_type_txt = 'E' THEN
    IF lv_price_num > 85 THEN
        lv_disc_num:= lv_price_num*.20;
    ELSIF lv_price_num > 45 THEN
        lv_disc_num:= lv_price_num*.15;
    ELSE
        lv_disc_num:= lv_price_num*.10;
    END IF;
ELSIF lv_type_txt = 'C' THEN
    lv_disc_num:= lv_price_num* .05;
END IF;
    DBMS_OUTPUT.PUT_LINE ('discount: '||lv_disc_num);
END;
/
SELECT*FROM bb_basket;
/
CREATE TABLE autos
    (auto_id NUMBER (5),
    acquire_date DATE,
    color VARCHAR2 (15),
    CONSTRAINT autos_auto_id_pk PRIMARY KEY (auto_id)
    );

/
DESC autos;
/
INSERT INTO autos (auto_id, acquire_date, color)
    VALUES (45321,'05-MAY-2012', 'grey');
INSERT INTO autos (auto_id, acquire_date, color)
    VALUES (81433,'12-OCT-2012', 'red');
COMMIT;
SELECT* FROM autos;
/
UPDATE autos
    SET color ='silver'
    WHERE auto_id =45321;
/
SELECT* FROM autos;
/
ROLLBACK;
/
DELETE FROM autos
    WHERE auto_id =45321;
/ 
SELECT* FROM autos;
/
DROP TABLE autos;
/
SELECT* FROM autos;


--REVIEW QUESTIONS ON CHAPTER ONE(MCQ)
--1A
--2B
--3A
--4A,B,D
--5B,C,D
--6C
--7D
--8C
--9D
--10B
--11
--12 YES, BEACUSE ORACLE ISN'T THE ONLY DATABASE DEVELOPMENT SERVER AVAILABLE 
--13 A TWO TIER APPLICATION SPLITS PROGRAMMING LOGIC BETWEEN CLIENT MACHINE AND  DATABSE SERVER WHILE A THREE-TIER APPPLICATION PLACES THE PROGRAM CODE ON AN APPLICATION SERVER
--14

--HANDS-ON ASSIGNMENT PART 1
--EXAMPLES
-- Q2
SELECT idproduct, productname, price, active, type, idDepartment, stock
FROM bb_product;

--Q3
SELECT idshopper, b.idbasket, b.orderplaced,b.dtordered, b.dtcreated
FROM bb_shopper s INNER JOIN bb_basket b
        USING (idshopper);

-- 4
SELECT idproduct, p.productname, pc.categoryname, pd.optionname
    FROM bb_product p INNER JOIN bb_productoption
      USING (idproduct)
        INNER JOIN bb_productoptiondetail pd
          USING (idoption)
            INNER JOIN bb_productoptioncategory pc
              USING (idoptioncategory);
 --EXERCISES
 --Q1
 SELECT DISTINCT (bi.idproduct), b.orderplaced
 FROM bb_basketitem bi INNER JOIN bb_basket b 
    USING (idbasket)
    WHERE b.orderplaced = 1
ORDER BY idproduct;
/
--Q2
--USING THE ANSI JOIN METHOD
SELECT idbasket, idproduct, productname, description
FROM bb_basketitem  INNER JOIN bb_product 
   USING (idproduct);

--USING THE TRADITIONAL JOIN METHOD
SELECT bi.idbasket, p.idproduct, p.productname, p.description
FROM bb_basketitem bi JOIN bb_product p
   ON bi.idproduct = p.idproduct;
/
SELECT bi.idbasket, p.idproduct, p.productname, p.description
FROM bb_basketitem bi, bb_product p
WHERE bi.idproduct = p.idproduct;

--Q3 modifying the querry above to add customer's lastname
SELECT lastname, idbasket, idproduct, productname, description
FROM bb_basketitem  INNER JOIN bb_product 
   USING (idproduct)
     INNER JOIN bb_basket
       USING (idbasket)
         INNER JOIN bb_shopper
           USING (idshopper);

--Q4
SELECT idbasket, idshopper, TO_CHAR (dtordered, 'Month DD,YYYY') "dtordered"
FROM bb_basket INNER JOIN bb_shopper
    USING (idshopper)
WHERE dtordered BETWEEN '01-FEB-12' AND '29-FEB-12';
/
--Q5 Displaying the total quantity sold by product Id
SELECT bi.idproduct, SUM(b.quantity) "quantity sold"
FROM bb_basketitem bi JOIN bb_basket b USING (idbasket)
GROUP BY idproduct;
/
--Q6 modifying the querry above to show only products that have sold less than a quantity of 3

SELECT bi.idproduct, SUM(b.quantity) "quantity sold"
FROM bb_basketitem bi JOIN bb_basket b USING (idbasket)
GROUP BY idproduct
HAVING SUM(b.quantity) <3;
/

--Q7 active Poducts priced above the overall average of coffee items
SELECT idproduct, productname, price
FROM bb_product
WHERE active = 1
    AND price >  (SELECT AVG(price) from bb_product);
/
--Q8
DROP TABLE contacts;
CREATE TABLE contacts
    (con_id NUMBER (4),
    company_name VARCHAR2(30) NOT NULL,
    Email VARCHAR2 (30),
    last_date  DATE DEFAULT SYSDATE,
    con_cnt NUMBER (3),
    CONSTRAINT contacts_con_id_pk PRIMARY KEY (con_id),
    CONSTRAINT contacts_con_cnt_ck CHECK (con_cnt > 0)
    );
/
--Q9 populating the table above
INSERT ALL
   INTO contacts (con_id, company_name, email, last_date, con_cnt)
         VALUES (1, 'MINESEC', 'ntong@gmail.com', DEFAULT, 2)
    INTO contacts (con_id, company_name, email, con_cnt)
         VALUES (2, 'MINEDUB', 'mih2gmail.com', 4)
SELECT* FROM dual;

COMMIT;

SELECT
    *
FROM contacts;
/
--Q10
UPDATE contacts
SET email = 'ber@gmail.com' 
WHERE con_id = 1;
/
SELECT
    *
FROM contacts;
/
ROLLBACK;
/

--Assignment 1-2
--Assignment 1-3
--Assignment 1-4 HELP NEEDED HERE IN 2,3, AND 4!


--HANDS-ON ASSIGNMENTS PART II
--Q1
SELECT d.firstname, d.lastname, p.pledgeamt,p.pledgedate, pa.payamt
FROM dd_donor d INNER JOIN dd_pledge p
    USING (iddonor)
      INNER JOIN dd_payment pa
        USING (idpledge);
/
--Q2 list of donors who have made apledge, indicating monthly pay
SELECT d.firstname, d.lastname, p.pledgedate,p.pledgeamt, p.paymonths
FROM dd_donor d  JOIN dd_pledge p
    ON d.iddonor = p.iddonor;
/
--Q3 unduplicated list of projects that have pledges assigned
SELECT DISTINCT (pr.idproj), pr.projname
FROM dd_project pr JOIN dd_pledge pl
    ON pr.idproj = pl.idproj;
/
--Q4 number of pledges made by each donor, including their names.
SELECT d.iddonor, d.firstname,d.lastname, COUNT (pl.iddonor) "num_of_pledges"
FROM dd_donor d JOIN dd_pledge pl 
    ON d.iddonor = pl.iddonor
GROUP BY pl.iddonor, d.iddonor, d.firstname,d.lastname
ORDER BY iddonor;
/
--Q5all pledges made before march 8, 2012 including all column data from the dd_pledge table
SELECT*
FROM dd_pledge
WHERE pledgedate < '08-MAR-12';--TO_DATE('March 8, 2012', 'MM,DD,YYYY');



--CASE PROJECTS
--CASE 1-1 NEED HELP

--CASE 1-2
SELECT movie_id, movie_title,  movie_cat_id, movie_category
FROM mm_movie INNER JOIN mm_movie_type 
    USING (movie_cat_id);


/
SELECT member_id, last, suspension
FROM mm_member;
/
SELECT member_id, last, checkout_date, movie_title
FROM mm_member INNER JOIN  mm_rental
    USING (member_id)
     INNER JOIN mm_movie
       USING (movie_id);
/


--CHAPTER TWO
--CHALLENGE 2-1
SET SERVEROUTPUT ON;
/
DECLARE
    lv_bildate_date DATE := '21-OCT-12';
    lv_last_txt VARCHAR2(30);
    lv_bal_num NUMBER (6,2) := 1000; 
BEGIN
    lv_last_txt := 'Brown';
    DBMS_OUTPUT.PUT_LINE ('billing date:' ||lv_bildate_date);
    DBMS_OUTPUT.PUT_LINE ('last name:' ||lv_last_txt);
    DBMS_OUTPUT.PUT_LINE ('credit ballance:' || lv_bal_num);
END;
/
--CHALLENGE 2-2
DECLARE
    lv_mailstatus_txt CHAR(1) NOT NULL := 'Y';
    lv_balowed_num NUMBER(6,2) := 1200;
    lv_minpayrate_num CONSTANT NUMBER (2,2):= .05;
    lv_minpayamt_num NUMBER (6,2);
BEGIN
    --lv_minpayrate_num:=.07;
    lv_minpayamt_num:= lv_balowed_num*lv_minpayrate_num;
    lv_mailstatus_txt:= 'N';
    DBMS_OUTPUT.PUT_LINE ('mail status: '||lv_mailstatus_txt);
    DBMS_OUTPUT.PUT_LINE ('balance owed: '||lv_balowed_num);
    DBMS_OUTPUT.PUT_LINE ('minimum pay rate: '||lv_minpayrate_num);
    DBMS_OUTPUT.PUT_LINE ('minimum pay amount: '||lv_minpayamt_num);
END;
/
DECLARE
    lv_orderdate_date DATE;
    lv_shipdate_date DATE;
    lv_duration_num NUMBER (3);
BEGIN
    lv_orderdate_date:= '20-SEP-10';
    lv_shipdate_date:= '20-OCT-12';
    lv_duration_num := MONTHS_BETWEEN (lv_shipdate_date, lv_orderdate_date);
    DBMS_OUTPUT.PUT_LINE ('ship duration in months: '||lv_duration_num);
END;
/
--CHALLENGE 2-3
DECLARE
    lv_promocode_txt VARCHAR2 (6):= 'A0807X';
    lv_month_num NUMBER (2);
    lv_year_num NUMBER (2);
BEGIN
    lv_month_num := SUBSTR(lv_promocode_txt,2,2);
    lv_year_num := SUBSTR(lv_promocode_txt, 4, 2);
    DBMS_OUTPUT.PUT_LINE ('MONTH: '||lv_month_num);
    DBMS_OUTPUT.PUT_LINE ('YEAR: '||lv_year_num);
END;
/

--THE BASIC IF STATEMENT
DECLARE
    lv_state_txt CHAR (2):='VA';
    lv_sub_num NUMBER (5,2):=100;
    lv_tax_amount_num NUMBER (4,2):=0;
BEGIN
    IF lv_state_txt = 'VA' THEN
       lv_tax_amount_num := lv_sub_num * .06;
    END IF;
    DBMS_OUTPUT.PUT_LINE(lv_tax_amount_num);
END;
/
--changing the state to NC
DECLARE
    lv_state_txt CHAR (2):='NC';
    lv_sub_num NUMBER (5,2):=100;
    lv_tax_amount_num NUMBER (4,2):=0;
BEGIN
    IF lv_state_txt = 'VA' THEN
       lv_tax_amount_num := lv_sub_num * .06;
    END IF;
    DBMS_OUTPUT.PUT_LINE(lv_tax_amount_num);
END;
/
--initialising lv_tax_amount_num to NULL and changing state to NC
DECLARE
    lv_state_txt CHAR (2):='NC';
    lv_sub_num NUMBER (5,2):=100;
    lv_tax_amount_num NUMBER (4,2);
BEGIN
    IF lv_state_txt = 'VA' THEN
       lv_tax_amount_num := lv_sub_num * .06;
    END IF;
    DBMS_OUTPUT.PUT_LINE(lv_tax_amount_num);
END;
/

--THE IF/THEN/ELSE STATEMENT
DECLARE
    lv_state_txt CHAR (2):='NC';
    lv_sub_num NUMBER (5,2):=100;
    lv_tax_amount_num NUMBER (4,2):=0;
BEGIN
    IF lv_state_txt = 'VA' THEN
       lv_tax_amount_num := lv_sub_num * .06;
    ELSE lv_tax_amount_num := lv_sub_num * .04;
    END IF;
    DBMS_OUTPUT.PUT_LINE(lv_tax_amount_num);
END;
/
--IF/THEN versus IF statement
DECLARE
    lv_state_txt CHAR (2):='NC';
    lv_sub_num NUMBER (5,2):=100;
    lv_tax_amount_num NUMBER (4,2):=0;
BEGIN
    IF lv_state_txt = 'VA' THEN
       lv_tax_amount_num := lv_sub_num * .06;
    END IF;
    IF lv_state_txt <> 'VA' THEN
        lv_tax_amount_num := lv_sub_num * .04;
    END IF;
    DBMS_OUTPUT.PUT_LINE(lv_tax_amount_num);
END;
/
--IF/THEN/ELSIF/ELSE

DECLARE
    lv_state_txt CHAR (2):='ME';
    lv_sub_num NUMBER (5,2):=100;
    lv_tax_amount_num NUMBER (4,2):=0;
BEGIN
    IF lv_state_txt = 'VA' THEN
        lv_tax_amount_num := lv_sub_num* .06;
    ELSIF lv_state_txt = 'ME' THEN
        lv_tax_amount_num := lv_sub_num* .05;
    ELSIF lv_state_txt = 'NY' THEN
        lv_tax_amount_num := lv_sub_num* .07;
    ELSE 
        lv_tax_amount_num  := lv_sub_num* .04;
    END IF;
    DBMS_OUTPUT.PUT_LINE(lv_state_txt ||':'||lv_tax_amount_num);
END;
/
--IF Statement Evaluations
DECLARE
    lv_option_num NUMBER(2) := 4;
BEGIN
    IF lv_option_num = 3 THEN
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'whole bean');
    ELSIF lv_option_num = 4 THEN
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'ground bean');
    END IF;
END;
/
DECLARE
    lv_option_num NUMBER(2) := 5;
BEGIN
    IF lv_option_num = 3 THEN
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'whole bean');
    ELSIF lv_option_num = 4 THEN
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'ground bean');
   ELSE
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'N/A');
    END IF;
END;
/
DECLARE
    lv_option_num NUMBER(2) := 5;
BEGIN
    IF lv_option_num = 3 THEN
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'whole bean');
    ELSIF lv_option_num = 4 THEN
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'ground bean');
   ELSIF lv_option_num IS NULL THEN
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'N/A');
    ELSE
        DBMS_OUTPUT.PUT_LINE (lv_option_num ||': '||'unknown');
    END IF;
END;
/
DECLARE
    lv_orderdate_date DATE:= '15-SEP-12';
    lv_shipdate_date DATE :='19-SEP-12';
    lv_shipflag_bln BOOLEAN;
BEGIN
    IF (lv_shipdate_date - lv_orderdate_date) >3 THEN
        lv_shipflag_bln := FALSE;
    ELSE
        lv_shipflag_bln := FALSE;
    END IF;
END;
/
DECLARE
    lv_orddate_date DATE := '11-MAR-23';
    lv_shipdate_date DATE := '18-MAR-23';
    lv_shipflag_bln BOOLEAN;
BEGIN
    IF (lv_shipdate_date - lv_orddate_date)> 5 THEN
        lv_shipflag_bln := TRUE;
    ELSE 
        lv_shipflag_bln := FALSE;
    END IF;
END;
/
--NESTED IF TATEMENTS
DECLARE
    lv_type_txt     CHAR (1):= 'C';
    lv_price_num    NUMBER (5,2):= 85;
    lv_dicount_num  NUMBER (5,2);
BEGIN
    IF lv_type_txt = 'E' THEN
        IF lv_price_num > 70 THEN
            lv_dicount_num:= lv_price_num* .07;
        ELSIF lv_price_num > 90 THEN
            lv_dicount_num:= lv_price_num* .05;
        END IF;
    ELSIF lv_type_txt = 'C' THEN
        lv_dicount_num:= lv_price_num* .09;
    ELSE
        lv_dicount_num:= 0;
    END IF;
    DBMS_OUTPUT.PUT_LINE ('type:'||lv_type_txt||' '||'price:'||lv_price_num||' '|| 'discount:'|| lv_dicount_num);
END;
/
--CASE STATEMENTS
DECLARE
    lv_type_txt     CHAR (1):= 'C';
    lv_price_num    NUMBER (5,2):= 85;
    lv_dicount_num  NUMBER (5,2);
BEGIN
    CASE lv_type_txt 
        WHEN 'E' THEN lv_dicount_num:= lv_price_num* .07;
        WHEN 'D' THEN lv_dicount_num:= lv_price_num* .05;
        WHEN 'C' THEN lv_dicount_num:= lv_price_num* .09;
        ELSE lv_dicount_num:= 0;
    END CASE;
    DBMS_OUTPUT.PUT_LINE ('type:'||lv_type_txt||' '||'price:'||lv_price_num||' '|| 'discount:'|| lv_dicount_num);
END
/
--CHALLENGE 2-8
DECLARE
    lv_promocode_text CHAR(1):= 'A';
    lv_ord_total_num NUMBER (5,2):=100;
    lv_disc_amount_num NUMBER (5,2);
BEGIN
    CASE lv_promocode_text
        WHEN 'A'THEN lv_disc_amount_num:= lv_ord_total_num * .05;
        WHEN 'B'THEN lv_disc_amount_num:= lv_ord_total_num * .1;
        WHEN 'C'THEN lv_disc_amount_num:=lv_ord_total_num * .15;
        ELSE lv_disc_amount_num:=lv_ord_total_num * .02;
    END CASE;
    DBMS_OUTPUT.PUT_LINE ('promocode:'||lv_promocode_text||' '||'dicount:'||'$'||lv_disc_amount_num);
END;
/
--SEARCHED CASE STATEMENT
DECLARE
    lv_state_txt CHAR (2):= 'VA';
    lv_zip_text CHAR (5):= '23321';
    lv_ord_total_num NUMBER (5,2):= 100;
    lv_tax_num NUMBER (5,2);
BEGIN
    CASE 
        WHEN lv_zip_text = '23321'THEN 
            lv_tax_num:= lv_ord_total_num*.02;
        WHEN lv_state_txt ='VA' THEN 
            lv_tax_num:= lv_ord_total_num*.06;
        ELSE 
            lv_tax_num:= lv_ord_total_num*.04;
    END CASE;
    DBMS_OUTPUT.PUT_LINE('state:'||lv_state_txt||' '||'zip:'||lv_zip_text||' '||'tax:'||lv_tax_num);
END;
/
--NESTED CASE STATEMENT 
DECLARE
    lv_type_txt     CHAR (1):= 'C';
    lv_price_num    NUMBER (5,2):= 85;
    lv_dicount_num  NUMBER (5,2);
BEGIN
    CASE
        WHEN lv_type_txt = 'C' THEN
            CASE
                WHEN lv_price_num < 60 THEN 
                    lv_dicount_num:= lv_price_num* .06;
                WHEN lv_price_num > 60 THEN
                    lv_dicount_num:= lv_price_num* .09;
                ELSE 
                    lv_dicount_num:= lv_price_num* .04;
            END CASE;
        WHEN lv_type_txt = 'E' THEN
            lv_dicount_num:= lv_price_num* .02;
    END CASE;
    DBMS_OUTPUT.PUT_LINE('type:'||lv_type_txt||' '||'price:'||lv_price_num||' '||'discount:'||lv_dicount_num);    
END;
/
--CHALLENGE 2-9
DECLARE
    lv_promocode_txt    CHAR (1):='A';
    lv_ordtotal_num     NUMBER (5,2):=100;
    lv_discount_num     NUMBER (5,2);
BEGIN
    CASE lv_promocode_txt
        WHEN 'A' THEN lv_discount_num:=lv_ordtotal_num*.05;
        WHEN 'B' THEN lv_discount_num:=lv_ordtotal_num*.1;
        WHEN 'C' THEN lv_discount_num:=lv_ordtotal_num*.15;
        ELSE lv_discount_num:=lv_ordtotal_num*.02;
    END CASE;
    DBMS_OUTPUT.PUT_LINE (lv_discount_num);
END;
/
--LOOPING CONSTRUCTS
--BASIC LOOPS
DECLARE
    lv_count_num NUMBER (1):=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE (lv_count_num);
        EXIT WHEN lv_count_num=5;
        lv_count_num:=lv_count_num+1;
    END LOOP;
END;
/
--Changing the position of the exit when clause given in the code above
DECLARE
    lv_count_num NUMBER (1):=1;
BEGIN
    LOOP
         EXIT WHEN lv_count_num=5;
        DBMS_OUTPUT.PUT_LINE (lv_count_num);
        lv_count_num:=lv_count_num+1;
    END LOOP;
END;
/
--CHALLENGE 2-10
DECLARE
    lv_count_num    NUMBER(3):= 11;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(lv_count_num);
        EXIT WHEN lv_count_num <2;
        lv_count_num :=lv_count_num - 2;
    END LOOP;
END;
/
--WHILE LOOP
DECLARE
    lv_count_num NUMBER (1):=1;
BEGIN
       WHILE lv_count_num <=5 LOOP
        DBMS_OUTPUT.PUT_LINE (lv_count_num);
        lv_count_num:=lv_count_num+1;
    END LOOP;
END;
/
--FOR LOOP
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE (i);
    END LOOP;
END;
/
DECLARE
    lv_upper_num NUMBER(3) := 3;
BEGIN
    FOR i IN 1..lv_upper_num LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
--multiples of 2, using the FOR LOOP
DECLARE
    lv_count_num NUMBER (2):=2;
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(lv_count_num|| ' x '||i||' = '|| i*lv_count_num);
    END LOOP;
END;
/
--OR
DECLARE
    lv_factor_num  NUMBER (3):=2;
BEGIN
        FOR i IN 1..10 LOOP
            DBMS_OUTPUT.PUT_LINE(lv_factor_num ||' x '||i||' = '|| lv_factor_num*i);
        END LOOP;
END;
/
--CHALLENGE 2-12
DECLARE
    lv_subtraction_num  NUMBER(3):= 11;
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(lv_subtraction_num);
        lv_subtraction_num:=lv_subtraction_num-2;
    END LOOP;
END;                                        
/
--CONTINUE STATEMENT
DECLARE
    lv_cnt_num  NUMBER (3):=0;
BEGIN
    FOR i IN 1..10 LOOP
        CONTINUE WHEN MOD (i,2)<> 0;
        DBMS_OUTPUT.PUT_LINE(i);
        lv_cnt_num := lv_cnt_num *2;
    END LOOP;
END;
/
--STATIC STATEMENTS
DECLARE
    lv_upper_num    NUMBER(3) := 3;
    lv_total_num    NUMBER(3);
BEGIN
    FOR i IN 1..lv_upper_num LOOP
    lv_total_num := lv_total_num + i;
END LOOP;
DBMS_OUTPUT.PUT_LINE(lv_total_num);  
END;
/

--NESTED LOOPS
BEGIN
    FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('outer loop');
            FOR ii IN 1..2 LOOP
                DBMS_OUTPUT.PUT_LINE('inner loop');
            END LOOP;
    END LOOP;
END;
/
BEGIN
    <<outer>>
    FOR oi IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('Outer Loop');
        <<inner>>
            FOR ii IN 1..2 LOOP
                IF oi <> 2 THEN CONTINUE outer; END IF;
                DBMS_OUTPUT.PUT_LINE('Inner Loop');
            END LOOP;
    END LOOP;
END;
/


--CHAPTER TWO REVIEW QUESTIONS
--MCQ
--1 B
--2 C
--3 B
--4 C
--5 B
--6 D
--7 A
--8 D
--9 A,C
--10 B
--11 VARIABLES ARE NAMED STRUCTURES FOR HOLDING VALUES MEANT FOR RETRIEVING AND MANIPULATING VALUES DURING PROGRAMMING
--12 THREE MAIN TYPES OF LOOP STRUCTURES IN PL/SQL ARE : FOR LOOP, WHILE LOOP, AND CONTINUE STATEMENT
--    1. THE FOR LOOP INCLUDES A RANGE TO DETERMINE HOW MANY TIMES THE LOOP ITERATES
--    2. THE WHILE LOOP HAS A CONDITION AT THE BEGINING WHICH DETERMINES WHETHER THE LOOP ITERATES FURTHER OR NOT
--    3. THE CONTINUE STATEMENT IS USED TO MOVE TO THE NEXT ITERATION OF THE LOOP.
--13 THE TWO TYPES OF DECISION STRUCTURES IN PL/SQL ARE THE IF AND CASE STRUCTURES 
--14 THE FLOWCHART HELPS DEVELOPERS MAP OUT THE SEQUENCE OF EVENTS TO BE CODED
--15 WHEN A CONSTANT OPTION IS SET IN A VARIABLE DECLERATION, IT CANNOT BE CHANGED.




--ADVANCED REVIEW QUESTIONS
--1 B
--2 A
--3 D
--4 D
--5 C


--HANDS-ON ASSIGNMENTS PART I
--ASSGNMENT 2-1: USING SCALAR VARIABLES   
DECLARE
    lv_test_date    DATE:=  TO_DATE('10-DEC-12', 'DD-MON-YYYY'); --HOW CAN I TO_CHAR this date?
    lv_test_num     CONSTANT NUMBER (2):=10;
    lv_test_txt     VARCHAR2(10);
BEGIN
    lv_test_txt:= 'Ntongai';
    DBMS_OUTPUT.PUT_LINE(lv_test_date);
    DBMS_OUTPUT.PUT_LINE(lv_test_num);
    DBMS_OUTPUT.PUT_LINE(lv_test_txt);
END;
/
--ASSIGNMENT 2-2 CREATING A FLOWCHART TO DEMONSTRATE THE FOLLOWING BLOCK
DECLARE
    lv_total_purchase_num   NUMBER (4):= 300;
    lv_rating_txt           VARCHAR2 (4);
BEGIN
    CASE 
        WHEN lv_total_purchase_num > 200 THEN 
            lv_rating_txt:= 'high';
         WHEN lv_total_purchase_num > 100 THEN 
            lv_rating_txt:= 'mid';
          WHEN lv_total_purchase_num  <100 THEN 
            lv_rating_txt:= 'low';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('customer rating: '||lv_rating_txt);
END;
/

--ASSIGNMENT 2-3: USING IF STATEMENT TO TEST THE BLOCK ABOVE
DECLARE
    lv_total_purchase_num   NUMBER (4):= 103;
    lv_rating_txt           VARCHAR2 (4);
BEGIN
    IF lv_total_purchase_num >200 THEN
        lv_rating_txt:= 'high';
    ELSIF lv_total_purchase_num >100 THEN
        lv_rating_txt:= 'mid';
    ELSIF lv_total_purchase_num <100 THEN
        lv_rating_txt:= 'low';
    END IF;
     DBMS_OUTPUT.PUT_LINE('customer rating: '||lv_rating_txt);
END;
/
--ASSIGNMENT 2-4: USING THE CASE STATEMENT TO TEST THE ABOVE BLOCK
DECLARE
    lv_total_purchase_num   NUMBER (4):= 99;
    lv_rating_txt           VARCHAR2 (4);
BEGIN
    CASE 
        WHEN lv_total_purchase_num > 200 THEN 
            lv_rating_txt:= 'high';
         WHEN lv_total_purchase_num > 100 THEN 
            lv_rating_txt:= 'mid';
          WHEN lv_total_purchase_num  <100 THEN 
            lv_rating_txt:= 'low';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('customer rating: '||lv_rating_txt);
END;
/
--ASSIGNMENT 2-5 USING A BOOLEAN VARIABLE
DECLARE
    lv_acc_balance_num  NUMBER(5,2):=300;    --HOW TO DISPLAY RESULTS HERE
    lv_amt_paid_num     NUMBER(5,2):=200;
    lv_due_flag_bln     BOOLEAN;
BEGIN
    lv_due_flag_bln:=((lv_acc_balance_num-lv_amt_paid_num)>0);
    IF lv_due_flag_bln THEN
        DBMS_OUTPUT.PUT_LINE('the amount is still due');
    ELSE
        DBMS_OUTPUT.PUT_LINE('the amount is not due');
    END IF;
END;
/
--ASSIGNMENT 2-6 USING LOOPING STATEMENTS   ----HELP NEEDED HERE
DECLARE
    lv_price_num        NUMBER :=20;
    lv_total_avl_num    NUMBER:=200;
    lv_item_num         NUMBER:=0;
BEGIN 
    FOR i IN 1..26 LOOP
            WHILE lv_total_avl_num <= lv_price_num LOOP
            DBMS_OUTPUT.PUT_LINE('Number of items bought= '||lv_item_num||'  '||'available balance= '||lv_total_avl_num );
            lv_total_avl_num := lv_total_avl_num - lv_price_num;
    lv_item_num:= lv_item_num +1;
            END LOOP;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('remaining balance: '||lv_total_avl_num);
END; 
/

DECLARE
    lv_item_num         NUMBER(2):=0;
BEGIN 
    FOR i IN 1..20 LOOP
    lv_item_num:= lv_item_num +1;
    DBMS_OUTPUT.PUT_LINE(lv_item_num);
    END LOOP;
END; 
/
--ASSIGNMENT 2-7 CREATING A FLOWCHART

--ASSIGNMENT 2-8: USING IF STATEMENT TO REPRESENT THE FLOWCHART IN ASSIGNMENT 2-7
DECLARE
    lv_quantity_num             NUMBER(5):=10;
    lv_membership_status_txt    CHAR(1):='Y';
    lv_ship_fee_num             NUMBER(5,2);
    lv_member_flag_bln          BOOLEAN;
BEGIN
   IF lv_membership_status_txt = 'Y' THEN
        lv_member_flag_bln:= TRUE;
            IF lv_member_flag_bln       = TRUE AND lv_quantity_num >=10 THEN
                    lv_ship_fee_num := 9;
                ELSIF lv_member_flag_bln = TRUE AND lv_quantity_num >=7 THEN
                    lv_ship_fee_num := 7;
                ELSIF lv_member_flag_bln = TRUE AND lv_quantity_num >=4 THEN
                    lv_ship_fee_num   := 5;
                ELSIF lv_member_flag_bln = TRUE AND lv_quantity_num = 3 THEN
                lv_ship_fee_num      := 3;
            END IF;
    ELSE
        lv_member_flag_bln:= FALSE;
     END IF;           
            IF lv_member_flag_bln       = FALSE AND lv_quantity_num >=10 THEN
                    lv_ship_fee_num := 12;
                ELSIF lv_member_flag_bln = FALSE AND lv_quantity_num >=7 THEN
                    lv_ship_fee_num := 10;
                ELSIF lv_member_flag_bln = FALSE AND lv_quantity_num >=4 THEN
                    lv_ship_fee_num := 7.5;
                 ELSIF lv_member_flag_bln = FALSE AND lv_quantity_num = 3 THEN
                    lv_ship_fee_num := 5;
             END IF;
    DBMS_OUTPUT.PUT_LINE(lv_ship_fee_num);
END;       
/  
--HANDS-ON ASSIGNMENTS PART II
--ASSIGNMENT 2-9: USING A FOR LOOP       ------HELP NEEDED HERE
DECLARE
    lv_pay_due_date             DATE;
    lv_permonth_pay_amnt_num    NUMBER(6,2):=100;
    lv_pledge_owed_num          NUMBER(6,2):=1200;
BEGIN
    FOR i IN 1..12 LOOP
    lv_pledge_owed_num := lv_pledge_owed_num - lv_permonth_pay_amnt_num;
    DBMS_OUTPUT.PUT_LINE('month number:'||i||' '||'amount to pay:'||lv_pledge_owed_num);
    END LOOP;   
EN
/
DECLARE
    lv_plegde_num               DD_PLEDGE.IDPLEDGE%TYPE :=104;
    lv_payment_due_date DATE := TO_DATE(SYSDATE, 'DD-MON-YYYY');
    lv_month_amt_num        NUMBER(5,2);
    lv_months_count             NUMBER(5,2);
    lv_total_months         NUMBER(2);
    lv_pledgeamt_num       DD_PLEDGE.IDPLEDGE%TYPE;
    lv_remaining_bal    NUMBER(5,2);
    
BEGIN
    SELECT PLEDGEAMT, PAYMONTHS
    INTO lv_month_amt_num, lv_total_months  
    FROM DD_PLEDGE
    WHERE IDPLEDGE = lv_pledge_num;
    lv_month_amt_num  :=lv_pledgeamt_num / lv_total_months;
    FOR i IN 1..lv_total_months  LOOP
      lv_remaining_bal:= lv_pledgeamt_num ;
      lv_payment_due_date:= ADD_MONTHS(lv_payment_due_date,1);
      DBMS_OUTPUT.PUT_LINE(lv_remaining_bal);
      END LOOP;     
END;
/
DECLARE
    lv_pay_due_date             DATE;
    lv_permonth_pay_amnt_num    NUMBER(6,2):=100;
    lv_pledge_owed_num          NUMBER(6,2):=1200;
BEGIN
     LOOP
        DBMS_OUTPUT.PUT_LINE(lv_pledge_owed_num);
        EXIT WHEN lv_pledge_owed_num   = 0;
        lv_pledge_owed_num  :=lv_pledge_owed_num-lv_permonth_pay_amnt_num;
    END LOOP;
END;
/
--ASSIGNMENT 2-11: USING A WHILE LOOP TO DISPLAY TOTAL PAID   ----NEED HELP
DECLARE
    lv_pay_due_date             DATE;
    lv_permonth_pay_amnt_num    NUMBER(6,2):=100;
    lv_pledge_owed_num          NUMBER(6,2):=1200;
BEGIN
    WHILE lv_pledge_owed_num >= 0 LOOP
    DBMS_OUTPUT.PUT_LINE('amount owed: '||lv_pledge_owed_num);
    lv_pledge_owed_num:=lv_pledge_owed_num - lv_permonth_pay_amnt_num ;
    END LOOP;
END;
/
--ASSIGNMENT 2-12: USING A CASE EXPRESSION TO ANSWER 2-9-------HELP NEEDED!
DECLARE
    lv_pay_due_date             DATE;
    lv_permonth_pay_amnt_num    NUMBER(6,2):=100;
    lv_pledge_owed_num          NUMBER(6,2):=1200;
BEGIN
    CASE
        WHEN lv_pledge_owed_num -lv_permonth_pay_amnt_num >= 0 THEN
            lv_pledge_owed_num :=lv_permonth_pay_amnt_num-lv_permonth_pay_amnt_num;
        ELSE 
            lv_pledge_owed_num:= 0;
    END CASE;
    DBMS_OUTPUT.PUT_LINE (lv_pledge_owed_num);
END;
/
DECLARE
    lv_plan_code_num    NUMBER(1)   := 0;
    lv_pledge_amnt_num  NUMBER(6,2) := 1000;
    lv_pay_amnt_num     NUMBER(6,2);
BEGIN
    CASE 
            WHEN lv_plan_code_num= 0 THEN lv_pay_amnt_num:=lv_pledge_amnt_num*.25;
            WHEN lv_plan_code_num= 1 THEN lv_pay_amnt_num:=lv_pledge_amnt_num*.50;
            WHEN lv_plan_code_num= 2 THEN lv_pay_amnt_num:=lv_pledge_amnt_num*1;
            ELSE
            lv_pay_amnt_num:=0;
    END CASE;
    DBMS_OUTPUT.PUT_LINE(lv_pay_amnt_num);
END;
/
DECLARE
    lv_plan_code_num    NUMBER(1)   := 0;
    lv_pledge_amnt_num  NUMBER(6,2) := 1000;
    lv_pay_amnt_num     NUMBER(6,2);
BEGIN
     CASE lv_plan_code_num 
            WHEN 0 THEN lv_pay_amnt_num:=lv_pledge_amnt_num*.25;
            WHEN 1 THEN lv_pay_amnt_num:=lv_pledge_amnt_num*.50;
            WHEN 2 THEN lv_pay_amnt_num:=lv_pledge_amnt_num*1;
            ELSE
            lv_pay_amnt_num:=0;
    END CASE;
    DBMS_OUTPUT.PUT_LINE(lv_pay_amnt_num);
END;
/



--ASSIGNMENT 2-13: USING NESTED IF
DECLARE
    lv_donor_type_code_text      CHAR(1)     :='G';
    lv_pledge_amnt_num           NUMBER(5,2) := 500;
    lv_matching_pledge_num       NUMBER(6,2);
BEGIN
    IF lv_donor_type_code_text = 'I' THEN
        IF lv_pledge_amnt_num >=500 THEN
            lv_matching_pledge_num:=lv_pledge_amnt_num*.20;
        ELSIF lv_pledge_amnt_num >=250 THEN
            lv_matching_pledge_num:=lv_pledge_amnt_num*.30;
        ELSIF lv_pledge_amnt_num >=100 THEN
            lv_matching_pledge_num:=lv_pledge_amnt_num*.50;
        END IF; 
    ELSIF lv_donor_type_code_text = 'B' THEN
        IF lv_pledge_amnt_num >=1000 THEN
            lv_matching_pledge_num:=lv_pledge_amnt_num*.50;
        ELSIF lv_pledge_amnt_num >=500 THEN
            lv_matching_pledge_num:=lv_pledge_amnt_num*.10;
        ELSIF lv_pledge_amnt_num >=100 THEN
            lv_matching_pledge_num:=lv_pledge_amnt_num*.20;
        END IF; 
    ELSIF lv_donor_type_code_text = 'G' THEN
        IF lv_pledge_amnt_num >=100 THEN
            lv_matching_pledge_num:=lv_pledge_amnt_num*.50;
        END IF; 
    END IF;
    DBMS_OUTPUT.PUT_LINE('Donor type:'||lv_donor_type_code_text||'  '||
                        'pledge amount:'||lv_pledge_amnt_num||'  '||
                        'matching %:'||lv_matching_pledge_num);
END;
/


--CASE PROJECTS
--CASE 2-1: FLOWCHARTING
--1. A flowchart is a visual representation of a computer algorithm. it is represented by rectangles and diamond-shaped boxes connected by arrows.
--2. it shows a step by step flow of a process
--3.It can be used in different fields of work orther than computing.
--4.an oval represents a start or end point
--5. an arrow shows the relationship between the variables
--6.a rectangle represents a process
--7.a diamond indicates a decision
--8. a parallelogram represents input or output

--CASE 2-2: WORKING WITH THE MORE MOVIE RENTALS
DECLARE
    lv_number_rentals_num   NUMBER(4):=4;
    lv_rating_txt           VARCHAR2(6);
BEGIN
    CASE
        WHEN lv_number_rentals_num >=35 THEN
            lv_rating_txt:= 'High';
        WHEN lv_number_rentals_num >=21 THEN
            lv_rating_txt:= 'Mid';
        WHEN lv_number_rentals_num >=5 THEN
            lv_rating_txt:= 'Low';
        WHEN lv_number_rentals_num <=5 THEN
            lv_rating_txt:= 'Dump';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Number of Rentals:'||lv_number_rentals_num||'  '||
                        'Rental Rating:'||lv_rating_txt);
END;