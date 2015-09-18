-- Adicionando nova coluna na prc_service_price

ALTER TABLE BILLCHKOW.PRC_SERVICE_PRICE ADD (CHARGE_TYPE_ID VARCHAR2(25));

commit;

exit;

