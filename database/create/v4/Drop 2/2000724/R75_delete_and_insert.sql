delete from bck_consequence;
delete from bck_carrier_dm;
drop sequence bck_carrier_dm_seq;

create sequence bck_carrier_dm_seq INCREMENT BY 1 START WITH 1 CACHE 1000;

INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','AC','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','AL','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','AM','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','AP','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','AT','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','BA','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','BR','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','CE','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','DF','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','ES','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','FL','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','GF','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','GO','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','MA','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','MG','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','MS','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','MT','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','PA','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','PB','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','PE','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','PI','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','PR','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','PT','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','RJ','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','RN','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','RO','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','RR','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','RS','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','SC','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','SE','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','SK','C',NULL,NULL);
INSERT INTO bck_carrier_dm VALUES (bck_carrier_dm_seq.nextval,'AT&T','45','SP','C',NULL,NULL);
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'AT&T','45','TO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'AT&T','45','UG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'AT&T','45','US','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','AC','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','AL','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','AM','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','AP','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','AT','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','BA','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','BR','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','CE','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','DF','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','ES','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','FL','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','GF','A1',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','GO','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','MA','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','MG','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','MS','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','MT','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','PA','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','PB','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','PE','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','PI','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','PR','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','PT','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','RJ','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','RN','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','RO','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','RR','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','RS','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','SC','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','SE','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','SK','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','SP','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','TO','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','UG','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Brasil Telecom','14','US','A',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','AC','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','AL','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','AM','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','AP','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','AT','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','BA','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','BR','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','CE','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','DF','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','ES','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','FL','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','GF','U','29',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','GO','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','MA','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','MG','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','MS','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','MT','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','PA','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','PB','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','PE','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','PI','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','PR','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','PT','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','RJ','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','RN','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','RO','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','RR','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','RS','U6',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','SC','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','SE','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','SK','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','SP','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','TO','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','UG','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'CTBC','12','US','U','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','AC','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','AL','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','AM','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','AP','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','AT','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','BA','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','BR','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','CE','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','DF','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','ES','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','FL','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','GF','A','19',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','GO','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','MA','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','MG','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','MS','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','MT','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','PA','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','PB','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','PE','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','PI','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','PR','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','PT','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','RJ','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','RN','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','RO','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','RR','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','RS','A6',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','SC','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','SE','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','SK','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','SP','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','TO','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','UG','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'EMBRATEL','21','US','A','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','AC','C','8',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','AL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','AM','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','AP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','AT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','BA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','BR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','CE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','DF','C','2',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','ES','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','FL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','GF','E','4',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','GO','C','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','MA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','MG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','MS','C','3',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','MT','C','7',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','PA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','PB','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','PE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','PI','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','PR','C','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','PT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','RJ','I','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','RN','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','RO','E','3',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','RR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','RS','C','4',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','SC','C','6',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','SE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','SK','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','SP','E','4',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','TO','C','9',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','UG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'GVT','25','US','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','AC','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','AL','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','AM','6',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','AP','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','AT','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','BA','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','BR','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','CE','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','DF','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','ES','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','FL','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','GF','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','GO','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','MA','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','MG','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','MS','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','MT','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','PA','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','PB','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','PE','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','PI','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','PR','5','21',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','PT','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','RJ','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','RN','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','RO','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','RR','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','RS','B','20',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','SC','5','21',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','SE','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','SK','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','SP','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','TO','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','UG','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'INTELIG','23','US','5',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','AC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','AL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','AM','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','AP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','AT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','BA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','BR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','CE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','DF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','ES','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','FL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','GF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','GO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','MA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','MG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','MS','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','MT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','PA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','PB','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','PE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','PI','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','PR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','PT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','RJ','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','RN','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','RO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','RR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','RS','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','SC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','SE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','SK','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','SP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','TO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','UG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Sercomtel','43','US','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','AC','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','AL','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','AM','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','AP','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','AT','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','BA','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','BR','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','CE','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','DF','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','ES','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','FL','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','GF','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','GO','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','MA','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','MG','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','MS','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','MT','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','PA','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','PB','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','PE','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','PI','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','PR','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','PT','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','RJ','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','RN','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','RO','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','RR','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','RS','B5','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','SC','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','SE','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','SK','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','SP','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','TO','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','UG','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telecom Americas','36','US','B','5',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','AC','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','AL','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','AM','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','AP','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','AT','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','BA','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','BR','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','CE','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','DF','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','ES','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','FL','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','GF','BB',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','GO','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','MA','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','MG','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','MS','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','MT','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','PA','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','PB','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','PE','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','PI','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','PR','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','PT','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','RJ','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','RN','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','RO','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','RR','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','RS','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','SC','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','SE','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','SK','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','SP','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','TO','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','UG','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TELEFONICA','15','US','I',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','AC','B','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','AM','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','AP','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','BA','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','DF','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','ES','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','GF','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','GO','B','25',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','MA','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','MS','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','MT','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','PA','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','PR','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','RJ','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','RO','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','RR','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','RS','B','19',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','SC','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','SE','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','SP','B','25',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar - TNL PCA S.A','97','TO','B','17',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','AC','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','AL','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','AM','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','AP','B','11',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','AT','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','BA','B','11',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','BR','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','CE','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','DF','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','ES','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','FL','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','GF','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','GO','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','MA','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','MG','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','MS','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','MT','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','PA','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','PB','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','PE','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','PI','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','PR','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','PT','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','RJ','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','RN','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','RO','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','RR','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','RS','B','12',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','SC','B','11',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','SE','B','11',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','SK','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','SP','B','18',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','TO','B','10',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','UG','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Telemar','31','US','F',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','AC','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','AL','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','AM','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','AP','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','AT','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','BA','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','BR','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','CE','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','DF','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','ES','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','FL','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','GF','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','GO','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','MA','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','MG','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','MS','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','MT','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','PA','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','PB','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','PE','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','PI','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','PR','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','PT','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','RJ','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','RN','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','RO','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','RR','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','RS','A1',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','SC','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','SE','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','SK','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','SP','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','TO','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','UG','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'TIM','41','US','A','1',NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','AC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','AL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','AM','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','AP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','AT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','BA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','BR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','CE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','DF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','ES','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','FL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','GF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','GO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','MA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','MG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','MS','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','MT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','PA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','PB','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','PE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','PI','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','PR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','PT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','RJ','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','RN','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','RO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','RR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','RS','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','SC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','SE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','SK','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','SP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','TO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','UG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 1','85','US','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','AC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','AL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','AM','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','AP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','AT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','BA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','BR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','CE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','DF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','ES','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','FL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','GF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','GO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','MA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','MG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','MS','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','MT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','PA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','PB','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','PE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','PI','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','PR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','PT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','RJ','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','RN','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','RO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','RR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','RS','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','SC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','SE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','SK','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','SP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','TO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','UG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'Vesper - Regi�o 3','89','US','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','AC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','AL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','AM','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','AP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','AT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','BA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','BR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','CE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','DF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','ES','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','FL','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','GF','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','GO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','MA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','MG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','MS','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','MT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','PA','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','PB','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','PE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','PI','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','PR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','PT','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','RJ','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','RN','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','RO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','RR','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','RS','AA',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','SC','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','SE','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','SK','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','SP','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','TO','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','UG','C',NULL,NULL)
;
INSERT INTO bck_carrier_dm
VALUES
(bck_carrier_dm_seq.nextval,'VIVO','00','US','C',NULL,NULL)
;

commit;
