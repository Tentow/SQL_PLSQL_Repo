--CHAPTER THREE HANDLING DATA IN PL/SQL BLOCKS
/
SET SERVEROUTPUT ON;
/
--CHALLENGE 3-1
DECLARE
    lv_cardnum_num  NUMBER(15);
    lv_cardtype_num    CHAR(1);
    lv_basket_num   NUMBER(3) := 10;
BEGIN

SELECT cardnumber, cardtype
    INTO lv_cardnum_num,lv_cardtype_num
   FROM bb_basket
    WHERE Idbasket = lv_basket_num;
    
    DBMS_OUTPUT.PUT_LINE('card number:'||lv_cardnum_num||
                        ' '||'card type:'||lv_cardtype_num|| 
                        ' '||'basket id:'||lv_basket_num);

END;
/
--Using the %TYPE Attribute

DECLARE
        lv_basket_num bb_basket.idBasket%TYPE;
        lv_created_date bb_basket.dtcreated%TYPE;
        lv_qty_num bb_basket.quantity%TYPE;
        lv_sub_num bb_basket.subtotal%TYPE;
        lv_days_num NUMBER(3);
BEGIN
        SELECT idBasket, dtcreated, quantity, subtotal
        INTO lv_basket_num, lv_created_date, lv_qty_num, lv_sub_num
        FROM bb_basket
        WHERE idShopper = 25
        AND orderplaced = 0;
        
        lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;
        
        DBMS_OUTPUT.PUT_LINE(lv_basket_num || ' * ' ||
        lv_created_date || ' * ' || lv_qty_num || ' * ' ||
        lv_sub_num || ' * ' || lv_days_num);
END;
/
--CHALLENGE 3-2
DECLARE
    lv_cardnum_num      bb_basket.cardnumber%TYPE;
    lv_cardtype_num     bb_basket.cardtype%TYPE;
    lv_basket_num       bb_basket.idbasket%TYPE := 10;
BEGIN

SELECT cardnumber, cardtype
    INTO lv_cardnum_num,lv_cardtype_num
   FROM bb_basket
    WHERE Idbasket = lv_basket_num;
    
    DBMS_OUTPUT.PUT_LINE('card number:'||lv_cardnum_num||
                        ' '||'card type:'||lv_cardtype_num|| 
                        ' '||'basket id:'||lv_basket_num);

END;
/

--CHALLENGE 3-3
DECLARE
    lv_cardnum_num      bb_basket.cardnumber%TYPE;
    lv_cardtype_num     bb_basket.cardtype%TYPE;
    lv_basket_num       bb_basket.idbasket%TYPE := 10;
BEGIN

SELECT cardnumber, cardtype
    INTO lv_cardnum_num,lv_cardtype_num
   FROM bb_basket
    WHERE Idbasket = lv_basket_num;
    
    IF lv_cardtype_num = 'V' THEN
            DBMS_OUTPUT.PUT_LINE('shopper used credit card type of '||lv_cardtype_num);
        ELSIF lv_cardtype_num = 'X' THEN
            DBMS_OUTPUT.PUT_LINE('shopper used credit card type of '||lv_cardtype_num);
        ELSIF lv_cardtype_num = 'M' THEN
            DBMS_OUTPUT.PUT_LINE('shopper used credit card type of '||lv_cardtype_num);
       ELSE 
            DBMS_OUTPUT.PUT_LINE('No credit card type indicated'||lv_cardtype_num);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('card number:'||lv_cardnum_num||
                        ' '||'card type:'||lv_cardtype_num|| 
                        ' '||'basket id:'||lv_basket_num);

END;

/

--CHALLENGE 3-4
DECLARE
    lv_cardnum_num      bb_basket.cardnumber%TYPE;
    lv_cardtype_num     bb_basket.cardtype%TYPE;
    lv_basket_num       bb_basket.idbasket%TYPE := 10;
BEGIN

SELECT cardnumber, cardtype
    INTO lv_cardnum_num,lv_cardtype_num
   FROM bb_basket
    WHERE Idbasket = lv_basket_num;
    
   CASE lv_cardtype_num
        WHEN 'V' THEN
            DBMS_OUTPUT.PUT_LINE('shopper used credit card type of '||lv_cardtype_num);
         WHEN  'X' THEN
            DBMS_OUTPUT.PUT_LINE('shopper used credit card type of '||lv_cardtype_num);
         WHEN 'M' THEN
            DBMS_OUTPUT.PUT_LINE('shopper used credit card type of '||lv_cardtype_num);
       ELSE 
            DBMS_OUTPUT.PUT_LINE('No credit card type indicated'||lv_cardtype_num);
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('card number:'||lv_cardnum_num||
                        ' '||'card type:'||lv_cardtype_num|| 
                        ' '||'basket id:'||lv_basket_num);

END;

/

-- RECORD DATA TYPE
DECLARE
     TYPE type_basket IS RECORD(
     basket bb_basket.idBasket%TYPE,
     created bb_basket.dtcreated%TYPE,
     qty bb_basket.quantity%TYPE,
     sub bb_basket.subtotal%TYPE);
     
     rec_basket type_basket;
     
     lv_days_num NUMBER(3);
     lv_shopper_num NUMBER(3) := 25;
     
BEGIN
     SELECT idBasket, dtcreated, quantity, subtotal
     INTO rec_basket
     FROM bb_basket
     WHERE idShopper = lv_shopper_num
     AND orderplaced = 0;
     
    lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
    
     DBMS_OUTPUT.PUT_LINE(rec_basket.basket ||'*'||
     rec_basket.created ||'*'|| rec_basket.qty
     ||'*'|| rec_basket.sub ||'*'|| lv_days_num);
END;
/

-- the %ROWTYPE Attribute

DECLARE
    rec_shopper bb_shopper%ROWTYPE;
    
BEGIN
    SELECT *
    INTO rec_shopper
    FROM bb_shopper
    WHERE idshopper = 25;
    
    DBMS_OUTPUT.PUT_LINE(rec_shopper.lastname);
    DBMS_OUTPUT.PUT_LINE(rec_shopper.address);
    DBMS_OUTPUT.PUT_LINE(rec_shopper.email);
END;
/
--CHALLENGE 3-7
DECLARE
    TYPE type_basket  IS RECORD(
        cardnum_num      bb_basket.cardnumber%TYPE,
        cardtype_num     bb_basket.cardtype%TYPE,
        basket_num       bb_basket.idbasket%TYPE);
        
        rec_basket type_basket;
        
        lv_basket_num   NUMBER(3) :=10;
    
BEGIN
 
SELECT cardnumber, cardtype, idbasket
    INTO rec_basket
   FROM bb_basket
    WHERE Idbasket = lv_basket_num ;
    
    DBMS_OUTPUT.PUT_LINE('card number:'||rec_basket.cardnum_num||
                        ' '||'card type:'||rec_basket.cardtype_num|| 
                        ' '||'basket id:'||rec_basket.basket_num);

END;
/


--CHALLENGE 3-8

DECLARE
    rec_basketitem      bb_basketitem%ROWTYPE;
    
    lv_idbasket_num     NUMBER(3) := 4;
BEGIN
    SELECT * 
       INTO rec_basketitem 
    FROM bb_basketitem
    WHERE idbasket =  lv_idbasket_num ;
    
    DBMS_OUTPUT.PUT_LINE('basket id: '||rec_basketitem.idbasket);
    DBMS_OUTPUT.PUT_LINE('product id: '||rec_basketitem.idproduct);
    DBMS_OUTPUT.PUT_LINE('price: '|| rec_basketitem.price);
    
END;
/

--Record Operations

DECLARE
    rec_dept bb_department%ROWTYPE;
BEGIN
    rec_dept.iddepartment := 4;
    rec_dept.deptname := 'Teas';
    rec_dept.deptdesc := 'Premium teas';    
    
    DBMS_OUTPUT.PUT_LINE(rec_dept.deptname);
END;
/

DECLARE
    rec_dept bb_department%ROWTYPE;
BEGIN
    rec_dept.iddepartment := 4;
    rec_dept.deptname := 'Teas';
    rec_dept.deptdesc := 'Premium teas';    
    
    INSERT INTO bb_department
        VALUES rec_dept;
    COMMIT;
END;
/

DECLARE
    rec_department     bb_department%ROWTYPE;
    
BEGIN 
    rec_department.iddepartment := 5;
    rec_department.deptname := 'coffee';
    rec_department.deptdesc := 'coffee for children';
    
    INSERT INTO bb_department
        VALUES rec_department;
        
    COMMIT;
END;
/

DECLARE
    rec_department   BB_department%ROWTYPE;
    
BEGIN
    rec_department.iddepartment := 4;
    rec_department.deptname :='teas';
    rec_department.deptdesc := 'premiun teas';
    rec_department.deptimage := 'tea.gif';
    
    UPDATE bb_department
     SET ROW = rec_department
     WHERE iddepartment = rec_department.iddepartment;
     
    COMMIT;

END;
/


DECLARE
    rec_dept       bb_department%ROWTYPE;

BEGIN
    rec_dept.iddepartment := 5;
    rec_dept.DEPTNAME := 'coffee';
    rec_dept.DEPTDESC := 'coffee for children';
    rec_dept.DEPTIMAGE := 'coffee.gif';
    
    UPDATE BB_DEPARTMENT
        SET ROW = rec_dept
        WHERE IDDEPARTMENT = rec_dept.IDDEPARTMENT;
        
    COMMIT;

END;


/
DECLARE
    rec_dept       bb_department%ROWTYPE;

BEGIN
    rec_dept.iddepartment := 5;
    rec_dept.DEPTNAME := 'coffee';
    rec_dept.DEPTDESC := 'coffee for children';
    rec_dept.DEPTIMAGE := 'coffee.gif';
    
    UPDATE BB_DEPARTMENT
        SET ROW = rec_dept
        WHERE IDDEPARTMENT = rec_dept.IDDEPARTMENT
        RETURNING iddepartment, DEPTNAME, DEPTDESC ,DEPTIMAGE 
            INTO rec_dept;
    DBMS_OUTPUT.PUT_LINE(rec_dept.iddepartment);
    DBMS_OUTPUT.PUT_LINE(rec_dept.DEPTNAME);
    DBMS_OUTPUT.PUT_LINE(rec_dept.DEPTDESC);
    DBMS_OUTPUT.PUT_LINE(rec_dept.DEPTIMAGE);
END;
/


--WORKING WITH COLLECTIONS

DECLARE
    TYPE type_roast IS TABLE OF NUMBER           --ASOCIATIVE ARRAY DATA
    INDEX BY BINARY_INTEGER;                     --TYPE DECLARATION
    
    tbl_roast  type_roast;                       --ASSOCIATIVE ARRAY VARIABLE DECLARATION
    
     lv_tot_num NUMBER := 0;
     lv_cnt_num NUMBER := 0;
     lv_avg_num NUMBER;
     lv_samp1_num NUMBER(5,2) := 6.22;
     lv_samp2_num NUMBER(5,2) := 6.13;             --INITIALIZING VERIABLES
     lv_samp3_num NUMBER(5,2) := 6.27;
     lv_samp4_num NUMBER(5,2) := 6.16;
     lv_samp5_num NUMBER(5,2);

BEGIN
     tbl_roast(1) := lv_samp1_num;
     tbl_roast(2) := lv_samp2_num;
     tbl_roast(3) := lv_samp3_num;           --POPULATING THE TABLE VARIABLES
     tbl_roast(4) := lv_samp4_num;
     tbl_roast(5) := lv_samp5_num;
    
     FOR i IN 1..tbl_roast.COUNT LOOP
        IF tbl_roast(i) IS NOT NULL THEN
          lv_tot_num := lv_tot_num + tbl_roast(i);
          lv_cnt_num := lv_cnt_num + 1;
        END IF;
    END LOOP;
    
     lv_avg_num := lv_tot_num / lv_cnt_num;
     
    DBMS_OUTPUT.PUT_LINE(lv_tot_num);
    DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
    DBMS_OUTPUT.PUT_LINE(tbl_roast.COUNT);
    DBMS_OUTPUT.PUT_LINE(lv_avg_num);
    
END;
/ 

--Table of Records

DECLARE

    TYPE type_basketitems IS TABLE OF bb_basketitem%ROWTYPE
    INDEX BY BINARY_INTEGER;
 
    tbl_items type_basketitems;
    
    lv_ind_num      NUMBER(3)                       := 1;
    lv_id_num       bb_basketitem.idproduct%TYPE    := 7;
    lv_price_num    bb_basketitem.price%TYPE           := 10.80;
    lv_qty_num      bb_basketitem.quantity%TYPE        := 2;
    lv_opt1_num     bb_basketitem.option1%TYPE         := 2;
    lv_opt2_num     bb_basketitem.option2%TYPE         := 3;
 
BEGIN

    tbl_items(lv_ind_num).idproduct     := lv_id_num;
    tbl_items(lv_ind_num).price         := lv_price_num;
    tbl_items(lv_ind_num).quantity      := lv_qty_num;
    tbl_items(lv_ind_num).option1       := lv_opt1_num;
    tbl_items(lv_ind_num).option2       := lv_opt2_num;
    
    DBMS_OUTPUT.PUT_LINE(lv_ind_num);
    DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).idproduct);
    DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).price);

END;
/

--INTRODUCTION TO BULK PROCESSING
--using bulk processing to display the of product names
--with the type 'E'.
DECLARE
    TYPE type_product IS TABLE OF bb_product%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    tbl_product     type_product;

BEGIN
    
    SELECT *
     BULK COLLECT
      INTO tbl_product 
       FROM bb_product
        WHERE type = 'E';
       
    FOR i IN 1..tbl_product.COUNT LOOP
       DBMS_OUTPUT.PUT_LINE(tbl_product(i).productname);
    END LOOP;

END;
/

-- using bulkk processing to display the price list and 
--total price of all products that the quantity commanded = 1
DECLARE 
    
    TYPE type_basket IS TABLE OF bb_basketitem%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    tbl_basketitem  type_basket;
     
    lv_tot_num     NUMBER(5,2) :=0;
    
BEGIN

    SELECT *
      BULK COLLECT
        INTO tbl_basketitem
         FROM bb_basketitem
           WHERE QUANTITY = 1;

    FOR i IN 1..tbl_basketitem.COUNT LOOP
     IF tbl_basketitem IS NOT NULL THEN
        lv_tot_num := lv_tot_num + tbl_basketitem(i).price;
         DBMS_OUTPUT.PUT_LINE('product price= '||tbl_basketitem(i).price);
     END IF;
    END LOOP;
        
          DBMS_OUTPUT.PUT_LINE('total price of products = '||lv_tot_num);
END;
/

--Using bulk processing to display the name and adress of
--all shoppers living in Virginia.

DECLARE

    TYPE type_shop IS TABLE OF bb_shopper%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    tb1_shopper         type_shop;
    
BEGIN

    SELECT * --firstname, lastname, address
      BULK COLLECT
       INTO tb1_shopper
        FROM bb_shopper
        WHERE STATE = 'VA';
        
    FOR i IN 1..tb1_shopper.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('firstname: '||tb1_shopper(i).firstname||' *'
                            ||'lastname: '||tb1_shopper(i).lastname||' *'
                            ||'address: '||tb1_shopper(i).address||' *'
                            ||'state: '||tb1_shopper(i).state);
        
    END LOOP;

END;
/

--GOTO STATEMENTS
BEGIN
IF lv_rows_num = 0 THEN
GOTO insert_row;
END IF;
...
...
<<insert_row>>
INSERT INTO bb_basket (idBasket)
VALUES (bb_basket_seq.NEXTVAL);
...
...
END
/

-- REVIE QUESTIONS
--MCQS


--1 C 
--2 A
--3 B
--4 A
--5 C
--6 C
--7 C
--8 A
--9 A
--10 B
--11 VARIABLES ARE NAMED STRUCTURES. THEY ARE NEEDED TO HOLD VALUES FOR 
-----SUBSEQUENT RETRIEVAL OR MANIPULATION 

--12 THE SELECT STATEMENT IS DIFFERENT WHEN USED IN A PL/SQL BLOCK IN THAT
-----IT MUST CONTAIN AN "INTO" CLAUSE.

--13 THE %TYPE ATTRIBUTE IS USED TO RETRIEVE THE CORRECT DATA TYPE FROM THE DATABASE
-----ON THE TABLE AND COLUMN SELECTED

--14 COMPOSITE DATA TYPES ALLOW VARIABLES TO HOLD MORE THAN ONE VALUE AS
------AS A UNIT, UNLIKE SCALAR VARIABLES.

--15 THE %ROWTYPE ATTRIBUTE IS A WAY TO DECLARE A RECORD VARIABLE DATA TYPE
------BASED ON A TABLE


--ADVANCED REVIEW QUESTIONS (MCQs)


--1 B
--2 C
--3 B
--4 C
--5 B


-- HANDS-ON ASSIGNMENTS PART I


--ASSIGNMENT 3-1  Querying data in a block

DECLARE
    
    lv_date      BB_BASKETSTATUS.DTSTAGE%TYPE; 
    lv_shipper   BB_BASKETSTATUS.SHIPPER%TYPE;
    lv_shipping# BB_BASKETSTATUS.SHIPPINGNUM%TYPE;
    lv_basket_id  BB_BASKETSTATUS.IDBASKET%TYPE      := 3;
    
BEGIN

    SELECT DTSTAGE,SHIPPER, SHIPPINGNUM, IDBASKET
     INTO lv_date, lv_shipper, lv_shipping#, lv_basket_id 
      FROM BB_BASKETSTATUS
       WHERE IDBASKET = lv_basket_id
                AND IDSTAGE = 5;
    
    DBMS_OUTPUT.PUT_LINE('date shipped:' ||lv_date);
    DBMS_OUTPUT.PUT_LINE('shipper: '||lv_shipper);
    DBMS_OUTPUT.PUT_LINE('shipping number: '||lv_shipping#);
    --DBMS_OUTPUT.PUT_LINE(lv_basket_id);
END;
/

--running the block above with basket id 7. this returns a "no data found" error because the the 
--order has not yet been shipped.
DECLARE
    
    lv_date      BB_BASKETSTATUS.DTSTAGE%TYPE; 
    lv_shipper   BB_BASKETSTATUS.SHIPPER%TYPE;
    lv_shipping# BB_BASKETSTATUS.SHIPPINGNUM%TYPE;
    lv_basket_id  BB_BASKETSTATUS.IDBASKET%TYPE      := 7;
    
BEGIN

    SELECT DTSTAGE,SHIPPER, SHIPPINGNUM, IDBASKET
     INTO lv_date, lv_shipper, lv_shipping#, lv_basket_id 
      FROM BB_BASKETSTATUS
       WHERE IDBASKET = lv_basket_id
                AND IDSTAGE = 5;
    
    DBMS_OUTPUT.PUT_LINE('date shipped:' ||lv_date);
    DBMS_OUTPUT.PUT_LINE('shipper: '||lv_shipper);
    DBMS_OUTPUT.PUT_LINE('shipping number: '||lv_shipping#);
    --DBMS_OUTPUT.PUT_LINE(lv_basket_id);
END;
/

--ASSIGNMENT 3-2 Using a record variable 

DECLARE
    
    rec_shipstatus      bb_basketstatus%ROWTYPE;
    
    lv_basket_id        bb_basketstatus.idbasket%TYPE  :=3;   
    
BEGIN
    SELECT *
      INTO rec_shipstatus
       FROM bb_basketstatus
        WHERE idbasket = lv_basket_id
            AND idstage = 5;

      DBMS_OUTPUT.PUT_LINE('date shipped:' ||rec_shipstatus.DTSTAGE);
      DBMS_OUTPUT.PUT_LINE('shipper: '||rec_shipstatus.SHIPPER);
      DBMS_OUTPUT.PUT_LINE('shipping number: '||rec_shipstatus.SHIPPINGNUM);
      DBMS_OUTPUT.PUT_LINE('notes: '||rec_shipstatus.NOTES);
END;
/

--Assignment 3-3: Processing Database Data with IF Statements


DECLARE

    lv_shopper_id       bb_basket.IDSHOPPER%TYPE := 26;
    lv_total_num        bb_basket.TOTAL%TYPE;
    lv_rating_txt       VARCHAR2(5);
BEGIN
    SELECT SUM(TOTAL)
     INTO lv_total_num 
      FROM BB_BASKET
       WHERE IDSHOPPER = lv_shopper_id
            AND orderplaced = 1;
            
    IF lv_total_num > 200 THEN 
            lv_rating_txt := 'high';
        ELSIF lv_total_num > 100 THEN 
            lv_rating_txt := 'mid';
        ELSIF lv_total_num <= 100 THEN 
            lv_rating_txt := 'low';
    END IF;
       
    DBMS_OUTPUT.PUT_LINE('total: '||lv_total_num );
    DBMS_OUTPUT.PUT_LINE('the customer is rated: '||lv_rating_txt);
END;
/

SELECT SUM(TOTAL)
FROM BB_BASKET
WHERE IDSHOPPER = 21
    AND orderplaced = 1;
/
SELECT *
FROM BB_BASKET
/


--Assignment 3-4: Using Searched CASE Statements

DECLARE

    lv_shopper_id       bb_basket.IDSHOPPER%TYPE := 26;
    lv_total_num        bb_basket.TOTAL%TYPE;
    lv_rating_txt       VARCHAR2(5);
BEGIN
    SELECT SUM(TOTAL)
     INTO lv_total_num 
      FROM BB_BASKET
       WHERE IDSHOPPER = lv_shopper_id
            AND orderplaced = 1;
    CASE        
        WHEN lv_total_num > 200 THEN 
                lv_rating_txt := 'high';
        WHEN lv_total_num > 100 THEN 
                lv_rating_txt := 'mid';
        WHEN lv_total_num <= 100 THEN 
                lv_rating_txt := 'low';
        ELSE
            DBMS_OUTPUT.PUT_LINE('customer has no active orders');
    END CASE;
       
    DBMS_OUTPUT.PUT_LINE('total: '||lv_total_num );
    DBMS_OUTPUT.PUT_LINE('the customer is rated: '||lv_rating_txt);
END;
/


--Assignment 3-5: Using a WHILE Loop

DECLARE
    
    lv_amt_available        NUMBER(5,2) :=100;
    lv_product_id           bb_product.idproduct%TYPE := 4;
    lv_price                bb_product.price%TYPE;
    lv_cnt_num              NUMBER(5) := 1;
BEGIN

    SELECT IDproduct, price
         INTO lv_product_id,lv_price 
          FROM bb_product
           WHERE IDPRODUCT = lv_product_id;
                 
    WHILE lv_amt_available  >= lv_price LOOP 
    
        WHILE lv_amt_available >= lv_price LOOP
        
    DBMS_OUTPUT.PUT_LINE('number of purchasable items: '||lv_cnt_num||' *'||
                        'product price is: '||lv_price||' *'||
                        'your balance is: '||lv_amt_available);
                        
    lv_amt_available := lv_amt_available - lv_price;
    
    lv_cnt_num := lv_cnt_num +1;
    
        END LOOP;
     END LOOP;
   
END;
/
SELECT IDproduct, price
FROM bb_product
WHERE idproduct = 6;
/
SELECT*
FROM bb_product;

/



--Assignment 3-6: Working with IF Statements

DECLARE

    quantity_num    bb_basket.QUANTITY%TYPE;
    basket_id       bb_basket.IDBASKET%TYPE := 5;
    lv_shipcost_num NUMBER(5,2);

BEGIN

    SELECT QUANTITY, IDBASKET
     INTO quantity_num, basket_id
      FROM bb_basket
        WHERE IDBASKET = basket_id;
        
    IF quantity_num <= 3 THEN
            lv_shipcost_num := 5;
       ELSIF quantity_num <= 6 THEN
            lv_shipcost_num := 7.5;
       ELSIF quantity_num <= 10 THEN
            lv_shipcost_num := 10;
       ELSIF quantity_num > 10 THEN
        lv_shipcost_num := 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('The quantity of items for customer# '||basket_id
                        ||' is '||quantity_num
                        ||' and the shipping cost is '||lv_shipcost_num);
END;
/

DECLARE

    quantity_num    bb_basket.QUANTITY%TYPE;
    basket_id       bb_basket.IDBASKET%TYPE := 12;
    lv_shipcost_num NUMBER(5,2);

BEGIN

    SELECT QUANTITY, IDBASKET
     INTO quantity_num, basket_id
      FROM bb_basket
        WHERE IDBASKET = basket_id;
        
    IF quantity_num <= 3 THEN
            lv_shipcost_num := 5;
       ELSIF quantity_num <= 6 THEN
            lv_shipcost_num := 7.5;
       ELSIF quantity_num <= 10 THEN
            lv_shipcost_num := 10;
       ELSIF quantity_num > 10 THEN
        lv_shipcost_num := 12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('The quantity of items for customer# '||basket_id
                        ||' is '||quantity_num
                        ||' and the shipping cost is '||lv_shipcost_num);
END;
/


--Assignment 3-7: Using Scalar Variables for Data Retrieval

DECLARE

    basket_id            bb_basket.idbasket%TYPE   := 12;
    subtot_num           bb_basket.subtotal%TYPE;
    ship_num             bb_basket.shipping%TYPE;
    tax_num              bb_basket.tax%TYPE;
    total_num            bb_basket.total%TYPE;

BEGIN
    
    SELECT idbasket, subtotal, shipping, tax, total 
     INTO basket_id,subtot_num,ship_num,tax_num,total_num
      FROM bb_basket
        WHERE idbasket = basket_id;
        
    DBMS_OUTPUT.PUT_LINE('basket id: '||basket_id);
    DBMS_OUTPUT.PUT_LINE('subtotal: '||subtot_num);
    DBMS_OUTPUT.PUT_LINE('shipping cost: '||ship_num);
    DBMS_OUTPUT.PUT_LINE('tax: '||tax_num);
    DBMS_OUTPUT.PUT_LINE('total: '||total_num);

END;
/

SELECT idbasket, subtotal, shipping, tax, total 
FROM bb_basket
WHERE idbasket = 12 ;
/


--Assignment 3-8: Using a Record Variable for Data Retrieval

DECLARE
    rec_basket          bb_basket%ROWTYPE;
    basket_id_num       bb_basket.idbasket%TYPE := 12;

BEGIN
    SELECT *
     INTO rec_basket
       FROM bb_basket
         WHERE idbasket = basket_id_num;
         
    DBMS_OUTPUT.PUT_LINE('basket id: '||rec_basket.idbasket);
    DBMS_OUTPUT.PUT_LINE('subtotal: '||rec_basket.subtotal);
    DBMS_OUTPUT.PUT_LINE('shipping cost: '||rec_basket.shipping);
    DBMS_OUTPUT.PUT_LINE('tax: '||rec_basket.tax);
    DBMS_OUTPUT.PUT_LINE('total: '||rec_basket.total);

END;
/

SELECT idbasket, subtotal, shipping, tax, total 
FROM bb_basket
WHERE idbasket = 12 ;
/


--Hands-On Assignments Part II
A--ssignment 3-9: Retrieving Pledge Totals
DECLARE
    
    idproj_num                  DD_PROJECT.IDPROJ%TYPE := 501;
    projname_txt                DD_PROJECT.PROJNAME%TYPE;
    number_pledges_num       DD_PLEDGE.IDPLEDGE%TYPE;
    sum_pledgeamt_num        DD_PLEDGE.PLEDGEAMT%TYPE;
    avg_pledge_num           DD_PLEDGE.PLEDGEAMT%TYPE;

BEGIN

    SELECT IDPROJ,PROJNAME, COUNT(IDPLEDGE),
            SUM(PLEDGEAMT), ROUND(AVG(PLEDGEAMT),2)
        INTO idproj_num,projname_txt,number_pledges_num,
            sum_pledgeamt_num, avg_pledge_num     
        FROM dd_project INNER JOIN dd_pledge
        USING (idproj)
        WHERE idproj = idproj_num
        GROUP BY IDPROJ,PROJNAME;
        
        DBMS_OUTPUT.PUT_LINE('project id: '||idproj_num||' *'||
                            'project name: '||projname_txt||' *'||
                            'number of pledges made: '||number_pledges_num||' *'||
                             'total dollars pledged: '||sum_pledgeamt_num||' *'|| 
                             ' average pledge amount: '||avg_pledge_num);

END;
/
SELECT* FROM dd_pledge;

/
SELECT IDPROJ,PROJNAME, COUNT(IDPLEDGE) "number of pledges made",
        SUM(PLEDGEAMT) "total pledgeamt", ROUND(AVG(PLEDGEAMT),2)"avg pledgeamt"
FROM dd_project INNER JOIN dd_pledge
 USING (idproj)
WHERE idproj = 500
GROUP BY IDPROJ,PROJNAME;

/

--Assignment 3-10: Adding a Project

--creating a SEQUENCE for project table

CREATE SEQUENCE dd_projid_seq
START WITH 530
INCREMENT BY 1
NOCACHE;

--querrying sequence nextval on project id
SELECT dd_projid_seq.NEXTVAL
FROM DUAL;
/
DECLARE
    
    rec_project         dd_project%ROWTYPE;
    
BEGIN
   
  
     rec_project.IDPROJ        := dd_projid_seq.NEXTVAL;
     rec_project.PROJNAME      := 'HK Animal Shelter Extension';
     rec_project.PROJSTARTDATE := TO_DATE('1/1/2013', 'mm/dd/yyyy');
     rec_project.PROJENDDATE   := TO_DATE('5/31/2013', 'mm/dd/yyyy');
     rec_project.PROJFUNDGOAL  := 65000;
    
        
    INSERT INTO DD_PROJECT
        VALUES rec_project
    RETURNING IDPROJ, PROJNAME, PROJSTARTDATE, PROJENDDATE, PROJFUNDGOAL
        INTO rec_project.IDPROJ,rec_project.PROJNAME,rec_project.PROJSTARTDATE, rec_project.PROJENDDATE, rec_project.PROJFUNDGOAL;
        
    COMMIT;

        
    DBMS_OUTPUT.PUT_LINE('project ID :'||rec_project.IDPROJ);
    DBMS_OUTPUT.PUT_LINE(' project name :'||rec_project.PROJNAME);
    DBMS_OUTPUT.PUT_LINE('start :'||rec_project.PROJSTARTDATE);
    DBMS_OUTPUT.PUT_LINE('end :'||rec_project.PROJENDDATE);
    DBMS_OUTPUT.PUT_LINE('fundraising goal :'||rec_project.PROJFUNDGOAL);
END;
/

--querrying project table to display updated column
SELECT IDPROJ, PROJNAME, PROJSTARTDATE, PROJENDDATE, PROJFUNDGOAL
FROM dd_project
WHERE projid =530;
/


--Assignment 3-11: Retrieving and Displaying Pledge Data

DECLARE

    rec_pledge          dd_pledge%ROWTYPE;
    lv_pledge_id_num    dd_pledge.idpledge%TYPE := 100 ;

BEGIN
    
    SELECT * --IDPLEDGE, iddonor, pledgeamt, paymonths
     INTO rec_pledge--.IDPLEDGE,rec_pledge.iddonor,rec_pledge.pledgeamt,rec_pledge.paymonths
      FROM dd_pledge
       WHERE IDPLEDGE = lv_pledge_id_num
       ORDER BY paymonths;
       
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '||rec_pledge.IDPLEDGE||' '||
                        'donor ID: '||rec_pledge.iddonor||' '||
                        ' pledge amount: '||rec_pledge.pledgeamt||' '||
                        'number of months for payment: '||rec_pledge.paymonths);

END;        ----HOW DO WE DISPLAY MANY ROWS AT THE SAME TIME IN THIS CODE?
/


SELECT IDPLEDGE, iddonor, pledgeamt, pledgeamt, paymonths
FROM dd_pledge
ORDER BY paymonths;

SELECT *
FROM dd_pledge;
/


--Assignment 3-12: Retrieving a Specific Pledge

DECLARE

    rec_pledge          dd_pledge%ROWTYPE;
    rec_payment         dd_payment%ROWTYPE;
    lv_pledge_id_num    dd_pledge.idpledge%TYPE := 104;
    lv_sum_payamt_num   NUMBER(5,2);
    lv_balance_num      NUMBER(5,2);
    

BEGIN
    
    SELECT IDPLEDGE, iddonor, pledgeamt, paymonths,SUM(payamt), pledgeamt-SUM(payamt)
     INTO rec_pledge.IDPLEDGE,rec_pledge.iddonor,rec_pledge.pledgeamt,rec_pledge.paymonths,
                    lv_sum_payamt_num, lv_balance_num 
      FROM dd_pledge INNER JOIN dd_payment USING
                (IDPLEDGE)
       WHERE IDPLEDGE = lv_pledge_id_num
        GROUP BY IDPLEDGE, iddonor, pledgeamt, paymonths;
       
    DBMS_OUTPUT.PUT_LINE('Pledge ID: '||rec_pledge.IDPLEDGE||' '||
                        'donor ID: '||rec_pledge.iddonor||' '||
                        ' pledge amount: '||rec_pledge.pledgeamt||' '||
                        ' total paid: '||lv_sum_payamt_num||' '||
                        ' total balance: '||lv_balance_num) ;
END;      
/

SELECT IDPLEDGE, iddonor, pledgeamt, paymonths,SUM(payamt), pledgeamt-SUM(payamt)
     --INTO rec_pledge--.IDPLEDGE,rec_pledge.iddonor,rec_pledge.pledgeamt,rec_pledge.paymonths
      FROM dd_pledge INNER JOIN dd_payment USING
                (IDPLEDGE)
       WHERE IDPLEDGE = 104
       GROUP BY IDPLEDGE, iddonor, pledgeamt, paymonths;
/
SELECT *
FROM dd_payment;
/


--Assignment 3-13: Modifying Data        --HELP NEEDED. CAN'T DISPLAY PREVIOUS FUND RAISING GOAL

SELECT IDPROJ, projname, projstartdate, projfundgoal
FROM DD_PROJECT;

SELECT*
FROM DD_PROJECT;
/


--Case Projects
--Case 3-1: Using Variable Types
--* scalar variables can hold just one value at a time
--* record variables can hold multiple columns of variables 
--* table variables can hold all the values in a given table ---CLARIFICATION NEED HERE



--Case 3-2: Working with More Movie Rentals

DECLARE
 
    rec_movie           MM_MOVIE%ROWTYPE;
    rec_rental          MM_RENTAL%ROWTYPE;
    movie_id_num        mm_movie.movie_id%TYPE   := 4;
    lv_rating_txt       VARCHAR2(5);
    lv_count_num        CHAR(3);        
    

BEGIN

    SELECT MOVIE_TITLE, COUNT(CHECKOUT_DATE)
     INTO rec_movie.MOVIE_TITLE, lv_count_num
      FROM MM_MOVIE INNER JOIN MM_RENTAL 
            USING (MOVIE_ID)
       WHERE MOVIE_ID =movie_id_num 
        GROUP BY MOVIE_TITLE;

    IF lv_count_num < 5 THEN 
            lv_rating_txt := 'dump';
        ELSIF lv_count_num <= 20 THEN 
            lv_rating_txt := 'low';
        ELSIF lv_count_num <= 35 THEN 
            lv_rating_txt := 'mid';
        ELSIF lv_count_num > 35 THEN 
            lv_rating_txt := 'high';
        ELSE 
        DBMS_OUTPUT.PUT_LINE('movie has never been rented');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('the movie titled ' ||'"'||rec_movie.MOVIE_TITLE||'" '|| 
                        'is rated ' ||'"'||lv_rating_txt||'" '||
                        'based on the number of rental counts');

END;
/

SELECT MOVIE_TITLE, COUNT(CHECKOUT_DATE)
FROM MM_MOVIE INNER JOIN MM_RENTAL 
        USING (MOVIE_ID)
WHERE MOVIE_ID =11 
GROUP BY MOVIE_TITLE;

SELECT COUNT(CHECKOUT_DATE)
FROM MM_RENTAL
WHERE MOVIE_ID = 11;

/


DECLARE
 
    rec_movie           MM_MOVIE%ROWTYPE;
    rec_rental          MM_RENTAL%ROWTYPE;
    movie_id_num        mm_movie.movie_id%TYPE   := 25;
    lv_rating_txt       VARCHAR2(5);
    lv_count_num        CHAR(3);        
    

BEGIN

    SELECT MOVIE_TITLE, COUNT(CHECKOUT_DATE)
     INTO rec_movie.MOVIE_TITLE, lv_count_num
      FROM MM_MOVIE INNER JOIN MM_RENTAL 
            USING (MOVIE_ID)
       WHERE MOVIE_ID =movie_id_num 
        GROUP BY MOVIE_TITLE;

    IF lv_count_num < 5 THEN 
            lv_rating_txt := 'dump';
        ELSIF lv_count_num <= 20 THEN 
            lv_rating_txt := 'low';
        ELSIF lv_count_num <= 35 THEN 
            lv_rating_txt := 'mid';
        ELSIF lv_count_num > 35 THEN 
            lv_rating_txt := 'high';
        ELSE 
        DBMS_OUTPUT.PUT_LINE('movie has never been rented');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('the movie titled ' ||'"'||rec_movie.MOVIE_TITLE||'" '|| 
                        'is rated ' ||'"'||lv_rating_txt||'" '||
                        'based on the number of rental counts');

END;        --CAN'T Add exception handlers for errors I can and can’t anticipate.
/

