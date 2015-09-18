DROP TABLE vivo_bck.r69_localidade_cep CASCADE CONSTRAINTS
/
CREATE TABLE vivo_bck.r69_localidade_cep
   (dsc_localidade    VARCHAR2(40) not null,
    num_cep           VARCHAR2(8) not null,
  CONSTRAINT r69_localidade_cep_pk PRIMARY KEY (dsc_localidade, num_cep) USING INDEX)
/

insert into vivo_bck.r69_localidade_cep values ('SAO PAULO', '00000000');
insert into vivo_bck.r69_localidade_cep values ('GLORINHA', '94380000');
insert into vivo_bck.r69_localidade_cep values ('S PAULO', '04743010');
commit;
