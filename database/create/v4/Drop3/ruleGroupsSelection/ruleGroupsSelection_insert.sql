-- populating tables for Rule Groups Selection (Billcheckout Version 4, Drop 3)
INSERT INTO BILLCHKOW.bck_rule_group
VALUES (1,'Regras Release Drop 3','X');

INSERT INTO BILLCHKOW.bck_rule_list
VALUES (0,'Inicializa��o','conf/drools/','INIT*.drl','X',NULL);
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (1,'Tarifa��o','conf/drools/','R01*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (2,'Temporiza��o de M�nima de Chamadas','conf/drools/','R02*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (4,'Cobrancas no Boleto de Pagamento','conf/drools/','R04*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (5,'Concess�o de Benef�cios sobre Uso','conf/drools/','R05*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (6,'Duplicidade e Sobreposi��o de Chamadas','conf/drools/','R06_R07*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (8,'Per�odo Mensalidade','conf/drools/','R08*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (9,'C�digo de Barras','conf/drools/','R09*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (10,'Chamadas Fora da Ordem Cronol�gica','conf/drools/','R10*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (11,'Vig�ncia das Chamadas','conf/drools/','R11*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (13,'Tarifa de Assinatura','conf/drools/','R13*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (16,'Tarifas Passthrough','conf/drools/','R16*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (19,'Tarifacao AD1 e DSL1','conf/drools/','R19*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (20,'Desconto Progressivo','conf/drools/','R20*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (30,'Tarifa��o Favoritos','conf/drools/','R30*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (31,'Tarifa��o Intra-grupo','conf/drools/','R31*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (32,'Demonstra��o na Se��o Correta','conf/drools/','R32*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (40,'Terminais Faturados','conf/drools/','R40*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (47,'Data de Vencimento','conf/drools/','R47*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (50,'Tarifa��o de Uso Negociado','conf/drools/','R50*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (52,'Dados Cadastrais do Cliente','conf/drools/','R52*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (53,'Produtos x Tecnologia do Aparelho','conf/drools/','R53*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (54,'FUST e FUNNTEL','conf/drools/','R54*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (55,'Negocia��o Obrigat�ria','conf/drools/','R55*.drl',NULL,'X');
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
VALUES (63,'Conviv�ncia entre os Produtos','conf/drools/','R63*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (64,'M�s e Per�odo da Fatura','conf/drools/','R64*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (65,'Sum�rio das Notas Fiscais','conf/drools/','R65*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (66,'Per�odo da Concess�o do Benef�cio','conf/drools/','R66*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (68,'Multa de Fideliza��o','conf/drools/','R68*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (69,'Multa e Juros Indevido','conf/drools/','R69_82*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (71,'Servi�o Gest�o','conf/drools/','R71*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (73,'Servi�o Avulso','conf/drools/','R73*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (74,'Servi�o de Compartilhamento','conf/drools/','R74*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (75,'S�rie e Sub-S�rie das Notas Fiscais','conf/drools/','R75*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (78,'Tipo de Cliente','conf/drools/','R78*.drl',NULL,'X');
INSERT INTO BILLCHKOW.bck_rule_list
VALUES (83,'Informa��es Incompletas','conf/drools/','R83*.drl',NULL,'X');

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
values (auth_sequence.nextval, 'RulesGroupEditor', 0, 'A', 'Sele��o de Grupos de Regras: Visualiza��o e Edi��o', null, null, null);

COMMIT;
