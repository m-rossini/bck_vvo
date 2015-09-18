DROP SEQUENCE BCK_PARM_THRESHOLD_CALLS_SEQ;

DELETE FROM BCK_PARM_THRESHOLD_CALLS;

CREATE SEQUENCE BCK_PARM_THRESHOLD_CALLS_SEQ INCREMENT BY 1 START WITH 1 CACHE 1000;

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VC1R', '', '', 'TIME', 15060, 0.1, 1.75);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VC2H', '', '', 'TIME', 15060, 0.91, 2.5);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VC2C', '', '', 'TIME', 15060, 0.91, 2.5);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VC2R', '', '', 'TIME', 15060, 0.91, 2.5);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VC3H', '', '', 'TIME', 15060, 1, 3);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VC3C', '', '', 'TIME', 15060, 1, 3);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VC3R', '', '', 'TIME', 15060, 1, 3);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'AD2', '', '', 'TIME', 15060, 0.7, 2);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'INT', '', '', 'TIME', 15060, 0.92, 15);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'INTR', '', '', 'TIME', 15060, 0.92, 15);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'INTC', '', '', 'TIME', 15060, 0.92, 15);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'ROI', '', '', 'TIME', 15060, 0.05, 20);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'DADOS ALTA VELOCIDADE', '', '', 'UNIT', '', '', 50);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'VIVO PLAY', '', '', 'UNIT', '', '', 50);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'WAP', '', '', 'UNIT', '', '', 50);

insert into bck_parm_threshold_calls values (BCK_PARM_THRESHOLD_CALLS_SEQ.NEXTVAL, 'ZAP', '', '', 'UNIT', '', '', 100);

commit;


