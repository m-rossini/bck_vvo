-- sequences	 
CREATE SEQUENCE BCK_CONSEQUENCE_UID INCREMENT BY 1 START WITH 1 CACHE 1000;
CREATE SEQUENCE BCK_DIMENSIONS_UID INCREMENT BY 1 START WITH 1 CACHE 1000;
create hibernate_sequence INCREMENT BY 1 START WITH 1;

---
CREATE TABLE ref_import_history (
   objid 					integer 			not null,
   imported_filename 		varchar2(128) 		not null,
   import_date 				date	 			not null,
   custom_1 				varchar2(30)				,
   custom_2 				varchar2(30)				,
   custom_3 				varchar2(30)
);

ALTER TABLE ref_import_history ADD CONSTRAINT ref_import_history_pk PRIMARY KEY (objid);


--
--  CREATES SERVICE TABLE
-- 
CREATE TABLE prc_service (
   objid					integer 			not null,
   import_id 				integer 	 		not null,
   parent_service_id 		integer 					,
   service_external_id 		varchar2(30) 		not null,
   service_name 			varchar2(40)				,
   service_description 		varchar2(60)				,
   service_type 			varchar2(1)					,
   custom_1 				varchar2(30)				,
   custom_2 				varchar2(30)				,
   custom_3 				varchar2(30)
);

ALTER TABLE prc_service ADD CONSTRAINT prc_service_pk  PRIMARY KEY (objid);
ALTER TABLE prc_service ADD CONSTRAINT prc_service_fk1 FOREIGN KEY (import_id) REFERENCES ref_import_history (objid);
ALTER TABLE prc_service ADD CONSTRAINT prc_service_fk2 FOREIGN KEY (parent_service_id) REFERENCES prc_service (objid);

CREATE INDEX prc_service_idx_1 ON prc_service (service_name, service_type);
CREATE INDEX prc_service_idx_2 ON prc_service (service_external_id);
CREATE INDEX prc_service_idx_3 ON prc_service (import_id);
CREATE INDEX prc_service_idx_4 ON prc_service (parent_service_id);

--
--  CREATES TAX CATEGORIES TABLE
-- 
CREATE TABLE prc_tax_category (
   objid					integer 			not null,
   import_id 				integer 			not null,
   tax_code 				varchar2(30) 		not null,
   updated_date	 			date	 			not null,
   custom_1 				varchar2(30)				,
   custom_2 				varchar2(30)				,
   custom_3 				varchar2(30)
);

ALTER TABLE prc_tax_category ADD CONSTRAINT prc_tax_category_pk  PRIMARY KEY (objid);
ALTER TABLE prc_tax_category ADD CONSTRAINT prc_tax_category_fk1 FOREIGN KEY (import_id) REFERENCES ref_import_history (objid);

--
--  CREATES TAX RATES TABLE
-- 
CREATE TABLE prc_tax_rate (
   objid					integer 			not null,
   import_id 				integer				not null,
   tax_category_id 			integer		 		not null,
   rate_external_id			varchar2(30) 		not null,
   effective_date 			date		 		not null,
   expiration_date 			date						,
   tax_rate 				number(20,8) 		not null,
   custom_1 				varchar2(30)				,
   custom_2 				varchar2(30)				,
   custom_3 				varchar2(30)
);

ALTER TABLE prc_tax_rate ADD CONSTRAINT prc_tax_rate_pk  PRIMARY KEY (objid);
ALTER TABLE prc_tax_rate ADD CONSTRAINT prc_tax_rate_fk1 FOREIGN KEY (import_id) REFERENCES ref_import_history (objid);
ALTER TABLE prc_tax_rate ADD CONSTRAINT prc_tax_rate_fk2 FOREIGN KEY (tax_category_id) REFERENCES prc_tax_category (objid);

CREATE INDEX prc_tax_rate_idx_1 ON prc_tax_rate (tax_category_id, rate_external_id, effective_date, expiration_date);


--
--  CREATES SERVICE FREE UNITS TABLE
-- 
CREATE TABLE prc_service_free_units (
   objid 					integer 			not null,
   import_id 				integer				not null,
   free_units_external_id 	varchar2(30)				,
   free_units_share_mode 	varchar2(1)					,
   free_units_qty 			number(20,8)				,
   free_units_type 			varchar2(10)				,
   custom_1 				varchar2(30)				,
   custom_2 				varchar2(30)				,
   custom_3 				varchar2(30)
);

ALTER TABLE prc_service_free_units ADD CONSTRAINT prc_service_free_units_pk  PRIMARY KEY (objid);
ALTER TABLE prc_service_free_units ADD CONSTRAINT prc_service_free_units_fk1 FOREIGN KEY (import_id) REFERENCES ref_import_history (objid);

--
--  CREATES SERVICE PRICES TABLE
-- 
CREATE TABLE prc_service_price (
   objid					integer 			not null,
   import_id	 			integer 			not null,
   service_id 				integer 			not null,
   sp_area_id 				varchar2(15) 		not null,
   effective_date 			date		 		not null,
   expiration_date	 		date						,
   updated_date 			date		 		not null,
   scenario_id 				varchar2(20) 		not null,
   charge_type 				varchar2(1)					,
   tax_code 				integer						,
   free_units_id 			integer						,
   initial_unit_type 		        varchar2(10) 		not null,
   initial_unit_qty		 	number(20,8) 		not null,
   initial_unit_incl_qty                number(20,8)				,
   initial_unit_value 		        number(20,8)				,
   step_unit_type 			varchar2(10)				,
   step_unit_qty 			number(20,8)				,
   step_unit_incl_qty                    number(20,8)				,
   step_unit_value 			number(20,8)				,
   negotiable_flag 			varchar2(1)				,
   passthrough_flag                     varchar2(1)				,
   custom_1 				varchar2(30)				,
   custom_2 				varchar2(30)				,
   custom_3 				varchar2(30)
);

ALTER TABLE prc_service_price ADD CONSTRAINT prc_service_price_pk  PRIMARY KEY (objid); 
ALTER TABLE prc_service_price ADD CONSTRAINT prc_service_price_fk1 FOREIGN KEY (import_id) REFERENCES ref_import_history (objid);
ALTER TABLE prc_service_price ADD CONSTRAINT prc_service_price_fk2 FOREIGN KEY (tax_code) REFERENCES prc_tax_category (objid);
ALTER TABLE prc_service_price ADD CONSTRAINT prc_service_price_fk3 FOREIGN KEY (service_id) REFERENCES prc_service (objid);
ALTER TABLE prc_service_price ADD CONSTRAINT prc_service_price_fk4 FOREIGN KEY (free_units_id) REFERENCES prc_service_free_units (objid);

CREATE INDEX prc_service_price_idx_1 ON prc_service_price (service_id, sp_area_id, effective_date, updated_date, scenario_id, charge_type);
CREATE INDEX prc_service_price_idx_2 ON prc_service_price (scenario_id, charge_type);
CREATE INDEX prc_service_price_idx_3 ON prc_service_price (import_id);
CREATE INDEX prc_service_price_idx_4 ON prc_service_price (scenario_id, effective_date, expiration_date);


CREATE TABLE om_unit_convertion (
	FROM_UNIT 				VARCHAR2(20) 		NOT NULL,
	TO_UNIT   				VARCHAR2(20) 		NOT NULL,
	CONVERTION_RATE 	DECIMAL(20,8)		NOT NULL
);

INSERT INTO om_unit_convertion VALUES ('TIME',    'TIME',     1);
INSERT INTO om_unit_convertion VALUES ('SECONDS', 'TIME',     1);
INSERT INTO om_unit_convertion VALUES ('MINUTES', 'TIME',    60);
INSERT INTO om_unit_convertion VALUES ('HOUR',    'TIME',  3600);
INSERT INTO om_unit_convertion VALUES ('DATA',   'DATA',        1);
INSERT INTO om_unit_convertion VALUES ('BYTES',  'DATA',        1);
INSERT INTO om_unit_convertion VALUES ('KBYTES', 'DATA',     1000);
INSERT INTO om_unit_convertion VALUES ('KB',     'DATA',     1000);
INSERT INTO om_unit_convertion VALUES ('MBYTES', 'DATA',  1000000);
INSERT INTO om_unit_convertion VALUES ('MB',     'DATA',  1000000);
INSERT INTO om_unit_convertion VALUES ('UNIT',     'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ('EVENT',    'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ('FLAT',     'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ( 'MONTHLY', 'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ( 'EVENTS',     'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ( 'BILLINGS',   'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ( 'PERCENT',    'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ( 'EVT',        'UNIT',  1);
INSERT INTO om_unit_convertion VALUES ( 'DURATION(S', 'TIME',  60);
INSERT INTO om_unit_convertion VALUES ( 'SEC',        'TIME',  60);
INSERT INTO om_unit_convertion VALUES ( 'DATA-.01MB', 'DATA',  10000);
INSERT INTO om_unit_convertion VALUES ( '.01MB',      'DATA',  10000);
INSERT INTO om_unit_convertion VALUES ( 'DATA-.01KB', 'DATA',     10);
INSERT INTO om_unit_convertion VALUES ( '.01KB',      'DATA',     10);
INSERT INTO om_unit_convertion VALUES ('DATA',    'DATA-.01MB',     100/ (1024*1024));


CREATE TABLE bck_account_summary 
(
   objid 											INTEGER					PRIMARY KEY,
   external_id								VARCHAR2(255),
   account_number 						VARCHAR2(64),
   account_state 							VARCHAR2(2),
   customer_type 							VARCHAR2(2),
   cycle_code 								VARCHAR2(10) 		NOT NULL,
   cycle_end 									DATE,
   due_date 									DATE 						NOT NULL,
   payments_amnt 							DECIMAL(20,8),
   penalties_amnt 						DECIMAL(20,8),
   interests_amnt 						DECIMAL(20,8),
   penalties_return_amnt 			DECIMAL(20,8),
   interests_return_amnt 			DECIMAL(20,8),
   contract_break_amnt 				DECIMAL(20,8),
   ajustment_amnt 						DECIMAL(20,8),
   month_instmt_amnt 					DECIMAL(20,8),
   eqpmnt_instmt_amnt 				DECIMAL(20,8),
   retention_amnt 						DECIMAL(20,8),
   dispute_credits 						DECIMAL(20,8),
   curr_period_amnt 					DECIMAL(20,8),
   state_tax_amnt 						DECIMAL(20,8),
   total_amnt 								DECIMAL(20,8)
);

CREATE INDEX bck_account_summary_idx_1 ON bck_account_summary
(external_id, account_state, account_number);


CREATE TABLE bck_checked_services  (                                                             
   OBJID									INTEGER						PRIMARY KEY,                           
   external_id 						VARCHAR2(255),                                  
   cycle_code 						VARCHAR2(10),                                    
   cycle_end 							DATE,                                            
   account_state 					VARCHAR2(2),                                  
   account_number 				VARCHAR2(15),                                
   service_name 					VARCHAR2(128),                                 
   event_count 						INTEGER,                                          
   error_count 						INTEGER
);                                                            
                                                              
CREATE INDEX bck_checked_services_idx1 ON bck_checked_services
(external_id, account_state, cycle_code, cycle_end, service_name); 


CREATE TABLE bck_scenarios (
  scenario_id 		INTEGER 			PRIMARY KEY,
  call_class 			VARCHAR2(20),
  call_subclass 	VARCHAR2(20),
  tariff 					VARCHAR2(2),
  checked 				VARCHAR2(1),
  order_id 				INTEGER
);

CREATE INDEX bck_scenarios_idx1 ON bck_scenarios(call_class, call_subclass, tariff);
CREATE INDEX bck_scenarios_idx2 ON bck_scenarios(order_id);

DELETE FROM bck_scenarios;
INSERT INTO bck_scenarios values(1, 'N/C', 'N/C', 'U', 'Y', 9999999);
INSERT INTO bck_scenarios VALUES(100, 'VC1H', 'MM', 'P', 'Y', 10);
INSERT INTO bck_scenarios VALUES(101, 'VC1H', 'MM', 'O', 'Y', 20);
INSERT INTO bck_scenarios VALUES(102, 'VC1H', 'MF', 'P', 'Y', 30);
INSERT INTO bck_scenarios VALUES(103, 'VC1H', 'MF', 'O', 'Y', 40);
INSERT INTO bck_scenarios VALUES(104, 'VC1H', 'MMI', 'P', 'Y', 50);
INSERT INTO bck_scenarios VALUES(105, 'VC1H', 'MMI', 'O', 'Y', 60);
INSERT INTO bck_scenarios VALUES(106, 'VC1H', 'GRUPO', 'P', 'Y', 70);
INSERT INTO bck_scenarios VALUES(107, 'VC1H', 'GRUPO', 'O', 'Y', 80);
INSERT INTO bck_scenarios VALUES(400, 'FRANQUIA', 'VC1', 'U', 'Y', 90);
INSERT INTO bck_scenarios VALUES(401, 'FRANQUIA', '*555', 'U', 'Y', 100);
INSERT INTO bck_scenarios VALUES(402, 'FRANQUIA', 'WAP', 'U', 'Y', 110);
INSERT INTO bck_scenarios VALUES(403, 'FRANQUIA', 'VC1SPV', 'U', 'Y', 120);
INSERT INTO bck_scenarios VALUES(430, '*1234/*555', 'MMI', 'P', 'Y', 130);
INSERT INTO bck_scenarios VALUES(431, '*1234/*555', 'MMI', 'O', 'Y', 140);
INSERT INTO bck_scenarios VALUES(130, 'VC1SPV', 'MM', 'P', 'Y', 150);
INSERT INTO bck_scenarios VALUES(131, 'VC1SPV', 'MM', 'O', 'Y', 160);
INSERT INTO bck_scenarios VALUES(132, 'VC1SPV', 'MF', 'P', 'Y', 170);
INSERT INTO bck_scenarios VALUES(133, 'VC1SPV', 'MF', 'O', 'Y', 180);
INSERT INTO bck_scenarios VALUES(134, 'VC1SPV', 'N/C', 'P', 'Y', 190);
INSERT INTO bck_scenarios VALUES(135, 'VC1SPV', 'N/C', 'O', 'Y', 200);
INSERT INTO bck_scenarios VALUES(150, 'VC1C', 'MM', 'P', 'Y', 210);
INSERT INTO bck_scenarios VALUES(151, 'VC1C', 'MM', 'O', 'Y', 220);
INSERT INTO bck_scenarios VALUES(152, 'VC1C', 'MF', 'P', 'Y', 230);
INSERT INTO bck_scenarios VALUES(153, 'VC1C', 'MF', 'O', 'Y', 240);
INSERT INTO bck_scenarios VALUES(154, 'VC1C', 'MMI', 'P', 'Y', 250);
INSERT INTO bck_scenarios VALUES(155, 'VC1C', 'MMI', 'O', 'Y', 260);
INSERT INTO bck_scenarios VALUES(156, 'VC1C', 'GRUPO', 'P', 'Y', 270);
INSERT INTO bck_scenarios VALUES(157, 'VC1C', 'GRUPO', 'O', 'Y', 280);
INSERT INTO bck_scenarios VALUES(500, 'ROI', 'U', 'P', 'Y', 290);
INSERT INTO bck_scenarios VALUES(501, 'ROI', 'U', 'O', 'Y', 300);
INSERT INTO bck_scenarios VALUES(600, 'MODEM', 'VC1', 'P', 'Y', 310);
INSERT INTO bck_scenarios VALUES(601, 'MODEM', 'VC1', 'O', 'Y', 320);
INSERT INTO bck_scenarios VALUES(620, 'WAP', 'VC1', 'P', 'Y', 330);
INSERT INTO bck_scenarios VALUES(621, 'WAP', 'VC1', 'O', 'Y', 340);
INSERT INTO bck_scenarios VALUES(622, 'WAP', 'ROAM', 'P', 'Y', 350);
INSERT INTO bck_scenarios VALUES(633, 'WAP', 'ROAM', 'O', 'Y', 360);
INSERT INTO bck_scenarios VALUES(650, 'S.V.A.', 'U', 'P', 'Y', 370);
INSERT INTO bck_scenarios VALUES(651, 'S.V.A.', 'U', 'O', 'Y', 380);
INSERT INTO bck_scenarios VALUES(652, 'S.V.A.', 'U', 'U', 'Y', 390);
INSERT INTO bck_scenarios VALUES(700, 'AD1', 'U', 'P', 'Y', 400);
INSERT INTO bck_scenarios VALUES(701, 'AD1', 'U', 'O', 'Y', 410);
INSERT INTO bck_scenarios VALUES(702, 'AD1', 'U', 'U', 'Y', 420);
INSERT INTO bck_scenarios VALUES(710, 'AD2', 'U', 'P', 'Y', 430);
INSERT INTO bck_scenarios VALUES(711, 'AD2', 'U', 'O', 'Y', 440);
INSERT INTO bck_scenarios VALUES(712, 'AD2', 'U', 'U', 'Y', 450);
INSERT INTO bck_scenarios VALUES(200, 'VC2H', 'MM', 'P', 'Y', 460);
INSERT INTO bck_scenarios VALUES(201, 'VC2H', 'MM', 'O', 'Y', 470);
INSERT INTO bck_scenarios VALUES(202, 'VC2H', 'MF', 'P', 'Y', 480);
INSERT INTO bck_scenarios VALUES(203, 'VC2H', 'MF', 'O', 'Y', 490);
INSERT INTO bck_scenarios VALUES(204, 'VC2H', 'N/C', 'P', 'Y', 500);
INSERT INTO bck_scenarios VALUES(205, 'VC2H', 'N/C', 'O', 'Y', 510);
INSERT INTO bck_scenarios VALUES(206, 'VC2C', 'MM', 'P', 'Y', 520);
INSERT INTO bck_scenarios VALUES(207, 'VC2C', 'MM', 'O', 'Y', 530);
INSERT INTO bck_scenarios VALUES(208, 'VC2C', 'MF', 'P', 'Y', 540);
INSERT INTO bck_scenarios VALUES(209, 'VC2C', 'MF', 'O', 'Y', 550);
INSERT INTO bck_scenarios VALUES(210, 'VC2C', 'N/C', 'P', 'Y', 560);
INSERT INTO bck_scenarios VALUES(211, 'VC2C', 'N/C', 'O', 'Y', 570);
INSERT INTO bck_scenarios VALUES(212, 'VC2R', 'MM', 'P', 'Y', 580);
INSERT INTO bck_scenarios VALUES(213, 'VC2R', 'MM', 'O', 'Y', 590);
INSERT INTO bck_scenarios VALUES(214, 'VC2R', 'MF', 'P', 'Y', 600);
INSERT INTO bck_scenarios VALUES(215, 'VC2R', 'MF', 'O', 'Y', 610);
INSERT INTO bck_scenarios VALUES(216, 'VC2R', 'N/C', 'P', 'Y', 620);
INSERT INTO bck_scenarios VALUES(217, 'VC2R', 'N/C', 'O', 'Y', 630);
INSERT INTO bck_scenarios VALUES(300, 'VC3H', 'MM', 'P', 'Y', 640);
INSERT INTO bck_scenarios VALUES(301, 'VC3H', 'MM', 'O', 'Y', 650);
INSERT INTO bck_scenarios VALUES(302, 'VC3H', 'MF', 'P', 'Y', 660);
INSERT INTO bck_scenarios VALUES(303, 'VC3H', 'MF', 'O', 'Y', 670);
INSERT INTO bck_scenarios VALUES(304, 'VC3H', 'N/C', 'P', 'Y', 680);
INSERT INTO bck_scenarios VALUES(305, 'VC3H', 'N/C', 'O', 'Y', 690);
INSERT INTO bck_scenarios VALUES(306, 'VC3C', 'MM', 'P', 'Y', 700);
INSERT INTO bck_scenarios VALUES(307, 'VC3C', 'MM', 'O', 'Y', 710);
INSERT INTO bck_scenarios VALUES(308, 'VC3C', 'MF', 'P', 'Y', 720);
INSERT INTO bck_scenarios VALUES(309, 'VC3C', 'MF', 'O', 'Y', 730);
INSERT INTO bck_scenarios VALUES(310, 'VC3C', 'N/C', 'P', 'Y', 740);
INSERT INTO bck_scenarios VALUES(311, 'VC3C', 'N/C', 'O', 'Y', 750);
INSERT INTO bck_scenarios VALUES(312, 'VC3R', 'MM', 'P', 'Y', 760);
INSERT INTO bck_scenarios VALUES(313, 'VC3R', 'MM', 'O', 'Y', 770);
INSERT INTO bck_scenarios VALUES(314, 'VC3R', 'MF', 'P', 'Y', 780);
INSERT INTO bck_scenarios VALUES(315, 'VC3R', 'MF', 'O', 'Y', 790);
INSERT INTO bck_scenarios VALUES(316, 'VC3R', 'N/C', 'P', 'Y', 800);
INSERT INTO bck_scenarios VALUES(317, 'VC3R', 'N/C', 'O', 'Y', 810);
INSERT INTO bck_scenarios VALUES(520, 'INT', 'U', 'P', 'Y', 820);
INSERT INTO bck_scenarios VALUES(521, 'INT', 'U', 'O', 'Y', 830);
INSERT INTO bck_scenarios VALUES(522, 'INTC', 'U', 'P', 'Y', 840);
INSERT INTO bck_scenarios VALUES(523, 'INTC', 'U', 'O', 'Y', 850);
INSERT INTO bck_scenarios VALUES(524, 'INTR', 'U', 'P', 'Y', 860);
INSERT INTO bck_scenarios VALUES(525, 'INTR', 'U', 'O', 'Y', 870);
INSERT INTO bck_scenarios VALUES(730, 'DSL1', 'U', 'P', 'Y', 880);
INSERT INTO bck_scenarios VALUES(731, 'DSL1', 'U', 'O', 'Y', 890);
INSERT INTO bck_scenarios VALUES(732, 'DSL2', 'U', 'P', 'Y', 900);
INSERT INTO bck_scenarios VALUES(733, 'DSL2', 'U', 'O', 'Y', 910);
INSERT INTO bck_scenarios VALUES(670, 'DADOS 2,5G', 'U', 'P', 'Y', 920);
INSERT INTO bck_scenarios VALUES(671, 'DADOS 2,5G', 'U', 'O', 'Y', 930);
INSERT INTO bck_scenarios VALUES(800, 'TORPEDO', 'VIVO', 'U', 'Y', 940);
INSERT INTO bck_scenarios VALUES(801, 'TORPEDO', 'SMS', 'U', 'Y', 950);
INSERT INTO bck_scenarios VALUES(802, 'TORPEDO', 'MMS', 'U', 'Y', 960);
INSERT INTO bck_scenarios VALUES(803, 'TORPEDO', 'OUTRA OPER.', 'U', 'Y', 970);
INSERT INTO bck_scenarios VALUES(804, 'TORPEDO', 'OUTRO EST.', 'U', 'Y', 980);
INSERT INTO bck_scenarios VALUES(805, 'TORPEDO', 'OUTROS', 'U', 'Y', 990);
INSERT INTO bck_scenarios VALUES(850, 'SERVIÇOS TERCEIROS', 'U', 'U', 'Y', 1000);

-- Table: BCK_ACCOUNT_DM
CREATE TABLE BCK_ACCOUNT_DM (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	ACCOUNT_TYPE 		VARCHAR2(8)				, 
	HOLDING_NUMBER 		VARCHAR2(32)			, 
	ACCOUNT_NUMBER 		VARCHAR2(32)			, 
	CUSTOM_1 			VARCHAR2(30)			, 
	CUSTOM_2 			VARCHAR2(30)			, 
	CUSTOM_3 			VARCHAR2(30)
); 

ALTER TABLE BCK_ACCOUNT_DM ADD CONSTRAINT BCK_ACCOUNT_DM_PK
	 PRIMARY KEY (OBJID);
	 

-- Table: BCK_CARRIER_DM
CREATE TABLE  BCK_CARRIER_DM (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	CARRIER_NAME 		VARCHAR2(48)		NOT NULL	, 
	CARRIER_CODE 		VARCHAR2(8)			NOT NULL	, 
	CARRIER_STATE 		VARCHAR2(8)		NOT NULL		, 
	CUSTOM_1 			VARCHAR2(30)			, 
	CUSTOM_2 			VARCHAR2(30)			, 
	CUSTOM_3 			VARCHAR2(30) 
);

ALTER TABLE BCK_CARRIER_DM ADD CONSTRAINT BCK_CARRIER_DM_PK
	 PRIMARY KEY (OBJID);

CREATE UNIQUE INDEX BCK_CARRIER_DM_IX01 ON BCK_CARRIER_DM (CARRIER_CODE, CARRIER_STATE, CARRIER_NAME);
-- Table: BCK_CYCLE_DM
CREATE TABLE BCK_CYCLE_DM (
	OBJID	 			NUMBER(19,0) 	NOT NULL, 
	CYCLE_CODE 			VARCHAR2(8)				, 
	CUT_DATE 			DATE					, 
	ISSUE_DATE 			DATE					, 
	DUE_DATE 			DATE					, 
	CUSTOM_1 			VARCHAR2(30 CHAR)		, 
	CUSTOM_2 			VARCHAR2(30 CHAR)		, 
	CUSTOM_3 			VARCHAR2(30 CHAR)
); 

ALTER TABLE BCK_CYCLE_DM ADD CONSTRAINT BCK_CYCLE_DM_PK
	 PRIMARY KEY (OBJID);

-- for JPivot to work
CREATE OR REPLACE FORCE VIEW BCK_CYCLE_DM_VIEW 
	(OBJID, CYCLE_CODE, CUT_DATE, ISSUE_DATE, DUE_DATE) AS 
	( SELECT OBJID, CYCLE_CODE, to_char(CUT_DATE) as CUT_DATE, 
	         to_char(ISSUE_DATE) as ISSUE_DATE, 
	         to_char(DUE_DATE) as DUE_DATE
  from BCK_CYCLE_DM );

-- Table: BCK_GEO_DM
CREATE TABLE BCK_GEO_DM (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	GEO_COUNTRY 		VARCHAR2(32)			,
	GEO_REGION 			VARCHAR2(16)			,
	GEO_STATE 			VARCHAR2(2)				,
	GEO_CITY 			VARCHAR2(64)			,
	CUSTOM_1 			VARCHAR2(30)			,
	CUSTOM_2 			VARCHAR2(30)			, 
	CUSTOM_3 			VARCHAR2(30)
);	
	
ALTER TABLE BCK_GEO_DM ADD CONSTRAINT BCK_GEO_DM_PK
	 PRIMARY KEY (OBJID);
	 
CREATE UNIQUE INDEX BCK_GEO_DM_IX01 ON BCK_GEO_DM ( GEO_COUNTRY, GEO_STATE, GEO_CITY);	 

-- Table: BCK_TIME_DM
CREATE TABLE BCK_TIME_DM (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	TIME_YEAR 			VARCHAR2(4)				, 
	TIME_MONTH 			VARCHAR2(2)				, 
	TIME_DAY 			VARCHAR2(2)				, 
	CUSTOM_1 			VARCHAR2(30)			,
	CUSTOM_2 			VARCHAR2(30)			,
	CUSTOM_3 			VARCHAR2(30)
);
 
ALTER TABLE BCK_TIME_DM ADD CONSTRAINT BCK_TIME_DM_PK
	 PRIMARY KEY (OBJID);


-- Table: BCK_RULE_TYPE
CREATE TABLE BCK_RULE_TYPE (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	TYPE_NAME 			VARCHAR2(32) 	NOT NULL, 
	DESCRIPTION 		VARCHAR2(128)			, 
	CUSTOM_1 			VARCHAR2(30)			, 
	CUSTOM_2 			VARCHAR2(30)			, 
	CUSTOM_3 			VARCHAR2(30)
);

ALTER TABLE BCK_RULE_TYPE ADD CONSTRAINT BCK_RULE_TYPE_PK
	 PRIMARY KEY (OBJID); 
	 
ALTER TABLE BCK_RULE_TYPE ADD CONSTRAINT BCK_RULE_TYPE_UK1
	 UNIQUE (TYPE_NAME);


-- Table: BCK_RULE
CREATE TABLE BCK_RULE (	
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	RULE_CODE 			VARCHAR2(16) 	NOT NULL, 
	RULE_NAME 			VARCHAR2(64) 	NOT NULL, 
	DESCRIPTION 		VARCHAR2(128)			, 
	RULE_TYPE_UID 		NUMBER(19,0)			, 
	CUSTOM_1 			VARCHAR2(30)			, 
	CUSTOM_2 			VARCHAR2(30)			, 
	CUSTOM_3 			VARCHAR2(30)
);

ALTER TABLE BCK_RULE ADD CONSTRAINT BCK_RULE_PK
	 PRIMARY KEY (OBJID);
	 
ALTER TABLE BCK_RULE ADD CONSTRAINT BCK_RULE_UK1
	 UNIQUE (RULE_CODE);

ALTER TABLE BCK_RULE ADD CONSTRAINT BCK_RULE_FK1
	FOREIGN KEY (RULE_TYPE_UID) REFERENCES BCK_RULE_TYPE (OBJID);

-- sequences	 
CREATE SEQUENCE BCK_CONSEQUENCE_UID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE BCK_DIMENSIONS_UID INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE BCK_PARAMETERS INCREMENT BY 1 START WITH 1;


---Insert new Rule Codes
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'A00-1','Contador de Tarifação Incorreta', null, null, null,null, null);      
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'A00-2','Contador de Tarifação Incorreta', null, null, null,null, null);   
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R00-1','Serviço não Encontrado', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R00-2','Serviço não Encontrado', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R00-3','Serviço não Encontrado', null, null, null,null, null);   
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R01-2','Erro de Tarifação', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R01-4','Erro de Tarifação', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R01-7','Erro de Tarifação', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R01-8','Erro de Tarifação', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R02-1','Duração Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R02-2','Duração Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R03-1','Descrição Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R03-2','Descrição Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R03-3','Descrição Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R03-4','Descrição Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R04-1','Valor da Fatura Incorreto', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R06-1','Uso Duplicado', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R07-1','Uso Sobreposto', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R07-2','Uso Sobreposto', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R08-1','Intervalo de Assinatura Inválido', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R08-2','Intervalo de Assinatura Inválido', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R08-3','Intervalo de Assinatura Inválido', null, null, null,null, null);          
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R09-1','Código de Barras Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R09-2','Código de Barras Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R09-3','Código de Barras Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R09-4','Código de Barras Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R09-5','Código de Barras Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R10-1','Chamadas fora de Ordem', null, null, null,null, null);    
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R11-1','Validade da Chamada Expirada', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R11-2','Validade da Chamada Expirada', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R11-3','Validade da Chamada Expirada', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R12-1','Período de Assinatura Incorreto', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R12-2','Período de Assinatura Incorreto', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R13-1','Serviço de Assinatura Incorreto', null, null, null,null, null);   
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R13-2','Serviço de Assinatura Incorreto', null, null, null,null, null);   	  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R13-3','Serviço de Assinatura Incorreto', null, null, null,null, null);   
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R16-1','Uso Fora dos Limites', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R16-2','Uso Fora dos Limites', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R16-3','Uso Fora dos Limites', null, null, null,null, null);     
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R19-1','Uso Não Zerado', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R19-2','Uso Não Zerado', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R20-1', 'Desconto Progressivo Incorreto', null, null, null, null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R23-1', 'Promoção Inválida', null, null, null, null, null);  	
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R27-1', 'Periodo Serviço Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R27-2', 'Periodo Serviço Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R27-3', 'Periodo Serviço Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R32-1','Demonstração Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R32-2','Demonstração Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R32-3','Demonstração Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R32-4','Demonstração Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R32-5','Demonstração Inválida', null, null, null,null, null);        
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R32-6','Demonstração Inválida', null, null, null,null, null);     
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R40-1','Período de Subscrição Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R40-2','Período de Subscrição Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R40-3','Período de Subscrição Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R41-1','Subscrição Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R41-2','Subscrição Inválida', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R47-1','Validação de Data de Vencimento', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R47-2','Validação de Data de Vencimento', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R59-1','Imposto Inválido', null, null, null,null, null);   
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R59-2','Imposto Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R60-1','Imposto Indevido', null, null, null,null, null);    
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R65-1','Validação de Totais de NF', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R82-1', 'Valor de Multa e Juros Inválido', null, null, null, null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R82-2', 'Valor de Multa e Juros Inválido', null, null, null, null, null);   
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-1','Conteúdo de Campo Inválido', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-2','Conteúdo de Campo Inválido', null, null, null,null, null);         
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-3','Conteúdo de Campo Inválido', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-4','Conteúdo de Campo Inválido', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-5','Conteúdo de Campo Inválido', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-6','Conteúdo de Campo Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-7','Conteúdo de Campo Inválido', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-8','Conteúdo de Campo Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-9','Conteúdo de Campo Inválido', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-10','Conteúdo de Campo Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-11','Conteúdo de Campo Inválido', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-12','Conteúdo de Campo Inválido', null, null, null,null, null);
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-13','Conteúdo de Campo Inválido', null, null, null,null, null);  

  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R83-14','Conteúdo de Campo Inválido', null, null, null,null, null);    
	insert into bck_rule values (	BCK_DIMENSIONS_UID.nextval, 'R30-1', 'Intra Grupo com valor indevido', null, null, null, null, null)
	insert into bck_rule values (	BCK_DIMENSIONS_UID.nextval, 'R30-2', 'Intra Grupo inválido', null, null, null, null, null)
	insert into bck_rule values (	BCK_DIMENSIONS_UID.nextval, 'R66-1', 'Promoção Indevida', null, null, null, null, null)
	insert into bck_rule values (	BCK_DIMENSIONS_UID.nextval, 'R66-2', 'Promoção Inexistente', null, null, null, null, null)
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R69-1','Juro e Multa Indevido', null, null, null,null, null);  
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R69-2','Juro e Multa Indevido', null, null, null,null, null);  
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R82-1','Juro e Multa Inválido', null, null, null,null, null);
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R60-1','Imposto do Governo Estadual', null, null, null,null, null);  
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R68-1','Multa por Quebra de Contato', null, null, null,null, null);  
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R68-2','Multa por Quebra de Contato', null, null, null,null, null); 
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R68-3','Multa por Quebra de Contato', null, null, null,null, null); 
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R00-2','Serviço não Encontrado', null, null, null,null, null);  
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R59-2','Imposto Inválido', null, null, null,null, null);
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R16-2','Uso Fora dos Limites', null, null, null,null, null);
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R16-3','Uso Fora dos Limites', null, null, null,null, null);   
	insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R10-1','Chamadas fora de Ordem', null, null, null,null, null);                
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R69-1','Juro e Multa Indevido', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R69-2','Juro e Multa Indevido', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R68-1','Multa por Quebra de Contato', null, null, null,null, null);  
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R68-2','Multa por Quebra de Contato', null, null, null,null, null); 
  insert into bck_rule values ( BCK_DIMENSIONS_UID.nextval, 'R68-3','Multa por Quebra de Contato', null, null, null,null, null);          
  		
	  		
-- Table: BCK_CONSEQUENCE_ATTR
CREATE TABLE BCK_CONSEQUENCE_ATTR (
	 OBJID NUMBER(19,0) NOT NULL, 
   ATTR_NAME_1 VARCHAR2(32),
   ATTR_VALUE_1 VARCHAR2(128),
   ATTR_NAME_2 VARCHAR2(32),
   ATTR_VALUE_2 VARCHAR2(128),
   ATTR_NAME_3 VARCHAR2(32),
   ATTR_VALUE_3 VARCHAR2(128),
   ATTR_NAME_4 VARCHAR2(32),
   ATTR_VALUE_4 VARCHAR2(128),
   ATTR_NAME_5 VARCHAR2(32),
   ATTR_VALUE_5 VARCHAR2(128),
   ATTR_NAME_6 VARCHAR2(32),
   ATTR_VALUE_6 VARCHAR2(128),
   ATTR_NAME_7 VARCHAR2(32),
   ATTR_VALUE_7 VARCHAR2(128),
   ATTR_NAME_8 VARCHAR2(32),
   ATTR_VALUE_8 VARCHAR2(128),
   ATTR_NAME_9 VARCHAR2(32),
   ATTR_VALUE_9 VARCHAR2(128),
   ATTR_NAME_10 VARCHAR2(32),
   ATTR_VALUE_10 VARCHAR2(128),
   ATTR_NAME_11 VARCHAR2(32),
   ATTR_VALUE_11 VARCHAR2(128),
   ATTR_NAME_12 VARCHAR2(32),
   ATTR_VALUE_12 VARCHAR2(128),
   ATTR_NAME_13 VARCHAR2(32),
   ATTR_VALUE_13 VARCHAR2(128),
   ATTR_NAME_14 VARCHAR2(32),
   ATTR_VALUE_14 VARCHAR2(128),
   ATTR_NAME_15 VARCHAR2(32),
   ATTR_VALUE_15 VARCHAR2(128),
   ATTR_NAME_16 VARCHAR2(32),
   ATTR_VALUE_16 VARCHAR2(128),
   ATTR_NAME_17 VARCHAR2(32),
   ATTR_VALUE_17 VARCHAR2(128),
   ATTR_NAME_18 VARCHAR2(32),
   ATTR_VALUE_18 VARCHAR2(128),
   ATTR_NAME_19 VARCHAR2(32),
   ATTR_VALUE_19 VARCHAR2(128),
   ATTR_NAME_20 VARCHAR2(32),
   ATTR_VALUE_20 VARCHAR2(128)
);

ALTER TABLE BCK_CONSEQUENCE_ATTR ADD CONSTRAINT BCK_CONSEQUENCE_ATTR_PK
	 PRIMARY KEY (OBJID); 

-- Table: BCK_CONSEQUENCE

CREATE TABLE  BCK_CONSEQUENCE (	
 	OBJID 				NUMBER(19,0) 	NOT NULL, 
	ACCOUNT_UID 		NUMBER(19,0) 	NOT NULL,
	CARRIER_UID 		NUMBER(19,0) 	NOT NULL,
	CYCLE_UID 			NUMBER(19,0) 	NOT NULL,
	GEO_UID 			NUMBER(19,0) 	NOT NULL,
	TIME_UID 			NUMBER(19,0) 	NOT NULL,
	RULE_UID 			NUMBER(19,0) 	NOT NULL,
	TRANSACTION_ID 		VARCHAR2(64)			, 
	DESCRIPTION 		VARCHAR2(128)			, 
	CONSEQUENCE_LEVEL 	VARCHAR2(10) 	NOT NULL,
   ATTRIBUTE_UID NUMBER(19) NOT NULL,
   FILENAME            VARCHAR2(256)           ,
	CUSTOM_1 			VARCHAR2(30)			, 
	CUSTOM_2 			VARCHAR2(30)			, 
	CUSTOM_3 			VARCHAR2(30)			, 
	CUSTOM_4 			VARCHAR2(30)			, 
	CUSTOM_5 			VARCHAR2(30)
);
ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_PK
	PRIMARY KEY (OBJID); 
	
ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_FK1
	 FOREIGN KEY (ACCOUNT_UID) REFERENCES BCK_ACCOUNT_DM (OBJID);
	  
ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_FK2
	FOREIGN KEY (TIME_UID) REFERENCES BCK_TIME_DM (OBJID);
	
ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_FK3
	FOREIGN KEY (RULE_UID) REFERENCES BCK_RULE (OBJID);
	
ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_FK4
	FOREIGN KEY (GEO_UID) REFERENCES BCK_GEO_DM (OBJID);
	
ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_FK5
	FOREIGN KEY (CARRIER_UID) REFERENCES BCK_CARRIER_DM (OBJID);
	
ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_FK6
	FOREIGN KEY (CYCLE_UID) REFERENCES BCK_CYCLE_DM (OBJID);

ALTER TABLE BCK_CONSEQUENCE ADD CONSTRAINT BCK_CONSEQUENCE_FK7
  FOREIGN KEY (ATTRIBUTE_UID) REFERENCES BCK_CONSEQUENCE_ATTR (OBJID);
  
  
CREATE UNIQUE INDEX BCK_CONSEQUENCE_IDX1 ON BCK_CONSEQUENCE (ATTRIBUTE_UID); 
	
create index BCK_CONSEQUENCE_idx_2 
 on bck_consequence (TRANSACTION_ID, RULE_UID);
 	
-- Creates the Invoice fact table
CREATE TABLE BCK_INVOICE_FACT (
  CYCLE_ID                                  NUMBER(19) NOT NULL,
  ACCOUNT_ID                                NUMBER(19) NOT NULL,
  CARRIER_ID                                NUMBER(19) NOT NULL,
  GEO_ID                                    NUMBER(19) NOT NULL,
  TIME_ID                                   NUMBER(19) NOT NULL,
  TOTAL_AMOUNT                              NUMBER(14,6) NOT NULL,
  CURRENT_AMOUNT                            NUMBER(14,6) NOT NULL,  
  interest_amount														NUMBER(14,6) NOT NULL,  
  penalty_amount														NUMBER(14,6) NOT NULL,
  TRANSACTION_ID 			    VARCHAR2(64)
);


CREATE INDEX BCK_INVOICE_FACT_IDX1 ON BCK_INVOICE_FACT (CYCLE_ID, ACCOUNT_ID, CARRIER_ID, GEO_ID, TIME_ID);


CREATE TABLE BCK_CONTRACT_TOTALS_FACT (
  CYCLE_ID                                  NUMBER(19) NOT NULL,
  ACCOUNT_ID                                NUMBER(19) NOT NULL,
  CARRIER_ID                                NUMBER(19) NOT NULL,
  GEO_ID                                    NUMBER(19) NOT NULL,
  TIME_ID                                   NUMBER(19) NOT NULL,
  CONTRACT_ID                               NUMBER(19) NOT NULL,
  RATEPLAN_ID                               NUMBER(19) NOT NULL,
  TOTAL_AMOUNT                              NUMBER(14,6) NOT NULL,
  EVENT_COUNT                               NUMBER(10) NOT NULL,  
  USED_VOLUME							    NUMBER(14) NOT NULL  
);

CREATE TABLE BCK_CONTRACT_DM (
  OBJID                                     NUMBER(19)  NOT NULL,
  CONTRACT_NUMBER							VARCHAR2(20) NOT NULL,
  ACCESS_NUMBER								VARCHAR2(20),
  CUSTOMER_NAME								VARCHAR2(50)
);

ALTER TABLE BCK_CONTRACT_DM ADD CONSTRAINT BCK_CONTRACT_DM_PK 
   PRIMARY KEY (OBJID);
   
CREATE INDEX BCK_CONTRACT_DM_IDX1 ON BCK_CONTRACT_DM (CONTRACT_NUMBER, ACCESS_NUMBER);


CREATE TABLE BCK_RATEPLAN_DM (
  OBJID                                     NUMBER(19)  NOT NULL,
  RATEPLAN_NAME								VARCHAR2(30) NOT NULL,
  SERVICE_TYPE 								VARCHAR2(50) NOT NULL  
);

ALTER TABLE BCK_RATEPLAN_DM ADD CONSTRAINT BCK_RATEPLAN_DM_PK 
   PRIMARY KEY (OBJID);
   
CREATE INDEX BCK_RATEPLAN_DM_IDX1 ON BCK_RATEPLAN_DM (RATEPLAN_NAME, SERVICE_TYPE);

--- ##################### ---
--- TABELAS DE PARAMETROS ---
--- ##################### ---
CREATE TABLE BCK_TAX_TYPE (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	TAX_CODE 			VARCHAR2(10)	NOT NULL, 
	TAX_NAME			VARCHAR2(64)	NOT NULL, 
	CUSTOM_1			VARCHAR2(30)			,
	CUSTOM_2			VARCHAR2(30)			, 
	CUSTOM_3			VARCHAR2(30)
);	
	
ALTER TABLE BCK_TAX_TYPE ADD CONSTRAINT BCK_TAX_TYPE_PK
	 PRIMARY KEY (OBJID);
	 
-- Table: BCK_FISCAL_CODE
CREATE TABLE BCK_FISCAL_CODE (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	FISCAL_CODE			VARCHAR2(10)	NOT NULL, 
	CODE_DESCRIPTION	VARCHAR2(128)	NOT NULL, 
	CUSTOM_1			VARCHAR2(30)			,
	CUSTOM_2			VARCHAR2(30)			, 
	CUSTOM_3			VARCHAR2(30)
);	
	
ALTER TABLE BCK_FISCAL_CODE ADD CONSTRAINT BCK_FISCAL_CODE_PK
	 PRIMARY KEY (OBJID);

create unique index BCK_FISCAL_CODE_IX01 on BCK_FISCAL_CODE (FISCAL_CODE);

-- Table: BCK_TAX_RATE
CREATE TABLE BCK_TAX_RATE (
	OBJID 				NUMBER(19,0) 	NOT NULL, 
	TAX_RATE			NUMBER(6,4)		NOT NULL, 
	GEO_UID				NUMBER(19,0)	NOT NULL, 
	TAX_TYPE_UID		NUMBER(19,0)	NOT NULL, 
	FISCAL_CODE_UID		NUMBER(19,0)			, 
	CUSTOM_1			VARCHAR2(30)			,
	CUSTOM_2			VARCHAR2(30)			, 
	CUSTOM_3			VARCHAR2(30)
);	

ALTER TABLE BCK_TAX_RATE ADD CONSTRAINT BCK_TAX_RATE_PK
	 PRIMARY KEY (OBJID);

ALTER TABLE BCK_TAX_RATE ADD CONSTRAINT BCK_TAX_RATE_FK1
	 FOREIGN KEY (GEO_UID) REFERENCES BCK_GEO_DM (OBJID);

ALTER TABLE BCK_TAX_RATE ADD CONSTRAINT BCK_TAX_RATE_FK2
	 FOREIGN KEY (TAX_TYPE_UID) REFERENCES BCK_TAX_TYPE (OBJID);

ALTER TABLE BCK_TAX_RATE ADD CONSTRAINT BCK_TAX_RATE_FK3
	 FOREIGN KEY (FISCAL_CODE_UID) REFERENCES BCK_FISCAL_CODE (OBJID);
   
  
CREATE UNIQUE INDEX BCK_TIME_IDX1 ON  BCK_TIME_DM (TIME_YEAR, TIME_MONTH, TIME_DAY);
CREATE UNIQUE INDEX BCK_CYCLE_IDX1 ON  BCK_CYCLE_DM (CYCLE_CODE, CUT_DATE, DUE_DATE);
CREATE UNIQUE INDEX BCK_CARRIER_IDX1 ON  BCK_CARRIER_DM (CARRIER_CODE, CARRIER_STATE);
CREATE UNIQUE INDEX BCK_ACCOUNT_IDX1 ON  BCK_ACCOUNT_DM (ACCOUNT_NUMBER);
  

--Creates parameters tables
CREATE TABLE  BCK_PARM_THRESHOLD_CALLS 
   (	OBJID NUMBER(19,0) NOT NULL ENABLE, 
	CALL_CLASS VARCHAR2(20 CHAR) NOT NULL ENABLE, 
	CALL_SUB_CLASS VARCHAR2(20 CHAR), 
	CALL_TARIFF VARCHAR2(5 CHAR), 
	MAX_DURATION_TYPE VARCHAR2(32 CHAR), 
	MAX_DURATION_UNIT NUMBER(19,0), 
	MIN_VALUE NUMBER(12,6), 
	MAX_VALUE NUMBER(12,6), 
	 PRIMARY KEY (OBJID) ENABLE
   );

CREATE UNIQUE INDEX  BCK_PARM_THRESHOLD_CALLS_IDX1 ON  
	BCK_PARM_THRESHOLD_CALLS 
	(CALL_CLASS, CALL_SUB_CLASS, CALL_TARIFF);

	CREATE TABLE BCK_PARM_DUE_DATES (
	OBJID				NUMBER(19,0) 	NOT NULL, 
	CYCLE_CODE			VARCHAR2(2)		NOT NULL,
	CUSTOMER_TYPE		VARCHAR2(2)		NOT NULL,
	DUE_DATE			NUMBER(2)		NOT NULL,
	MONTH_CHANGE_IND	CHAR(1)			NOT NULL
);

ALTER TABLE BCK_PARM_DUE_DATES ADD CONSTRAINT BCK_PARM_DUE_DATES_PK PRIMARY KEY (OBJID);

INSERT INTO BCK_PARM_DUE_DATES VALUES ( 1, '63', 'A', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 2, '63', 'B', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 3, '63', 'F', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 4, '63', 'J', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 5, '63', 'K', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 6, '63', 'L', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 7, '63', 'M', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 8, '63', 'N', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 9, '63', 'O', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 10, '63', 'Q', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 11, '63', 'R', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 12, '63', 'S', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 13, '63', 'T', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 14, '63', 'U', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 15, '63', 'X', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 16, '63', 'Y', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 17, '63', 'W', 17, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 18, '66', 'A', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 19, '66', 'B', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 20, '66', 'F', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 21, '66', 'J', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 22, '66', 'K', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 23, '66', 'L', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 24, '66', 'M', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 25, '66', 'N', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 26, '66', 'O', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 27, '66', 'Q', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 28, '66', 'R', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 29, '66', 'S', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 30, '66', 'T', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 31, '66', 'U', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 32, '66', 'X', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 33, '66', 'Y', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 34, '66', 'W', 21, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 35, '71', 'A', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 36, '71', 'B', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 37, '71', 'F', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 38, '71', 'J', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 39, '71', 'K', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 40, '71', 'L', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 41, '71', 'M', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 42, '71', 'N', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 43, '71', 'O', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 44, '71', 'Q', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 45, '71', 'R', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 46, '71', 'S', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 47, '71', 'T', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 48, '71', 'U', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 49, '71', 'X', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 50, '71', 'Y', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 51, '71', 'W', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 52, '12', 'A', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 53, '12', 'B', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 54, '12', 'F', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 55, '12', 'J', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 56, '12', 'K', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 57, '12', 'L', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 58, '12', 'M', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 59, '12', 'N', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 60, '12', 'O', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 61, '12', 'Q', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 62, '12', 'R', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 63, '12', 'S', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 64, '12', 'T', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 65, '12', 'U', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 66, '12', 'X', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 67, '12', 'Y', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 68, '12', 'W', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 69, '78', 'A', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 70, '78', 'B', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 71, '78', 'F', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 72, '78', 'J', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 73, '78', 'K', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 74, '78', 'L', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 75, '78', 'M', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 76, '78', 'N', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 77, '78', 'O', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 78, '78', 'Q', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 79, '78', 'R', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 80, '78', 'S', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 81, '78', 'T', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 82, '78', 'U', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 83, '78', 'X', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 84, '78', 'Y', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 85, '78', 'W', 3, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 86, '55', 'A', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 87, '55', 'B', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 88, '55', 'F', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 89, '55', 'J', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 90, '55', 'K', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 91, '55', 'L', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 92, '55', 'M', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 93, '55', 'N', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 94, '55', 'O', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 95, '55', 'Q', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 96, '55', 'R', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 97, '55', 'S', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 98, '55', 'T', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 99, '55', 'U', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 100, '55', 'X', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 101, '55', 'Y', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 102, '55', 'W', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 103, '56', 'A', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 104, '56', 'B', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 105, '56', 'F', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 106, '56', 'J', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 107, '56', 'K', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 108, '56', 'L', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 109, '56', 'M', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 110, '56', 'N', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 111, '56', 'O', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 112, '56', 'Q', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 113, '56', 'R', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 114, '56', 'S', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 115, '56', 'T', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 116, '56', 'U', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 117, '56', 'X', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 120, '56', 'Y', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 121, '56', 'W', 10, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 122, '63', 'C', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 123, '63', 'D', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 124, '63', 'E', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 125, '63', 'G', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 126, '63', 'H', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 127, '63', 'I', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 128, '63', 'P', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 129, '63', 'V', 25, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 131, '66', 'C', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 132, '66', 'D', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 133, '66', 'E', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 134, '66', 'G', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 135, '66', 'H', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 136, '66', 'I', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 137, '66', 'P', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 138, '66', 'V', 28, 'N');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 141, '71', 'C', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 142, '71', 'D', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 143, '71', 'E', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 144, '71', 'G', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 145, '71', 'H', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 146, '71', 'I', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 147, '71', 'P', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 148, '71', 'V', 5, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 151, '12', 'C', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 152, '12', 'D', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 153, '12', 'E', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 154, '12', 'G', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 155, '12', 'H', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 156, '12', 'I', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 157, '12', 'P', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 158, '12', 'V', 7, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 161, '78', 'C', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 162, '78', 'D', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 163, '78', 'E', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 164, '78', 'G', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 165, '78', 'H', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 166, '78', 'I', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 167, '78', 'P', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 168, '78', 'V', 12, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 171, '55', 'C', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 172, '55', 'D', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 173, '55', 'E', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 174, '55', 'G', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 175, '55', 'H', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 176, '55', 'I', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 177, '55', 'P', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 178, '55', 'V', 15, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 181, '56', 'C', 18, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 182, '56', 'D', 18, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 183, '56', 'E', 18, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 184, '56', 'G', 18, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 185, '56', 'H', 18, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 186, '56', 'I', 18, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 187, '56', 'P', 18, 'S');
INSERT INTO BCK_PARM_DUE_DATES VALUES ( 188, '56', 'V', 18, 'S');

