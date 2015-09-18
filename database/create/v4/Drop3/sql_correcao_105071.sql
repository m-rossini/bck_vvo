CREATE MATERIALIZED VIEW billchkow.FIN_DR_UN_WEEKDAY_DM_MVIEW
as
(
select distinct to_char(a.call_dt,'fmDAY') AS week_call_dt_str, to_char(a.call_dt,'DD/MM/YYYY') as call_dt_str
from fin_dr_aux_fact a
);
