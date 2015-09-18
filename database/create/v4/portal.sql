
create table AUT_USER (
   cd_user  varchar2(8) NOT NULL PRIMARY KEY,
   tx_password char(32),
   nm_user varchar2(32),
   dt_create date NOT NULL,
   dt_last_access date,
   qt_logins integer,
   dt_status date NOT NULL,
   st_status CHAR(1) NOT NULL,
   cd_user_last_update varchar2(8) NOT NULL
);

CREATE INDEX IDX_USER_STATUS ON AUT_USER (ST_STATUS, DT_STATUS);

create table AUT_GROUP (
   cd_group INTEGER NOT NULL PRIMARY KEY,
   nm_group varchar2(32) NOT NULL,
   dt_create date NOT NULL,
   dt_status date NOT NULL,
   st_status CHAR(1) NOT NULL,
   cd_user_last_update varchar2(8) NOT NULL
);

CREATE INDEX IDX_GROUP_NAME ON AUT_GROUP (NM_GROUP);

CREATE INDEX IDX_GROUP_STATUS ON AUT_GROUP (ST_STATUS, DT_STATUS);

CREATE TABLE AUT_PERM (
   cd_perm INTEGER NOT NULL primary key,
   nm_perm varchar2(32),
   tx_desc varchar2(256)
);

CREATE INDEX IDX_NM_PERM ON AUT_PERM (NM_PERM);

CREATE TABLE AUT_USER_GROUP_ASGM (
   cd_user varchar2(8) NOT NULL,
   cd_group INTEGER NOT NULL,
   dt_asgm date NOT NULL,
   dt_expr date,
   cd_user_last_update varchar2(8) NOT NULL,
   PRIMARY KEY(cd_user,cd_group,dt_asgm)
);

ALTER TABLE AUT_USER_GROUP_ASGM
  ADD CONSTRAINT AUT_USER_GROUP_USER_FK FOREIGN KEY (cd_user)
      REFERENCES AUT_USER (cd_user);

ALTER TABLE AUT_USER_GROUP_ASGM
  ADD CONSTRAINT AUT_USER_GROUP_GROUP_FK FOREIGN KEY (cd_group)
      REFERENCES AUT_GROUP (cd_group);

CREATE TABLE AUT_GROUP_PERM_ASGM (
   cd_group INTEGER NOT NULL,
   cd_perm INTEGER NOT NULL,
   dt_asgm date NOT NULL,
   dt_expr date,
   cd_user_last_update varchar2(8) NOT NULL,
   PRIMARY KEY(cd_group,cd_perm,dt_asgm)
);

ALTER TABLE AUT_GROUP_PERM_ASGM
  ADD CONSTRAINT AUT_GROUP_PERM_GROUP_FK FOREIGN KEY (cd_group)
      REFERENCES AUT_GROUP (cd_group);

ALTER TABLE AUT_GROUP_PERM_ASGM
  ADD CONSTRAINT AUT_GROUP_PERM_PERM_FK FOREIGN KEY (cd_perm)
      REFERENCES AUT_PERM (cd_perm);


-- table: WEB_USER
create table WEB_USER (
	USER_ID			integer 		NOT NULL,
	SECURITY_ID		varchar2(128)	NOT NULL,
	USER_EMAIL		varchar2(512)	NOT NULL,
	USER_NAME		varchar2(512)			,
	LOGIN_TRIES		integer 		NOT NULL
);

alter table WEB_USER add constraint WEB_USER_PK
      primary key (USER_ID);

alter table WEB_USER add constraint WEB_USER_UK1
      unique (SECURITY_ID);

alter table WEB_USER add constraint WEB_USER_UK2
      unique (USER_EMAIL);

create index WEB_USER_IDX1 on WEB_USER (USER_NAME);

create sequence USER_SEQUENCE start with 1;


-- table: PROC_REQUEST
create table PROC_REQUEST (
	REQUEST_ID 			integer			NOT NULL,
	REQUEST_LABEL    	varchar2(256)			,
	LATEST_STATUS   	integer			NOT NULL
);

alter table PROC_REQUEST add constraint PROC_REQUEST_PK
      primary key (REQUEST_ID);

create index PROC_REQUEST_IDX1 on PROC_REQUEST (REQUEST_LABEL);

create sequence PROC_REQUEST_SEQUENCE start with 1;


-- table: PROC_REQUEST_INFO
create table PROC_REQUEST_INFO (
	REQUEST_ID      	integer			NOT NULL,
	INFO_KEY			varchar2(64)	NOT NULL,
	INFO_VALUE			varchar2(256)
);

alter table PROC_REQUEST_INFO add constraint PROC_REQUEST_INFO_PK
      primary key (REQUEST_ID, INFO_KEY);

alter table PROC_REQUEST_INFO add constraint PROC_REQUEST_INFO_FK1
      foreign key (REQUEST_ID) references PROC_REQUEST (REQUEST_ID);
create index PROC_REQUEST_INFO_IX01 ON PROC_REQUEST_INFO (REQUEST_ID);

-- table: PROC_REQUEST_INFILE
create table PROC_REQUEST_INFILE (
	FILENAME			varchar2(512)	NOT NULL,
	REQUEST_ID			integer			NOT NULL
);

alter table PROC_REQUEST_INFILE add constraint PROC_REQUEST_INFILE_PK
      primary key  (FILENAME, REQUEST_ID);

alter table PROC_REQUEST_INFILE add constraint PROC_REQUEST_INFILE_FK1
      foreign key (REQUEST_ID) references PROC_REQUEST (REQUEST_ID);

create index PROC_REQUEST_INFILE_IDX1 on PROC_REQUEST_INFILE (REQUEST_ID);


-- table: PROC_REQUEST_TRAIL
create table PROC_REQUEST_TRAIL (
	TRAIL_ID			integer			NOT NULL,
	REQUEST_ID			integer			NOT NULL,
	STATUS_ID			integer			NOT NULL,
	TRAIL_DATETIME		date			NOT NULL,
	TRAIL_MESSAGE		varchar2(512)
);

alter table PROC_REQUEST_TRAIL add constraint PROC_REQUEST_TRAIL_PK
      primary key  (TRAIL_ID);

alter table PROC_REQUEST_TRAIL add constraint PROC_REQUEST_TRAIL_FK1
      foreign key (REQUEST_ID) references PROC_REQUEST (REQUEST_ID);

create index PROC_REQUEST_TRAIL_IDX1 on PROC_REQUEST_TRAIL (REQUEST_ID);

create sequence PROC_TRAIL_SEQUENCE start with 1;


-- table: PROC_REQUEST_OUTFILE
create table PROC_REQUEST_OUTFILE (
	FILE_ID				integer			NOT NULL,
	TRAIL_ID			integer			NOT NULL,
	FILENAME			varchar2(512)	NOT NULL
);

alter table PROC_REQUEST_OUTFILE add constraint PROC_REQUEST_OUTFILE_PK
      primary key  (FILE_ID);

alter table PROC_REQUEST_OUTFILE add constraint PROC_REQUEST_OUTFILE_FK1
      foreign key (TRAIL_ID) references PROC_REQUEST_TRAIL (TRAIL_ID);

create index PROC_REQUEST_OUTFILE_IDX1 on PROC_REQUEST_OUTFILE (TRAIL_ID);

create index PROC_REQUEST_OUTFILE_IDX2 on PROC_REQUEST_OUTFILE (FILENAME);

create sequence OUTFILE_SEQUENCE start with 1;


-- table: PROC_OUTFILE_ATTRS
create table PROC_OUTFILE_ATTRS (
	FILE_ID				integer			NOT NULL,
	ATTR_KEY			varchar2(64)	NOT NULL,
	ATTR_VALUE			varchar2(256)
);

alter table PROC_OUTFILE_ATTRS add constraint PROC_OUTFILE_ATTRS_PK
      primary key (FILE_ID, ATTR_KEY);

alter table PROC_OUTFILE_ATTRS add constraint PROC_REQUEST_ATTRS_FK1
      foreign key (FILE_ID) references PROC_REQUEST_OUTFILE (FILE_ID);



-- table: WEB_REQUEST
create table WEB_REQUEST (
	REQUEST_ID 			integer			NOT NULL,
	START_DATE			date			NOT NULL,
	REQUEST_STATUS		integer			NOT NULL,
	END_DATE    		date					,
	OWNER_ID   			integer
);

alter table WEB_REQUEST add constraint WEB_REQUEST_PK
      primary key (REQUEST_ID);

create index WEB_REQUEST_IDX1 on WEB_REQUEST (START_DATE);
create index WEB_REQUEST_IDX2 on WEB_REQUEST (END_DATE);
create index WEB_REQUEST_IDX3 on WEB_REQUEST (REQUEST_STATUS);
create index WEB_REQUEST_IDX4 on WEB_REQUEST (OWNER_ID);

create sequence WEB_REQUEST_SEQUENCE start with 1;


-- table: WEB_REQUEST_REQUESTS
create table WEB_REQUEST_REQUESTS (
	WEB_REQUEST_ID      integer			NOT NULL,
	PROC_REQUEST_ID		integer			NOT NULL
);

alter table WEB_REQUEST_REQUESTS add constraint WEB_REQUEST_REQUESTS_PK
      primary key (WEB_REQUEST_ID, PROC_REQUEST_ID);

alter table WEB_REQUEST_REQUESTS add constraint WEB_REQUEST_REQUESTS_FK1
      foreign key (WEB_REQUEST_ID) references WEB_REQUEST (REQUEST_ID);

alter table WEB_REQUEST_REQUESTS add constraint WEB_REQUEST_REQUESTS_FK2
      foreign key (PROC_REQUEST_ID) references PROC_REQUEST (REQUEST_ID);
create index WEB_REQUEST_REQUESTS_IX01 ON WEB_REQUEST_REQUESTS (PROC_REQUEST_ID);

-- table: WEB_REQUEST_INFO
create table WEB_REQUEST_INFO (
	WEB_REQUEST_ID		integer			NOT NULL,
	INFO_KEY			varchar2(64)	NOT NULL,
	INFO_VALUE			varchar2(256)
);

alter table WEB_REQUEST_INFO add constraint WEB_REQUEST_INFO_PK
      primary key  (WEB_REQUEST_ID, INFO_KEY);

alter table WEB_REQUEST_INFO add constraint WEB_REQUEST_INFO_FK1
      foreign key (WEB_REQUEST_ID) references WEB_REQUEST (REQUEST_ID);


-- table: WEB_NOTIFICATION
create table WEB_NOTIFICATION (
	NOTIFICATION_ID		integer			NOT NULL,
	WEB_REQUEST_ID		integer			NOT NULL,
	EMAIL_ADDRESS		varchar2(256)	NOT NULL,
	SENT_DATETIME		date
);

alter table WEB_NOTIFICATION add constraint WEB_NOTIFICATION_PK
      primary key  (NOTIFICATION_ID);

alter table WEB_NOTIFICATION add constraint WEB_NOTIFICATION_FK1
      foreign key (WEB_REQUEST_ID) references WEB_REQUEST (REQUEST_ID);

create index WEB_NOTIFICATION_IDX1 on WEB_NOTIFICATION (WEB_REQUEST_ID);

create sequence WEB_NOTIFICATION_SEQUENCE start with 1;


-- table: WEB_BUNDLEFILE
create table WEB_BUNDLEFILE (
	FILE_ID				integer			NOT NULL,
	WEB_REQUEST_ID		integer			NOT NULL,
	FILENAME			varchar2(512)	NOT NULL,
	CREATE_DATETIME		date			NOT NULL,
	MESSAGE				varchar2(512)
);

alter table WEB_BUNDLEFILE add constraint WEB_BUNDLEFILE_PK
      primary key  (FILE_ID);

alter table WEB_BUNDLEFILE add constraint WEB_BUNDLEFILE_FK1
      foreign key (WEB_REQUEST_ID) references WEB_REQUEST (REQUEST_ID);

create index WEB_BUNDLEFILE_IDX1 on WEB_BUNDLEFILE (WEB_REQUEST_ID);

create sequence BUNDLEFILE_SEQUENCE start with 1;



CREATE TABLE WEB_REQUEST_COUNTER (
REQUEST_ID 				NUMBER(19) 										NOT NULL,
TOTAL_COUNT 				NUMBER(19)			DEFAULT 0			NOT NULL,
FINISH_COUNT 			NUMBER(19) 			DEFAULT 0			NOT NULL			);

ALTER TABLE WEB_REQUEST_COUNTER ADD CONSTRAINT WEB_REQUEST_COUNTER_PK PRIMARY KEY (REQUEST_ID);



INSERT INTO AUT_GROUP (CD_GROUP,NM_GROUP,DT_CREATE,DT_STATUS,ST_STATUS,CD_USER_LAST_UPDATE) VALUES (1,'admin',sysdate,sysdate,'A','1');
INSERT INTO AUT_GROUP (CD_GROUP,NM_GROUP,DT_CREATE,DT_STATUS,ST_STATUS,CD_USER_LAST_UPDATE) VALUES (2,'everyone',sysdate,sysdate,'A','1');

INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (1,'request.create',null);
INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (2,'request.group.view',null);
INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (3,'iq.search',null);
INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (4,'user.update.all',null);
INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (5,'group.view',null);
INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (6,'group.create',null);
INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (7,'request.manager','Request Management');
INSERT INTO AUT_PERM (CD_PERM,NM_PERM,TX_DESC) VALUES (8,'rules.edit','Edit Rules');

INSERT INTO AUT_USER (CD_USER,TX_PASSWORD,NM_USER,DT_CREATE,DT_LAST_ACCESS,QT_LOGINS,DT_STATUS,ST_STATUS,CD_USER_LAST_UPDATE) VALUES
            ('1','4233DFFD57472EE531C3C2A8FC964691','Auster Administrator',sysdate,sysdate,0,sysdate,'A','1');

INSERT INTO AUT_GROUP_PERM_ASGM (CD_GROUP,CD_PERM,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES (1,1,sysdate,null,'1');
INSERT INTO AUT_GROUP_PERM_ASGM (CD_GROUP,CD_PERM,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES (1,2,sysdate,null,'1');
INSERT INTO AUT_GROUP_PERM_ASGM (CD_GROUP,CD_PERM,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES (1,3,sysdate,null,'1');
INSERT INTO AUT_GROUP_PERM_ASGM (CD_GROUP,CD_PERM,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES (1,4,sysdate,null,'1');
INSERT INTO AUT_GROUP_PERM_ASGM (CD_GROUP,CD_PERM,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES (1,5,sysdate,null,'1');
INSERT INTO AUT_GROUP_PERM_ASGM (CD_GROUP,CD_PERM,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES (1,6,sysdate,null,'1');
INSERT INTO AUT_GROUP_PERM_ASGM (CD_GROUP,CD_PERM,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES (2,4,sysdate,null,'1');

INSERT INTO AUT_USER_GROUP_ASGM (CD_USER,CD_GROUP,DT_ASGM,DT_EXPR,CD_USER_LAST_UPDATE) VALUES ('1',1,sysdate,null,'admin');

INSERT INTO WEB_USER (USER_ID,SECURITY_ID,USER_EMAIL,USER_NAME,LOGIN_TRIES) VALUES (USER_SEQUENCE.NEXTVAL,'1','admin@auster.com.br','Auster Administrator',0);


