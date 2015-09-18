insert into r52_cust (first_name, cust_id) values('LIG TEST SERVIÇOS ELETRICOS S/C LTDA', '0001')    
insert into r52_cust_addr values('R ATIBAIA', '700', 'AP 611', 'BL 6', 'COLONIA', '13219', '300', 'JUNDIAI', 'SP', '', '0001', '1', '20070921', '20071018')
insert into r52_cust_idntfc values ('CNPJ', '0001', '03728290000182')
insert into r52_sbscrp_asgm values ('0031461888', '20070921', '20071018')
insert into r52_cust_acct values ('0001', '1', '0031461888')

create table r52_sbscrp_asgm (
    acct_nbr VARCHAR2(50),
    sbscrp_asgm_expr_dt VARCHAR2(20),
    sbscrp_asgm_eff_dt VARCHAR2(20) 
)

create table r52_cust_acct (
    cust_id VARCHAR2(50),
    acct_nbr VARCHAR2(50),
    mlng_addr_seq_nbr VARCHAR2(50)        
)

create table r52_cust_idntfc (
    cust_id VARCHAR2(30),
    cust_id_text VARCHAR2(30),
    cust_idntfc_type_cd VARCHAR2(20)      
)

create table r52_cust (
    bus_name VARCHAR2(50),
    first_name VARCHAR2(50),
    middle_name VARCHAR2(50),
    last_name VARCHAR2(50),
    cust_id VARCHAR2(50)
)

create table r52_cust_addr (
    addr_expr_dt VARCHAR2(20),
    addr_eff_dt VARCHAR2(20),
    street_name VARCHAR2(50),
    house_nbr VARCHAR2(50),
    delvry_1_text VARCHAR2(50),
    delvry_2_text VARCHAR2(50),
    county_name VARCHAR2(50),
    postal_cd VARCHAR2(50),
    postal_plus_cd VARCHAR2(50),
    city_name VARCHAR2(50),
    state_cd VARCHAR2(50),
    POST_OFFICE_BOX_NBR VARCHAR2(50),
    cust_id VARCHAR2(50),
    addr_seq_nbr VARCHAR2(50)
)







