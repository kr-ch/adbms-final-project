declare
v_name varchar2(20);
v_is_open_source char(1):='Y';
v_download_site varchar2(100);
v_sql varchar2(2000);
begin
for i in 6..1000 loop
    v_name:='Tech'||i;
    v_download_site:='www.tech'||i||'.com';
    v_sql:=q'{insert into technology(tech_id,name,launch_date,is_open_source,download_site)
              values(:1,:2,:3,:4,:5)}';
    execute immediate v_sql using SEQ_TECHNOLOGY_TECH_ID.nextval,v_name,sysdate,v_is_open_source,v_download_site;
    commit;
  end loop;
end;


--tech stack table 
DECLARE
    v_stack_name VARCHAR2(20);
    v_sql        VARCHAR2(2000);
BEGIN
    FOR i IN 1..500 LOOP
        v_stack_name := 'Tech_Stack' || i;
        v_sql := q'{insert into technology_stack(stack_id,stack_name,stack_sub_id)
              values(:1,:2,:3)}';
        EXECUTE IMMEDIATE v_sql
            USING seq_tech_stack_id.nextval, v_stack_name, seq_tech_stack_sub_id.nextval;
        COMMIT;
    END LOOP;
END;

--subscription table
DECLARE
    v_sub_type      VARCHAR2(20) := 'free';
    v_is_free       CHAR(1) := 'N';
    v_sub_name      VARCHAR2(50);
    v_download_url  VARCHAR2(255);
    v_prerequisites VARCHAR2(4000);
    v_sql           VARCHAR2(2000);
    v_tech_id       NUMBER(10);
BEGIN
    FOR i IN 1..10000 LOOP
        v_sub_name := 'Sub_name' || i;
        v_download_url := 'www.sub.tech'
                          || i
                          || '.com';
        v_prerequisites := 'Tech'
                           || round(dbms_random.value(1, 1000));
        SELECT
            tech_id
        INTO v_tech_id
        FROM
            (
                SELECT
                    tech_id
                FROM
                    technology
                ORDER BY
                    dbms_random.value
            )
        WHERE
            ROWNUM = 1;

        v_sql := q'{insert into subscription(subscription_id, tech_id, sub_type, is_free, sub_name, download_url, prerequisites)
              values(:1,:2,:3,:4,:5,:6,:7)}';
        EXECUTE IMMEDIATE v_sql
            USING seq_subscription_id.nextval, v_tech_id, v_sub_type, v_is_free, v_sub_name, v_download_url, v_prerequisites;

        COMMIT;
    END LOOP;
END;


--use_cases table
DECLARE
    v_use_name        VARCHAR2(50);
    v_prior_knowledge VARCHAR2(255);
    v_scenario_rank   NUMBER(10);
    v_tech_id         NUMBER(10);
    v_sql             VARCHAR2(2000);
BEGIN
    FOR i IN 1..4000 LOOP
        v_use_name := 'use_name' || i;
        v_scenario_rank := '112' || i;
        v_prior_knowledge := 'Tech'
                             || round(dbms_random.value(1, 1000));
        SELECT
            tech_id
        INTO v_tech_id
        FROM
            (
                SELECT
                    tech_id
                FROM
                    technology
                ORDER BY
                    dbms_random.value
            )
        WHERE
            ROWNUM = 1;

        v_sql := q'{insert into use_cases(use_id, tech_id, use_name, scenario_rank, prior_knowledge)
              values(:1,:2,:3,:4,:5)}';
        EXECUTE IMMEDIATE v_sql
            USING seq_use_id.nextval, v_tech_id, v_use_name, v_scenario_rank, v_prior_knowledge;
        COMMIT;
    END LOOP;
END;
