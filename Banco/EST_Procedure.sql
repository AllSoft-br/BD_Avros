#A procedure será chamada quando todas as sessões forem concluidas
#Assim ele cria uma cópia dos dados para as respectivas tablas de orçamento e sessão concluidas

DELIMITER $
CREATE PROCEDURE orcamento_concluido(IN id_orc INT(10))

	BEGIN
		DECLARE nsessoes int(10);
		DECLARE concluidas int(10);
		
		select qntd_sessao from tbl_orcamento where cod_orc = id_orc into @nsessoes;
		select count(id_sessao) from tbl_sessao 
				where concluida = 1
				and fk_cod_orc = id_orc into @concluidas;

		if @nsessoes <= @concluidas then

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

		end if;
	
	END $

Delimiter ;

#--------------------------------------------------------------------------------------------------------





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

#-------------------------------------------------------------------------------------------------------------
