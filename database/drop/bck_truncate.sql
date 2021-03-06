truncate table PRC_SERVICE_PRICE reuse storage;
alter table PRC_SERVICE_PRICE disable constraint PRC_SERVICE_PRICE_FK1;
alter table PRC_SERVICE_PRICE disable constraint PRC_SERVICE_PRICE_FK2;
alter table PRC_SERVICE_PRICE disable constraint PRC_SERVICE_PRICE_FK3;
alter table PRC_SERVICE_PRICE disable constraint PRC_SERVICE_PRICE_FK4;
alter table PRC_SERVICE disable constraint PRC_SERVICE_FK1;
alter table PRC_SERVICE disable constraint PRC_SERVICE_FK2;
truncate table PRC_SERVICE reuse storage;
alter table "PRC_SERVICE_FREE_UNITS" disable constraint "PRC_SERVICE_FREE_UNITS_FK1";
truncate table PRC_SERVICE_FREE_UNITS reuse storage;
alter table prc_tax_rate disable constraint prc_tax_rate_fk1;
alter table prc_tax_rate disable constraint prc_tax_rate_fk2;
alter table prc_tax_category disable constraint prc_tax_category_fk1;
truncate table REF_IMPORT_HISTORY reuse storage;
truncate table prc_tax_rate reuse storage;
truncate table prc_tax_category reuse storage;
truncate table bck_consequence reuse storage;
alter table bck_consequence disable constraints bck_consequence_fk7;
truncate table bck_consequence_attr reuse storage;
alter table PRC_SERVICE_PRICE enable constraint PRC_SERVICE_PRICE_FK1;
alter table PRC_SERVICE_PRICE enable constraint PRC_SERVICE_PRICE_FK2;
alter table PRC_SERVICE_PRICE enable constraint PRC_SERVICE_PRICE_FK3;
alter table PRC_SERVICE_PRICE enable constraint PRC_SERVICE_PRICE_FK4;
alter table PRC_SERVICE enable constraint PRC_SERVICE_FK1;
alter table PRC_SERVICE enable constraint PRC_SERVICE_FK2;
alter table PRC_SERVICE_FREE_UNITS enable constraint PRC_SERVICE_FREE_UNITS_FK1;
alter table bck_consequence enable constraints bck_consequence_fk7;
alter table prc_tax_rate enable constraint prc_tax_rate_fk1;
alter table prc_tax_rate enable constraint prc_tax_rate_fk2;
alter table prc_tax_category enable constraint prc_tax_category_fk1;
alter table bck_consequence enable constraints bck_consequence_fk7;
commit;
