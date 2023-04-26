CREATE OR REPLACE VIEW v_customer_master AS
    SELECT
        c.first_name,
        c.middle_name,
        c.last_name,
        la.street_name,
        la.building_num,
        la.phone,
        ca.country,
        ca.state,
        ca.city,
        ca.zipcode
    FROM
        customers       c
        LEFT JOIN local_address   la ON ( c.cust_id = la.cust_id )
        LEFT JOIN country_address ca ON ( la.country_add_id = ca.country_add_id );

--v_technology_master View
CREATE OR REPLACE VIEW v_technology_master AS
    SELECT
        a.name          AS technology_name,
        a.launch_date,
        a.is_open_source,
        b.stack_name    AS tech_stack_name,
        d.use_name      AS use_case,
        d.prior_knowledge,
        e.type          AS technology_type,
        f.name          AS owner_company,
        g.comp_name     AS client_company,
        g.business_type AS client_business
    FROM
        technology       a
        LEFT JOIN tech_stack_map   c ON ( c.tech_id = a.tech_id )
        LEFT JOIN technology_stack b ON ( b.stack_id = c.stack_id )
        LEFT JOIN use_cases        d ON ( a.tech_id = d.tech_id )
        LEFT JOIN technology_type  e ON ( a.tech_id = e.tech_id )
        LEFT JOIN owner_companies  f ON ( a.tech_id = f.tech_id )
        LEFT JOIN tech_comp_map    h ON ( a.tech_id = h.tech_id )
        LEFT JOIN client_companies g ON ( g.comp_id = h.comp_id );


--v_subscription_master View
CREATE OR REPLACE VIEW v_subscription_master AS
    SELECT
        s.sub_type AS subscription_type,
        s.is_free,
        s.sub_name AS subscription_name,
        s.download_url,
        t.name AS technology_name,
        t.launch_date,
        t.is_open_source,
        tt.type AS technology_type,
        ts.stack_name AS tech_stack_name
    FROM
        subscription       s
        LEFT JOIN technology t ON ( t.tech_id = s.tech_id )
        LEFT JOIN technology_type tt ON ( tt.tech_id = s.tech_id )
        LEFT JOIN tech_stack_map tsm ON ( tsm.tech_id = s.tech_id )
        LEFT JOIN technology_stack ts ON ( ts.stack_id = tsm.stack_id )
