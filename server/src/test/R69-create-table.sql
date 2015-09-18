	Select pi.long_dstn_carr_id LD, di.doc_due_amt VALOR_DOC, di.doc_past_due_dt VENCTO
  From project.pnlty_intrst pi, project.pymt_asgm pa, project.doc_info di
	Where pi.acct_nbr = '&Conta' and
        pi.rcvbl_seq_nbr = pa.rcvbl_seq_nbr and
        pi.acct_nbr = pa.rcvbl_acct_nbr and
        pi.pymt_asgm_seq_nbr = pa.pymt_asgm_seq_nbr and
        pa.doc_type_cd = di.doc_type_cd and
        pa.doc_refdt = di.doc_refdt and
        pa.doc_seq_nbr = di.doc_seq_nbr and
        pa.rcvbl_acct_nbr = di.acct_nbr
group by pi.long_dstn_carr_id, di.doc_due_amt, di.doc_past_due_dt
					
create table INTEREST_FEE (
ACCOUNT_NO VARCHAR(10),
carrier_code VARCHAR(2), 
carrier_state VARCHAR(2), 
doc_amt NUMBER (18,2),
doc_due_dt DATE)
;

					select 
							account_no as "accountno", carrier_code as "carriercode", carrier_state as "carrierstate", 
							doc_amt as "docamt",  doc_due_dt as "docduedt"
					from INTEREST_FEE
					where account_no = ?

insert into INTEREST_FEE values(
'0132279303',  '00', 'RS', 3.10 , to_date('20060901', 'YYYYMMDD'));	

insert into INTEREST_FEE values(
'2009170221',  '00', 'RS', 3.10 , to_date('20060901', 'YYYYMMDD'));