#INSERTS DAS TABELAS


#-------------------------------------------------------------------------------------------------------------------------------------------------
#INSERTS DA TABELA LOGIN
INSERT INTO tbl_login (nome, CPF, login, senha, admin)
VALUES ('Wallace Abreu de Oliveira', '53141191913', 'admin', '123', 1);

INSERT INTO tbl_login (nome, CPF, login, senha)
VALUES ('Eduardo de Souza', '12398765436', 'Edu', '321');

INSERT INTO tbl_login (nome, CPF, login, senha)
VALUES ('Lohan William', '63826344802', 'Lohan', '231');

INSERT INTO tbl_login (nome, CPF, login, senha)
VALUES ('Ronaldo Nazaro', '73648371758', 'Rnd', '213');

SELECT * FROM tbl_login;
#-------------------------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------------------------
#INSERTS DA TABELA CLIENTE
INSERT INTO tbl_cliente (nome, CPF, data_nasc, tel, fk_id_login)
VALUES ('Douglas Lambertinny', '64837748274', '1994/04/20', '9876-5432', 1);

INSERT INTO tbl_cliente (nome, CPF, sexo, data_nasc, tel, fk_id_login)
VALUES ('Luana Ferreira Nascimento', '37485574758', 1, '1997-07-14', '1234-5678', 2);

INSERT INTO tbl_cliente (nome, CPF, data_nasc, tel, fk_id_login)
VALUES ('Japa Itapecerica', '63857365982', '1998-03-19', '8374-8374', 2);

INSERT INTO tbl_cliente (nome, CPF, sexo, data_nasc, tel, fk_id_login)
VALUES ('Vanessa Lira', '83647362717', 1, '1992-01-07', '5601-0893', 3);

SELECT * FROM tbl_cliente;
#-------------------------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------------------------
#TABELA REPRESENTANTE
INSERT INTO tbl_representante (nome, CPF, sexo,  data_nasc, tel)
VALUES ('Eucrimaria Luiza Ferreira Nascimento', '37474456283', 1, '1960/12/10', '6253-7474'); 

INSERT INTO tbl_representante (nome, CPF, data_nasc, tel)
VALUES ('China da Serra', '93472647364', '1978/02/01', '6208-8062'); 

SELECT * FROM tbl_representante;
#-------------------------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------------------------
#TABELA PARENTESCO
INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('AVÓ');

INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('AVÔ');

INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('TIA');

INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('TIO');

INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('MÃE');

INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('PAI');

INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('MADRASTA');

INSERT INTO tbl_parentesco (tipo_parentesco)
VALUES ('PADRASTO');

SELECT * FROM tbl_parentesco;
#-------------------------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------------------------
#TABELA RELAÇÃO
INSERT INTO tbl_rel (fk_id_cli, fk_id_parentesco, fk_id_representante)
VALUES (2, 2, 1);

INSERT INTO tbl_rel (fk_id_cli, fk_id_parentesco, fk_id_representante)
VALUES (3, 1, 2);

SELECT * FROM tbl_rel;
#-------------------------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------------------------
#TABELA ORCAMENTO
insert into tbl_orcamento(tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc)
values ('cartão', 1090.98, 4, 1);

insert into tbl_orcamento(tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc)
values ('Dinheiro', 398.80, 3, 2);

insert into tbl_orcamento(tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc)
values ('Cartão', 200.00, 2, 3);

insert into tbl_orcamento(tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc)
values ('Não específicado ..hmm..', 50.00, 1, 4);

select * from tbl_orcamento;
#-------------------------------------------------------------------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------------------------------------------------------------------
#TABELA SESSÃO
INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('0', 100.00, 'cartão', '2015-06-15', '15:00', 1);

INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('0', 100.00, 'cartão', '2015-06-25', '13:00', 1);

INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('0', 100.00, 'cartão', '2015-07-10', '15:00', 1);

INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('1', 100.00, 'cartão', '2015-07-30', '15:00', 1);




#------------------------------------------------------------------------------------------------------------------
CALL insere_registro('tbl_cliente', 1, 'delete', 'Inserir um dado na tabela Cliente', 1,

					'INSERT INTO tbl_cliente (nome, CPF, data_nasc, tel, fk_id_login)
					VALUES ("Douglas Lambertinny", "64837748274", "1994/04/20", "9876-5432", 1);', '-', '-', '-'

);


INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('0', 132.93, 'Dinheiro', '2015-06-22', '19:00', 2);

INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('0', 132.93, 'Dinheiro', '2015-07-07', '19:00', 2);

INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('1', 132.93, 'Dinheiro', '2015-07-22', '19:00', 2);



INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('0', 100.00, 'Cartão', '2015-08-12', '17:00', 3);

INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('1', 100.00, 'Cartão', '2015-08-30', '12:00', 3);



INSERT INTO tbl_sessao(concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, fk_cod_orc)
VALUES ('1', 50.00, 'Não especificada ..hm..', '2015-08-15', '22:00', 4);

SELECT * FROM tbl_sessao;
#-------------------------------------------------------------------------------------------------------------------------------------------------






#-----------------------------------------------------------------------------------------------------------------
#Auditoria

INSERT INTO tbl_registro (tabela_alt, cod_ref, acao, desc_acao, fk_id_login,  cod_sql, dado_ant, dado_novo, campo, data_alt)
		VALUES ('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-05-10 10:00:00'),
('tbl_sessao', 1, 'insert', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-10 10:00:00'),
('tbl_sessao', 1, 'insert', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-9 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-8 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-7 10:00:00'),

('tbl_sessao', 1, 'login', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-6 10:00:00'),
('tbl_sessao', 1, 'login', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-5 10:00:00'),
('tbl_cliente', 1, 'login', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-10 10:00:00'),
('tbl_cliente', 1, 'login', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-9 10:00:00'),
('tbl_cliente', 1, 'login', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-8 10:00:00'),
('tbl_cliente', 1, 'login', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-05-7 10:00:00'),

('tbl_sessao', 1, 'delete', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-10 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-9 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-8 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-7 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-6 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-5 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-4 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-05-3 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-05-2 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-05-1 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-04-30 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-04-29 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-04-28 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-04-27 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-04-10 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-03-10 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-03-10 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-04-10 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-03-10 10:00:00'),
('tbl_cliente', 1, 'delete', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-02-10 10:00:00'),

('tbl_cliente', 1, 'update', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-9 10:00:00'),
('tbl_cliente', 1, 'update', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-8 10:00:00'),
('tbl_cliente', 1, 'update', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-7 10:00:00'),
('tbl_cliente', 1, 'update', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-6 10:00:00'),
('tbl_cliente', 1, 'update', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-5 10:00:00'),
('tbl_cliente', 1, 'update', 'genérico', 2, 'sql genérico', '-', '-', '-', '2015-05-4 10:00:00'),
('tbl_cliente', 1, 'update', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-05-3 10:00:00'),
('tbl_cliente', 1, 'update', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-05-10 10:00:00'),

('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-04-11 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-03-12 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-02-13 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-02-14 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-02-10 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-02-10 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-02-10 10:00:00'),
('tbl_cliente', 1, 'insert', 'genérico', 1, 'sql genérico', '-', '-', '-', '2015-02-10 10:00:00');