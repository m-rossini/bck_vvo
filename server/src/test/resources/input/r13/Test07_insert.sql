  CREATE TABLE R13_NEGOT_PRICE (                                           
  ACCT_NBR                       VARCHAR2(64),                             
  SBSCRP_ID                      VARCHAR2(64),                             
  SVC_PRICE_SEQ_NBR              VARCHAR2(64),                             
  SVC_NAME                       VARCHAR2(64),                             
  OBJID                          VARCHAR2(64),                             
  CHARGE_TYPE                    VARCHAR2(64),                             
  EFFECTIVE_DATE                 DATE,                                     
  EXPIRATION_DATE                DATE,                                     
  SCENARIO_ID                    VARCHAR2(64),                             
  FREE_UNITS_ID                  NUMBER,                                   
  INITIAL_UNIT_VALUE             NUMBER,                                   
  INITIAL_UNIT_QTY               NUMBER,                                   
  INITIAL_UNIT_TYPE              VARCHAR2(64),
  INITIAL_UNIT_INCL_QTY	         NUMBER,                                   
  STEP_UNIT_VALUE                NUMBER,                                   
  STEP_UNIT_QTY                  NUMBER,                                   
  STEP_UNIT_TYPE                 VARCHAR2(64),                             
  STEP_UNIT_INCL_QTY             NUMBER,                                   
  NEGOTIABLE_FLAG                VARCHAR2(64),                             
  PASSTHROUGH_FLAG               VARCHAR2(64),                             
  SP_AREA_ID                     VARCHAR2(64),                             
  TAX_CODE                       NUMBER,                                   
  UPDATED_DATE                   DATE,                                     
  CUSTOM_1                       VARCHAR2(64),                             
  CUSTOM_2                       VARCHAR2(64),                             
  CUSTOM_3                       VARCHAR2(64),
  NEGOT_PCT                      NUMBER,
  NEGOT_TYPE_CD                  VARCHAR2(64),
  NEGOT_TAX_INCL_FLAG            VARCHAR2(64)); 

insert into R13_NEGOT_PRICE values ('0121741645','0121741616','1846761','PLANO FLEXIVEL','0','R',to_date('20020922','yyyymmdd'), to_date('20061023','yyyymmdd'),'1846761','0','0,00000000','0','MONTHLY',                                    '0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4',                                    to_date('20080319', 'yyyymmdd'),'','','','100','D','N');
insert into R13_NEGOT_PRICE values ('0121741645','0121741616','1846761','PLANO FLEXIVEL','0','R',to_date('20061024','yyyymmdd'), to_date('20070325','yyyymmdd'),'1846761','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4', to_date('20080319','yyyymmdd'),'','','','100','D','N');
insert into R13_NEGOT_PRICE values ('0121741645','0121741616','1846761','PLANO FLEXIVEL','0','R',to_date('20070326','yyyymmdd'), to_date('20070702','yyyymmdd'),'1846761','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4', to_date('20080319','yyyymmdd'),'','','','0','A','Y');
insert into R13_NEGOT_PRICE values ('0121741645','0121741616','79755930','PLANO FLEXIVEL','0','R',to_date('20070703','yyyymmdd'),'','79755930','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4',to_date('20080319','yyyymmdd'),'','','','100','D','N');
insert into R13_NEGOT_PRICE values ('2012203880','0121741616','1846761','PLANO FLEXIVEL','0','R',to_date('20061024','yyyymmdd'), to_date('20070325','yyyymmdd'),'1846761','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4', to_date('20080319','yyyymmdd'),'','','','100','D','N');
insert into R13_NEGOT_PRICE values ('2012203880','0121741616','1846761','PLANO FLEXIVEL','0','R',to_date('20070326','yyyymmdd'), to_date('20070702','yyyymmdd'),'1846761','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4', to_date('20080319','yyyymmdd'),'','','','0','A','Y');
insert into R13_NEGOT_PRICE values ('2012203880','0121741616','1938471','PAC GESTAO COMPLETO','0','R',to_date('20070426','yyyymmdd'),'','1938471','0','0,00000000','0','MONTHLY','0,0000','0,00000000','0','MONTHLY','0,0000','Y','N','TELERJ','4',to_date('20080319','yyyymmdd'),'','','','0','A','Y');
insert into R13_NEGOT_PRICE values ('2012203880','0121741616','1846761','PLANO FLEXIVEL','0','R',to_date('20060926','yyyymmdd'), to_date('20061023','yyyymmdd'),'1846761','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4', to_date('20080319','yyyymmdd'),'','','','100','D','N');
insert into R13_NEGOT_PRICE values ('2012203880','0121741616','79755930','PLANO FLEXIVEL','0','R',to_date('20070703','yyyymmdd'),'','79755930','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4',to_date('20080319','yyyymmdd'),'','','','100','D','N');
insert into R13_NEGOT_PRICE values ('2015929210','0121741616','1846761','PLANO FLEXIVEL','0','R',to_date('20070326','yyyymmdd'), to_date('20070702','yyyymmdd'),'1846761','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4', to_date('20080319','yyyymmdd'),'','','','0','A','Y');
insert into R13_NEGOT_PRICE values ('2015929210','0121741616','79755930','PLANO FLEXIVEL','0','R',to_date('20070703','yyyymmdd'),'','79755930','0','0,00000000','0','MONTHLY','0,5000','0,00000000','0','MONTHLY','0,1000','Y','N','TELERJ','4',to_date('20080319','yyyymmdd'),'','','','100','D','N');
