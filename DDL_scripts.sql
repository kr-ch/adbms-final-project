DROP TABLE tech_stack_map;
CREATE TABLE tech_stack_map (
    tech_id  NUMBER(10),
    stack_id NUMBER(10)
);

DROP TABLE use_cases;
CREATE TABLE use_cases (
    use_id          NUMBER(10),
    tech_id         NUMBER(10) NOT NULL,
    use_name        VARCHAR2(50) NOT NULL,
    scenario_rank   NUMBER(10),
    prior_knowledge VARCHAR2(255) NOT NULL 
);

DROP TABLE tech_comp_map;
CREATE TABLE tech_comp_map (
    tech_id NUMBER(10) NOT NULL,
    comp_id NUMBER(10) NOT NULL
);

DROP TABLE local_address;
CREATE TABLE local_address (
    local_add_id       NUMBER(10),
    cust_id            NUMBER(10) NOT NULL,
    country_add_id     NUMBER(10) NOT NULL,
    street_name        VARCHAR2(50),
    apartment_num      NUMBER(10),
    office_num         NUMBER(10),
    building_num       NUMBER(10) NOT NULL,
    building_name      VARCHAR2(50),
    landmark           VARCHAR2(255),
    phone              NUMBER(10) NOT NULL,
    isd_code           NUMBER(5),
    is_current_address CHAR(1)
);

DROP TABLE customers;
CREATE TABLE customers (
    cust_id      NUMBER(10),
    initial_name VARCHAR2(10),
    first_name   VARCHAR2(50) NOT NULL,
    middle_name  VARCHAR2(50),
    last_name    VARCHAR2(50) NOT NULL
);


DROP TABLE technology_stack;
CREATE TABLE technology_stack (
    stack_id     NUMBER(10),
    stack_name   VARCHAR2(50) NOT NULL,
    stack_sub_id NUMBER(10) NOT NULL
);

DROP TABLE learning;
CREATE TABLE learning (
    learn_id   NUMBER(10),
    tech_id    NUMBER(10) NOT NULL,
    learn_mode VARCHAR2(10),
    reg_url    VARCHAR2(255) NOT NULL,
    is_free    CHAR(1),
    price      NUMBER(10, 3) NOT NULL
);

DROP TABLE subscription;
CREATE TABLE subscription (
    subscription_id NUMBER(10),
    tech_id         NUMBER(10) NOT NULL,
    sub_type        VARCHAR2(20) NOT NULL,
    is_free         CHAR(1),
    sub_name        VARCHAR2(50) NOT NULL,
    download_url    VARCHAR2(255) NOT NULL,
    prerequisites   VARCHAR2(4000) NOT NULL
);

DROP TABLE certification;
CREATE TABLE certification (
    cert_id          NUMBER(10),
    tech_id          NUMBER(10) NOT NULL,
    cert_code        VARCHAR2(20),
    cert_name        VARCHAR2(50) NOT NULL,
    cert_path_id     NUMBER(2),
    cert_seq_in_path NUMBER(2),
    registration_url VARCHAR2(255) NOT NULL,
    price            NUMBER(10) NOT NULL,
    currency         VARCHAR2(3),
    exam_mode        VARCHAR2(20) NOT NULL,
    exam_duration    NUMBER(3) NOT NULL,
    duration_unit    VARCHAR2(10) NOT NULL
);

DROP TABLE technology_type;
CREATE TABLE technology_type (
    tech_id NUMBER(10),
    type_id NUMBER(10),
    type    VARCHAR2(20) NOT NULL
);

DROP TABLE client_companies;
CREATE TABLE client_companies (
    comp_id        NUMBER(10),
    country_add_id NUMBER(10),
    comp_name      VARCHAR2(255),
    business_type  VARCHAR2(50) NOT NULL
);

DROP TABLE owner_companies;
CREATE TABLE owner_companies (
    o_comp_id      NUMBER(10),
    tech_id        NUMBER(10),
    country_add_id NUMBER(10),
    name           VARCHAR2(50)
);

DROP TABLE country_address;
CREATE TABLE country_address (
    country_add_id NUMBER(10),
    country        VARCHAR2(50),
    state          VARCHAR2(50),
    city           VARCHAR2(50),
    area_code      NUMBER(10),
    zipcode        VARCHAR2(10) NOT NULL
);

DROP TABLE technology;
CREATE TABLE technology (
    tech_id        NUMBER(10),
    name           VARCHAR2(50),
    launch_date    DATE,
    is_open_source CHAR(1),
    download_site  VARCHAR2(4000) NOT NULL
);

ALTER TABLE technology ADD CONSTRAINT pk_tech_id PRIMARY KEY ( tech_id );

ALTER TABLE technology_stack ADD CONSTRAINT pk_stack_id PRIMARY KEY ( stack_id );

ALTER TABLE technology_stack ADD CONSTRAINT u_stack_sub_id UNIQUE ( stack_sub_id );

ALTER TABLE customers ADD CONSTRAINT pk_cust_id PRIMARY KEY ( cust_id );

ALTER TABLE tech_stack_map
    ADD CONSTRAINT fk_stack_map_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE tech_stack_map
    ADD CONSTRAINT fk_stack_map_stack_id FOREIGN KEY ( stack_id )
        REFERENCES technology_stack ( stack_id );

ALTER TABLE use_cases ADD CONSTRAINT pk_use_id PRIMARY KEY ( use_id );

ALTER TABLE use_cases
    ADD CONSTRAINT fk_use_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE learning ADD CONSTRAINT pk_learn_id PRIMARY KEY ( learn_id );

ALTER TABLE learning
    ADD CONSTRAINT fk_learn_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE subscription ADD CONSTRAINT pk_subscription_id PRIMARY KEY ( subscription_id );

ALTER TABLE subscription
    ADD CONSTRAINT fk_sub_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE certification ADD CONSTRAINT pk_certification_id PRIMARY KEY ( cert_id );

ALTER TABLE certification
    ADD CONSTRAINT fk_cert_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE certification ADD CONSTRAINT u_cert_path_id UNIQUE ( cert_path_id );

ALTER TABLE technology_type ADD CONSTRAINT pk_tech_type_id PRIMARY KEY ( type_id );

ALTER TABLE technology_type
    ADD CONSTRAINT fk_type_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE country_address ADD CONSTRAINT pk_country_add_id PRIMARY KEY ( country_add_id );

ALTER TABLE client_companies ADD CONSTRAINT pk_cli_comp_id PRIMARY KEY ( comp_id );

ALTER TABLE client_companies
    ADD CONSTRAINT fk_cli_comp_add_id FOREIGN KEY ( country_add_id )
        REFERENCES country_address ( country_add_id );

ALTER TABLE owner_companies ADD CONSTRAINT pk_owner_comp_id PRIMARY KEY ( o_comp_id );

ALTER TABLE owner_companies
    ADD CONSTRAINT fk_own_comp_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE owner_companies
    ADD CONSTRAINT fk_own_comp_add_id FOREIGN KEY ( country_add_id )
        REFERENCES country_address ( country_add_id );

ALTER TABLE tech_comp_map
    ADD CONSTRAINT fk_comp_map_comp_id FOREIGN KEY ( comp_id )
        REFERENCES client_companies ( comp_id );

ALTER TABLE tech_comp_map
    ADD CONSTRAINT fk_comp_map_tech_id FOREIGN KEY ( tech_id )
        REFERENCES technology ( tech_id );

ALTER TABLE local_address ADD CONSTRAINT pk_loc_add_id PRIMARY KEY ( local_add_id );

ALTER TABLE local_address
    ADD CONSTRAINT fk_loc_add_cust_id FOREIGN KEY ( cust_id )
        REFERENCES customers ( cust_id );

ALTER TABLE local_address
    ADD CONSTRAINT fk_loc_add_count_add_id FOREIGN KEY ( country_add_id )
        REFERENCES country_address ( country_add_id );
        
create sequence SEQ_TECHNOLOGY_TECH_ID	start with 1190000 increment by 1 nocycle;
create sequence SEQ_TECH_STACK_ID	start with 1290000 increment by 1 nocycle;
create sequence SEQ_TECH_STACK_SUB_ID start with	1390000 increment by 1 nocycle;
create sequence SEQ_CUST_ID	start with 1490000 increment by 1 nocycle;
create sequence SEQ_USE_ID	start with 1590000 increment by 1 nocycle;
create sequence SEQ_LEARN_ID start with	1690000 increment by 1 nocycle;
create sequence SEQ_SUBSCRIPTION_ID	start with 1790000 increment by 1 nocycle;
create sequence SEQ_CERT_ID	start with 1890000 increment by 1 nocycle;
create sequence SEQ_SCERT_PATH_ID start with 1990000 increment by 1 nocycle;
create sequence SEQ_TYPE_ID	start with 2190000 increment by 1 nocycle;
create sequence SEQ_COUNTRY_ADD_ID	start with 2290000 increment by 1 nocycle;
create sequence SEQ_OWN_COMP_ID	start with 2390000 increment by 1 nocycle;
create sequence SEQ_LOC_COMP_ID	start with 2490000 increment by 1 nocycle;
create sequence SEQ_LOC_ADD_ID	start with 2590000 increment by 1 nocycle;

        