create table NEGOT_PRICE (
	CHARGE_TYPE 				varchar2(1) 	not null,
	EFFECTIVE_DATE				date			not null,
	EXPIRATION_DATE				date					,
	SCENARIO_ID					varchar2(64)	not null,
	INITIAL_UNIT_VALUE			number(18,6)			,
	INITIAL_UNIT_QTY			number(18,6)			,
	INITIAL_UNIT_TYPE			varchar2(16)			,
	INITIAL_UNIT_INCL_QTY		number(18,6)			,
	STEP_UNIT_VALUE				number(18,6)			,
	STEP_UNIT_QTY				number(18,6)			,
	STEP_UNIT_TYPE				varchar2(16)			,
	STEP_UNIT_INCL_QTY			number(18,6)			,
	SP_AREA_ID					varchar2(12)	not null,
	TAX_CODE					number(10)				,
	UPDATED_DATE				date			not null,
	ACCOUNT_NUMBER				varchar2(32)	not null
);

create index NEGOT_PRICE_IDX1 on NEGOT_PRICE ( SCENARIO_ID, ACCOUNT_NUMBER );

insert into NEGOT_PRICE values ( 'U', '01/01/00', '31/12/05', 'negot001', 0.305, 30, 'SECONDS', 0.5, 0.061 , 6, 'SECONDS', 0.1, 'RS', 4, '01/01/00', '0020020021');
insert into NEGOT_PRICE values ( 'U', '01/01/06', '31/12/06', 'negot001', 0.300, 30, 'SECONDS', 0.5, 0.060 , 6, 'SECONDS', 0.1, 'RS', 4, '01/01/06', '0020020021');
insert into NEGOT_PRICE values ( 'U', '01/01/07', null,       'negot001', 0.294, 30, 'SECONDS', 0.5, 0.0588, 6, 'SECONDS', 0.1, 'RS', 4, '01/01/07', '0020020021');
insert into NEGOT_PRICE values ( 'R', '01/01/00', null, 	  'subscr01', 15, 1, 'MONTHLY', 1, 0, 0, 'MONTHLY', 0, 'RS', 4, '01/01/00', '0020020021');

insert into NEGOT_PRICE values ( 'U', '01/01/06', '31/12/06', '77339340', 0.92201, 30, 'FLAT', 0.5, 0, 6, 'FLAT', 0.1, 'TELERON', 4, '01/01/06', '0020020021');