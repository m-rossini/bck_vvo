-------------TABLES-------------------

-- controle de processo batch
--alteracao de layout
drop table BILLCHKOW.BCK_CONTROL_BATCH;

CREATE TABLE BILLCHKOW.BCK_CONTROL_BATCH 
(          
    OBJID              NUMBER(19,0)     NOT NULL,    
    JOB_NAME           VARCHAR2(64)             ,
    JOB_REQ            VARCHAR2(64)             ,
    CYCLE_CODE         VARCHAR2(64)             , 
    CYCLE_DT           DATE                     ,    
    FILE_NAME          VARCHAR2(128)            ,
    PATH_NAME          VARCHAR2(128)            ,
    EXECUTED_FLAG      VARCHAR2(1)  
);

--Tabela OutPut Parameters
CREATE TABLE  BILLCHKOW.ast_param_config
    (objid                          NUMBER(14,0) NOT NULL,
    value                          VARCHAR2(512) NOT NULL,
    module_name                    VARCHAR2(32) NOT NULL,
    short_description              VARCHAR2(32),
    description                    VARCHAR2(256));

-- Constraints for AST_PARAM_CONFIG
ALTER TABLE  BILLCHKOW.ast_param_config
ADD CONSTRAINT  ast_param_config_pk PRIMARY KEY (objid);

---------Receita Diaria---------------

CREATE TABLE BILLCHKOW.FIN_CUSTOMER_TYPE_DM
    (CUSTOMER_TYPE                  VARCHAR2(1),
    CUSTOMER_DESCRIPTION           VARCHAR2(48),
    DUE_DATE                       VARCHAR2(15),
    CUSTOMER_CLASS                 VARCHAR2(20));

CREATE TABLE BILLCHKOW.FIN_DR_FACT 
(
    STATE                   VARCHAR2(10) NOT NULL,
    PROC_DT                 DATE,
    CYCLE_CD                VARCHAR2(10) NOT NULL,
    FAT_DT                  DATE,
    CALL_DT                 DATE,
    CSP                     VARCHAR2(10),
    CAPTION_TEXT            VARCHAR2(100),
    CALL_DIRECTION          VARCHAR2(10),
    CALL_SENT               VARCHAR2(10),
    CALL_HOR                VARCHAR2(10),
    CALL_AREA               VARCHAR2(10),
    SVC_NAME                VARCHAR2(100),
    QTT_CALLS               NUMBER(19),
    DUR_CALLS               NUMBER(19),
    DUR_BILLING_CALLS       NUMBER(19),
    DUR_FRANQ_CALLS         NUMBER(19),
    QTT_PROMO_CALLS         NUMBER(19),
    AMOUNT_GROSS_CALLS      NUMBER(10,2),
    AMOUNT_LIQ_CALLS        NUMBER(10,2),    
    AMOUNT_FRANQ_CALLS      NUMBER(10,2),      
    AMOUNT_LIQ_FRANQ_CALLS  NUMBER(10,2),  
    AMOUNT_PROMO_CALLS      NUMBER(10,2),
    AMOUNT_LIQ_PROMO_CALLS  NUMBER(10,2),
    LN_BILLING              NUMBER(10,2)
);

CREATE TABLE BILLCHKOW.FIN_DR_AUX_FACT 
(
    CYCLE_DT              DATE,
    CYCLE_CD              VARCHAR2(10),
    CARRIER               VARCHAR2(100),
    CALL_DT               DATE,
    QTT_CALLS             NUMBER(19),
    STATE                 VARCHAR2(10),
    STATUS                VARCHAR2(10)
);

-- Index
CREATE INDEX BILLCHKOW.FIN_DR_STATE_IDX ON BILLCHKOW.FIN_DR_FACT
  (
    STATE                  ASC
  );

CREATE INDEX BILLCHKOW.FIN_DR_CYCLECD_IDX ON BILLCHKOW.FIN_DR_FACT
  (
    CYCLE_CD                  ASC
  );

CREATE INDEX BILLCHKOW.FIN_DR_SVCNAME_IDX ON BILLCHKOW.FIN_DR_FACT
  (
    SVC_NAME                  ASC
  );

--------------CAPTION CODE--------------
CREATE TABLE billchkow.fin_jm_capt_fact
    (account_number                 VARCHAR2(10) NOT NULL,
    captn_cd                       VARCHAR2(7) NOT NULL,
    charge_cr_amt                  NUMBER(14,2),
    uf                             VARCHAR2(2) NOT NULL,
    cycle_cd                       VARCHAR2(2) NOT NULL,
    last_bill_date                 DATE,
    acct_type_cd                   VARCHAR2(40),
    debito_e                       DATE);

CREATE TABLE billchkow.fin_jm_demand_fact
    (account_number                 VARCHAR2(10),
    uf                             VARCHAR2(2),
    area                           VARCHAR2(128),
    reason                         VARCHAR2(32),
    eff_dt                         DATE,
    exp_dt                         DATE);

CREATE TABLE billchkow.fin_jm_jm_fact
    (account_number                 VARCHAR2(10) NOT NULL,
    doc_state                      VARCHAR2(2) NOT NULL,
    cycle_code                     VARCHAR2(2) NOT NULL,
    cycle_cut_date                 DATE,
    doc_ref                        VARCHAR2(6),
    doc_due_dt                     DATE,
    doc_past_due_dt                DATE,
    qtt_del_dt                     NUMBER(18,0),
    recv_dt                        DATE,
    bill_pymt_due_dt               DATE,
    pnlty_intrst_type_id           VARCHAR2(5) NOT NULL,
    long_dstn_carr_id              VARCHAR2(4),
    pnlty_intrst_amt               NUMBER(14,2));
    
CREATE INDEX billchkow.fin_jm_acc_idx ON billchkow.fin_jm_jm_fact
  (
    account_number                  ASC
  );
CREATE INDEX billchkow.fin_jm_cap_idx ON billchkow.fin_jm_jm_fact
  (
    pnlty_intrst_type_id            ASC
  );
CREATE INDEX billchkow.fin_jm_cycle_idx ON billchkow.fin_jm_jm_fact
  (
    cycle_code                      ASC
  );
  
CREATE INDEX billchkow.fin_jm_state_idx ON billchkow.fin_jm_jm_fact
  (
    doc_state                       ASC
  );

-- Tabela de CAPTION_CODE
CREATE TABLE billchkow.fin_captioncode_fact
    (caption_cd                     VARCHAR2(8),
    acct_nbr                       VARCHAR2(10),
    sbscrp_id                      VARCHAR2(10),
    access_nbr                     VARCHAR2(10),
    svc_name                       VARCHAR2(20),
    invn_charge_cr_amt             NUMBER(18,2),
    prcng_comm_uf                  VARCHAR2(10),
    cy                             VARCHAR2(2),
    last_bil                       DATE,
    acct_type_desc                 VARCHAR2(40),
    debito_e                       DATE,
    svc_agrmnt_seq_                VARCHAR2(15),
    svc_price_seq_n                VARCHAR2(15),
    svc_agrm                       DATE);
  
-- Tabela de Expurgo
CREATE TABLE billchkow.fin_expurgo_fact
    (acct_nbr                       VARCHAR2(10),
    access_nbr                     VARCHAR2(10),
    cycle_id                       VARCHAR2(2));
  
-- Tabela de Churn
CREATE TABLE billchkow.fin_churn_fact
    (acct_nbr                       VARCHAR2(10),
    class_cred                     VARCHAR2(2),
    cpf_cnpj                       NUMBER(14,0),
    dat_fat_old                    DATE,
    saldo_pendente                 NUMBER(17,2),
    enter_date                     DATE,
    access_nbr                     VARCHAR2(10),
    dat_habil                      DATE,
    dat_expr                       DATE,
    uf                             VARCHAR2(2),
    chanel                         VARCHAR2(32),
    recision_id                    VARCHAR2(2),
    pf_pj                          VARCHAR2(2));

-- Tabela para o arquivo de entrada do Held Bill
CREATE TABLE BILLCHKOW.FIN_HELDBILL_FACT (   
   acct_nbr          		varchar2(30) 		,
   csa                      varchar2(30)        ,
   uf                       varchar2(2)         ,
   acct_status              varchar2(1)         ,
   cod_motivo_retencao      varchar2(10)        ,
   acct_cycle               varchar2(2)         ,
   las_bill_dt              date                ,
   valor_faturado           number(17,2));

CREATE TABLE BILLCHKOW.FIN_LD_TRAFEGO_FACT
    (TARIFA                         VARCHAR2(50),
    DESCRIPTION                    VARCHAR2(20),
    DESC_DET                       VARCHAR2(20));

CREATE TABLE BILLCHKOW.FIN_LD_ORIGINAL_FACT
    (ACCT_CONTABIL                 VARCHAR2(20),
    SVC_NAME                       VARCHAR2(20),
    STATE_CD                       VARCHAR2(2),
    TYPE_                          VARCHAR2(80),
    MINUTOS                        NUMBER(20,0),
    TOTAL_CALLS                    NUMBER(20,0),
    VALUE_CALLS                    NUMBER(18,2),
    CYCLE_CD                       VARCHAR2(2),
    CYCLE_DT                       DATE,
    PROC_FLAG                      VARCHAR2(1));

CREATE TABLE BILLCHKOW.FIN_LD_DEPARA_FACT
    (ACCT_CONTABIL                 VARCHAR2(20),
    SVC_NAME                       VARCHAR2(20),
    REPASSE                        VARCHAR2(10),
    TYPE_                          VARCHAR2(80));

CREATE TABLE BILLCHKOW.FIN_CCI_INVOICED
    (CAPTN_CD                       VARCHAR2(32),
    GEO_ID                         VARCHAR2(2),
    CYCLE_ID                       VARCHAR2(2),
    AMOUNT                         NUMBER(17,2),
    QTT_CALLS                      NUMBER(19,0),
    TOT_SECONDS                    NUMBER(19,0),
    TOT_MINUTES                    NUMBER(17,2),
    LAST_BILL_DT                   DATE);

CREATE TABLE BILLCHKOW.FIN_HB_INVOICED
    (NIVEL_VALUE                    VARCHAR2(32),
    QTT_ACCOUNT                    NUMBER(19,0),
    NIVEL_TYPE                     VARCHAR2(32),
    PROC_DATE                      DATE,
    CYCLE_CODE                     VARCHAR2(2));
    
-----------DRP SUMMARY--------------
CREATE TABLE BILLCHKOW.fin_drpsummary_fact
    (state_code                     VARCHAR2(2),
    drop_calls                     NUMBER(19,0),
    duration_drop_calls            NUMBER(17,2),
    calls                          NUMBER(19,0),
    duration_calls                 NUMBER(17,2),
    cycle_code                     VARCHAR2(2),
    cut_date                       DATE,
    proc_flag                      VARCHAR2(1));

--BILLAMOUNT
CREATE TABLE BILLCHKOW.fin_billamount_fact
    (account_number                 VARCHAR2(10),
    cycle_date                     DATE,
    cycle_code                     VARCHAR2(2),
    property                       VARCHAR2(2),
    customer_type                  VARCHAR2(2),
    caption_code                   VARCHAR2(32),
    current_month_billed           NUMBER(17,2),
    total_amount                   NUMBER(17,2),
    total_amount_1                 NUMBER(17,2),
    total_amount_2                 NUMBER(17,2),
    total_amount_3                 NUMBER(17,2),
    document_type                  VARCHAR2(4),
    terminal_amount                NUMBER(19,0),
    account_status                 VARCHAR2(2),
    held_flag                      VARCHAR2(6),
    dormant_flag                   VARCHAR2(6));

CREATE TABLE BILLCHKOW.fin_ba_invoiced
    (account_status                 VARCHAR2(1),
    customer_type                  VARCHAR2(1),
    proc_date                      DATE,
    cycle_code                     VARCHAR2(2),
    qtt_account                    NUMBER(19,0),
    total_current                  NUMBER(17,2),
    total_prev                     NUMBER(17,2))
;

CREATE TABLE BILLCHKOW.fin_billamount_csa_fact
    (cycle_code                     VARCHAR2(2),
    cut_date                       DATE,
    qtt_account                    NUMBER(19,0),
    csa                            VARCHAR2(32),
    status                         VARCHAR2(2),
    customer_type                  VARCHAR2(2),
    description                    VARCHAR2(64));
    
-- Dormant Ciclo
CREATE TABLE BILLCHKOW.fin_dormant_ciclo_fact
    (conta                          VARCHAR2(15) NOT NULL,
    sbscrp_id                      VARCHAR2(15),
    tipo_de_cliente                VARCHAR2(1),
    tipo_de_conta                  VARCHAR2(1),
    bus_name                       VARCHAR2(80),
    first_name                     VARCHAR2(60),
    middle_name                    VARCHAR2(60),
    last_name                      VARCHAR2(60),
    nome_servico                   VARCHAR2(60),
    ciclo                          VARCHAR2(10),
    status_conta                   VARCHAR2(1),
    tipo_documento                 VARCHAR2(10),
    numero_documento               VARCHAR2(20),
    data_de_efetivacao             DATE,
    dormant_flag_cd                VARCHAR2(1),
    data_fat                       DATE);
    
--Dormant Chamada
CREATE TABLE BILLCHKOW.fin_dormant_chamada_fact
    (source_record_type_cd          VARCHAR2(1),
    acct_nbr                       VARCHAR2(15),
    event_dt                       DATE,
    event_tm                       VARCHAR2(15),
    orig_sid_bid                   VARCHAR2(3),
    gdng_id                        VARCHAR2(15),
    ldc_id                         VARCHAR2(4),
    orig_city_name                 VARCHAR2(10),
    orig_state_cd                  VARCHAR2(2),
    term_city_name                 VARCHAR2(10),
    term_state_cd                  VARCHAR2(2),
    rvrs_charge_flag               VARCHAR2(1),
    called_access_nbr              VARCHAR2(15),
    callng_access_nbr              NUMBER(15,0),
    chg_round_unit_qty             NUMBER(15,0),
    chg_price_amt                  VARCHAR2(17),
    entrpr_def_text                VARCHAR2(20),
    trnf_access_nbr                VARCHAR2(17),
    call_type                      VARCHAR2(10));
    
--Dormant Colaborador
CREATE TABLE BILLCHKOW.fin_dormant_colaborador_fact
    (flag                           VARCHAR2(20),
    acct_nbr                       VARCHAR2(20),
    sbscrp_id                      VARCHAR2(20),
    access_nbr                     VARCHAR2(20),
    svc_name                       VARCHAR2(40),
    svc_agrmnt_eff_dt              DATE,
    svc_agrmnt_trmntn_dt           DATE,
    dormant_flag_cd                VARCHAR2(1),
    held_bill_reason_cd            VARCHAR2(2),
    cust_idntfc_type_cd            VARCHAR2(15),
    cust_id_text                   VARCHAR2(15));
    
--Dormant Demanda
CREATE TABLE BILLCHKOW.fin_dormant_demanda_fact
    (acct_nbr                      VARCHAR2(15),
    cpf_cnpj                       VARCHAR2(20),
    solicitante                    VARCHAR2(20),
    motivo                         VARCHAR2(20),
    data_inicial                   DATE,
    data_final                     DATE);
    
CREATE TABLE BILLCHKOW.fin_dormant_invoiced
    (status_dormant                 VARCHAR2(32),
    cycle_code                     VARCHAR2(2),
    status_account                 VARCHAR2(20),
    fat_date                       DATE,
    qtt_acoount                    NUMBER(19,0));
    
    
    
---- SPLITBILLING ---------------------------
-- Create Sequence 

create sequence "SHARING_GROUP_USAGE_DETAILS_SQ" START WITH 1 INCREMENT BY 1 nomaxvalue;
create sequence "SHARING_GROUP_SUMMARY_SQ" START WITH 1 INCREMENT BY 1 nomaxvalue;
create sequence "SHARING_GROUP_DETAIL_SQ" START WITH 1 INCREMENT BY 1 nomaxvalue;

-- Create Tables section


Create table "SHARING_GROUP_DETAIL_REPORT" (
	"ID_GROUP_DETAIL" Number NOT NULL ,
	"CYCLE_END_DATE" Date,
	"CYCLE_CODE" Varchar2 (30),
	"CYCLE_NAME" Varchar2 (30),
	"CPF_CNPJ" Varchar2 (40),
	"TYPE" Varchar2 (2),
	"ID_HIERARQUIA" Number,
	"ID_GRUPO" Number,
	"ACCESS_NUMBER" Number,
	"ACCOUNT_NUMBER" Number,
	"CONTA_PAGADORA" Varchar2 (30),
	"STATUS_CONTA_PAGADORA" Varchar2 (2),
	"FRANQ_UTILIZADA" Varchar2 (15),
	"QTD_EVENTOS" Number,
	"PERC_UTIL" Number,
	"MENSALIDADE" Varchar2 (30),
	"ESTADO" Varchar2 (30),
	"REGIONAL" Varchar2 (30),
primary key ("ID_GROUP_DETAIL") 
);

Create table "SHARING_GROUP_SUMMARY_REPORT" (
	"ID_GROUP_SUMMARY" Number NOT NULL ,
	"CYCLE_END_DATE" Date,
	"CYCLE_CODE" Varchar2 (30),
	"NOME_CLIENTE" Varchar2 (60),
	"CPF_CNPJ" Varchar2 (40),
	"TYPE" Varchar2 (2),
	"ID_HIERARQUIA" Number,
	"NUM_CONTA_RAIZ" Number,
	"ID_GRUPO" Number,
	"MENSALIDADE" Varchar2 (30),
	"NOME_SERV_TITULAR" Varchar2 (30),
	"VALOR_MENSALIDADE" Number,
	"TOTAL_FRANQUIA" Number,
	"PRO_RATA" Number,
	"ATV_SVC_TITULAR" Date,
	"EXP_SVC_TITULAR" Date,
	"ESTADO" Varchar2 (30),
	"REGIONAL" Varchar2 (30),
primary key ("ID_GROUP_SUMMARY") 
);

Create table "SHARING_GROUP_USAGE_DETAILS_RE" (
	"ID_USAGE_DETAIL" Number NOT NULL ,
	"CYCLE_END_DATE" Date,
	"CYCLE_CODE" Varchar2 (30),
	"ID_HIERARQUIA" Number,
	"ID_GRUPO" Number,
	"TIPO_CHAMADA" Varchar2 (5),
	"DIRECAO" Varchar2 (10),
	"NUM_ORIGEM" Number,
	"NUM_DESTINO" Number,
	"DT_INICIO" Date,
	"HR_INICIO" Varchar2 (10),
	"DURACAO" Varchar2 (30),
	"ESTADO" Varchar2 (30),
	"REGIONAL" Varchar2 (30),
primary key ("ID_USAGE_DETAIL") 
);


-----------VIEWS E MVIEWS-------------------

CREATE MATERIALIZED VIEW BILLCHKOW.fin_ba_acc_dm_mview
AS
(
   SELECT
   	distinct (Account_Number), property as geo_id, Account_Status, Customer_Type, Document_Type, Held_Flag, Dormant_Flag, terminal_amount, cycle_code
   FROM FIN_BILLAMOUNT_FACT
);

CREATE MATERIALIZED VIEW BILLCHKOW.fin_billamount_total_mview
AS 
(
    SELECT distinct(account_number), cycle_code , held_flag, sum(total_amount) total_bill
    FROM fin_billamount_fact
    group by account_number, cycle_code, held_flag
);

CREATE MATERIALIZED VIEW BILLCHKOW.fin_ba_total_mview 
AS 
(
  SELECT 
    F.Account_Number, F.Cycle_Date, F.Cycle_Code as cycle_id, F.Property as geo_id, F.Current_Month_Billed, F.Total_Amount, F.Total_Amount_1,
    F.Total_Amount_2, F.Total_Amount_3, F.Terminal_Amount, C.OBJID as Captn_id,
    round((Total_Amount_1+Total_Amount_2+Total_Amount_3)/3, 2) as Total_Amount_AVG,
    round(SQRT ( (power( (Total_Amount_1 - (Total_Amount_1+Total_Amount_2+Total_Amount_3)/3), 2 ) + power( (Total_Amount_2 - (Total_Amount_1+Total_Amount_2+Total_Amount_3)/3), 2) + power( (Total_Amount_3 - (Total_Amount_1+Total_Amount_2+Total_Amount_3)/3), 2))/2 ), 2) as Desvio_Amount
  FROM FIN_BILLAMOUNT_FACT F, FIN_CAPTION_DM C
  WHERE C.captn_cd = F.caption_code  
);

CREATE MATERIALIZED VIEW BILLCHKOW.fin_ba_validate_mview
AS 
(
select customer_type, account_status, sum(total_acct_bill) total_acct_bill, sum(total_acct_csa) total_acct_csa 
from (
        (
         select customer_type, account_status, count(1) as total_acct_bill, 0 as total_acct_csa 
         from (
                select distinct(account_number), customer_type, account_status from fin_billamount_fact
              ) 
         group by customer_type, account_status
        )
 UNION ALL
        (
         select customer_type, status as account_status, 0 as total_acct_bill, sum(qtt_account) as total_acct_csa 
         from fin_billamount_csa_fact 
         group by customer_type, status
        )
     ) 
group by customer_type, account_status
);

--HELD BILL
-- View usada para o relatorio HBill
CREATE MATERIALIZED VIEW fin_hb_fact_mview
AS
(
 SELECT
        acct_nbr, uf as geo_id, acct_cycle as cycle_id, csa, valor_faturado, COD_MOTIVO_RETENCAO 
        FROM FIN_HELDBILL_FACT
        WHERE cod_motivo_retencao is not null
    UNION ALL
    SELECT
        acct_nbr, uf as geo_id, acct_cycle as cycle_code, csa, valor_faturado, cod_motivo_retencao
        FROM FIN_HELDBILL_FACT
        WHERE cod_motivo_retencao is null
        AND valor_faturado <= 5
);

CREATE MATERIALIZED VIEW fin_hb_motivo_held_dm_mview 
AS
(
    select distinct COD_MOTIVO_RETENCAO from FIN_HELDBILL_FACT
);

-- View usada nos dois relatorios HBill e HB x BAmount
CREATE MATERIALIZED VIEW BILLCHKOW.fin_hb_acc_dm_mview AS
(
    select distinct(acct_nbr), acct_status, to_char(las_bill_dt, 'yyyyMM') as las_bill_dt, cod_motivo_retencao
    from fin_heldbill_fact
);

-- View usada nos dois relatorios HBill e HB x BAmount 
CREATE MATERIALIZED VIEW BILLCHKOW.fin_hb_csa_dm_mview AS
(
    select distinct a.uf, a.csa, b.geo_region 
    from fin_heldbill_fact a, FIN_GEO_DM b
    where a.uf = b.geo_state
);

-- View usada para o relatorio HB x BA
CREATE MATERIALIZED VIEW BILLCHKOW.fin_hbba_fact_mview AS
( 
    SELECT distinct (H.acct_nbr),H.csa, H.geo_id, H.cycle_id,
                DECODE(B.account_number, NULL, 0, 1) as exist_account, -- verifica existência da conta HB em BA                
                DECODE(B.held_flag, NULL, 0, 1) as flag_amount, -- se flag held está ativa em Bill Amount
                DECODE(total_bill,least(total_bill,5),1,0) as flag_valor_amount, -- valor menor igual a 5, seta com 1
                H.valor_faturado as valor_HB, 
                nvl(b.total_bill,0) as valor_BA
    FROM FIN_HB_FACT_MVIEW H, FIN_BILLAMOUNT_TOTAL_MVIEW B
    WHERE h.acct_nbr = account_number (+)
    AND h.cycle_id = b.cycle_code (+)     
);

-- DRPSUMMARY
-- View drpSummary
CREATE OR REPLACE VIEW BILLCHKOW.fin_drpsummary_fact_view (
   nivel_type,
   state_code,
   cycle_code,
   qtt_calls,
   qtt_calls_prev,
   qtt_calls_avg,
   qtt_current,
   qtt_avg )
AS
(
    SELECT NIVEL_TYPE, STATE_CODE, CYCLE_CODE, SUM(QTT_CALLS) QTT_CALLS, SUM(QTT_CALLS_PREV) QTT_CALLS_PREV, SUM(QTT_CALLS_AVG) QTT_CALLS_AVG,
           (select sum(DROP_CALLS + CALLS) QTT_CURRENT from FIN_DRPSUMMARY_FACT where CYCLE_CODE = CYCLE_CODE 
            and CUT_DATE = (SELECT MAX(CUT_DATE) from FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = CYCLE_CODE) group by CYCLE_CODE ) as QTT_CURRENT,
           nvl((select round(sum(DROP_CALLS + CALLS)/10, 2) QTT_CURRENT from FIN_DRPSUMMARY_FACT where CYCLE_CODE = CYCLE_CODE 
           and extract (month from CUT_DATE) = (SELECT extract (month from add_months(MAX(CUT_DATE), -2)) from FIN_DRPSUMMARY_FACT LAST 
           where LAST.CYCLE_CODE = CYCLE_CODE) group by CYCLE_CODE), 0) as QTT_AVG
    FROM (
        (SELECT 'CHAMADAS NÃO FATURADAS' AS NIVEL_TYPE, A.STATE_CODE, A.CYCLE_CODE, A.DROP_CALLS AS QTT_CALLS, 0 AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT A
         WHERE CUT_DATE = (SELECT MAX(CUT_DATE) from FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE)
        UNION ALL
         SELECT 'CHAMADAS DROPADAS' AS NIVEL_TYPE, A.STATE_CODE, A.CYCLE_CODE, A.CALLS AS QTT_CALLS, 0 AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT A
         WHERE CUT_DATE = (SELECT MAX(CUT_DATE) from FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE))
      UNION
        (SELECT 'CHAMADAS NÃO FATURADAS' AS NIVEL_TYPE, B.STATE_CODE, B.CYCLE_CODE, 0 AS QTT_CALLS, B.DROP_CALLS AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG 
         FROM FIN_DRPSUMMARY_FACT B
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -1)) FROM FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = B.CYCLE_CODE)
        UNION ALL 
         SELECT 'CHAMADAS FATURADAS' AS NIVEL_TYPE, B.STATE_CODE, B.CYCLE_CODE, 0 AS QTT_CALLS, B.CALLS AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT B
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -1)) FROM FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = B.CYCLE_CODE))
      UNION 
        (SELECT 'CHAMADAS NÃO FATURADAS' AS NIVEL_TYPE, C.STATE_CODE, C.CYCLE_CODE, 0 AS QTT_CALLS, 0 AS QTT_CALLS_PREV, ROUND(SUM(C.DROP_CALLS)/10) QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT C
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -2)) FROM FIN_DRPSUMMARY_FACT LAST  WHERE LAST.CYCLE_CODE = C.CYCLE_CODE)
         GROUP BY C.STATE_CODE, C.CYCLE_CODE
        UNION ALL  
         SELECT 'CHAMADAS FATURADAS' AS NIVEL_TYPE, C.STATE_CODE, C.CYCLE_CODE,  0 AS QTT_CALLS, 0 AS QTT_CALLS_PREV, ROUND(SUM(C.DROP_CALLS)/10) QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT C
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -2)) FROM FIN_DRPSUMMARY_FACT LAST  WHERE LAST.CYCLE_CODE = C.CYCLE_CODE)
         GROUP BY C.STATE_CODE, C.CYCLE_CODE)  
     )
    GROUP BY NIVEL_TYPE, STATE_CODE, CYCLE_CODE
)
;

--DORMANT
--VIEWs de DORMANT
--VIEW DE CONTAS DORMANT_COLABORADOR
CREATE MATERIALIZED VIEW BILLCHKOW.fin_dco_acc_dm_mview 
as (
    SELECT
    distinct (access_nbr), acct_nbr, sbscrp_id, held_bill_reason_cd, cust_idntfc_type_cd, cust_id_text, 
    svc_agrmnt_eff_dt, svc_agrmnt_trmntn_dt
    FROM fin_dormant_colaborador_fact
);

-- VIEW DE SERVICO DORMANT_COLABORADOR
CREATE MATERIALIZED VIEW BILLCHKOW.fin_dco_svc_dm_mview 
as (
    SELECT
    distinct SVC_NAME
    FROM fin_dormant_colaborador_fact
);

-- MATERIALIZED VIEW DORMANT_COLABORADOR
CREATE MATERIALIZED VIEW BILLCHKOW.FIN_DCO_FACT_MVIEW
AS(
SELECT 
       acct_nbr ,access_nbr, FLAG, SVC_NAME, DORMANT_FLAG_CD, decode(SUBSTR(CUST_ID_TEXT, 1, 8),'02449992',1,0) as FLAG_CNPJ_VIVO,
       decode(DORMANT_FLAG_CD,'Y',1,0) as FLAG_ACC_ATIVA, FLAG_CURRENT, FLAG_LAST_MONTH
FROM (
        SELECT acct_nbr, access_nbr, FLAG, SVC_NAME, SVC_AGRMNT_EFF_DT, 
            SVC_AGRMNT_TRMNTN_DT, DORMANT_FLAG_CD, CUST_ID_TEXT,       
            decode(extract(month from SVC_AGRMNT_TRMNTN_DT),
                   extract(month from sysdate), decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_CURRENT,
            decode(extract(month from SVC_AGRMNT_TRMNTN_DT),
                   extract(month from add_months(sysdate,-1)), decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_LAST_MONTH          
        from FIN_DORMANT_COLABORADOR_FACT
        Where extract(month from SVC_AGRMNT_TRMNTN_DT) between (extract(month from add_months(sysdate,-1))) 
              and (extract(month from sysdate))
    )
  ); 
  
  
-- VIEW DE CONTAS DORMANT_CHAMADA
CREATE MATERIALIZED VIEW BILLCHKOW.fin_dch_acc_dm_mview as 
(
    SELECT
    distinct (acct_nbr), source_record_type_cd, event_dt, event_tm, orig_sid_bid,
        gdng_id, ldc_id, orig_city_name, orig_state_cd, term_city_name, term_state_cd,
        rvrs_charge_flag, called_access_nbr, callng_access_nbr, chg_round_unit_qty,
        chg_price_amt, entrpr_def_text, trnf_access_nbr, call_type
    FROM fin_dormant_chamada_fact
);

--MATERIALIZED VIEW CALL TYPE DORMANT_CHAMADA
CREATE MATERIALIZED VIEW BILLCHKOW.fin_typecall_dch_dm_mview
AS 
SELECT DISTINCT CALL_TYPE FROM FIN_DORMANT_CHAMADA_FACT;

--MATERIALIZED VIEW RECORD TYPE DORMANT_CHAMADA
CREATE MATERIALIZED VIEW BILLCHKOW.FIN_TYPERECORD_DCH_DM_MVIEW
AS
SELECT DISTINCT SOURCE_RECORD_TYPE_CD FROM FIN_DORMANT_CHAMADA_FACT;
    
-- MATERIALIZED VIEW DORMANT_CHAMADA
CREATE MATERIALIZED VIEW BILLCHKOW.FIN_DCH_FACT_MVIEW AS 
(
    SELECT distinct (dc.acct_nbr), SOURCE_RECORD_TYPE_CD, CALL_TYPE,
        DECODE(BA.account_number, NULL, 0, 1) as exist_account, -- verifica existência da conta DC em BA                
        DECODE(BA.held_flag, NULL, 0, 1) as flag_amount -- se flag held está ativa em Bill Amount                                
    FROM FIN_DORMANT_CHAMADA_FACT DC, fin_billamount_total_mview BA
    WHERE dc.acct_nbr = ba.account_number (+)
  );

-- MATERIALIZED VIEW DORMANT_CICLO
CREATE MATERIALIZED VIEW BILLCHKOW.fin_dc_fact_mview
AS
(
    SELECT SBSCRP_ID, NOME_SERVICO, CICLO, DORMANT_FLAG_CD, decode(SUBSTR(NUMERO_DOCUMENTO, 1, 8),'02449992',1,0) as FLAG_CNPJ_VIVO,
           decode(DORMANT_FLAG_CD,'Y',1,0) as FLAG_DORMANT, decode(STATUS_CONTA,'A',1,0) as FLAG_STATUS, FLAG_CURRENT, FLAG_LAST_MONTH
    FROM (
       SELECT SBSCRP_ID, NOME_SERVICO, CICLO, DORMANT_FLAG_CD, STATUS_CONTA, NUMERO_DOCUMENTO,
            decode(extract(month from DATA_FAT),
                   extract(month from sysdate), decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_CURRENT,
            decode(extract(month from DATA_FAT),
                   extract(month from add_months(sysdate,-1)), decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_LAST_MONTH          
        FROM FIN_DORMANT_CICLO_FACT
        WHERE extract(month from DATA_FAT) between (extract(month from add_months(sysdate,-1))) and (extract(month from sysdate))
    )
);

-- MATERIALIZED VIEW CONTA DORMANT_CICLO
CREATE MATERIALIZED VIEW BILLCHKOW.fin_dc_acc_dm_mview ( 
   sbscrp_id, conta, tipo_de_cliente, tipo_de_conta, nome_cliente, bus_name, status_conta, tipo_documento, numero_documento,
   data_de_efetivacao, data_fat )
AS
(
    SELECT
        distinct (sbscrp_id), conta, tipo_de_cliente, tipo_de_conta,  
        first_name||' '||middle_name||' '||last_name as nome_cliente, bus_name, status_conta,
        tipo_documento, numero_documento, data_de_efetivacao, data_fat         
    FROM fin_dormant_ciclo_fact
);

--  VIEW SERVICO DORMANT_CICLO
CREATE MATERIALIZED VIEW BILLCHKOW.fin_dc_svc_dm_mview (
   nome_servico )
AS
(
    SELECT
        distinct (nome_servico)
    FROM fin_dormant_ciclo_fact
);

--MATERIALIZED VIEW DORMANT_DEMANDA
CREATE MATERIALIZED VIEW BILLCHKOW.FIN_DDE_FACT_MVIEW
AS
SELECT ACCT_NBR, CPF_CNPJ, SOLICITANTE, MOTIVO, DATA_INICIAL, DATA_FINAL, COUNT(ACCT_NBR) AS ACCOUNT_NUMBER
FROM FIN_DORMANT_DEMANDA_FACT
GROUP BY ACCT_NBR, CPF_CNPJ, SOLICITANTE, MOTIVO, DATA_INICIAL, DATA_FINAL;

--MATERIALIZED VIEW CONTA DORMANT_DEMANDA
CREATE MATERIALIZED VIEW BILLCHKOW.FIN_ACC_DDE_MVIEW
AS
SELECT DISTINCT ACCT_NBR, CPF_CNPJ
FROM FIN_DORMANT_DEMANDA_FACT;

--MATERIALIZED VIEW SOLICITANTE DORMANT_DEMANDA
CREATE MATERIALIZED VIEW BILLCHKOW.FIN_SOLICITANTE_DDE_MVIEW
AS
SELECT DISTINCT (SOLICITANTE), MOTIVO, DATA_INICIAL, DATA_FINAL
FROM FIN_DORMANT_DEMANDA_FACT
ORDER BY SOLICITANTE;

--------------Receita Diaria

-- Views
CREATE OR REPLACE VIEW BILLCHKOW.FIN_DR_SVC_DM_VIEW (
   svc_name )
AS
(
 SELECT distinct a.svc_name
  FROM FIN_DR_FACT a
)
;

CREATE OR REPLACE VIEW BILLCHKOW.FIN_DR_CPT_DM_VIEW (
   caption_text )
AS
(
 SELECT distinct a.caption_text
  FROM FIN_DR_FACT a
)
;

CREATE OR REPLACE VIEW BILLCHKOW.FIN_DR_CSP_DM_VIEW (
   csp )
AS
(
 SELECT distinct nvl(a.csp, 'Nenhum')
  FROM FIN_DR_FACT a
)
;

CREATE OR REPLACE VIEW BILLCHKOW.FIN_DR_STATE_DM_VIEW (
   state )
AS
(
 SELECT distinct a.state
  FROM FIN_DR_FACT a
);

-- Materialized Views
CREATE MATERIALIZED VIEW billchkow.FIN_DR_SVC_DM_MVIEW 
AS
(
 SELECT distinct a.svc_name
  FROM FIN_DR_FACT a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_CPT_DM_MVIEW 
AS
(
 SELECT distinct a.caption_text
  FROM FIN_DR_FACT a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_CSP_DM_MVIEW 
AS 
(
 SELECT distinct nvl(a.csp, 'Nenhum') as CSP
  FROM FIN_DR_FACT a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_CYCLE_DM_MVIEW
AS 
(
 SELECT distinct a.cycle_cd
  FROM FIN_DR_FACT a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_STATE_DM_MVIEW
AS 
(
 SELECT distinct a.state
  FROM FIN_DR_FACT a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_STATE_DM_MVIEW
AS 
(
 SELECT distinct a.state
  FROM fin_dr_aux_fact a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_WEEKDAY_DM_MVIEW
as
(
select distinct to_char(a.call_dt,'fmDAY') AS week_call_dt_str, to_char(a.call_dt,'DD/MM/YYYY') as call_dt_str
from fin_dr_aux_fact a
);


CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_CSA_DM_MVIEW
AS 
(
 SELECT distinct a.carrier
  FROM fin_dr_aux_fact a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_CYCLE_DM_MVIEW
AS 
(
  SELECT distinct a.cycle_cd, a.cycle_dt
  FROM fin_dr_aux_fact a
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_DAY_DM_MVIEW
as
select distinct a.call_dt, to_char(a.call_dt,'fmDAY') AS week_call_dt_str, to_char(a.call_dt,'DD/MM/YYYY') as call_dt_str, to_char(a.call_dt,'MM/YYYY') as call_month_str
from fin_dr_aux_fact a
order by call_dt;

CREATE MATERIALIZED VIEW billchkow.FIN_DR_MONTH_WEEK_MVIEW
AS
(
select to_char(call_dt,'fmDAY') as week_call_dt, sum(a.qtt_calls) as WEEK_QTT, ROUND(sum(a.qtt_calls), 2) as WEEK_AVG
FROM FIN_DR_FACT a
where extract(month from call_dt) <= (SELECT extract (month from add_months(MAX(call_dt), -1)) 
                                              FROM FIN_DR_FACT LAST)
group by to_char(call_dt,'fmDAY')
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_MONTH_MVIEW
AS 
(
 SELECT cycle_cd, caption_text, call_dt, call_dt_str, week_call_dt, dur_calls,
        dur_billing_calls, dur_franq_calls, qtt_calls_current, amount_calls_current     
  FROM (
         SELECT   a.cycle_cd, a.caption_text, a.call_dt, to_char(call_dt,'DD/MM/YYYY') as call_dt_str,
         to_char(call_dt,'fmDAY') as week_call_dt,
         SUM (a.dur_calls) dur_calls,
         SUM (a.dur_billing_calls) dur_billing_calls,
         SUM (a.dur_franq_calls) dur_franq_calls,
         SUM (decode(extract(month from a.fat_dt),extract(month from (SELECT MAX(fat_dt) from fin_dr_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd)), nvl(a.qtt_calls, 0), 0)) as qtt_calls_current,    
         SUM (decode(extract(month from a.fat_dt),extract(month from (SELECT MAX(fat_dt) from fin_dr_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd)), nvl(a.amount_gross_calls, 0), 0)) as amount_calls_current         
         FROM fin_dr_fact a
         WHERE EXTRACT (MONTH FROM fat_dt) =
                                   (SELECT EXTRACT (MONTH FROM MAX (fat_dt))
                                      FROM fin_dr_fact LAST)
         GROUP BY a.cycle_cd, a.caption_text, a.call_dt, to_char(call_dt,'fmDAY')
  )
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_CALLDT_DM_MVIEW
AS 
 SELECT distinct a.call_dt, call_dt_str, a.week_call_dt
 FROM fin_dr_month_mview a
 ORDER BY a.call_dt;
 
CREATE MATERIALIZED VIEW fin_dr_sum_mview
AS
select dr.caption_text, dr.state, dr.cycle_cd, dr.fat_dt, sum(dr.qtt_calls) as qtt_calls, 
sum(dr.amount_gross_calls) as amount_gross_calls 
from fin_dr_fact dr
where dr.qtt_calls <> 0
group by dr.caption_text, dr.state, dr.cycle_cd, dr.fat_dt
order by dr.caption_text

CREATE MATERIALIZED VIEW fin_dr_cci_fact_mview
as
SELECT caption_text, state, cycle_cd, sum(qtt_calls_cci) qtt_calls_cci, sum(amount_cci) valor_faturado_cci, sum(qtt_calls_rd) qtt_calls_dr,
         sum(amount_rd)  valor_faturado_dr
from (    
    select b.captn_text as caption_text, sum(a.qtt_calls) as qtt_calls_cci, sum(a.amount) as amount_cci, 0 as qtt_calls_rd, 0 as amount_rd, a.geo_id as state, a.cycle_id as cycle_cd
    from fin_cci_fact a, fin_caption_dm b, (select distinct state from fin_dr_sum_mview, fin_cci_fact where cycle_cd = cycle_id) d   
    where LAST_BILL_DATE = (SELECT MAX(LAST_BILL_DATE) from fin_cci_fact cci_dt where cci_dt.cycle_id = a.cycle_id) 
    and QTT_CALLS <> 0 and a.captn_id = b.objid
    and a.geo_id = d.state
    group by b.captn_text, a.geo_id, a.cycle_id
UNION ALL
    select c.caption_text, 0 as qtt_calls_cci, 0 as amount_cci, sum(c.qtt_calls) as qtt_calls_rd, 
           sum(c.amount_gross_calls) as amount_rd, c.state as geo_id, c.cycle_cd as cycle_id
    from fin_dr_sum_mview c
    group by caption_text, state, cycle_cd
)
group by caption_text, state, cycle_cd

CREATE MATERIALIZED VIEW billchkow.FIN_DR_VM_FACT_MVIEW 
as
select call_dt, to_char(call_dt,'DD/MM/YYYY') as call_dt_str, to_char(call_dt,'MM/YYYY') as call_month_str, cycle_cd, state, 
    nvl(csp, 'Nenhum') as csp, sum(qtt_calls) as qtt_calls, sum(dur_calls) as dur_calls,
    sum(dur_billing_calls) as dur_billing_calls, sum(dur_franq_calls) as dur_franq_calls, sum(amount_gross_calls) as amount_gross_calls,
    round(sum(amount_gross_calls)/(sum(qtt_calls)),2) as valor_medio_cdr, 
    round(sum(amount_gross_calls)/((sum(dur_billing_calls)+sum(dur_franq_calls))/60),2) as valor_medio_minuto
from fin_dr_fact
group by call_dt, cycle_cd, state, csp
order by call_dt asc;

CREATE MATERIALIZED VIEW billchkow.FIN_DR_DAY_DM_MVIEW
as
select distinct call_dt, to_char(call_dt,'fmDAY') AS week_call_dt_str, to_char(call_dt,'DD/MM/YYYY') as call_dt_str, to_char(call_dt,'MM/YYYY') as call_month_str, cycle_cd
from fin_dr_fact
order by call_dt;

CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_MVIEW
AS
(
  SELECT a.state, a.carrier, a.cycle_dt, a.cycle_cd,
 to_char(call_dt,'fmDAY') week_call_dt, sum(a.qtt_calls) qtt_calls_current, 
 to_char(a.call_dt,'DD/MM/YYYY') as call_dt_str
  FROM fin_dr_aux_fact a
  WHERE extract(month from a.cycle_dt) = extract(month from (SELECT MAX(cycle_dt) from fin_dr_aux_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd))
  GROUP BY a.state, a.carrier, a.cycle_dt, a.cycle_cd, a.call_dt, to_char(call_dt,'fmDAY'),  to_char(a.call_dt,'DD/MM/YYYY')
);
-- Statistical Views 
CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_QTTCALL_DM_MVIEW
AS
  SELECT a.cycle_cd, a.carrier, a.state,
 to_char(a.call_dt,'fmDAY') AS week_call_dt, 
 ROUND(sum(a.qtt_calls), 2) sum_qtt_call
 FROM fin_dr_aux_fact a
 WHERE 
 EXTRACT(month FROM cycle_dt) <= EXTRACT (month FROM add_months((SELECT MAX(cycle_dt) from fin_dr_aux_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd), -1)) AND
 EXTRACT(month FROM cycle_dt) >= EXTRACT (month FROM add_months((SELECT MAX(cycle_dt) from fin_dr_aux_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd), -3))
 GROUP BY a.cycle_cd, a.carrier, a.state, to_char(call_dt,'fmDAY') 
 ORDER BY to_char(a.call_dt,'fmDAY');
 
CREATE MATERIALIZED VIEW billchkow.FIN_DR_QTTCALL_DM_MVIEW
AS
 SELECT a.cycle_cd,a.caption_text, 
 to_char(call_dt,'fmDAY') AS week_call_dt, 
 ROUND(sum(a.qtt_calls), 2) sum_qtt_call
 FROM FIN_DR_FACT a
 WHERE 
 EXTRACT(month FROM fat_dt) <=   (SELECT EXTRACT (month FROM add_months(MAX(fat_dt), -1)) 
                                              FROM FIN_DR_FACT LAST)
 GROUP BY a.cycle_cd,a.caption_text, to_char(call_dt,'fmDAY') 
 ORDER BY to_char(call_dt,'fmDAY');

CREATE MATERIALIZED VIEW billchkow.FIN_DR_AMCALL_DM_MVIEW
AS
 SELECT  a.cycle_cd,a.caption_text, to_char(call_dt,'fmDAY') AS week_call_dt, 
 ROUND(sum(a.amount_gross_calls), 2) sum_am_call
 FROM FIN_DR_FACT a
 WHERE 
 EXTRACT(month FROM fat_dt) <=   (SELECT EXTRACT (month FROM add_months(MAX(fat_dt), -1)) 
                                              FROM FIN_DR_FACT LAST)
 GROUP BY a.cycle_cd,a.caption_text, to_char(call_dt,'fmDAY') 
 ORDER BY to_char(call_dt,'fmDAY');
 
CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_QTTDAYS_DM_MVIEW
AS
 SELECT count(*) sum_qtt_days, week_call_dt, cycle_cd, carrier, state
 FROM(
  SELECT DISTINCT a.cycle_cd, a.carrier, a.state, 
  a.call_dt, to_char(call_dt,'fmDAY') AS week_call_dt
  FROM FIN_DR_AUX_FACT a 
  WHERE 
   EXTRACT(month FROM cycle_dt) <= EXTRACT (month FROM add_months((SELECT MAX(cycle_dt) from fin_dr_aux_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd), -1)) AND
   EXTRACT(month FROM cycle_dt) >= EXTRACT (month FROM add_months((SELECT MAX(cycle_dt) from fin_dr_aux_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd), -3))
 )
 GROUP BY week_call_dt, carrier, state, cycle_cd;
 
 

CREATE MATERIALIZED VIEW billchkow.FIN_DR_QTTDAYS_DM_MVIEW
AS
 SELECT count(*) sum_qtt_days, week_call_dt, cycle_cd, caption_text
 FROM(
  SELECT DISTINCT caption_text, cycle_cd, call_dt, to_char(call_dt,'fmDAY') AS week_call_dt
  FROM FIN_DR_FACT a 
  WHERE EXTRACT(month FROM fat_dt) <=  (SELECT EXTRACT (month FROM add_months(MAX(fat_dt), -1)) FROM FIN_DR_FACT LAST)
 )
 GROUP BY week_call_dt, cycle_cd, caption_text;


CREATE VIEW billchkow.FIN_DR_QTTDESV_DM_VIEW (caption_text, week_call_dt, cycle_cd, desvio_qtt)
AS
(
SELECT caption_text, week_call_dt, cycle_cd, ROUND(SQRT(SUM(POWER(qtt_calls_sum-avg_week_day, 2)/sum_qtt_days)),2) desvio_qtt
FROM
(
    SELECT a.cycle_cd, a.caption_text ,a.call_dt, to_char(a.call_dt,'fmDAY') week_call_dt,
    ROUND(sum(a.qtt_calls), 2) qtt_calls_sum, 
    (
        SELECT ROUND((sum_qtt_call/sum_qtt_days)/3, 2) 
        FROM FIN_DR_QTTCALL_DM_MVIEW c, FIN_DR_QTTDAYS_DM_MVIEW d 
        WHERE 
         c.cycle_cd = d.cycle_cd AND 
         c.week_call_dt = d.week_call_dt AND
         c.caption_text = d.caption_text AND
         c.cycle_cd = a.cycle_cd AND 
         c.week_call_dt=to_char(a.call_dt,'fmDAY') AND
         c.caption_text = a.caption_text
    ) 
    AS avg_week_day,
    (
        SELECT sum_qtt_days
        FROM FIN_DR_QTTDAYS_DM_MVIEW g 
        WHERE 
         g.cycle_cd = a.cycle_cd AND 
         g.week_call_dt=to_char(a.call_dt,'fmDAY') AND
         g.caption_text = a.caption_text
    ) 
    AS sum_qtt_days    
    FROM FIN_DR_FACT a 
    WHERE 
    EXTRACT(month FROM fat_dt) <=   
    (
        SELECT EXTRACT (month FROM add_months(MAX(fat_dt), -1)) 
        FROM FIN_DR_FACT LAST
    )
    GROUP BY a.caption_text, a.call_dt, to_char(a.call_dt,'fmDAY'), a.cycle_cd
)
GROUP BY caption_text, week_call_dt, cycle_cd);

CREATE VIEW billchkow.FIN_DR_AMDESV_DM_VIEW (caption_text, week_call_dt, cycle_cd, desvio_am)
AS
(
SELECT caption_text, week_call_dt, cycle_cd, ROUND(SQRT(SUM(POWER(am_calls_sum-avg_week_day, 2)/sum_qtt_days)),2) desvio_am
FROM
(
    SELECT a.cycle_cd, a.caption_text ,a.call_dt, to_char(a.call_dt,'fmDAY') week_call_dt,
    ROUND(sum(a.amount_gross_calls), 2) am_calls_sum, 
    (
        SELECT ROUND((sum_am_call/sum_qtt_days)/3, 2) 
        FROM FIN_DR_AMCALL_DM_MVIEW c, FIN_DR_QTTDAYS_DM_MVIEW d 
        WHERE 
         c.cycle_cd = d.cycle_cd AND 
         c.week_call_dt = d.week_call_dt AND
         c.caption_text = d.caption_text AND
         c.cycle_cd = a.cycle_cd AND 
         c.week_call_dt=to_char(a.call_dt,'fmDAY') AND
         c.caption_text = a.caption_text
    ) 
    AS avg_week_day,
    (
        SELECT sum_qtt_days
        FROM FIN_DR_QTTDAYS_DM_MVIEW g 
        WHERE 
         g.cycle_cd = a.cycle_cd AND 
         g.week_call_dt=to_char(a.call_dt,'fmDAY') AND
         g.caption_text = a.caption_text
    ) 
    AS sum_qtt_days    
    FROM FIN_DR_FACT a 
    WHERE 
    EXTRACT(month FROM fat_dt) <=   
    (
        SELECT EXTRACT (month FROM add_months(MAX(fat_dt), -1)) 
        FROM FIN_DR_FACT LAST
    )
    GROUP BY a.caption_text, a.call_dt, to_char(a.call_dt,'fmDAY'), a.cycle_cd
)
GROUP BY caption_text, week_call_dt, cycle_cd);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_STAT_DM_MVIEW
AS
SELECT a.caption_text ,a.week_call_dt, a.cycle_cd,
ROUND((c.sum_qtt_call/a.sum_qtt_days)/3,2) avg_qtt_call, 
ROUND((b.sum_am_call/a.sum_qtt_days)/3,2) avg_am_call, desvio_qtt, desvio_am
FROM 
FIN_DR_QTTDAYS_DM_MVIEW a, FIN_DR_AMCALL_DM_MVIEW b, 
FIN_DR_QTTCALL_DM_MVIEW c, fin_dr_qttdesv_dm_view d,
fin_dr_amdesv_dm_view e
WHERE 
a.week_call_dt = b.week_call_dt AND
a.cycle_cd = b.cycle_cd         AND
a.caption_text = b.caption_text AND
a.week_call_dt = c.week_call_dt AND
a.cycle_cd = c.cycle_cd         AND
a.caption_text = c.caption_text AND
a.week_call_dt = e.week_call_dt AND
a.cycle_cd = e.cycle_cd         AND
a.caption_text = e.caption_text AND
a.week_call_dt = d.week_call_dt AND
a.cycle_cd = d.cycle_cd         AND
a.caption_text = d.caption_text;

CREATE OR REPLACE VIEW billchkow.FIN_DR_MONTH_VIEW (
       cycle_cd, caption_text, call_dt, call_dt_str, week_call_dt, dur_calls,
       dur_billing_calls, dur_franq_calls, qtt_calls_current, amount_calls_current,
       avg_qtt_call, avg_am_call, desvio_qtt, desvio_am, Parameter_Amount, Parameter_Percent        
)
AS
(
    SELECT 
       a.cycle_cd, a.caption_text, a.call_dt, a.call_dt_str, a.week_call_dt, a.dur_calls,
       a.dur_billing_calls, a.dur_franq_calls, a.qtt_calls_current, a.amount_calls_current,
       nvl((select avg_qtt_call from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as avg_qtt_call
       ,
        nvl((select avg_am_call from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as avg_am_call
       , 
        nvl((select desvio_qtt from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as desvio_qtt
       , 
       nvl((select desvio_am from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as desvio_am
       ,    
       nvl((select PARAMETER_AMOUNT from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'DAILYREVAMOUNT'), 0) as Parameter_Amount,
       nvl((select PARAMETER_ITEM from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'DAILYREVAMOUNT'), 0) as Parameter_Percent
    FROM FIN_DR_MONTH_MVIEW a
);

CREATE VIEW billchkow.FIN_DR_UN_QTTDESV_DM_VIEW (carrier, state, cycle_cd, week_call_dt, desvio_qtt)
AS
(
SELECT carrier, state, cycle_cd, week_call_dt, 
ROUND(SQRT(SUM(POWER(qtt_calls_sum-avg_week_day, 2)/sum_qtt_days)),2) desvio_qtt
FROM
(
    SELECT a.carrier, a.state, a.cycle_cd, a.call_dt, to_char(a.call_dt,'fmDAY') week_call_dt,
    ROUND(sum(a.qtt_calls), 2) qtt_calls_sum, 
    (
        SELECT ROUND((sum_qtt_call/sum_qtt_days)/3, 2) 
        FROM FIN_DR_UN_QTTCALL_DM_MVIEW c, FIN_DR_UN_QTTDAYS_DM_MVIEW d 
        WHERE 
         c.cycle_cd = d.cycle_cd AND 
         c.week_call_dt = d.week_call_dt AND
         c.carrier = d.carrier AND
         c.state = d.state AND
         c.cycle_cd = a.cycle_cd AND 
         c.week_call_dt = to_char(a.call_dt,'fmDAY') AND
         c.carrier = a.carrier AND
         c.state = a.state
    ) 
    AS avg_week_day,
    (
        SELECT sum_qtt_days
        FROM FIN_DR_UN_QTTDAYS_DM_MVIEW g 
        WHERE 
         g.cycle_cd = a.cycle_cd AND 
         g.week_call_dt = to_char(a.call_dt,'fmDAY') AND
         g.carrier = a.carrier AND
         g.state = a.state
    ) 
    AS sum_qtt_days    
    FROM FIN_DR_AUX_FACT a 
    WHERE 
    EXTRACT(month FROM cycle_dt) <= EXTRACT (month FROM add_months((SELECT MAX(cycle_dt) from fin_dr_aux_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd), -1)) AND
    EXTRACT(month FROM cycle_dt) >= EXTRACT (month FROM add_months((SELECT MAX(cycle_dt) from fin_dr_aux_fact FINDRLAST WHERE FINDRLAST.CYCLE_CD = cycle_cd), -3))
    GROUP BY a.carrier, a.state, a.cycle_cd, a.call_dt, to_char(a.call_dt,'fmDAY')
)
GROUP BY carrier, state, cycle_cd, week_call_dt
);

CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_STAT_DM_MVIEW
AS
SELECT a.cycle_cd, a.carrier, a.state, a.week_call_dt,
ROUND((b.sum_qtt_call/a.sum_qtt_days)/3,2) avg_qtt_call, c.desvio_qtt
FROM 
FIN_DR_UN_QTTDAYS_DM_MVIEW a, FIN_DR_UN_QTTCALL_DM_MVIEW b,
FIN_DR_UN_QTTDESV_DM_VIEW c
WHERE 
a.state = b.state AND
a.carrier = b.carrier AND
a.cycle_cd = b.cycle_cd AND
a.week_call_dt = b.week_call_dt AND
c.state = b.state AND
c.carrier = b.carrier AND
c.cycle_cd = b.cycle_cd AND
c.week_call_dt = b.week_call_dt;

CREATE OR REPLACE VIEW billchkow.FIN_DR_UN_VIEW(state, carrier, cycle_dt, cycle_cd,
 week_call_dt, qtt_calls_current, call_dt_str, avg_qtt_call, desvio_qtt)
AS
(
 SELECT a.state, a.carrier, a.cycle_dt, a.cycle_cd,
 a.week_call_dt, a.qtt_calls_current, a.call_dt_str, 
 b.avg_qtt_call, b.desvio_qtt
  FROM fin_dr_un_mview a, fin_dr_un_stat_dm_mview b
  WHERE 
    a.state = b.state AND
    a.carrier = b.carrier AND
    a.cycle_cd = b.cycle_cd AND
    a.week_call_dt = b.week_call_dt
);

commit;

-----JUROS E MULTAS------

    
-- CREATE VIEWS --
CREATE OR REPLACE VIEW billchkow.fin_jm_demand_acc_dm_view (
   uf,
   account_number,
   eff_dt,
   exp_dt )
 AS
(
  SELECT distinct a.uf, a.account_number, a.eff_dt, a.exp_dt
  FROM fin_jm_demand_fact a
);

CREATE OR REPLACE VIEW billchkow.fin_jm_demand_area_dm_view (
   area )
AS
(
 SELECT distinct a.area
  FROM fin_jm_demand_fact a
);

CREATE OR REPLACE VIEW billchkow.fin_jm_demand_reason_dm_view (
   reason )
 AS
(
  SELECT distinct a.reason
  FROM fin_jm_demand_fact a
);

commit;

-- CREATE MATERIALIZED VIEWS --
CREATE MATERIALIZED VIEW billchkow.FIN_JM_CAPT_ACC_DM_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
 SELECT distinct (a.account_number), a.uf, a.last_bill_date, a.acct_type_cd, a.debito_e
  FROM fin_jm_capt_fact a
);

CREATE MATERIALIZED VIEW billchkow.FIN_JM_CAPT_TOTAL_MVIEW  
BUILD IMMEDIATE  
REFRESH ON DEMAND
AS
( 
select account_number, cycle_cd as cycle_id, sum(juros_amt) juros_amt, sum(multa_amt) multa_amt, sum (juros_amt + multa_amt) total_jm
from
((select account_number, cycle_cd, nvl(charge_cr_amt, 0) as juros_amt, 0 as multa_amt
    from fin_jm_capt_fact
    where captn_cd = 'XJROS2')
UNION ALL
(select account_number, cycle_cd, 0 as juros_amt, nvl(charge_cr_amt, 0) as multa_amt
    from fin_jm_capt_fact
    where captn_cd = 'XMULTA2'))
group by account_number, cycle_cd
);

CREATE MATERIALIZED VIEW billchkow.FIN_JM_CAPT_FACT_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
select j.account_number, j.cycle_id, j.juros_amt, j.multa_amt, j.total_jm, b.total_bill, decode ((total_bill-total_jm),0,1,0) critic
from fin_billamount_total_mview b, fin_jm_capt_total_mview j
where j.account_number = b.account_number 
);

CREATE MATERIALIZED VIEW billchkow.FIN_JM_CAPT_CRITIC_DM_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
  SELECT distinct account_number, decode (critic,1,'Sim','Não') critic
  FROM fin_jm_capt_fact_mview a
);

CREATE MATERIALIZED VIEW billchkow.FIN_JM_JM_ACC_DM_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
 SELECT distinct a.doc_state, a.account_number, a.doc_ref, a.doc_due_dt, a.doc_past_due_dt, a.recv_dt
  FROM fin_jm_jm_fact a
);

CREATE MATERIALIZED VIEW billchkow.FIN_JM_JM_CAPT_DM_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
 SELECT distinct pnlty_intrst_type_id
  FROM fin_jm_jm_fact a
);

CREATE MATERIALIZED VIEW billchkow.FIN_JM_JM_CARRIER_DM_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
SELECT distinct  a.long_dstn_carr_id, substr(a.long_dstn_carr_id,3, 4) state,
        substr(a.long_dstn_carr_id,1, 2) carrier
  FROM fin_jm_jm_fact a
);

CREATE MATERIALIZED VIEW billchkow.FIN_JM_JM_CYCLE_DM_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
SELECT distinct a.cycle_code as cycle_id
  FROM fin_jm_jm_fact a
  where length(cycle_code) = 2
);

CREATE OR REPLACE VIEW BILLCHKOW.FIN_JM_JM_FACT_VIEW (
   account_number,
   geo_id,
   cycle_id,
   cycle_cut_date,
   qtt_del_dt,
   bill_pymt_due_dt,
   pnlty_intrst_type_id,
   long_dstn_carr_id,
   pnlty_intrst_amt,
   pnlty_intrst_amt_prev_1,
   parameter_amount,
   parameter_percent
   )
AS
(
    SELECT a.account_number, a.doc_state as geo_id, a.cycle_code as cycle_id, a.cycle_cut_date, a.qtt_del_dt,  
       a.bill_pymt_due_dt, a.pnlty_intrst_type_id, a.long_dstn_carr_id, a.pnlty_intrst_amt,
       nvl((select pnlty_intrst_type_id from BILLCHKOW.fin_jm_jm_fact B
    		where A.account_number = B.account_number
    		AND A.doc_state = B.doc_state
    		AND A.cycle_code = B.cycle_code
    		AND extract(month from B.cycle_cut_date) = extract(month from add_months(A.cycle_cut_date,-1))
   	    ), 0) as pnlty_intrst_amt_prev_1,
       	nvl((select PARAMETER_AMOUNT from BILLCHKOW.FIN_REPORT_PARAMETER_DM PA
    		where PA.TYPE_REPORT = 'JUROS_MULTAS'
   	    ), 0) as PARAMETER_AMOUNT,
       	nvl((select PARAMETER_ITEM from BILLCHKOW.FIN_REPORT_PARAMETER_DM PA
    		where PA.TYPE_REPORT = 'JUROS_MULTAS'
   	    ), 0) as PARAMETER_PERCENT
  FROM BILLCHKOW.fin_jm_jm_fact a
  WHERE A.cycle_cut_date = (SELECT MAX(cycle_cut_date) FROM BILLCHKOW.fin_jm_jm_fact LAST WHERE LAST.cycle_code = A.cycle_code)
);

commit;

--------------CAPTION CODE--------------
-- VIEWs
-- CAPTION TEXT
create view billchkow.FIN_CAPTION_TEXT_DM as (
    Select distinct(captn_text) from fin_caption_dm
);

--View Materilizada de Contas CAPTION_CODE
CREATE materialized VIEW billchkow.fin_cc_account_dm_mview 
(
    account_number, 
    sbscrp_id, 
    access_nbr    
) as (
    SELECT
    distinct (acct_nbr) as account_number, sbscrp_id, access_nbr
    FROM fin_captioncode_fact
);


--View Materializada de Serviço CAPTION_CODE
CREATE materialized VIEW billchkow.fin_cc_service_dm_mview 
(
   caption_cd, svc_name
) AS (
SELECT distinct caption_cd, svc_name from fin_captioncode_fact
);

--View Materializada de Propriedade Expurgo CAPTION_CODE
CREATE MATERIALIZED VIEW billchkow.fin_cc_expurgo_dm_mview 
(
   access_nbr, cycle_id, prcng_comm_uf, last_bil
) AS (
SELECT distinct ex.access_nbr, cy as cycle_id, prcng_comm_uf, last_bil 
  from fin_captioncode_fact cc, fin_expurgo_fact ex where cc.acct_nbr = ex.acct_nbr and cc.access_nbr = ex.access_nbr
);

--View Materializada de Expurgo CAPTION_CODE
CREATE materialized VIEW billchkow.fin_cc_expurgo_fact_mview 
(
    CYCLE_ID, access_nbr, SVC_NAME, INVN_CHARGE_CR_AMT, PRCNG_COMM_UF, LAST_BIL
) as (
    SELECT A.CYCLE_ID, A.ACCESS_NBR AS access_nbr, B.SVC_NAME, B.INVN_CHARGE_CR_AMT, B.PRCNG_COMM_UF, B.LAST_BIL 
    FROM FIN_EXPURGO_FACT A, FIN_CAPTIONCODE_FACT B
    WHERE A.acct_nbr = B.acct_nbr AND A.access_nbr = B.access_nbr 
    AND A.cycle_id = B.cy
);  

--View Materializada de contas em Churn CAPTION_CODE
create materialized view billchkow.FIN_CC_CHURN_ACC_DM_MVIEW as (
    select distinct(access_nbr), acct_nbr, class_cred, cpf_cnpj, dat_fat_old, enter_date, dat_habil, dat_expr, chanel, recision_id, pf_pj
    from fin_churn_fact
);

--View Materialized de Churn CAPTION_CODE
CREATE materialized VIEW billchkow.fin_cc_churn_fact_mview (
    access_nbr, saldo_pendente, geo_id)
as (
  SELECT distinct (access_nbr), saldo_pendente, uf as geo_id
  FROM fin_churn_fact
);

-----------------------------CCI--------------

CREATE MATERIALIZED VIEW billchkow.FIN_CCI_INVOICED_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
select t.captn_cd, t.cycle_id, t.geo_id, sum(amount_current) amount_current, sum(calls_current) calls_current, sum(amount_avg) amount_avg, 
       sum(call_avg) call_avg, sum(tot_seconds) tot_seconds, sum(tot_minutes) tot_minutes, sum(amount_prev) amount_prev, sum(call_prev) call_prev, 
       sum(total_amount_inv) total_amount_inv, sum(total_amount_inv_avg) total_amount_inv_avg
FROM 
    (
    select A.captn_cd, A.cycle_id, A.geo_id, sum(A.amount) amount_current, sum(A.qtt_calls) calls_current, 0 as amount_avg, 0 as call_avg,
           sum(A.tot_seconds) tot_seconds, sum(A.tot_minutes) tot_minutes, 0 as amount_prev, 0 as call_prev  
    from fin_cci_invoiced A
    where extract (month from LAST_BILL_DT) = (
                                               SELECT extract (month from MAX(LAST_BILL_DT)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = A.CYCLE_ID
                                              )
    group by A.captn_cd, A.cycle_id, A.geo_id
    UNION ALL
    select B.captn_cd, B.cycle_id, B.geo_id, 0 as amount_current, 0 as calls_current, round(sum(B.amount)/10, 2) amount_avg, 
           round(sum(B.qtt_calls)/10, 2) call_avg, 0 as tot_seconds, 0 as tot_minutes, 0 as amount_prev, 0 as call_prev
    from fin_cci_invoiced B
    where extract (month from LAST_BILL_DT) < (
                                               SELECT extract (month from add_months(MAX(LAST_BILL_DT), -2)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = B.CYCLE_ID
                                              )
    group by B.captn_cd, B.cycle_id, B.geo_id
    UNION ALL
    select C.captn_cd, C.cycle_id, C.geo_id, 0 as amount_current, 0 as calls_current, 0 as amount_avg, 0 as call_avg,
           0 as tot_seconds, 0 as tot_minutes, sum(C.amount) amount_prev, sum(C.qtt_calls) call_prev 
    from fin_cci_invoiced C
    where extract (month from LAST_BILL_DT) = (
                                               SELECT extract (month from add_months(MAX(LAST_BILL_DT), -1)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = C.CYCLE_ID
                                              )
    group by C.captn_cd, C.cycle_id, C.geo_id
    ) t,
    (
    select sum(amount) total_amount_inv, cycle_id, 0 as total_amount_inv_avg from fin_cci_invoiced D
    where extract (month from LAST_BILL_DT) = (
                                               SELECT extract (month from MAX(LAST_BILL_DT)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = D.CYCLE_ID
                                               ) 
    group by cycle_id
    UNION ALL
    select 0 as total_amount_inv, cycle_id, round(sum(amount)/10, 2) total_amount_inv_avg from fin_cci_invoiced E
    where extract (month from LAST_BILL_DT) < (
                                               SELECT extract (month from add_months(MAX(LAST_BILL_DT), -2)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = E.CYCLE_ID
                                              ) 
    group by cycle_id
    ) x 
    WHERE t.cycle_id = x.cycle_id
    GROUP BY t.captn_cd, t.cycle_id, t.geo_id
);

-----------------VIEWS INVOICED-------------------------

CREATE OR REPLACE VIEW billchkow.FIN_BA_INVOICED_VIEW (
   ACCOUNT_STATUS,
   CYCLE_CODE,
   QTT_ACCOUNT,
   TOTAL_CURRENT,
   TOTAL_PREV,
   QTT_PREV,
   TOTAL_AVG,
   QTT_AVG,
   QTT_CURRENT_INV,
   QTT_AVG_INV )
AS
(
    SELECT t.account_status, t.cycle_code, qtt_account, total_current, total_prev, qtt_prev, total_avg, qtt_avg, qtt_current_inv, qtt_avg_inv   
    FROM (
    SELECT decode(account_status,'A','Faturas Ativas','N','Faturas NPD','F', 'Faturas Final') as account_status, cycle_code, 
            sum(qtt_account) qtt_account, sum(total_current) total_current, sum(total_prev) total_prev, sum(qtt_prev) qtt_prev, 
            sum(total_avg) total_avg, sum(qtt_avg) qtt_avg
    FROM (
          SELECT A.account_status, A.cycle_code, sum(A.qtt_account) qtt_account, sum(A.total_current) total_current, 
                 sum(A.total_prev) total_prev, 0 as qtt_prev , 0 as total_avg, 0 as qtt_avg    
          FROM FIN_BA_INVOICED A
          WHERE proc_date = (SELECT MAX(proc_date) FROM FIN_BA_INVOICED LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE)
          GROUP BY A.account_status, A.cycle_code 
        UNION ALL
          SELECT B.account_status, B.cycle_code, 0 as qtt_account, 0 as total_current, 0 as total_prev, sum(B.qtt_account) qtt_prev, 
                 0 as total_avg, 0 as qtt_avg   
          FROM FIN_BA_INVOICED B
          WHERE EXTRACT (month FROM B.proc_date) = (
                                                    SELECT EXTRACT (month FROM ADD_MONTHS(MAX(proc_date), -1))
                                                    FROM FIN_BA_INVOICED LAST 
                                                    WHERE LAST.CYCLE_CODE = B.CYCLE_CODE
                                                   )
          GROUP BY B.account_status, B.cycle_code 
        UNION ALL
          SELECT C.account_status, C.cycle_code, 0 as qtt_account, 0 as total_current, 0 as total_prev, 0 as qtt_prev, 
                 round(sum(C.total_current)/10, 2) total_avg, round(sum(C.qtt_account)/10, 2) qtt_avg 
          FROM FIN_BA_INVOICED C
          WHERE EXTRACT (month FROM C.proc_date) < (
                                                    SELECT EXTRACT (month FROM ADD_MONTHS(MAX(proc_date), -2))
                                                    FROM FIN_BA_INVOICED LAST 
                                                    WHERE LAST.CYCLE_CODE = C.CYCLE_CODE
                                                    )
          GROUP BY C.account_status, C.cycle_code 
    )
    GROUP BY account_status, cycle_code
    ) t,
    (
    SELECT cycle_code, sum(qtt_current_inv) qtt_current_inv, sum(qtt_avg_inv) qtt_avg_inv 
    FROM (
          SELECT D.cycle_code, sum(D.qtt_account) qtt_current_inv, 0 as qtt_avg_inv
          FROM FIN_BA_INVOICED D
          WHERE D.PROC_DATE = (SELECT MAX(PROC_DATE) FROM FIN_BA_INVOICED LAST WHERE LAST.CYCLE_CODE = D.CYCLE_CODE)
          GROUP BY D.cycle_code
        UNION ALL
          SELECT E.cycle_code, 0 as qtt_current, round(sum(qtt_account)/10, 2) qtt_avg_inv 
          FROM FIN_BA_INVOICED E
          WHERE EXTRACT (month from PROC_DATE) < (
                                                  SELECT extract (month from add_months(MAX(PROC_DATE), -2)) 
                                                  FROM FIN_BA_INVOICED LAST 
                                                  WHERE LAST.CYCLE_CODE = E.CYCLE_CODE
                                                 )
         GROUP BY E.cycle_code 
         )
    GROUP BY cycle_code 
    ) x
    WHERE t.cycle_code = x.cycle_code
);

CREATE OR REPLACE VIEW billchkow.FIN_DORMANT_INVOICED_VIEW (
   STATUS_ACCOUNT,
   STATUS_DORMANT,
   CYCLE_CD,
   QTT_ACCOUNT,
   ACCT_TOTAL_PREV,
   ACCT_TOTAL_AVG,
   TOTAL_BA,
   TOTAL_BA_AVG )
AS
(
SELECT status_account, status_dormant, cycle_cd, sum(qtt_acoount) qtt_account, sum(acct_total_prev) acct_total_prev,
       sum(acct_total_avg) acct_total_avg, (select count(1) from fin_ba_acc_dm_mview where cycle_code = cycle_cd) as total_ba,
       nvl((select round(sum(qtt_acoount)/10, 2) from fin_dormant_invoiced where cycle_code = cycle_cd 
       and extract (month from fat_date) < (select extract (month FROM ADD_MONTHS(MAX(fat_date), -2)) from fin_dormant_invoiced LAST 
       where LAST.cycle_code = cycle_cd)), 0) total_ba_avg
FROM (       
  select A.status_account, A.status_dormant, A.cycle_code as cycle_cd, A.qtt_acoount, 0 as acct_total_prev, 0 as acct_total_avg       
    from FIN_DORMANT_INVOICED A
    where fat_date = (SELECT MAX(fat_date) from FIN_DORMANT_INVOICED LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE)
 UNION
    select B.status_account, B.status_dormant, B.cycle_code, 0 as qtt_acoount, qtt_acoount as acct_total_prev, 0 as acct_total_avg        
    from FIN_DORMANT_INVOICED B
    where extract (month from fat_date) = (
                                           SELECT EXTRACT (month FROM ADD_MONTHS(MAX(fat_date), -1))
                                           FROM FIN_DORMANT_INVOICED LAST 
                                           WHERE LAST.CYCLE_CODE = B.CYCLE_CODE
                                          )
 UNION
    select C.status_account, C.status_dormant, C.cycle_code as cycle_cd, 0 as qtt_acoount, 0 as acct_total_prev, round(sum(qtt_acoount)/10, 2) acct_total_avg        
    from FIN_DORMANT_INVOICED C
    where extract (month from fat_date) < (
                                           SELECT EXTRACT (month FROM ADD_MONTHS(MAX(fat_date), -2))
                                           FROM FIN_DORMANT_INVOICED LAST 
                                           WHERE LAST.CYCLE_CODE = C.CYCLE_CODE
                                          )
    group by C.status_account, C.status_dormant, C.cycle_code
 UNION 
    select 'REL_DORMANT' as status_account, 'REL_DORMANT' as status_dormant, cycle_code, 
           (sum(mantida) - sum(retirada) + sum(inserida)) as qtt_acoount, 0 as acct_total_prev, 0 as acct_total_avg  
        from (
              select cycle_code, qtt_acoount as inserida, 0 as mantida, 0 as retirada 
              from FIN_DORMANT_INVOICED A
              where status_dormant = 'DORMANTS INSERIDAS'
              and fat_date = (select MAX(fat_date) from FIN_DORMANT_INVOICED LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE)
            UNION
              select cycle_code, 0 as inserida, qtt_acoount as mantida, 0 as retirada 
              from FIN_DORMANT_INVOICED B
              where status_dormant = 'DORMANTS MANTIDAS'
              and fat_date = (select MAX(fat_date) from FIN_DORMANT_INVOICED LAST WHERE LAST.CYCLE_CODE = B.CYCLE_CODE)
            UNION
              select cycle_code, 0 as inserida, 0 as mantida, qtt_acoount as retirada 
              from FIN_DORMANT_INVOICED C
              where status_dormant = 'DORMANTS RETIRADAS'
              and fat_date = (select MAX(fat_date) from FIN_DORMANT_INVOICED LAST WHERE LAST.CYCLE_CODE = C.CYCLE_CODE)
              )
     group by cycle_code
)
group by status_account, status_dormant, cycle_cd
);

CREATE MATERIALIZED VIEW billchkow.FIN_HB_INVOICED_MVIEW
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
SELECT t.nivel_value, t.nivel_type, t.cycle_code, sum(qtt_account) qtt_account, sum(qtt_avg) qtt_avg, sum(qtt_prev) qtt_prev, 
       sum(qtt_ba_current) qtt_ba_current, sum(qtt_ba_avg) qtt_ba_avg, sum(qtt_hb_current) qtt_hb_current, sum(qtt_hb_avg) qtt_hb_avg
FROM 
    (
    SELECT A.nivel_value, A.nivel_type, A.cycle_code, sum(A.qtt_account) qtt_account, 0 as qtt_avg, 0 as qtt_prev
    FROM FIN_HB_INVOICED A
    WHERE A.PROC_DATE = (SELECT MAX(PROC_DATE) FROM FIN_HB_INVOICED LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE)
    GROUP BY A.nivel_value, A.nivel_type, A.cycle_code
 UNION ALL
    SELECT B.nivel_value, B.nivel_type, B.cycle_code, 0 as qtt_account, 0 as qtt_avg, sum(B.qtt_account) qtt_prev
    FROM FIN_HB_INVOICED B
    WHERE EXTRACT (month from PROC_DATE) = (
                                             SELECT extract (month from add_months(MAX(PROC_DATE), -1)) 
                                             FROM FIN_HB_INVOICED LAST 
                                             WHERE LAST.CYCLE_CODE = B.CYCLE_CODE
                                           )
    GROUP BY B.nivel_value, B.nivel_type, B.cycle_code
 UNION ALL
    SELECT C.nivel_value, C.nivel_type, C.cycle_code, 0 as qtt_account, round(sum(qtt_account)/10, 2) qtt_avg, 0 as qtt_prev
    FROM FIN_HB_INVOICED C
    WHERE EXTRACT (month from PROC_DATE) = (
                                             SELECT extract (month from add_months(MAX(PROC_DATE), -2)) 
                                             FROM FIN_HB_INVOICED LAST 
                                             WHERE LAST.CYCLE_CODE = C.CYCLE_CODE
                                           )
    GROUP BY C.nivel_value, C.nivel_type, C.cycle_code
    ) t,
    (
    SELECT cycle_code, sum(qtt_ba_current) qtt_ba_current,  sum(qtt_ba_avg) qtt_ba_avg, sum(qtt_hb_current) qtt_hb_current, 
           sum(qtt_hb_avg) qtt_hb_avg
    FROM (       
    SELECT E.cycle_code, sum(qtt_account) qtt_ba_current, 0 as qtt_ba_avg, 0 as qtt_hb_current, 0 as qtt_hb_avg
    FROM FIN_HB_INVOICED E 
    WHERE PROC_DATE = (SELECT MAX(PROC_DATE) FROM FIN_HB_INVOICED LAST WHERE LAST.CYCLE_CODE = E.CYCLE_CODE) 
    AND NIVEL_TYPE = 'CONTAS PROCESSADAS'
    GROUP BY cycle_code
 UNION ALL
    SELECT F.cycle_code, 0 as qtt_ba_current, round(sum(qtt_account)/10, 2) qtt_ba_avg, 0 as qtt_hb_current, 0 as qtt_hb_avg
    FROM FIN_HB_INVOICED F
    WHERE EXTRACT (month from PROC_DATE) < (
                                               SELECT extract (month from add_months(MAX(PROC_DATE), -2)) 
                                               FROM FIN_HB_INVOICED LAST 
                                               WHERE LAST.CYCLE_CODE = F.CYCLE_CODE
                                              ) 
    AND NIVEL_TYPE = 'CONTAS PROCESSADAS'
    GROUP BY cycle_code
 UNION ALL
    SELECT E.cycle_code, 0 as qtt_ba_current, 0 as qtt_ba_avg, sum(qtt_account) as qtt_hb_current, 0 as qtt_hb_avg
    FROM FIN_HB_INVOICED E
    WHERE PROC_DATE = (SELECT MAX(PROC_DATE) FROM FIN_HB_INVOICED LAST WHERE LAST.CYCLE_CODE = E.CYCLE_CODE) 
    AND NIVEL_TYPE = 'HELD TOTAL'
    GROUP BY cycle_code
 UNION ALL
    SELECT F.cycle_code, 0 as qtt_ba_current, 0 as qtt_ba_avg, 0 as qtt_hb_current, round(sum(qtt_account)/10, 2) as qtt_hb_avg
    FROM FIN_HB_INVOICED F
    WHERE EXTRACT (month from PROC_DATE) < (
                                               SELECT extract (month from add_months(MAX(PROC_DATE), -2)) 
                                               FROM FIN_HB_INVOICED LAST 
                                               WHERE LAST.CYCLE_CODE = F.CYCLE_CODE
                                              ) 
    AND NIVEL_TYPE = 'HELD TOTAL'
    GROUP BY cycle_code
    ) GROUP BY cycle_code   
    ) x 
    WHERE t.cycle_code = x.cycle_code
    GROUP BY t.nivel_value, t.nivel_type, t.cycle_code
);

CREATE OR REPLACE VIEW billchkow.FIN_HB_INVOICED_VIEW (
   NIVEL_VALUE,
   CYCLE_CODE,
   QTT_ACCOUNT,
   QTT_AVG,
   QTT_PREV,
   QTT_BA_CURRENT,
   QTT_BA_AVG,
   QTT_HB_CURRENT,
   QTT_HB_AVG )
AS
(
        SELECT nivel_value, cycle_code, qtt_account, qtt_avg, qtt_prev, qtt_ba_current, qtt_ba_avg, qtt_hb_current,
               qtt_hb_avg
        FROM fin_hb_invoiced_mview
    UNION ALL
        SELECT DISTINCT 'Previsão para impressão' as nivel_value, cycle_code, (qtt_ba_current - qtt_hb_current) qtt_account, 
                         qtt_avg, qtt_prev, qtt_ba_current, qtt_ba_avg, qtt_hb_current, qtt_hb_avg
        FROM fin_hb_invoiced_mview 
);

CREATE OR REPLACE VIEW fin_hb_type_inv_view (
   nivel_value,
   nivel_type )
AS
( 
    SELECT nivel_value, nivel_type 
    FROM fin_hb_invoiced_mview 
  UNION All
    SELECT DISTINCT 'Previsão para impressão' as nivel_value, 'IMPRESSÃO' as nivel_type 
    FROM fin_hb_invoiced_mview
);

CREATE OR REPLACE VIEW billchkow.FIN_LD_INVOICED_VIEW (
   CYCLE_CD,
   ACCT_CONTABIL,
   SVC_NAME,
   STATE_CD,
   GEO_REGION,
   REPASSE,
   TARIFA,
   DESC_DET,
   TYPE_,
   MINUTOS,
   TOTAL_CALLS,
   CALLS_CURRENT,
   CALLS_PREV,
   CALLS_AVG,
   CALLS_TOTAL,
   CALLS_TOTAL_AVG )
AS
( 
 SELECT T.CYCLE_CD, ACCT_CONTABIL, SVC_NAME, STATE_CD, GEO_REGION, REPASSE, TARIFA, DESC_DET, TYPE_, SUM(MINUTOS) MINUTOS, 
        SUM(TOTAL_CALLS) TOTAL_CALLS, SUM(CALLS_CURRENT) CALLS_CURRENT, SUM(CALLS_PREV) CALLS_PREV, SUM(CALLS_AVG) CALLS_AVG, 
        SUM(CALLS_TOTAL) CALLS_TOTAL, SUM(CALLS_TOTAL_AVG) CALLS_TOTAL_AVG
  FROM (
        SELECT DISTINCT LDO.CYCLE_CD, LDO.ACCT_CONTABIL, LDO.SVC_NAME, LDO.STATE_CD, GEO.GEO_REGION, LDDP.REPASSE, 
               LDT.TARIFA, LDT.DESC_DET, LDDP.TYPE_, LDO.MINUTOS, LDO.TOTAL_CALLS, LDO.VALUE_CALLS AS CALLS_CURRENT, 0 AS CALLS_PREV, 0 AS CALLS_AVG
        FROM FIN_LD_ORIGINAL_FACT LDO, (SELECT DISTINCT TARIFA, DESCRIPTION, DESC_DET FROM FIN_LD_TRAFEGO_FACT WHERE description in ('VC2', 'VC3', 'AD', 'DDI')) LDT, 
             (SELECT DISTINCT ACCT_CONTABIL, SVC_NAME, REPASSE, TYPE_ from FIN_LD_DEPARA_FACT) LDDP, FIN_GEO_DM GEO
        WHERE LDO.type_ = LDT.TARIFA
        AND LDO.svc_name = LDDP.SVC_NAME
        AND LDO.STATE_CD = GEO.GEO_STATE
        AND LDO.CYCLE_DT = (SELECT MAX(CYCLE_DT) FROM FIN_LD_ORIGINAL_FACT LAST WHERE LAST.CYCLE_CD = LDO.CYCLE_CD)
      UNION 
        SELECT DISTINCT LDO.CYCLE_CD, LDO.ACCT_CONTABIL, LDO.SVC_NAME, LDO.STATE_CD, GEO.GEO_REGION, LDDP.REPASSE, 
               LDT.TARIFA, LDT.DESC_DET, LDDP.TYPE_, 0 AS MINUTOS, 0 AS TOTAL_CALLS, 0 AS CALLS_CURRENT, LDO.VALUE_CALLS AS CALLS_PREV, 0 AS CALLS_AVG
        FROM FIN_LD_ORIGINAL_FACT LDO, (SELECT DISTINCT TARIFA, DESCRIPTION, DESC_DET FROM FIN_LD_TRAFEGO_FACT WHERE description in ('VC2', 'VC3', 'AD', 'DDI')) LDT, 
             (SELECT DISTINCT ACCT_CONTABIL, SVC_NAME, REPASSE, TYPE_ from FIN_LD_DEPARA_FACT) LDDP, FIN_GEO_DM GEO
        WHERE LDO.type_ = LDT.TARIFA
        AND LDO.svc_name = LDDP.SVC_NAME
        AND LDO.STATE_CD = GEO.GEO_STATE
        AND EXTRACT (MONTH FROM LDO.CYCLE_DT) = (SELECT EXTRACT (MONTH FROM ADD_MONTHS(MAX(CYCLE_DT), -1)) FROM FIN_LD_ORIGINAL_FACT LAST WHERE LAST.CYCLE_CD = LDO.CYCLE_CD)
      UNION 
        SELECT DISTINCT LDO.CYCLE_CD, LDO.ACCT_CONTABIL, LDO.SVC_NAME, LDO.STATE_CD, GEO.GEO_REGION, LDDP.REPASSE, 
               LDT.TARIFA, LDT.DESC_DET, LDDP.TYPE_, 0 AS MINUTOS, 0 AS TOTAL_CALLS, 0 AS CALLS_CURRENT, 0 AS CALLS_PREV, ROUND(SUM(LDO.VALUE_CALLS)/10, 2) AS CALLS_AVG
        FROM FIN_LD_ORIGINAL_FACT LDO, (SELECT DISTINCT TARIFA, DESCRIPTION, DESC_DET FROM FIN_LD_TRAFEGO_FACT WHERE description in ('VC2', 'VC3', 'AD', 'DDI')) LDT, 
             (SELECT DISTINCT ACCT_CONTABIL, SVC_NAME, REPASSE, TYPE_ from FIN_LD_DEPARA_FACT) LDDP, FIN_GEO_DM GEO
        WHERE LDO.type_ = LDT.TARIFA
        AND LDO.svc_name = LDDP.SVC_NAME
        AND LDO.STATE_CD = GEO.GEO_STATE
        AND EXTRACT (MONTH FROM LDO.CYCLE_DT) < (SELECT EXTRACT (MONTH FROM ADD_MONTHS(MAX(CYCLE_DT), -2)) FROM FIN_LD_ORIGINAL_FACT LAST WHERE LAST.CYCLE_CD = LDO.CYCLE_CD)  
        GROUP BY LDO.CYCLE_CD, LDO.ACCT_CONTABIL, LDO.SVC_NAME, LDO.STATE_CD, GEO.GEO_REGION, LDDP.REPASSE, LDT.TARIFA, LDT.DESC_DET, LDDP.TYPE_
    ) T,
    (
        (SELECT CYCLE_CD, SUM(CALLS_TOTAL) CALLS_TOTAL, SUM(CALLS_TOTAL_AVG) CALLS_TOTAL_AVG
        FROM ( 
              SELECT CYCLE_CD, SUM(VALUE_CALLS) CALLS_TOTAL, 0 AS CALLS_TOTAL_AVG FROM (
              SELECT DISTINCT LDO.CYCLE_CD, LDO.ACCT_CONTABIL, LDO.SVC_NAME, LDO.STATE_CD, GEO.GEO_REGION, LDDP.REPASSE, 
                     LDT.TARIFA, LDT.DESC_DET, LDDP.TYPE_, LDO.MINUTOS, LDO.TOTAL_CALLS, LDO.VALUE_CALLS
              FROM FIN_LD_ORIGINAL_FACT LDO, (SELECT DISTINCT TARIFA, DESCRIPTION, DESC_DET FROM FIN_LD_TRAFEGO_FACT WHERE description in ('VC2', 'VC3', 'AD', 'DDI')) LDT, 
                   (SELECT DISTINCT ACCT_CONTABIL, SVC_NAME, REPASSE, TYPE_ from FIN_LD_DEPARA_FACT) LDDP, FIN_GEO_DM GEO
              WHERE LDO.type_ = LDT.TARIFA
              AND LDO.svc_name = LDDP.SVC_NAME
              AND LDO.STATE_CD = GEO.GEO_STATE
              AND LDO.CYCLE_DT = (SELECT MAX(CYCLE_DT) FROM FIN_LD_ORIGINAL_FACT LAST WHERE LAST.CYCLE_CD = LDO.CYCLE_CD))  
              GROUP BY CYCLE_CD       
            UNION 
              SELECT CYCLE_CD, 0 AS CALLS_TOTAL, ROUND(SUM(VALUE_CALLS)/10, 2) AS CALLS_TOTAL_AVG FROM (
              SELECT DISTINCT LDO.CYCLE_CD, LDO.ACCT_CONTABIL, LDO.SVC_NAME, LDO.STATE_CD, GEO.GEO_REGION, LDDP.REPASSE, 
                     LDT.TARIFA, LDT.DESC_DET, LDDP.TYPE_, LDO.MINUTOS, LDO.TOTAL_CALLS, LDO.VALUE_CALLS
              FROM FIN_LD_ORIGINAL_FACT LDO, (SELECT DISTINCT TARIFA, DESCRIPTION, DESC_DET FROM FIN_LD_TRAFEGO_FACT WHERE description in ('VC2', 'VC3', 'AD', 'DDI')) LDT, 
                   (SELECT DISTINCT ACCT_CONTABIL, SVC_NAME, REPASSE, TYPE_ from FIN_LD_DEPARA_FACT) LDDP, FIN_GEO_DM GEO
              WHERE LDO.type_ = LDT.TARIFA
              AND LDO.svc_name = LDDP.SVC_NAME
              AND LDO.STATE_CD = GEO.GEO_STATE
              AND EXTRACT (MONTH FROM LDO.CYCLE_DT) < (SELECT EXTRACT (MONTH FROM ADD_MONTHS(MAX(CYCLE_DT), -2)) FROM FIN_LD_ORIGINAL_FACT LAST WHERE LAST.CYCLE_CD = LDO.CYCLE_CD))             
              GROUP BY CYCLE_CD
             ) 
        GROUP BY CYCLE_CD)
    ) X
    WHERE T.CYCLE_CD = X.CYCLE_CD
    GROUP BY T.CYCLE_CD, ACCT_CONTABIL, SVC_NAME, STATE_CD, GEO_REGION, REPASSE, TARIFA, DESC_DET, TYPE_
);

CREATE OR REPLACE VIEW billchkow.FIN_BA_CUSTOMER_INVOICED_VIEW (
   CUSTOMER_TYPE,
   CYCLE_CODE,
   QTT_ACCOUNT,
   TOTAL_CURRENT,
   DUE_DATE,
   CUSTOMER_CLASS )
AS
(
    SELECT A.customer_type ||' - '|| B.customer_description as customer_type, A.cycle_code, sum(A.qtt_account) qtt_account, 
           sum(A.total_current) total_current, B.due_date, B.customer_class        
    FROM FIN_BA_INVOICED A, FIN_CUSTOMER_TYPE_DM B
    WHERE proc_date = (SELECT MAX(proc_date) FROM FIN_BA_INVOICED LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE)
    AND A.customer_type = B.customer_type
    GROUP BY A.customer_type, B.customer_description, A.cycle_code, B.due_date, B.customer_class         
);

CREATE OR REPLACE VIEW billchkow.FIN_BA_FACT_VIEW (
   ACCOUNT_NUMBER,
   CYCLE_DATE,
   CYCLE_ID,
   GEO_ID,
   CAPTN_ID,
   CURRENT_MONTH_BILLED,
   TOTAL_AMOUNT,
   TOTAL_AMOUNT_1,
   TOTAL_AMOUNT_2,
   TOTAL_AMOUNT_3,
   TOTAL_AMOUNT_AVG,
   TERMINAL_AMOUNT,
   DESVIO_AMOUNT,
   PARAMETER_AMOUNT,
   PARAMETER_PERCENT )
AS
(
    SELECT 
        account_number, cycle_date, cycle_id, geo_id, captn_id, current_month_billed, total_amount, 
        total_amount_1, total_amount_2, total_amount_3, total_amount_AVG, terminal_amount, desvio_amount,
        nvl((select PARAMETER_AMOUNT from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'BILLAMOUNT'), 0) as Parameter_Amount,
    	nvl((select PARAMETER_ITEM from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'BILLAMOUNT'), 0) as Parameter_Percent
    FROM FIN_BA_TOTAL_MVIEW 
);

-- Complemento do sql_drop3_aditional.sql no FULL

--View Materializada de total CAPTION_CODE
CREATE MATERIALIZED VIEW  BILLCHKOW.fin_cc_total_dm_mview 
AS
SELECT 
       acct_nbr, sbscrp_id, access_nbr, svc_name, caption_cd, prcng_comm_uf, last_bil, cycle_id, amt_current, amt_prev_1, amt_prev_2, 
       amt_prev_3, round((amt_prev_1 + amt_prev_2 + amt_prev_3)/3,2) amt_avg,
       round(SQRT ( (power( (amt_prev_1 - (amt_prev_1+amt_prev_2+amt_prev_3)/3), 2 ) + power( (amt_prev_2 - (amt_prev_1+amt_prev_2+amt_prev_3)/3), 2) + power( (amt_prev_3 - (amt_prev_1+amt_prev_2+amt_prev_3)/3), 2))/2), 2) desvio_valor       
FROM (
        SELECT distinct(access_nbr), acct_nbr, sbscrp_id, svc_name, caption_cd, prcng_comm_uf, last_bil, cy as cycle_id,       
            decode(extract(month from LAST_BIL),extract(month from sysdate), nvl(invn_charge_cr_amt, 0), 0) as amt_current,
            decode(extract(month from LAST_BIL),extract(month from add_months(sysdate,-1)), nvl(invn_charge_cr_amt, 0), 0) as amt_prev_1,
            decode(extract(month from LAST_BIL),extract(month from add_months(sysdate,-2)), nvl(invn_charge_cr_amt, 0), 0) as amt_prev_2,
            decode(extract(month from LAST_BIL),extract(month from add_months(sysdate,-3)), nvl(invn_charge_cr_amt, 0), 0) as amt_prev_3     
        from fin_captioncode_fact
        Where extract(month from LAST_BIL) between (extract(month from add_months(sysdate,-3))) and (extract(month from sysdate))
    );
    
CREATE MATERIALIZED VIEW  BILLCHKOW.fin_cc_total_mview
AS
SELECT 
      cc.acct_nbr, cc.sbscrp_id, cc.access_nbr, cc.svc_name, cc.caption_cd, cc.prcng_comm_uf, cc.last_bil, cc.cycle_id, cc.amt_current, cc.amt_prev_1, cc.amt_prev_2,  cc.amt_prev_3, 
      cc.amt_avg, cc.desvio_valor, decode((ba.account_number),null, 1, 0) as FLAG_BA
FROM fin_cc_total_dm_mview cc, fin_billamount_fact ba
where cc.acct_nbr = ba.account_number (+) and cc.cycle_id = ba.cycle_code(+) and cc.caption_cd = ba.caption_code(+);

--View de CAPTION_CODE
CREATE or replace VIEW BILLCHKOW.fin_cc_fact_view (
   acct_nbr, sbscrp_id, access_nbr, svc_name, captn_id, prcng_comm_uf, last_bil, cycle_id, amt_current, amt_prev_1,
   amt_prev_2, amt_prev_3, amt_avg, desvio_valor, flag_ba, parameter_amount, parameter_percent )
AS
(
   SELECT 
        CC.acct_nbr, CC.sbscrp_id, CC.access_nbr, CC.svc_name, C.objid as captn_id, CC.prcng_comm_uf, CC.last_bil, 
        CC.cycle_id, CC.amt_current, CC.amt_prev_1, CC.amt_prev_2, CC.amt_prev_3, CC.amt_avg, CC.desvio_valor,
        cc.flag_ba,         
        nvl((select PARAMETER_AMOUNT from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'CAPTN_CODE'), 0) as Parameter_Amount,
   	    nvl((select PARAMETER_ITEM from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'CAPTN_CODE'), 0) as Parameter_Percent
    FROM FIN_CC_TOTAL_MVIEW CC, FIN_CAPTION_DM C
    WHERE C.captn_cd = CC.caption_cd
);

CREATE MATERIALIZED VIEW BILLCHKOW.fin_dr_invoiced_mview
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
(
select captn_cd, cycle_cd, state, sum(valor_estimado) valor_estimado, sum(valor_realizado) valor_realizado, sum(valor_realizado_ant) valor_realizado_ant
FROM (
    SELECT b.captn_cd, a.cycle_cd, a.state, sum(amount_gross_calls) valor_estimado, 0 as valor_realizado, 0 as valor_realizado_ant
    FROM fin_dr_fact a, fin_caption_dm b 
    WHERE a.caption_text = b.captn_text
    AND a.fat_dt = (SELECT MAX(fat_dt) FROM fin_dr_fact LAST WHERE LAST.CYCLE_CD = A.CYCLE_CD)
    GROUP BY b.captn_cd, a.cycle_cd, a.state
  UNION ALL
    SELECT b.captn_cd, a.cycle_id as cycle_cd, a.geo_id as state, 0 as valor_estimado, sum(amount) valor_realizado, 0 as valor_realizado_ant    
    FROM fin_cci_fact a, fin_caption_dm b
    WHERE a.captn_id = b.objid
    AND a.last_bill_date = (SELECT MAX(LAST_BILL_DATE) FROM FIN_CCI_FACT LAST WHERE LAST.CYCLE_ID = A.CYCLE_ID)
    AND a.tot_minutes <> 0
    GROUP BY b.captn_cd, a.cycle_id, a.geo_id
  UNION ALL
    SELECT b.captn_cd, a.cycle_id as cycle_cd, a.geo_id as state, 0 as valor_estimado, 0 as valor_realizado, sum(amount) valor_realizado_ant    
    FROM fin_cci_fact a, fin_caption_dm b
    WHERE a.captn_id = b.objid
    AND EXTRACT (month from a.last_bill_date) = (SELECT EXTRACT (month from add_months(MAX(LAST_BILL_DATE), -1)) FROM FIN_CCI_FACT LAST WHERE LAST.CYCLE_ID = A.CYCLE_ID)
    AND a.tot_minutes <> 0
    GROUP BY b.captn_cd, a.cycle_id, a.geo_id
)
WHERE valor_estimado <> 0
GROUP BY captn_cd, cycle_cd, state
);

insert into BILLCHKOW.AST_PARAM_CONFIG values (100, '/opt/Billc/jbpm', 'JbpmWeb', '', 'Local para Upload de Arquivo de Comentarios');
insert into BILLCHKOW.AST_PARAM_CONFIG values (200, '/opt/Billc', 'InvoiceView', '', 'Local para adicionar arquivos do InvoiceView');

commit;

-- Selecao de Grupo de Regras

-- dropping Rule Groups Selection's tables and sequences
DROP TABLE BILLCHKOW.bck_rule_list CASCADE CONSTRAINTS;
DROP TABLE BILLCHKOW.bck_rule_group CASCADE CONSTRAINTS;
DROP TABLE BILLCHKOW.bck_rule_group_list CASCADE CONSTRAINTS;
DROP TABLE BILLCHKOW.bck_rule_exec_hist CASCADE CONSTRAINTS;
DROP SEQUENCE BILLCHKOW.bck_rule_list_seq;
DROP SEQUENCE BILLCHKOW.bck_rule_group_seq;

-- creating tables and sequences for Rule Groups Selection funcionality
CREATE TABLE BILLCHKOW.bck_rule_list
    (package_id                     NUMBER(10,0) NOT NULL,
    description                    VARCHAR2(64),
    relative_base                  VARCHAR2(128) NOT NULL,
    mask                           VARCHAR2(64) NOT NULL,
    always_run_flg                 VARCHAR2(1),
    user_visible                   VARCHAR2(1),
  PRIMARY KEY (package_id)
  USING INDEX TABLESPACE TI_BILLCPR1)
  TABLESPACE TD_BILLCPR1;

CREATE TABLE BILLCHKOW.bck_rule_group
    (group_id                       NUMBER(10,0) NOT NULL,
    group_name                     VARCHAR2(128) NOT NULL,
    runnable_flg                   VARCHAR2(1),
  PRIMARY KEY (group_id)
  USING INDEX TABLESPACE TI_BILLCPR1)
  TABLESPACE TD_BILLCPR1;

ALTER TABLE BILLCHKOW.bck_rule_group
ADD CONSTRAINT bck_rule_group_uk1 UNIQUE (group_name)
USING INDEX TABLESPACE TI_BILLCPR1;

CREATE TABLE BILLCHKOW.bck_rule_group_list
    (group_uid                      NUMBER(10,0) NOT NULL,
    package_uid                    NUMBER(10,0) NOT NULL)
  TABLESPACE TD_BILLCPR1;

ALTER TABLE BILLCHKOW.bck_rule_group_list
ADD CONSTRAINT fk_rule_list_id FOREIGN KEY (package_uid)
REFERENCES BILLCHKOW.bck_rule_list (package_id) ON DELETE CASCADE;

ALTER TABLE BILLCHKOW.bck_rule_group_list
ADD CONSTRAINT fk_rule_group_id FOREIGN KEY (group_uid)
REFERENCES BILLCHKOW.bck_rule_group (group_id) ON DELETE CASCADE;

CREATE TABLE BILLCHKOW.bck_rule_exec_hist
    (request_uid                    NUMBER NOT NULL,
    package_uid                    NUMBER(10,0) NOT NULL)
  TABLESPACE TD_BILLCPR1;

CREATE UNIQUE INDEX BILLCHKOW.bck_rule_exec_hist_pk ON BILLCHKOW.bck_rule_exec_hist
  (
    "REQUEST_UID" DESC,
    package_uid                     ASC
  )
  TABLESPACE TD_BILLCPR1;

ALTER TABLE BILLCHKOW.bck_rule_exec_hist
ADD CONSTRAINT fk_rule_exec_id FOREIGN KEY (request_uid)
REFERENCES BILLCHKOW.web_request (request_id);

CREATE SEQUENCE BILLCHKOW.BCK_RULE_LIST_SEQ
 START WITH 200
 INCREMENT BY 1
 MAXVALUE 9999999999;
 
CREATE SEQUENCE BILLCHKOW.BCK_RULE_GROUP_SEQ
 START WITH 2
 INCREMENT BY 1
 MAXVALUE 9999999999;

-- populating tables for Rule Groups Selection (Billcheckout Version 4, Drop 3)
INSERT INTO BILLCHKOW.bck_rule_group
VALUES (1,'Regras Release Drop 3','X');

INSERT INTO BILLCHKOW.bck_rule_list
VALUES (0,'Inicialização','conf/drools/','INIT*.drl','X',NULL);
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (1,'Tarifação','conf/drools/','R01*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (2,'Temporização de Mínima de Chamadas','conf/drools/','R02*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (4,'Cobrancas no Boleto de Pagamento','conf/drools/','R04*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (5,'Concessão de Benefícios sobre Uso','conf/drools/','R05*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (6,'Duplicidade e Sobreposição de Chamadas','conf/drools/','R06_R07*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (8,'Período Mensalidade','conf/drools/','R08*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (9,'Código de Barras','conf/drools/','R09*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (10,'Chamadas Fora da Ordem Cronológica','conf/drools/','R10*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (11,'Vigência das Chamadas','conf/drools/','R11*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (13,'Tarifa de Assinatura','conf/drools/','R13*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (16,'Tarifas Passthrough','conf/drools/','R16*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (19,'Tarifacao AD1 e DSL1','conf/drools/','R19*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (20,'Desconto Progressivo','conf/drools/','R20*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (30,'Tarifação Favoritos','conf/drools/','R30*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (31,'Tarifação Intra-grupo','conf/drools/','R31*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (32,'Demonstração na Seção Correta','conf/drools/','R32*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (40,'Terminais Faturados','conf/drools/','R40*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (47,'Data de Vencimento','conf/drools/','R47*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (50,'Tarifação de Uso Negociado','conf/drools/','R50*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (52,'Dados Cadastrais do Cliente','conf/drools/','R52*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (53,'Produtos x Tecnologia do Aparelho','conf/drools/','R53*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (54,'FUST e FUNNTEL','conf/drools/','R54*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (55,'Negociação Obrigatória','conf/drools/','R55*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (56,'Ordem da Prioridade de Consumo','conf/drools/','R56*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (57,'Produto x Tipo de Cliente x Cliente CNPJ','conf/drools/','R57*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (59,'Estado do Teminal Diferente da Conta','conf/drools/','R59*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (60,'ICMS na Nota Fiscal','conf/drools/','R60*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (62,'Quantidade de Parcelas do Aparelho','conf/drools/','R62*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (63,'Convivência entre os Produtos','conf/drools/','R63*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (64,'Mês e Período da Fatura','conf/drools/','R64*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (65,'Sumário das Notas Fiscais','conf/drools/','R65*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (66,'Período da Concessão do Benefício','conf/drools/','R66*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (68,'Multa de Fidelização','conf/drools/','R68*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (69,'Multa e Juros Indevido','conf/drools/','R69_82*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (71,'Serviço Gestão','conf/drools/','R71*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (73,'Serviço Avulso','conf/drools/','R73*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (74,'Serviço de Compartilhamento','conf/drools/','R74*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (75,'Série e Sub-Série das Notas Fiscais','conf/drools/','R75*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (78,'Tipo de Cliente','conf/drools/','R78*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (83,'Informações Incompletas','conf/drools/','R83*.drl',NULL,'X');

INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,1);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,2);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,4);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,5);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,6);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,8);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,9);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,10);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,11);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,13);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,16);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,19);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,20);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,30);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,31);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,32);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,40);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,47);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,50);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,52);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,53);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,54);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,55);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,56);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,57);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,59);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,60);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,62);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,63);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,64);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,65);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,66);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,68);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,69);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,71);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,73);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,74);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,75);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,78);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,83);

-- populating user permissions
insert into BILLCHKOW.auth_role (objid, role_name, static_cardnlt, role_status, description, custom_1, custom_2, custom_3)
values (auth_sequence.nextval, 'RulesGroupEditor', 0, 'A', 'Seleção de Grupos de Regras: Visualização e Edição', null, null, null);

COMMIT;

-- CREATE TABLE
CREATE TABLE BCK_DASH_BOARD
(
    MODULE_ID       NUMBER,
    MODULE_NAME     VARCHAR2(64),
    MODULE_DESC     VARCHAR2(128),
    FUNCTION        VARCHAR2(64)         
);

ALTER TABLE BCK_DASH_BOARD ADD CONSTRAINT BCK_DASH_BOARD_PK
PRIMARY KEY (MODULE_ID); 

CREATE TABLE BCK_DASH_BOARD_ITEM
(
    MODULE_ID       NUMBER,  -- FK
    ITEM_ID         NUMBER,
    ITEM_NAME       VARCHAR2(64),
    ITEM_WEIGHT     NUMBER(10,5),
    COMPLETED       NUMBER(10,9),  -- 0 = não começou    1 = terminou
    DISABLED_FLAG   CHAR(1),       -- 0 = ativo          1 = inativo 
    CYCLE_CODE      VARCHAR2(2)    
);

ALTER TABLE BCK_DASH_BOARD_ITEM ADD CONSTRAINT BCK_DASH_BOARD_ITEM_PK
PRIMARY KEY (MODULE_ID, ITEM_ID, CYCLE_CODE);

ALTER TABLE BCK_DASH_BOARD_ITEM ADD CONSTRAINT BCK_DASH_BOARD_ITEM_FK1
FOREIGN KEY (MODULE_ID) REFERENCES BCK_DASH_BOARD (MODULE_ID);

CREATE TABLE BCK_LOAD_PROCESS_STATUS
(
    MODULE_ID       NUMBER,  -- FK
    ITEM_ID         NUMBER,  -- FK   
    CYCLE_CODE      VARCHAR2(2),
    CUT_DATE        DATE,
    INIT_QTT_LOAD   NUMBER,
    END_QTT_LOAD    NUMBER,
    START_DATE      DATE,
    END_DATE        DATE    
);

ALTER TABLE BCK_LOAD_PROCESS_STATUS ADD CONSTRAINT BCK_LOAD_PROCESS_STATUS_FK1
FOREIGN KEY (MODULE_ID, ITEM_ID, CYCLE_CODE) REFERENCES BCK_DASH_BOARD_ITEM (MODULE_ID, ITEM_ID, CYCLE_CODE);

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CREATE PROCEDURE
CREATE OR REPLACE PACKAGE dashboard IS
    PROCEDURE refresh_start_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2, v_cut_date DATE, v_start_date DATE);
    PROCEDURE refresh_end_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2, v_init_qtt_load INTEGER, v_end_qtt_load INTEGER, v_end_date DATE);
END dashboard;

CREATE OR REPLACE PACKAGE BODY dashboard AS 
    -- start processing
    PROCEDURE refresh_start_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2, v_cut_date DATE, v_start_date DATE) IS
        var_module_id INTEGER;
        var_item_id   INTEGER;
    BEGIN
        SELECT module_id INTO var_module_id 
        FROM BCK_DASH_BOARD 
        WHERE module_name = v_module_name;

        SELECT item_id INTO var_item_id 
        FROM BCK_DASH_BOARD_ITEM 
        WHERE item_name = v_item_name
        AND module_id = var_module_id
        AND cycle_code = v_cycle_code;        
   
        UPDATE BCK_LOAD_PROCESS_STATUS 
        SET cut_date=v_cut_date, start_date=v_start_date, end_date=null, end_qtt_load=0, init_qtt_load=0
        WHERE module_id = var_module_id
        AND item_id = var_item_id
        AND cycle_code = v_cycle_code;
        
        UPDATE BCK_DASH_BOARD_ITEM 
        SET completed = 0 
        WHERE module_id = var_module_id
        AND item_id = var_item_id
        AND cycle_code = v_cycle_code;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('NO DATA FOUND');
    END refresh_start_processing;
    
    -- end processing
    PROCEDURE refresh_end_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2,
                                      v_init_qtt_load INTEGER, v_end_qtt_load INTEGER, v_end_date DATE) IS
        var_module_id INTEGER;
        var_item_id   INTEGER;
    BEGIN
       SELECT module_id INTO var_module_id 
       FROM BCK_DASH_BOARD 
       WHERE module_name = v_module_name;
   
       SELECT item_id INTO var_item_id 
       FROM BCK_DASH_BOARD_ITEM 
       WHERE item_name = v_item_name
       AND module_id = var_module_id
       AND cycle_code = v_cycle_code;
   
       UPDATE BCK_LOAD_PROCESS_STATUS 
       SET init_qtt_load = v_init_qtt_load, end_qtt_load = v_end_qtt_load, end_date = v_end_date 
       WHERE module_id = var_module_id
       AND item_id = var_item_id
       AND cycle_code = v_cycle_code;
   
       UPDATE BCK_DASH_BOARD_ITEM 
       SET completed = 1 
       WHERE module_id = var_module_id
       AND item_id = var_item_id
       AND cycle_code = v_cycle_code;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('NO DATA FOUND');
    END refresh_end_processing;
END dashboard;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- INSERT DADOS
INSERT INTO BCK_DASH_BOARD VALUES (1,'HELD BILL','Relatório de Contas não impressas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (2,'BILL AMOUNT','Relatório Total Faturado.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (3,'CAPTION CODE','Relatório Faturado por Captions.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (4,'DORMANT','Relatório de Contas não faturadas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (5,'JUROS E MULTAS','Relatório de Juros e Multas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (6,'RECEITA DIARIA','Relatório de Receita Diária.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (7,'CCI','Relatório CCI.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (8,'LONGA DISTANCIA','Relatório de Chamadas Longa Distância.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (9,'DRP SUMMARY','Relatório de Chamadas Dropadas e Não Dropadas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (10,'CONTAS FINANCEIRAS','Relatório de Contas Financeiras.', 'BCK016A');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (11,'SPLITBILLING','Relatório de Split Billing.', 'BCK014');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'78',SYSDATE,0,0,null,null);

commit;
