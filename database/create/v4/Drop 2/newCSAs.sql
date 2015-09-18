delete from BILLCHKOW.bck_consequence;

update BILLCHKOW.bck_carrier_dm set custom_1='B', custom_2='32' where carrier_code='31'
and carrier_state='RN';
update BILLCHKOW.bck_carrier_dm set custom_1='B', custom_2='32' where carrier_code='31'
and carrier_state='PE';
update BILLCHKOW.bck_carrier_dm set custom_1='B', custom_2='32' where carrier_code='31'
and carrier_state='AL';
update BILLCHKOW.bck_carrier_dm set custom_1='B', custom_2='32' where carrier_code='31'
and carrier_state='PB';
update BILLCHKOW.bck_carrier_dm set custom_1='B', custom_2='32' where carrier_code='31'
and carrier_state='PI';
update BILLCHKOW.bck_carrier_dm set custom_1='B', custom_2='32' where carrier_code='31'
and carrier_state='CE';

update BILLCHKOW.bck_carrier_dm set custom_1='S', custom_2='7' where carrier_code='25'
and carrier_state='BA';
update BILLCHKOW.bck_carrier_dm set custom_1='S', custom_2='8' where carrier_code='25'
and carrier_state='CE';
update BILLCHKOW.bck_carrier_dm set custom_1='S', custom_2='9' where carrier_code='25'
and carrier_state='PE';

commit;