-------------TABLES-------------------
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

--------------Juros e Multa--------------
CREATE TABLE fin_jm_jm_fact
(
    account_number                 VARCHAR2(10) NOT NULL,
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
    pnlty_intrst_amt               NUMBER(14,2),
    free_jm_flag                   VARCHAR2(1))
);

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
CREATE TABLE fin_drpsummary_fact
(
    state_code                     VARCHAR2(2),
    drop_calls                     NUMBER(19,0),
    duration_drop_calls            NUMBER(17,3),
    calls                          NUMBER(19,0),
    duration_calls                 NUMBER(17,3),
    cycle_code                     VARCHAR2(2),
    cut_date                       DATE,
    proc_flag                      VARCHAR2(1)
);

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
 
--DIAS PONDERADOS
CREATE TABLE fin_days_weighted_fact
(
    cycle_code                     VARCHAR2(2),
    cut_day                        VARCHAR2(2),
    cut_date                       DATE,
    value_sp                       NUMBER(19,5), 
    value_rs                       NUMBER(19,5), 
    value_ba_se                    NUMBER(19,5), 
    value_rj                       NUMBER(19,5), 
    value_es                       NUMBER(19,5), 
    value_gt                       NUMBER(19,5), 
    value_co_n                     NUMBER(19,5), 
    value_ne                       NUMBER(19,5), 
    value_mg                       NUMBER(19,5), 
    value_vivo                     NUMBER(19,5), 
    var_percent_sp                 NUMBER(19,5), 
    var_percent_rs                 NUMBER(19,5), 
    var_percent_ba_se              NUMBER(19,5), 
    var_percent_rj                 NUMBER(19,5), 
    var_percent_es                 NUMBER(19,5), 
    var_percent_gt                 NUMBER(19,5), 
    var_percent_co_n               NUMBER(19,5), 
    var_percent_ne                 NUMBER(19,5), 
    var_percent_mg                 NUMBER(19,5), 
    var_percent_vivo               NUMBER(19,5), 
    var_qtt_sp                     NUMBER(19,5), 
    var_qtt_rs                     NUMBER(19,5), 
    var_qtt_ba_se                  NUMBER(19,5), 
    var_qtt_rj                     NUMBER(19,5), 
    var_qtt_es                     NUMBER(19,5), 
    var_qtt_gt                     NUMBER(19,5), 
    var_qtt_co_n                   NUMBER(19,5), 
    var_qtt_ne                     NUMBER(19,5), 
    var_qtt_mg                     NUMBER(19,5), 
    var_qtt_vivo                   NUMBER(19,5) 
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
REFRESH ON DEMAND
  WITH ROWID
AS
(
  SELECT 
    F.Account_Number, F.Cycle_Date, F.Cycle_Code as cycle_id, F.Property as geo_id, F.Current_Month_Billed, F.Total_Amount, F.Total_Amount_1,
    F.Total_Amount_2, F.Total_Amount_3, F.Terminal_Amount, CAPTION_CODE,
    (Total_Amount_1 + Total_Amount_2 + Total_Amount_3)/3 as Total_Amount_AVG,
    (Total_Amount + Total_Amount_1 + Total_Amount_2 + Total_Amount_3)/4 as AVG_DM
  FROM FIN_BILLAMOUNT_FACT F
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
CREATE MATERIALIZED VIEW BILLCHKOW.fin_hb_fact_mview
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

CREATE MATERIALIZED VIEW BILLCHKOW.fin_hb_motivo_held_dm_mview 
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
   duration_calls,
   duration_drop_calls,
   qtt_calls,
   qtt_calls_prev,
   qtt_calls_avg,
   qtt_current,
   qtt_avg )
AS
(
    SELECT NIVEL_TYPE, STATE_CODE, CYCLE_CODE, SUM(duration_calls) duration_calls, SUM(duration_drop_calls) duration_drop_calls, SUM(QTT_CALLS) QTT_CALLS, 
           SUM(QTT_CALLS_PREV) QTT_CALLS_PREV, SUM(QTT_CALLS_AVG) QTT_CALLS_AVG,
          (select sum(DROP_CALLS + CALLS) QTT_CURRENT 
            from FIN_DRPSUMMARY_FACT where CYCLE_CODE = CYCLE_CODE 
            and CUT_DATE = (SELECT MAX(CUT_DATE) from FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = CYCLE_CODE) group by CYCLE_CODE 
           ) as QTT_CURRENT,
           nvl((select round(sum(DROP_CALLS + CALLS)/11, 2) QTT_CURRENT 
                from FIN_DRPSUMMARY_FACT 
                where CYCLE_CODE = CYCLE_CODE 
                and extract (month from CUT_DATE) = (SELECT extract (month from add_months(MAX(CUT_DATE), -1)) from FIN_DRPSUMMARY_FACT LAST 
                where LAST.CYCLE_CODE = CYCLE_CODE) group by CYCLE_CODE)
            , 0) as QTT_AVG
    FROM (
        (SELECT 'CHAMADAS NÃO FATURADAS' AS NIVEL_TYPE, A.STATE_CODE, A.CYCLE_CODE, 0 as duration_calls, A.duration_drop_calls, A.DROP_CALLS AS QTT_CALLS, 0 AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT A
         WHERE CUT_DATE = (SELECT MAX(CUT_DATE) from FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE)
      UNION ALL
         SELECT 'CHAMADAS FATURADAS' AS NIVEL_TYPE, A.STATE_CODE, A.CYCLE_CODE, A.duration_calls, 0 as duration_drop_calls, A.CALLS AS QTT_CALLS, 0 AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT A
         WHERE CUT_DATE = (SELECT MAX(CUT_DATE) from FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = A.CYCLE_CODE))
      UNION
        (SELECT 'CHAMADAS NÃO FATURADAS' AS NIVEL_TYPE, B.STATE_CODE, B.CYCLE_CODE, 0 AS duration_calls, 0 AS duration_drop_calls, 0 AS QTT_CALLS, B.DROP_CALLS AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG 
         FROM FIN_DRPSUMMARY_FACT B
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -1)) FROM FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = B.CYCLE_CODE)
        UNION ALL 
         SELECT 'CHAMADAS FATURADAS' AS NIVEL_TYPE, B.STATE_CODE, B.CYCLE_CODE, 0 AS duration_calls, 0 AS duration_drop_calls, 0 AS QTT_CALLS, B.CALLS AS QTT_CALLS_PREV, 0 AS QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT B
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -1)) FROM FIN_DRPSUMMARY_FACT LAST WHERE LAST.CYCLE_CODE = B.CYCLE_CODE))
      UNION 
        (SELECT 'CHAMADAS NÃO FATURADAS' AS NIVEL_TYPE, C.STATE_CODE, C.CYCLE_CODE, 0 AS duration_calls, 0 AS duration_drop_calls, 0 AS QTT_CALLS, 0 AS QTT_CALLS_PREV, ROUND(SUM(C.DROP_CALLS)/10) QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT C
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -2)) FROM FIN_DRPSUMMARY_FACT LAST  WHERE LAST.CYCLE_CODE = C.CYCLE_CODE)
         GROUP BY C.STATE_CODE, C.CYCLE_CODE
        UNION ALL  
         SELECT 'CHAMADAS FATURADAS' AS NIVEL_TYPE, C.STATE_CODE, C.CYCLE_CODE, 0 AS duration_calls, 0 AS duration_drop_calls, 0 AS QTT_CALLS, 0 AS QTT_CALLS_PREV, ROUND(SUM(C.DROP_CALLS)/10) QTT_CALLS_AVG
         FROM FIN_DRPSUMMARY_FACT C
         WHERE EXTRACT (month FROM CUT_DATE) = (SELECT EXTRACT (month FROM ADD_MONTHS(MAX(CUT_DATE), -2)) FROM FIN_DRPSUMMARY_FACT LAST  WHERE LAST.CYCLE_CODE = C.CYCLE_CODE)
         GROUP BY C.STATE_CODE, C.CYCLE_CODE)  
     )
    GROUP BY NIVEL_TYPE, STATE_CODE, CYCLE_CODE
);

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
CREATE MATERIALIZED VIEW billchkow.FIN_dco_fact_mview AS
(
SELECT 
       acct_nbr ,access_nbr, FLAG, SVC_NAME, DORMANT_FLAG_CD, decode(SUBSTR(CUST_ID_TEXT, 1, 8),'02449992',1,0) as FLAG_CNPJ_VIVO,
       decode(DORMANT_FLAG_CD,'Y',1,0) as FLAG_ACC_ATIVA, FLAG_CURRENT, FLAG_LAST_MONTH
FROM (
        SELECT acct_nbr, access_nbr, FLAG, SVC_NAME, SVC_AGRMNT_EFF_DT, 
            SVC_AGRMNT_TRMNTN_DT, DORMANT_FLAG_CD, CUST_ID_TEXT,       
            decode(extract(month from SVC_AGRMNT_TRMNTN_DT), (SELECT extract(month from max(SVC_AGRMNT_TRMNTN_DT)) FROM FIN_DORMANT_COLABORADOR_FACT), 
            decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_CURRENT,
            decode(extract(month from SVC_AGRMNT_TRMNTN_DT), (SELECT extract(month from add_months(max(SVC_AGRMNT_TRMNTN_DT), -1)) FROM FIN_DORMANT_COLABORADOR_FACT),    
            decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_LAST_MONTH          
        from FIN_DORMANT_COLABORADOR_FACT
        Where extract(month from SVC_AGRMNT_TRMNTN_DT) between (SELECT extract(month from add_months(max(SVC_AGRMNT_TRMNTN_DT), -1)) FROM FIN_DORMANT_COLABORADOR_FACT) 
        and (SELECT extract(month from max(SVC_AGRMNT_TRMNTN_DT)) FROM FIN_DORMANT_COLABORADOR_FACT)
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
 
CREATE MATERIALIZED VIEW BILLCHKOW.FIN_DR_SUM_MVIEW
AS
SELECT caption_text, state, cycle_cd, sum(qtt_calls) as qtt_calls, sum(amount_gross_calls) as amount_gross_calls 
FROM fin_dr_fact GROUP BY caption_text, state, cycle_cd ORDER BY caption_text;

CREATE MATERIALIZED VIEW BILLCHKOW.fin_dr_cci_fact_mview
as
(
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
);

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

CREATE MATERIALIZED VIEW billchkow.fin_jm_capt_total_mview
BUILD IMMEDIATE 
REFRESH ON DEMAND
AS
( 
select account_number, cycle_cd as cycle_id, sum(juros_amt) juros_amt, sum(multa_amt) multa_amt, sum (juros_amt + multa_amt) total_jm
from
(
    select account_number, cycle_cd, nvl(charge_cr_amt, 0) as juros_amt, 0 as multa_amt
     from fin_jm_capt_fact
     where captn_cd = 'XJROS2'
     and LAST_BILL_DATE = (SELECT max(LAST_BILL_DATE) from fin_jm_capt_fact)
   UNION ALL
    select account_number, cycle_cd, 0 as juros_amt, nvl(charge_cr_amt, 0) as multa_amt
     from fin_jm_capt_fact
     where captn_cd = 'XMULTA2'
     and LAST_BILL_DATE = (SELECT max(LAST_BILL_DATE) from fin_jm_capt_fact)
)
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

CREATE OR REPLACE VIEW BILLCHKOW.FIN_JM_EXEMPTION_FACT_VIEW (
   account_number,
   geo_id,
   cycle_id,
   cycle_cut_date,
   qtt_del_dt,
   bill_pymt_due_dt,
   pnlty_intrst_type_id,
   long_dstn_carr_id,
   pnlty_intrst_amt

  )
AS
(
    SELECT a.account_number, a.doc_state as geo_id, a.cycle_code as cycle_id, a.cycle_cut_date, a.qtt_del_dt,  
       a.bill_pymt_due_dt, a.pnlty_intrst_type_id, a.long_dstn_carr_id, a.pnlty_intrst_amt
      FROM fin_jm_jm_fact a
  WHERE A.cycle_cut_date = (SELECT MAX(cycle_cut_date) FROM fin_jm_jm_fact LAST WHERE LAST.cycle_code = A.cycle_code)
  AND FREE_JM_FLAG = '1'
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

CREATE OR REPLACE VIEW BILLCHKOW.fin_cci_invoiced_view
AS
(
select t.captn_cd, t.cycle_id, t.geo_id, sum(amount_current) amount_current, sum(calls_current) calls_current, sum(amount_avg) amount_avg, 
       sum(call_avg) call_avg, sum(tot_seconds) tot_seconds, sum(tot_minutes) tot_minutes, 
       sum(amount_prev) amount_prev, sum(call_prev) call_prev,
       (select sum(amount) from fin_cci_invoiced D
        where extract (month from LAST_BILL_DT) = (SELECT extract (month from MAX(LAST_BILL_DT)) 
                                                   FROM fin_cci_invoiced LAST 
                                                   WHERE LAST.CYCLE_ID = t.CYCLE_ID)) as total_amount_inv,
       (select round(sum(nvl(amount, 0))/11, 2) from fin_cci_invoiced E
        where extract (month from LAST_BILL_DT) <= (SELECT extract (month from add_months(MAX(LAST_BILL_DT), -1)) 
                                                    FROM fin_cci_invoiced LAST 
                                                    WHERE LAST.CYCLE_ID = E.CYCLE_ID)) as total_amount_inv_avg 
FROM 
    (
    select A.captn_cd, A.cycle_id, A.geo_id, sum(A.amount) amount_current, sum(A.qtt_calls) calls_current, 
           0 as amount_avg, 0 as call_avg, sum(A.tot_seconds) tot_seconds, sum(A.tot_minutes) tot_minutes, 
           0 as amount_prev, 0 as call_prev  
    from fin_cci_invoiced A
    where extract (month from LAST_BILL_DT) = (SELECT extract (month from MAX(LAST_BILL_DT)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = A.CYCLE_ID)
    group by A.captn_cd, A.cycle_id, A.geo_id
  UNION ALL
    select B.captn_cd, B.cycle_id, B.geo_id, 0 as amount_current, 0 as calls_current, round(sum(B.amount)/11, 2) amount_avg, 
           round(sum(B.qtt_calls)/11, 2) call_avg, 0 as tot_seconds, 0 as tot_minutes, 0 as amount_prev, 0 as call_prev
    from fin_cci_invoiced B
    where extract (month from LAST_BILL_DT) <= (SELECT extract (month from add_months(MAX(LAST_BILL_DT), -1)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = B.CYCLE_ID)
    group by B.captn_cd, B.cycle_id, B.geo_id
  UNION ALL
    select C.captn_cd, C.cycle_id, C.geo_id, 0 as amount_current, 0 as calls_current, 0 as amount_avg, 0 as call_avg,
           0 as tot_seconds, 0 as tot_minutes, sum(C.amount) amount_prev, sum(C.qtt_calls) call_prev 
    from fin_cci_invoiced C
    where extract (month from LAST_BILL_DT) = (SELECT extract (month from add_months(MAX(LAST_BILL_DT), -1)) 
                                               FROM fin_cci_invoiced LAST 
                                               WHERE LAST.CYCLE_ID = C.CYCLE_ID)
    group by C.captn_cd, C.cycle_id, C.geo_id
    ) t
group by t.captn_cd, t.cycle_id, t.geo_id
  );

CREATE MATERIALIZED VIEW BILLCHKOW.fin_cci_invoiced_mview
AS
(
    select * from fin_cci_invoiced_view
);

-----------------VIEWS INVOICED-------------------------

CREATE OR REPLACE VIEW billchkow.fin_ba_invoiced_view (
   account_status,
   cycle_code,
   qtt_account,
   total_current,
   total_prev,
   qtt_prev,
   total_avg,
   qtt_avg,
   qtt_current_inv,
   qtt_avg_inv )
AS
(
    SELECT t.account_status, t.cycle_code, qtt_account, total_current, total_prev, qtt_prev, total_avg, qtt_avg, 
           (SELECT sum(D.qtt_account) FROM FIN_BA_INVOICED D
            WHERE D.PROC_DATE = (SELECT MAX(PROC_DATE) FROM FIN_BA_INVOICED LAST WHERE LAST.CYCLE_CODE = t.CYCLE_CODE)) as qtt_current_inv,
           (SELECT round(sum(qtt_account)/11, 2)
            FROM FIN_BA_INVOICED E
            WHERE EXTRACT (month from PROC_DATE) <= (SELECT extract (month from add_months(MAX(PROC_DATE), -1)) 
                                                     FROM FIN_BA_INVOICED LAST 
                                                     WHERE LAST.CYCLE_CODE = E.CYCLE_CODE)) as qtt_avg_inv
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
                 round(sum(C.total_current)/11, 2) total_avg, round(sum(C.qtt_account)/10, 2) qtt_avg 
          FROM FIN_BA_INVOICED C
          WHERE EXTRACT (month FROM C.proc_date) <= (
                                                    SELECT EXTRACT (month FROM ADD_MONTHS(MAX(proc_date), -1))
                                                    FROM FIN_BA_INVOICED LAST 
                                                    WHERE LAST.CYCLE_CODE = C.CYCLE_CODE
                                                    )
          GROUP BY C.account_status, C.cycle_code 
    )
    GROUP BY account_status, cycle_code
    ) t
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

create or replace view BILLCHKOW.fin_hb_total_view as (
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
);

create or replace view BILLCHKOW.fin_hb_ba_invoiced_view as (
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
    WHERE EXTRACT (month from PROC_DATE) < (SELECT extract (month from add_months(MAX(PROC_DATE), -2)) 
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
);

CREATE MATERIALIZED VIEW BILLCHKOW.fin_hb_invoiced_mview
AS
(
  SELECT t.nivel_value, t.nivel_type, t.cycle_code, sum(qtt_account) qtt_account, sum(qtt_avg) qtt_avg, sum(qtt_prev) qtt_prev, 
         qtt_ba_current, qtt_ba_avg, qtt_hb_current, qtt_hb_avg
  FROM fin_hb_total_view t, fin_hb_ba_invoiced_view x
  WHERE t.cycle_code = x.cycle_code
  GROUP BY t.nivel_value, t.nivel_type, t.cycle_code, qtt_ba_current, qtt_ba_avg, qtt_hb_current, qtt_hb_avg
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

CREATE OR REPLACE VIEW BILLCHKOW.fin_hb_type_inv_view (
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

CREATE OR REPLACE VIEW BILLCHKOW.fin_ba_fact_view (
   account_number,
   cycle_date,
   cycle_id,
   geo_id,
   caption_code,
   current_month_billed,
   total_amount,
   total_amount_1,
   total_amount_2,
   total_amount_3,
   total_amount_avg,
   terminal_amount,
   AVG_DM,
   parameter_amount,
   parameter_percent )
AS
(
    SELECT 
        account_number, cycle_date, cycle_id, geo_id, caption_code, current_month_billed, total_amount, 
        total_amount_1, total_amount_2, total_amount_3, total_amount_AVG, terminal_amount, AVG_DM,
        nvl((select PARAMETER_AMOUNT from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'BILLAMOUNT'), 0) as Parameter_Amount,
    	nvl((select PARAMETER_ITEM from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'BILLAMOUNT'), 0) as Parameter_Percent
    FROM fin_ba_total_mview 
);

-- Complemento do sql_drop3_aditional.sql no FULL

--View Materializada de total CAPTION_CODE
CREATE MATERIALIZED VIEW billchkow.FIN_dc_fact_mview
AS
(
    SELECT SBSCRP_ID, NOME_SERVICO, CICLO, DORMANT_FLAG_CD, decode(SUBSTR(NUMERO_DOCUMENTO, 1, 8),'02449992',1,0) as FLAG_CNPJ_VIVO,
           decode(DORMANT_FLAG_CD,'Y',1,0) as FLAG_DORMANT, decode(STATUS_CONTA,'A',1,0) as FLAG_STATUS, FLAG_CURRENT, FLAG_LAST_MONTH
    FROM (
       SELECT SBSCRP_ID, NOME_SERVICO, CICLO, DORMANT_FLAG_CD, STATUS_CONTA, NUMERO_DOCUMENTO,
            decode(extract(month from DATA_FAT), (SELECT extract(month from max(DATA_FAT)) FROM FIN_DORMANT_CICLO_FACT), 
            decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_CURRENT,
            decode(extract(month from DATA_FAT), (SELECT extract(month from add_months(max(DATA_FAT), -1)) FROM FIN_DORMANT_CICLO_FACT), 
            decode(DORMANT_FLAG_CD, NULL, 0, 1),0) as FLAG_LAST_MONTH          
        FROM FIN_DORMANT_CICLO_FACT
        Where extract(month from DATA_FAT) between (SELECT extract(month from add_months(max(DATA_FAT), -1)) FROM FIN_DORMANT_CICLO_FACT) 
        and (SELECT extract(month from max(DATA_FAT)) FROM FIN_DORMANT_CICLO_FACT)
    )
);

CREATE MATERIALIZED VIEW billchkow.FIN_cc_total_dm_mview
AS
SELECT 
       acct_nbr, sbscrp_id, access_nbr, svc_name, caption_cd, prcng_comm_uf, last_bil, cycle_id, amt_current, amt_prev_1, amt_prev_2, 
       amt_prev_3, round((amt_prev_1 + amt_prev_2 + amt_prev_3)/3,2) amt_avg,
       round(SQRT ( (power( (amt_prev_1 - (amt_prev_1+amt_prev_2+amt_prev_3)/3), 2 ) + power( (amt_prev_2 - (amt_prev_1+amt_prev_2+amt_prev_3)/3), 2) + power( (amt_prev_3 - (amt_prev_1+amt_prev_2+amt_prev_3)/3), 2))/2), 2) desvio_valor       
FROM (
        SELECT distinct(access_nbr), acct_nbr, sbscrp_id, svc_name, caption_cd, prcng_comm_uf, last_bil, cy as cycle_id,       
            decode(extract(month from LAST_BIL),(SELECT extract(month from max(LAST_BIL)) FROM fin_captioncode_fact where cy = a.cy), nvl(invn_charge_cr_amt, 0), 0) as amt_current,
            decode(extract(month from LAST_BIL),(SELECT extract(month from add_months(max(LAST_BIL), -1)) FROM fin_captioncode_fact where cy = a.cy), nvl(invn_charge_cr_amt, 0), 0) as amt_prev_1,
            decode(extract(month from LAST_BIL),(SELECT extract(month from add_months(max(LAST_BIL), -2)) FROM fin_captioncode_fact where cy = a.cy), nvl(invn_charge_cr_amt, 0), 0) as amt_prev_2,
            decode(extract(month from LAST_BIL),(SELECT extract(month from add_months(max(LAST_BIL), -3)) FROM fin_captioncode_fact where cy = a.cy), nvl(invn_charge_cr_amt, 0), 0) as amt_prev_3     
        from fin_captioncode_fact a
        Where extract(month from LAST_BIL) between (SELECT extract(month from add_months(max(LAST_BIL), -3)) FROM fin_captioncode_fact where cy = a.cy)
        and (SELECT extract(month from max(LAST_BIL)) FROM fin_captioncode_fact where cy = a.cy)
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


-- VIEWS DIAS PONDERADOS

create materialized view BILLCHKOW.fin_weighted_cy_dm_mview as (
    select distinct cycle_code, cut_day, to_char(cut_date, 'DD/MM/YYYY') as cut_date from fin_days_weighted_fact
);

create or replace view BILLCHKOW.fin_days_weighted_fact_view as (
    SELECT a.cut_date, a.value_sp, a.value_rs,
           a.value_ba_se, a.value_rj, a.value_es, a.value_gt, a.value_co_n,
           a.value_ne, a.value_mg, a.value_vivo, a.var_percent_sp/100 as var_percent_sp,
           a.var_percent_rs/100 as var_percent_rs, a.var_percent_ba_se/100 as var_percent_ba_se, 
           a.var_percent_rj/100 as var_percent_rj, a.var_percent_es/100 as var_percent_es,
           a.var_percent_gt/100 as var_percent_gt, a.var_percent_co_n/100 as var_percent_co_n,
           a.var_percent_ne/100 as var_percent_ne, a.var_percent_mg/100 as var_percent_mg, a.var_percent_vivo/100 as var_percent_vivo,
           a.var_qtt_sp, a.var_qtt_rs, a.var_qtt_ba_se, a.var_qtt_rj,
           a.var_qtt_es, a.var_qtt_gt, a.var_qtt_co_n, a.var_qtt_ne,
           a.var_qtt_mg, a.var_qtt_vivo
  FROM fin_days_weighted_fact a
);


commit;
