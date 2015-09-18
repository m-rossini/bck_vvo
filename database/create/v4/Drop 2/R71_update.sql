delete BILLCHKOW.bck_consequence where rule_uid in (select objid from BILLCHKOW.bck_rule where rule_code like '%71%');

delete BILLCHKOW.bck_rule where rule_code like '%71%'; 

insert into BILLCHKOW.bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R71-1','Validação do Serviço Gestão', null, null, null,null, null);   
insert into BILLCHKOW.bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R71-2','Validação do Serviço Gestão', null, null, null,null, null);   

commit;

