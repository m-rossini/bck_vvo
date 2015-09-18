spool '&1'
set linesize 800
set head off
set pagesize 0
set feedback off
set termout off
set verify off
set trimspool on
select sp.svc_price_seq_nbr||';'||s.svc_name||';'|| sp.comm_svc_area_id||';'|| sp.charge_type_cd||';'||
s.svc_desc||';'|| sp.svc_price_eff_dt||';'|| sp.svc_price_expr_dt||';'|| sp.rate_factor_id||';'||
sp.init_charge_period_qty||';'|| sp.init_incl_unit_amt||';'|| sp.init_period_unit_cd||';'|| 
sp.init_price_amt||';'||
sp.adtnl_charge_period_qty||';'|| sp.adtnl_incl_unit_amt||';'|| sp.adtnl_period_unit_cd||';'||
sp.adtnl_price_amt||';'||sp.price_ngtbl_flag||';'||sp.tax_cat_cd||';'|| sp.usage_acum_seq_nbr||';'||
sp.free_usage_across_acct_ind||';'||rerate_incol_flag||';'||i.captn_text||';'||s.AIR_RATE_METHOD_CD||';'||s.TAX_INCL_FLAG||';'||sp.svc_charge_type_id
from project.svc s, svc_price sp, invc_captn i
where s.svc_name = sp.svc_name 
and i.captn_cd = sp.captn_cd
and i.charge_type_cd = sp.charge_type_cd;
spool off
exit;
