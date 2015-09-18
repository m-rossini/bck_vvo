-- creating tables and sequences for Rule Groups Selection funcionality
CREATE TABLE BILLCHKOW.bck_rule_list
    (package_id                     NUMBER(10,0) NOT NULL,
    description                    VARCHAR2(64),
    relative_base                  VARCHAR2(128) NOT NULL,
    mask                           VARCHAR2(64) NOT NULL,
    always_run_flg                 VARCHAR2(1),
    user_visible                   VARCHAR2(1),
  PRIMARY KEY (package_id)
  USING INDEX TABLESPACE TI_BILLCPR1)
  TABLESPACE TD_BILLCPR1;

CREATE TABLE BILLCHKOW.bck_rule_group
    (group_id                       NUMBER(10,0) NOT NULL,
    group_name                     VARCHAR2(128) NOT NULL,
    runnable_flg                   VARCHAR2(1),
  PRIMARY KEY (group_id)
  USING INDEX TABLESPACE TI_BILLCPR1)
  TABLESPACE TD_BILLCPR1;

ALTER TABLE BILLCHKOW.bck_rule_group
ADD CONSTRAINT bck_rule_group_uk1 UNIQUE (group_name)
USING INDEX TABLESPACE TI_BILLCPR1;

CREATE TABLE BILLCHKOW.bck_rule_group_list
    (group_uid                      NUMBER(10,0) NOT NULL,
    package_uid                    NUMBER(10,0) NOT NULL)
  TABLESPACE TD_BILLCPR1;

ALTER TABLE BILLCHKOW.bck_rule_group_list
ADD CONSTRAINT fk_rule_list_id FOREIGN KEY (package_uid)
REFERENCES BILLCHKOW.bck_rule_list (package_id) ON DELETE CASCADE;

ALTER TABLE BILLCHKOW.bck_rule_group_list
ADD CONSTRAINT fk_rule_group_id FOREIGN KEY (group_uid)
REFERENCES BILLCHKOW.bck_rule_group (group_id) ON DELETE CASCADE;

CREATE TABLE BILLCHKOW.bck_rule_exec_hist
    (request_uid                    NUMBER NOT NULL,
    package_uid                    NUMBER(10,0) NOT NULL)
  TABLESPACE TD_BILLCPR1;

CREATE UNIQUE INDEX BILLCHKOW.bck_rule_exec_hist_pk ON BILLCHKOW.bck_rule_exec_hist
  (
    "REQUEST_UID" DESC,
    package_uid                     ASC
  )
  TABLESPACE TD_BILLCPR1;

ALTER TABLE BILLCHKOW.bck_rule_exec_hist
ADD CONSTRAINT fk_rule_exec_id FOREIGN KEY (request_uid)
REFERENCES BILLCHKOW.web_request (request_id);

CREATE SEQUENCE BILLCHKOW.BCK_RULE_LIST_SEQ
 START WITH 200
 INCREMENT BY 1
 MAXVALUE 9999999999;
 
CREATE SEQUENCE BILLCHKOW.BCK_RULE_GROUP_SEQ
 START WITH 2
 INCREMENT BY 1
 MAXVALUE 9999999999;
