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


CALL orcamento_concluido(1004);

SELECT * FROM tbl_orcamento;
SELECT * FROM tbl_orccon;
SELECT * FROM tbl_sessao;
SELECT * FROM tbl_sescon;