#A procedure será chamada quando todas as sessões forem concluidas
#Assim ele cria uma cópia dos dados para as respectivas tabelas de orçamento e sessões concluidas

DELIMITER $
CREATE PROCEDURE orcamento_concluido(IN X INT(10))

	BEGIN

		INSERT INTO tbl_orccon(cod_orccon, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orccon)
		SELECT cod_orc, criado_em, tipo_pagamento, valor_total, qntd_sessao, fk_id_cli_orc
		FROM tbl_orcamento
		WHERE cod_orc = X;

		INSERT INTO tbl_sescon(id_sescon, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_cod_orccon)
		SELECT id_sessao, concluida, valor_sessao, tipo_pagamento, data_agendada, hora_agendada, desconto, fk_cod_orc
		FROM tbl_sessao	
		WHERE fk_cod_orc = X
		#GROUP BY fk_cod_orc
		;

		DELETE FROM tbl_sessao WHERE fk_cod_orc = x;
		DELETE FROM tbl_orcamento WHERE cod_orc = x;
	
	END $

Delimiter ;

<<<<<<< HEAD
CALL orcamento_concluido(1);

SELECT * FROM tbl_orcamento;
SELECT * FROM tbl_orccon;
SELECT * FROM tbl_sessao;
SELECT * FROM tbl_sescon;
#----------------------------------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta as sessões

DELIMITER $
CREATE PROCEDURE del_sessao(IN fk_id_orc INT(10))

	BEGIN

		DELETE FROM tbl_sessao WHERE fk_cod_orc = fk_id_orc;
	
	END $

Delimiter ;

CALL del_sessao(2);

SELECT * FROM tbl_sessao;
SELECT * FROM tbl_orcamento;
#------------------------------------------------------------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------------------------------------------------------------
#Procedure que deleta os orçamentos

DELIMITER $
CREATE PROCEDURE del_orcamento(IN fk_id_orc INT(10))

	BEGIN

		DELETE FROM tbl_orcamento WHERE cod_orc = fk_id_orc;
=======
#--------------------------------------------------------------------------------------------------------





#---------------------------------------------------------------------------------------------------------
#Procedure que grava as informações na auditoria
DELIMITER $

CREATE PROCEDURE insere_registro (IN tabela_alt VARCHAR(50), cod_ref INT(10), acao VARCHAR(15),
									desc_acao TINYTEXT, id_login INT(10), cod_sql TINYTEXT, dado_ant VARCHAR(50), dado_novo VARCHAR(50), campo varchar(20))

	BEGIN

		INSERT INTO tbl_registro (tabela_alt, cod_ref, acao, desc_acao, fk_id_login,  cod_sql, dado_ant, dado_novo, campo)
		VALUES (tabela_alt, cod_ref, acao, desc_acao, id_login, cod_sql, dado_ant, dado_novo, campo);
>>>>>>> b89745757a634567a2abaa31dfd7b1c84664c953
	
	END $

Delimiter ;

<<<<<<< HEAD
CALL del_orcamento(2);

SELECT * FROM tbl_sessao;
SELECT * FROM tbl_orcamento;
#------------------------------------------------------------------------------------------------------------------------------------------------

=======
#-------------------------------------------------------------------------------------------------------------
>>>>>>> b89745757a634567a2abaa31dfd7b1c84664c953
