#A procedure será chamada quando todas as sessões forem concluidas
#Assim ele cria uma cópia dos dados para as respectivas tabelas de orçamento e sessões concluidas

DELIMITER $
CREATE PROCEDURE orcamento_concluido(IN id_orcamento INT(10))

	BEGIN
		DECLARE nsessoes INT(10);
		DECLARE concluidas INT(10);
		
		SELECT qntd_sessao FROM tbl_orcamento WHERE id_orc = id_orcamento INTO @nsessoes;
		SELECT COUNT(id_sessao) FROM tbl_sessao 
				WHERE concluida = 1
				AND fk_id_orc = id_orcamento INTO @concluidas;

		IF @nsessoes <= @concluidas THEN

			INSERT INTO tbl_orccon(id_orccon, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orccon)
			SELECT id_orc, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc
			FROM tbl_orcamento
			WHERE id_orc = id_orcamento;

			INSERT INTO tbl_sescon(id_sescon, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_id_orccon)
			SELECT id_sessao, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_id_orc
			FROM tbl_sessao	
			WHERE fk_id_orc = id_orcamento
			#GROUP BY fk_id_orc
			;

			DELETE FROM tbl_sessao WHERE fk_id_orc = id_orcamento;
			DELETE FROM tbl_orcamento WHERE id_orc = id_orcamento;

			INSERT INTO tbl_registro (tabela_alt, cod_ref, acao, desc_acao, cod_sql)
			VALUES ('tbl_orcamento', id_orc, 'delete', CONCAT('o pagamento da última sessão do orçamento ' + CAST(id_orc AS CHAR(15)) +
			' foi efetuado, e o orçamento foi concluído'), 'INSERT INTO tbl_orccon(id_orccon, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orccon)
			SELECT id_orc, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc
			FROM tbl_orcamento
			WHERE id_orc = id_orcamento;

			INSERT INTO tbl_sescon(id_sescon, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_id_orccon)
			SELECT id_sessao, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_id_orc
			FROM tbl_sessao	
			WHERE fk_id_orc = id_orcamento
			#GROUP BY fk_id_orc
			;

			DELETE FROM tbl_sessao WHERE fk_id_orc = id_orcamento;
			DELETE FROM tbl_orcamento WHERE id_orc = id_orcamento;');

		END IF;
	
	END $

DELIMITER ;

#CALL orcamento_concluido(1);
#SELECT * FROM tbl_orcamento;
#SELECT * FROM tbl_sessao;
#SELECT * FROM tbl_orccon;
#SELECT * FROM tbl_sescon;
#----------------------------------------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta as sessões
DELIMITER $
CREATE PROCEDURE del_sessao(IN fk_id_orcamento INT(10))

	BEGIN

		DELETE FROM tbl_sessao WHERE fk_id_orc = fk_id_orcamento;
	
	END $

Delimiter ;

#CALL del_sessao(1);
#SELECT * FROM tbl_orcamento;
#SELECT * FROM tbl_sessao;
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta os orçamentos e sessões caso houver
DELIMITER $
CREATE PROCEDURE del_orcamento(IN fk_id_orcamento INT(10))

	BEGIN

		CALL del_sessao(fk_id_orcamento);
		DELETE FROM tbl_orcamento WHERE id_orc = fk_id_orcamento;
	
	END $

DELIMITER ;

#CALL del_orcamento(1);
#SELECT * FROM tbl_orcamento;
#SELECT * FROM tbl_sessao;
#------------------------------------------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta as sessões da tbl_sescon
DELIMITER $
CREATE PROCEDURE del_sescon(IN fk_id_orcamento INT(10))

	BEGIN

		DELETE FROM tbl_sescon WHERE fk_id_orccon = fk_id_orcamento;
	
	END $

Delimiter ;

#CALL del_sescon(1);
#SELECT * FROM tbl_orccon;
#SELECT * FROM tbl_sescon;
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta os orçamentos
DELIMITER $
CREATE PROCEDURE del_orccon(IN fk_id_orcamento INT(10))

	BEGIN

		CALL del_sescon(fk_id_orcamento);
		DELETE FROM tbl_orccon WHERE id_orccon = fk_id_orcamento;
	
	END $

DELIMITER ;

#CALL del_orccon(1);
#SELECT * FROM tbl_orccon;
#SELECT * FROM tbl_sescon;
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta os orçamentos
DELIMITER $
CREATE PROCEDURE del_relacao(IN fk_id_cliente INT(10))

	BEGIN

		DELETE FROM tbl_rel WHERE fk_id_cli = fk_id_cliente;
	
	END $

DELIMITER ;

#CALL del_relacao(1);
#SELECT * FROM tbl_rel;
#SELECT * FROM tbl_cliente;
#SELECT * FROM tbl_representante;
#------------------------------------------------------------------------------------------------------------------------------------------------




#------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta os orçamentos
DELIMITER $
CREATE PROCEDURE del_cliente(IN id_cliente INT(10))

	BEGIN

		DECLARE id_orcamento INT(10);
		DECLARE id_orcamentoc INT(10);

		SET @id_orcamento = (SELECT id_orc FROM tbl_orcamento WHERE fk_id_cli_orc = id_cliente); 
		CALL del_orcamento(@id_orcamento);

		SET @id_orcamentoc = (SELECT id_orccon FROM tbl_orccon WHERE fk_id_cli_orccon = id_cliente); 
		CALL del_orccon(@id_orcamentoc);

		CALL del_relacao(id_cliente);
		DELETE FROM tbl_cliente WHERE id_cli = id_cliente;
	
	END $

DELIMITER ;

#CALL del_cliente(1);
#SELECT * FROM tbl_orcamento;
#SELECT * FROM tbl_sessao;
#SELECT * FROM tbl_orccon;
#SELECT * FROM tbl_sescon;
#SELECT * FROM tbl_rel;
#SELECT * FROM tbl_cliente;
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que grava as informações na auditoria
DELIMITER $

CREATE PROCEDURE insere_registro (IN tabela_alt VARCHAR(50), cod_ref INT(10), acao VARCHAR(15),
									desc_acao TINYTEXT, id_login INT(10), cod_sql TINYTEXT, dado_ant TINYTEXT, dado_novo TINYTEXT, campo VARCHAR(20))

	BEGIN

		INSERT INTO tbl_registro (tabela_alt, cod_ref, acao, desc_acao, fk_id_login,  cod_sql, dado_ant, dado_novo, campo)
		VALUES (tabela_alt, cod_ref, acao, desc_acao, id_login, cod_sql, dado_ant, dado_novo, campo);
	
	END $

Delimiter ;
#------------------------------------------------------------------------------------------------------------------------------------------------

