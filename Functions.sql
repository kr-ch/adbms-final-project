CREATE OR REPLACE FUNCTION f_certification_price (
    v_id IN NUMBER,
    ind  IN CHAR
) RETURN NUMBER IS

    v_tech_id NUMBER(10);
    v_cert_id NUMBER(10);
    v_ind     CHAR(1) := ind;
    v_price   NUMBER(10, 3);
BEGIN
    IF v_ind = 'S' THEN
        v_cert_id := v_id;
    ELSIF v_ind = 'F' THEN
        v_tech_id := v_id;
    ELSE
        NULL;
    END IF;

    IF
        v_tech_id IS NULL
        AND v_cert_id IS NOT NULL
        AND v_ind = 'S'
    THEN
        SELECT
            price
        INTO v_price
        FROM
            certification
        WHERE
            cert_id = v_cert_id;

    ELSIF
        v_tech_id IS NOT NULL
        AND v_cert_id IS NULL
        AND v_ind = 'F'
    THEN
        SELECT
            SUM(c.price)
        INTO v_price
        FROM
            certification c,
            technology    t
        WHERE
                t.tech_id = v_tech_id
            AND c.tech_id = t.tech_id;

    END IF;

    IF v_price IS NOT NULL THEN
        RETURN v_price;
    ELSE
        RETURN -9;
    END IF;
END;
/

--Testing script START
select f_certification_price(1190000,'F') from dual
select f_certification_price(1890864,'S') from dual;
--Testing script ENDS


--f_learning_price Function
CREATE OR REPLACE FUNCTION f_learning_price (
    id IN NUMBER,
    ind  IN CHAR
) RETURN NUMBER IS

    v_tech_id NUMBER(10);
    v_learn_id NUMBER(10);
    v_ind     CHAR(1) := ind;
    v_price   NUMBER(10, 3);
BEGIN
    IF v_ind = 'S' THEN
        v_learn_id := id;
    ELSIF v_ind = 'F' THEN
        v_tech_id := id;
    END IF;

    IF
        AND v_learn_id IS NOT NULL
        AND v_ind = 'S'
    THEN
        SELECT
            price
        INTO v_price
        FROM
            learning
        WHERE
            learn_id = v_learn_id;

    ELSIF
        v_tech_id IS NOT NULL
        AND v_ind = 'F'
    THEN
        SELECT
            SUM(l.price)
        INTO v_price
        FROM
            learning l,
            technology    t
        WHERE
                t.tech_id = v_tech_id
            AND l.tech_id = l.tech_id;

    END IF;

    IF v_price IS NOT NULL THEN
        RETURN v_price;
    ELSE
        RETURN -9;
    END IF;
END;

--Testing script START
select f_learning_price(1190000,'F') from dual
select f_learning_price(1692929,'S') from dual;
--Testing script ENDS



--f_search_customer function
CREATE OR REPLACE FUNCTION f_search_customer (
    v_name IN VARCHAR2
) RETURN VARCHAR2 IS
    v_full_name VARCHAR2(100);
BEGIN
    IF v_name IS NOT NULL THEN
        SELECT
            first_name || ' ' || last_name
        INTO
            v_full_name
        FROM
            customers c
        WHERE
            c.first_name = v_name OR
            c.last_name = v_name;
        RETURN v_full_name;
    ELSE
        RETURN -9;
    END IF;
END;
/

--Testing script START
select f_search_customer('First_name347') from dual
select f_search_customer('Last_name347') from dual;
--Testing script END