set echo off lin 9999 trimsp on feedb off head off pages 0 tab off;

select 'insert into r32_planservice values ('''|| access_nbr_rqr_flag||''', '''|| svc_price_seq_nbr||''');' 
from svc a, svc_price b
where  a.svc_name = b.svc_name
and charge_type_cd ='R';

exit;

