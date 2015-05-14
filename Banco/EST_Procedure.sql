#A procedure será chamada quando todas as sessões forem concluidas
#Assim ele cria uma cópia dos dados para as respectivas tabelas de orçamento e sessões concluidas

DELIMITER $
CREATE PROCEDURE orcamento_concluido(IN id_orc INT(10))

	BEGIN
		DECLARE nsessoes INT(10);
		DECLARE concluidas INT(10);
		
		SELECT qntd_sessao FROM tbl_orcamento WHERE cod_orc = id_orc INTO @nsessoes;
		SELECT COUNT(id_sessao) FROM tbl_sessao 
				WHERE concluida = 1
				AND fk_cod_orc = id_orc INTO @concluidas;

		IF @nsessoes <= @concluidas THEN

			INSERT INTO tbl_orccon(cod_orccon, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orccon)
			SELECT cod_orc, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc
			FROM tbl_orcamento
			WHERE cod_orc = id_orc;

			INSERT INTO tbl_sescon(id_sescon, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_cod_orccon)
			SELECT id_sessao, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_cod_orc
			FROM tbl_sessao	
			WHERE fk_cod_orc = id_orc
			#GROUP BY fk_cod_orc
			;

			DELETE FROM tbl_sessao WHERE fk_cod_orc = id_orc;
			DELETE FROM tbl_orcamento WHERE cod_orc = id_orc;

			INSERT INTO tbl_registro (tabela_alt, cod_ref, acao, desc_acao, cod_sql)
			VALUES ('tbl_orcamento', id_orc, 'delete', CONCAT('o pagamento da última sessão do orçamento ', CAST(id_orc AS CHAR(15)),
			' foi efetuado, e o orçamento foi concluído'), 'INSERT INTO tbl_orccon(cod_orccon, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orccon)
			SELECT cod_orc, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc
			FROM tbl_orcamento
			WHERE cod_orc = id_orc;

			INSERT INTO tbl_sescon(id_sescon, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_cod_orccon)
			SELECT id_sessao, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_cod_orc
			FROM tbl_sessao	
			WHERE fk_cod_orc = id_orc
			#GROUP BY fk_cod_orc
			;

			DELETE FROM tbl_sessao WHERE fk_cod_orc = id_orc;
			DELETE FROM tbl_orcamento WHERE cod_orc = id_orc;');

		END IF;
	
	END $

DELIMITER ;
#----------------------------------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta as sessões

DELIMITER $
CREATE PROCEDURE del_sessao(IN fk_id_orc INT(10))

	BEGIN

		DELETE FROM tbl_sessao WHERE fk_cod_orc = fk_id_orc;
	
	END $

Delimiter ;
#------------------------------------------------------------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta os orçamentos

DELIMITER $
CREATE PROCEDURE del_orcamento(IN fk_id_orc INT(10))

	BEGIN

		call del_sessao(fk_id_orc);
		DELETE FROM tbl_orcamento WHERE cod_orc = fk_id_orc;
	
	END $

DELIMITER ;
#------------------------------------------------------------------------------------------------------------------------------------------------




#------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $
CREATE PROCEDURE calcula_idade(IN fk_id_orc INT(10))

	BEGIN

	END $

DELIMITER ;




#------------------------------------------------------------------------------------------------------------------------------------------------




#---------------------------------------------------------------------------------------------------------
#Procedure que grava as informações na auditoria
DELIMITER $

CREATE PROCEDURE insere_registro (IN tabela_alt VARCHAR(50), cod_ref INT(10), acao VARCHAR(15),
									desc_acao TINYTEXT, id_login INT(10), cod_sql TINYTEXT, dado_ant VARCHAR(50), dado_novo VARCHAR(50), campo varchar(20))

	BEGIN

		INSERT INTO tbl_registro (tabela_alt, cod_ref, acao, desc_acao, fk_id_login,  cod_sql, dado_ant, dado_novo, campo)
		VALUES (tabela_alt, cod_ref, acao, desc_acao, id_login, cod_sql, dado_ant, dado_novo, campo);
	
	END $

Delimiter ;

CALL insere_registro('tbl_cliente', 1, 'delete', 'Inserir um dado na tabela Cliente', 1,

					'INSERT INTO tbl_cliente (nome, CPF, data_nasc, tel, fk_id_login)
					VALUES ("Douglas Lambertinny", "64837748274", "1994/04/20", "9876-5432", 1);', '-', '-', '-'

);

#-------------------------------------------------------------------------------------------------------------
