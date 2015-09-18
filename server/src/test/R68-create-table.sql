					SELECT alna.access_nbr as 'accessNo', a.acct_nbr as 'accountNo', sali.sbscrp_id 'subId', 
							np.svc_agrmnt_seq_nbr as 'svcNbr',p.svc_charge_type_id as 'chargeTypeId', 
											sali.svc_name as 'serviceName', np.negot_eff_dt as'effectiveDate', 
											np.negot_expr_dt as 'expirationDate', negot_init_charge_amt as 'negotAmt', 
											negot_pct as 'negotPct', base_price_amt as 'baseAmt'
								FROM    negot_price np, svc_agrmnt_line_item sali, access_line_nbr_asgm alna, sbscrp_asgm a, svc_price p 
					WHERE np.sbscrp_id = sali.sbscrp_id 
					AND      sali.sbscrp_id = a.sbscrp_id 
					AND      np.svc_agrmnt_seq_nbr = sali.svc_agrmnt_seq_nbr 
					AND      np.svc_price_seq_nbr = p.svc_price_seq_nbr 
					AND      sali.sbscrp_id = alna.sbscrp_id 
					AND      a.acct_nbr =  ?
					
create table CONTRACT_BREAK_FEE (
ACCOUNT_NO VARCHAR(10),
ACCESS_NO VARCHAR(15),
SVC_NAME VARCHAR(32),
SUBSCRIPTION_ID VARCHAR(15),
SVC_AGREEMENT_SEQUENCE_NO NUMBER(15,0),
SVC_CHARGE_TYPE VARCHAR(8),
DT_EFFECTIVE DATE,
DT_EXPIRATION DATE,
NEGOT_AMT NUMBER(18,2),
NEGOT_PCT NUMBER (5,2),
BASE_AMT NUMBER (18,2))
;

select 
	account_no as "accountNo", access_no as "accessNo", svc_name as "serviceName", 
	dt_effective as "effectiveDate", dt_expiration as "expiration_date",
	negot_amt as "negotAmt" , base_amt as "baseAmt"
from CONTRACT_BREAK_FEE
where account_no = '10'

insert into CONTRACT_BREAK_FEE values(
'2002779676', '1199998888', 'CANCELAMENTO DE CONTRATO', 'SUBSCRIPTION', 1, 'O', to_date('20060901', 'YYYYMMDD'),
null, 10, 1, 11);	

insert into CONTRACT_BREAK_FEE values(
'2002779676', '4491189634', 'CANCELAMENTO DE CONTRATO', 'SUBSCRIPTION', 1, 'O', to_date('20060901', 'YYYYMMDD'),
null, 224, 1, 224);

insert into CONTRACT_BREAK_FEE values(
'2002779676', '4491187746', 'CANCELAMENTO DE CONTRATO', 'SUBSCRIPTION', 1, 'O', to_date('20060901', 'YYYYMMDD'),
null, 10, 1, 99999);
