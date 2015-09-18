DROP TABLE  BILLCHKOW.ast_param_config;
DROP MATERIALIZED VIEW  BILLCHKOW.fin_cc_total_mview;
DROP MATERIALIZED VIEW  BILLCHKOW.fin_cc_total_dm_mview;
DROP MATERIALIZED VIEW  BILLCHKOW.fin_dr_invoiced_mview;

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

--View de Valor faturado
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
