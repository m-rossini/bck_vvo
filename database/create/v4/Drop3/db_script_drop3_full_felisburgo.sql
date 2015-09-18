-------------TABLES-------------------

-- controle de processo batch
--alteracao de layout
drop table BILLCHKOW.BCK_CONTROL_BATCH;

CREATE TABLE BILLCHKOW.BCK_CONTROL_BATCH 
(          
    OBJID              NUMBER(19,0)     NOT NULL,    
    JOB_NAME           VARCHAR2(64)             ,
    JOB_REQ            VARCHAR2(64)             ,
    CYCLE_CODE         VARCHAR2(64)             , 
    CYCLE_DT           DATE                     ,    
    FILE_NAME          VARCHAR2(128)            ,
    PATH_NAME          VARCHAR2(128)            ,
    EXECUTED_FLAG      VARCHAR2(1)  
);

--Tabela OutPut Parameters
CREATE TABLE  BILLCHKOW.ast_param_config
    (objid                          NUMBER(14,0) NOT NULL,
    value                          VARCHAR2(512) NOT NULL,
    module_name                    VARCHAR2(32) NOT NULL,
    short_description              VARCHAR2(32),
    description                    VARCHAR2(256));

-- Constraints for AST_PARAM_CONFIG
ALTER TABLE  BILLCHKOW.ast_param_config
ADD CONSTRAINT  ast_param_config_pk PRIMARY KEY (objid);

---- SPLITBILLING ---------------------------
-- Create Sequence 

create sequence BILLCHKOW.SHARING_GROUP_USAGE_DETAILS_SQ START WITH 1 INCREMENT BY 1 nomaxvalue;
create sequence BILLCHKOW.SHARING_GROUP_SUMMARY_SQ START WITH 1 INCREMENT BY 1 nomaxvalue;
create sequence BILLCHKOW.SHARING_GROUP_DETAIL_SQ START WITH 1 INCREMENT BY 1 nomaxvalue;

-- Create Tables section
Create table BILLCHKOW.SHARING_GROUP_DETAIL_REPORT (
	"ID_GROUP_DETAIL" Number NOT NULL ,
	"CYCLE_END_DATE" Date,
	"CYCLE_CODE" Varchar2 (30),
	"CYCLE_NAME" Varchar2 (30),
	"CPF_CNPJ" Varchar2 (40),
	"TYPE" Varchar2 (2),
	"ID_HIERARQUIA" Number,
	"ID_GRUPO" Number,
	"ACCESS_NUMBER" Number,
	"ACCOUNT_NUMBER" Number,
	"CONTA_PAGADORA" Varchar2 (30),
	"STATUS_CONTA_PAGADORA" Varchar2 (2),
	"FRANQ_UTILIZADA" Varchar2 (15),
	"QTD_EVENTOS" Number,
	"PERC_UTIL" Number,
	"MENSALIDADE" Varchar2 (30),
	"ESTADO" Varchar2 (30),
	"REGIONAL" Varchar2 (30),
primary key ("ID_GROUP_DETAIL") 
);

Create table BILLCHKOW.SHARING_GROUP_SUMMARY_REPORT (
	"ID_GROUP_SUMMARY" Number NOT NULL ,
	"CYCLE_END_DATE" Date,
	"CYCLE_CODE" Varchar2 (30),
	"NOME_CLIENTE" Varchar2 (60),
	"CPF_CNPJ" Varchar2 (40),
	"TYPE" Varchar2 (2),
	"ID_HIERARQUIA" Number,
	"NUM_CONTA_RAIZ" Number,
	"ID_GRUPO" Number,
	"MENSALIDADE" Varchar2 (30),
	"NOME_SERV_TITULAR" Varchar2 (30),
	"VALOR_MENSALIDADE" Number,
	"TOTAL_FRANQUIA" Number,
	"PRO_RATA" Number,
	"ATV_SVC_TITULAR" Date,
	"EXP_SVC_TITULAR" Date,
	"ESTADO" Varchar2 (30),
	"REGIONAL" Varchar2 (30),
primary key ("ID_GROUP_SUMMARY") 
);

Create table BILLCHKOW.SHARING_GROUP_USAGE_DETAILS_RE (
	"ID_USAGE_DETAIL" Number NOT NULL ,
	"CYCLE_END_DATE" Date,
	"CYCLE_CODE" Varchar2 (30),
	"ID_HIERARQUIA" Number,
	"ID_GRUPO" Number,
	"TIPO_CHAMADA" Varchar2 (5),
	"DIRECAO" Varchar2 (10),
	"NUM_ORIGEM" Number,
	"NUM_DESTINO" Number,
	"DT_INICIO" Date,
	"HR_INICIO" Varchar2 (10),
	"DURACAO" Varchar2 (30),
	"ESTADO" Varchar2 (30),
	"REGIONAL" Varchar2 (30),
primary key ("ID_USAGE_DETAIL") 
);

insert into BILLCHKOW.AST_PARAM_CONFIG values (100, '/opt/Billc/jbpm', 'JbpmWeb', '', 'Local para Upload de Arquivo de Comentarios');
insert into BILLCHKOW.AST_PARAM_CONFIG values (200, '/opt/Billc', 'InvoiceView', '', 'Local para adicionar arquivos do InvoiceView');

commit;

-- Selecao de Grupo de Regras

-- dropping Rule Groups Selection's tables and sequences
DROP TABLE BILLCHKOW.bck_rule_list CASCADE CONSTRAINTS;
DROP TABLE BILLCHKOW.bck_rule_group CASCADE CONSTRAINTS;
DROP TABLE BILLCHKOW.bck_rule_group_list CASCADE CONSTRAINTS;
DROP TABLE BILLCHKOW.bck_rule_exec_hist CASCADE CONSTRAINTS;
DROP SEQUENCE BILLCHKOW.bck_rule_list_seq;
DROP SEQUENCE BILLCHKOW.bck_rule_group_seq;

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

-- populating tables for Rule Groups Selection (Billcheckout Version 4, Drop 3)
INSERT INTO BILLCHKOW.bck_rule_group
VALUES (1,'Regras Release Drop 3','X');

INSERT INTO BILLCHKOW.bck_rule_list
VALUES (0,'Inicialização','conf/drools/','INIT*.drl','X',NULL);
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (1,'Tarifação','conf/drools/','R01*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (2,'Temporização de Mínima de Chamadas','conf/drools/','R02*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (4,'Cobrancas no Boleto de Pagamento','conf/drools/','R04*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (5,'Concessão de Benefícios sobre Uso','conf/drools/','R05*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (6,'Duplicidade e Sobreposição de Chamadas','conf/drools/','R06_R07*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (8,'Período Mensalidade','conf/drools/','R08*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (9,'Código de Barras','conf/drools/','R09*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (10,'Chamadas Fora da Ordem Cronológica','conf/drools/','R10*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (11,'Vigência das Chamadas','conf/drools/','R11*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (13,'Tarifa de Assinatura','conf/drools/','R13*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (16,'Tarifas Passthrough','conf/drools/','R16*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (19,'Tarifacao AD1 e DSL1','conf/drools/','R19*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (20,'Desconto Progressivo','conf/drools/','R20*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (30,'Tarifação Favoritos','conf/drools/','R30*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (31,'Tarifação Intra-grupo','conf/drools/','R31*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (32,'Demonstração na Seção Correta','conf/drools/','R32*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (40,'Terminais Faturados','conf/drools/','R40*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (47,'Data de Vencimento','conf/drools/','R47*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (50,'Tarifação de Uso Negociado','conf/drools/','R50*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (52,'Dados Cadastrais do Cliente','conf/drools/','R52*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (53,'Produtos x Tecnologia do Aparelho','conf/drools/','R53*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (54,'FUST e FUNNTEL','conf/drools/','R54*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (55,'Negociação Obrigatória','conf/drools/','R55*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (56,'Ordem da Prioridade de Consumo','conf/drools/','R56*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (57,'Produto x Tipo de Cliente x Cliente CNPJ','conf/drools/','R57*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (59,'Estado do Teminal Diferente da Conta','conf/drools/','R59*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (60,'ICMS na Nota Fiscal','conf/drools/','R60*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (62,'Quantidade de Parcelas do Aparelho','conf/drools/','R62*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (63,'Convivência entre os Produtos','conf/drools/','R63*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (64,'Mês e Período da Fatura','conf/drools/','R64*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (65,'Sumário das Notas Fiscais','conf/drools/','R65*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (66,'Período da Concessão do Benefício','conf/drools/','R66*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (68,'Multa de Fidelização','conf/drools/','R68*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (69,'Multa e Juros Indevido','conf/drools/','R69_82*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (71,'Serviço Gestão','conf/drools/','R71*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (73,'Serviço Avulso','conf/drools/','R73*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (74,'Serviço de Compartilhamento','conf/drools/','R74*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (75,'Série e Sub-Série das Notas Fiscais','conf/drools/','R75*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (78,'Tipo de Cliente','conf/drools/','R78*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (83,'Informações Incompletas','conf/drools/','R83*.drl',NULL,'X');

INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,1);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,2);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,4);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,5);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,6);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,8);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,9);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,10);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,11);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,13);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,16);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,19);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,20);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,30);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,31);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,32);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,40);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,47);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,50);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,52);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,53);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,54);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,55);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,56);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,57);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,59);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,60);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,62);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,63);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,64);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,65);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,66);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,68);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,69);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,71);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,73);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,74);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,75);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,78);
INSERT INTO BILLCHKOW.bck_rule_group_list VALUES (1,83);

-- populating user permissions
insert into BILLCHKOW.auth_role (objid, role_name, static_cardnlt, role_status, description, custom_1, custom_2, custom_3)
values (auth_sequence.nextval, 'RulesGroupEditor', 0, 'A', 'Seleção de Grupos de Regras: Visualização e Edição', null, null, null);

COMMIT;

-- CREATE TABLE
CREATE TABLE BCK_DASH_BOARD
(
    MODULE_ID       NUMBER,
    MODULE_NAME     VARCHAR2(64),
    MODULE_DESC     VARCHAR2(128),
    FUNCTION        VARCHAR2(64)         
);

ALTER TABLE BCK_DASH_BOARD ADD CONSTRAINT BCK_DASH_BOARD_PK
PRIMARY KEY (MODULE_ID); 

CREATE TABLE BCK_DASH_BOARD_ITEM
(
    MODULE_ID       NUMBER,  -- FK
    ITEM_ID         NUMBER,
    ITEM_NAME       VARCHAR2(64),
    ITEM_WEIGHT     NUMBER(10,5),
    COMPLETED       NUMBER(10,9),  -- 0 = não começou    1 = terminou
    DISABLED_FLAG   CHAR(1),       -- 0 = ativo          1 = inativo 
    CYCLE_CODE      VARCHAR2(2)    
);

ALTER TABLE BCK_DASH_BOARD_ITEM ADD CONSTRAINT BCK_DASH_BOARD_ITEM_PK
PRIMARY KEY (MODULE_ID, ITEM_ID, CYCLE_CODE);

ALTER TABLE BCK_DASH_BOARD_ITEM ADD CONSTRAINT BCK_DASH_BOARD_ITEM_FK1
FOREIGN KEY (MODULE_ID) REFERENCES BCK_DASH_BOARD (MODULE_ID);

CREATE TABLE BCK_LOAD_PROCESS_STATUS
(
    MODULE_ID       NUMBER,  -- FK
    ITEM_ID         NUMBER,  -- FK   
    CYCLE_CODE      VARCHAR2(2),
    CUT_DATE        DATE,
    INIT_QTT_LOAD   NUMBER,
    END_QTT_LOAD    NUMBER,
    START_DATE      DATE,
    END_DATE        DATE    
);

ALTER TABLE BCK_LOAD_PROCESS_STATUS ADD CONSTRAINT BCK_LOAD_PROCESS_STATUS_FK1
FOREIGN KEY (MODULE_ID, ITEM_ID, CYCLE_CODE) REFERENCES BCK_DASH_BOARD_ITEM (MODULE_ID, ITEM_ID, CYCLE_CODE);

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CREATE PROCEDURE
CREATE OR REPLACE PACKAGE dashboard IS
    PROCEDURE refresh_start_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2, v_cut_date DATE, v_start_date DATE);
    PROCEDURE refresh_end_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2, v_init_qtt_load INTEGER, v_end_qtt_load INTEGER, v_end_date DATE);
END dashboard;

CREATE OR REPLACE PACKAGE BODY dashboard AS 
    -- start processing
    PROCEDURE refresh_start_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2, v_cut_date DATE, v_start_date DATE) IS
        var_module_id INTEGER;
        var_item_id   INTEGER;
    BEGIN
        SELECT module_id INTO var_module_id 
        FROM BCK_DASH_BOARD 
        WHERE module_name = v_module_name;

        SELECT item_id INTO var_item_id 
        FROM BCK_DASH_BOARD_ITEM 
        WHERE item_name = v_item_name
        AND module_id = var_module_id
        AND cycle_code = v_cycle_code;        
   
        UPDATE BCK_LOAD_PROCESS_STATUS 
        SET cut_date=v_cut_date, start_date=v_start_date, end_date=null, end_qtt_load=0, init_qtt_load=0
        WHERE module_id = var_module_id
        AND item_id = var_item_id
        AND cycle_code = v_cycle_code;
        
        UPDATE BCK_DASH_BOARD_ITEM 
        SET completed = 0 
        WHERE module_id = var_module_id
        AND item_id = var_item_id
        AND cycle_code = v_cycle_code;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('NO DATA FOUND');
    END refresh_start_processing;
    
    -- end processing
    PROCEDURE refresh_end_processing (v_module_name VARCHAR2, v_item_name VARCHAR2, v_cycle_code VARCHAR2,
                                      v_init_qtt_load INTEGER, v_end_qtt_load INTEGER, v_end_date DATE) IS
        var_module_id INTEGER;
        var_item_id   INTEGER;
    BEGIN
       SELECT module_id INTO var_module_id 
       FROM BCK_DASH_BOARD 
       WHERE module_name = v_module_name;
   
       SELECT item_id INTO var_item_id 
       FROM BCK_DASH_BOARD_ITEM 
       WHERE item_name = v_item_name
       AND module_id = var_module_id
       AND cycle_code = v_cycle_code;
   
       UPDATE BCK_LOAD_PROCESS_STATUS 
       SET init_qtt_load = v_init_qtt_load, end_qtt_load = v_end_qtt_load, end_date = v_end_date 
       WHERE module_id = var_module_id
       AND item_id = var_item_id
       AND cycle_code = v_cycle_code;
   
       UPDATE BCK_DASH_BOARD_ITEM 
       SET completed = 1 
       WHERE module_id = var_module_id
       AND item_id = var_item_id
       AND cycle_code = v_cycle_code;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('NO DATA FOUND');
    END refresh_end_processing;
END dashboard;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- INSERT DADOS
INSERT INTO BCK_DASH_BOARD VALUES (1,'HELD BILL','Relatório de Contas não impressas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (1,1,'Ciclo Held',1.0,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (1,1,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (2,'BILL AMOUNT','Relatório Total Faturado.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,1,'Bill Amount',0.7,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (2,2,'Bill Amount CSA',0.3,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (2,2,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (3,'CAPTION CODE','Relatório Faturado por Captions.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,1,'Ciclo',0.6,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,2,'Expurgo',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (3,3,'Churn',0.2,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (3,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (4,'DORMANT','Relatório de Contas não faturadas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,1,'Ciclo',0.5,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,2,'Chamada',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,3,'Colaborador',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (4,4,'Demanda',0.1,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,3,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (4,4,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (5,'JUROS E MULTAS','Relatório de Juros e Multas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,1,'Caption',0.4,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,2,'Demanda',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (5,3,'Juros Multas',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (5,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (6,'RECEITA DIARIA','Relatório de Receita Diária.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,1,'Diario',0.6,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (6,2,'Unbilled',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (6,2,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (7,'CCI','Relatório CCI.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,1,'CCI',0.4,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,2,'CCI PROC',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (7,3,'CCI PREL',0.3,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (7,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (8,'LONGA DISTANCIA','Relatório de Chamadas Longa Distância.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,1,'De Para',0.2,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,2,'Original',0.4,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (8,3,'Trafego',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (8,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (9,'DRP SUMMARY','Relatório de Chamadas Dropadas e Não Dropadas.', 'BCK010');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (9,1,'DRP',1.0,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (9,1,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (10,'CONTAS FINANCEIRAS','Relatório de Contas Financeiras.', 'BCK016A');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,1,'Diversas',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,2,'Genericas',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (10,3,'DTBN2BCK',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (10,3,'78',SYSDATE,0,0,null,null);

INSERT INTO BCK_DASH_BOARD VALUES (11,'SPLITBILLING','Relatório de Split Billing.', 'BCK014');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','12');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','55');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','56');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','63');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','66');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','71');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,1,'Summary',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,2,'Details',0.3,0,'0','78');
INSERT INTO BCK_DASH_BOARD_ITEM VALUES (11,3,'Usage',0.4,0,'0','78');
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'12',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'55',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'56',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'63',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'66',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'71',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,1,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,2,'78',SYSDATE,0,0,null,null);
INSERT INTO BCK_LOAD_PROCESS_STATUS VALUES (11,3,'78',SYSDATE,0,0,null,null);

commit;
