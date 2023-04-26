CREATE OR REPLACE PROCEDURE p_insert_learning (
    p_tech_id    IN NUMBER,
    p_learn_mode IN VARCHAR2,
    p_reg_url    IN VARCHAR2,
    p_price      NUMBER,
    p_message    OUT VARCHAR2
) IS
    v_is_free CHAR(1);
    v_cnt     NUMBER(2);
BEGIN
    SELECT
        COUNT(1)
    INTO v_cnt
    FROM
        technology
    WHERE
        tech_id = p_tech_id;

    IF v_cnt > 0 THEN
        IF p_price IS NULL OR p_price = 0 THEN
            v_is_free := 'Y';
        ELSE
            v_is_free := 'N';
        END IF;

        INSERT INTO learning (
            learn_id,
            tech_id,
            learn_mode,
            reg_url,
            is_free,
            price
        ) VALUES (
            seq_learn_id.NEXTVAL,
            p_tech_id,
            p_learn_mode,
            p_reg_url,
            v_is_free,
            p_price
        );

        COMMIT;
        p_message := 'Added Successfully!!!';
    ELSE
        p_message := 'First insert Teechnology';
    END IF;

END;
/

--Test Scrip STARTS
set serveroutput on
declare
v_out varchar2(50);
begin
p_insert_learning (1190000,'Online', 'www.learning_new.com', 200.35, v_out);
dbms_output.put_line(v_out);
end;
--Test script ENDS

--Subscription table stored procedure
CREATE OR REPLACE PROCEDURE p_insert_subscription (
    v_tech_id     IN NUMBER,
    sub_type      IN VARCHAR2,
    is_free       IN CHAR,
    sub_name      IN VARCHAR2,
    download_url  IN VARCHAR2,
    prerequisites IN VARCHAR2,
    p_message     OUT VARCHAR2
) IS
    v_cnt NUMBER(2);
BEGIN
    SELECT
        COUNT(1)
    INTO v_cnt
    FROM
        technology
    WHERE
        tech_id = v_tech_id;

    IF v_cnt > 0 THEN
        INSERT INTO subscription (
            subscription_id,
            tech_id,
            sub_type,
            is_free,
            sub_name,
            download_url,
            prerequisites
        ) VALUES (
            seq_subscription_id.NEXTVAL,
            v_tech_id,
            sub_type,
            is_free,
            sub_name,
            download_url,
            prerequisites
        );

        COMMIT;
        p_message := 'Added Successfully!!!';
    ELSE
        p_message := 'First insert Technology';
    END IF;

END;
/

--Test Scrip p_insert_subscription STARTS
set serveroutput on

DECLARE
    v_out VARCHAR2(50);
BEGIN
    p_insert_subscription(1190000, 'SubType', 'Y', 'Premium', 'www.subTyype.com/subscriptionPremium',
                         'No Prerequisites', v_out);
    dbms_output.put_line(v_out);
END;
--Test script ENDS



--p_update_cert_price procedure
CREATE OR REPLACE PROCEDURE p_update_cert_price (
    p_cert_id     IN NUMBER,
    p_price       IN NUMBER
    p_message     OUT VARCHAR2
) IS
    v_cnt NUMBER(2);
BEGIN
    SELECT
        COUNT(1)
    INTO v_cnt
    FROM
        certification
    WHERE
        cert_id = p_tech_id;

    IF v_cnt > 0 THEN
        IF p_price IS NULL OR p_price = 0 THEN
            --TO DO
        END IF;
        UPDATE certification
        SET price = p_price
        WHERE cert_id = p_cert_id;
        COMMIT;
        p_message := 'Updated Successfully!!!';
    ELSE
        p_message := 'Provide correct certificate ID';
    END IF;

END;
/

--Test Scrip p_update_cert_price START
set serveroutput on

DECLARE
    v_out VARCHAR2(50);
BEGIN
    p_update_cert_price(1890801, 0, v_out);
    dbms_output.put_line(v_out);
END;
--Test script END