create table r55_negotiable_products(
    OBJID			number(19,0) not null,
    SBSCRP_ID			varchar2(20),
    SVC_NAME 			varchar2(50),    
    NEGOT_INIT_CHARGE_AMT	varchar2(20),
    NEGOT_ADTNL_CHARGE_AMT	varchar2(20),
    BASE_PRICE_AMT		varchar2(20),
    SVC_AGRMNT_TRMNTN_DT	varchar2(20),
    SVC_AGRMNT_EFF_DT		varchar2(20),
    NEGOT_EFF_DT		varchar2(20),	
    NEGOT_EXPR_DT		varchar2(20),
    SVC_PRICE_SEQ_NBR		varchar2(20)
);

ALTER TABLE r55_negotiable_products ADD CONSTRAINT r55_negotiable_products_PK
	 PRIMARY KEY (OBJID);