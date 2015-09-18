--dados de conta para execucao Query1

create table r74_sharing_service(                                        
    OBJID						number(19,0) not null, 
    ACCT_NBR					varchar2(20),
    CYCLE_CD					varchar2(2),
    SBSCRP_ID					varchar2(20),
    CAPTN_TEXT					varchar2(50),
    SVC_NAME 					varchar2(50),
    FREE_USAGE_ACROSS_ACCT_IND  varchar2(2),
    ACCESS_NBR_RQR_FLAG         varchar2(2),
    LEADER_SBSCRP_ID            varchar2(20),
    USAGE_ACUM_SEQ_NBR          varchar2(20),
    COMM_SVC_AREA_ID			varchar2(20),    
    CHARGE_TYPE_CD				varchar2(2),
    SBSCRP_ASGM_EFF_DT			varchar2(20),
    SBSCRP_ASGM_EXPR_DT         varchar2(20),
    SVC_AGRMNT_EFF_DT			varchar2(20),
    SVC_AGRMNT_TRMNTN_DT		varchar2(20),
    SBSCRP_SVC_EFF_DT  			varchar2(20),
    SBSCRP_SVC_EXPR_DT 			varchar2(20) 
);                                                                          
                                                                            
ALTER TABLE r74_sharing_service ADD CONSTRAINT r74_sharing_service_PK
	 		PRIMARY KEY (OBJID);
	
-- Tabela de teste para conta Não TIT-DEP - Para execucao Query2	 		
create table r74_sharing_plan(                                        
    OBJID						number(5,0) not null, 
    SVC_NAME 					varchar2(50),
    USAGE_ACUM_SEQ_NBR          varchar2(20),
    ACCESS_NBR_RQR_FLAG         varchar2(2),    
    COMM_SVC_AREA_ID			varchar2(20),    
    SVC_PRICE_EFF_DT			varchar2(10),
    SVC_PRICE_EXPR_DT			varchar2(10)
);                                                                          
                                                                            
ALTER TABLE r74_sharing_plan ADD CONSTRAINT r74_sharing_plan_PK
	 		PRIMARY KEY (OBJID);

commit;
