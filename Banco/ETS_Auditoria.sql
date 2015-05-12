#Tabela Auditoria

CREATE TABLE tbl_registro(
	id_reg INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	tabela_alt VARCHAR(30) NOT NULL, #Nome da tabela que recebeu a ação
	cod_ref INT(10) NOT NULL, #Campo que vai referenciar o ID da pessoa/objeto da tabela alterada
	acao VARCHAR(15) NOT NULL, #Ação feita, insert/update/delete
	desc_acao TINYTEXT NOT NULL, #Recebe o código usado na alteração
	cod_sql TINYTEXT NOT NULL, #Guarda o código SQL usado
	dado_ant VARCHAR(50), #Guarda o dado antes da modificação
	dado_novo VARCHAR(50), #Guarda o dado após a modificação
	campo VARCHAR(20) NOT NULL, #Ação feita, insert/update/delete
	data_alt TIMESTAMP DEFAULT NOW(), #Data alteração
	fk_id_login INT(10) UNSIGNED NOT NULL, #Chave estrangeira que liga com a tabela login, porque só que irá realizar qualquer ação são eles
	PRIMARY KEY(id_reg),
	
	INDEX idx_fk_registro_login (fk_id_login ASC),

	CONSTRAINT fk_tbl_registro_login
		FOREIGN KEY (fk_id_login) #Criação da chave estrangeira para a tabela Cliente
		REFERENCES bd_estudio.tbl_login (id_login)
		ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
		ON UPDATE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
);

SELECT * FROM tbl_registro;

#---------------------------------------------------------------------------------------------------------
#Procedure que grava as informações
DELIMITER $

CREATE PROCEDURE insere_registro (IN tabela_alt VARCHAR(50), cod_ref INT(10), acao VARCHAR(15),
									desc_acao TINYTEXT, id_login INT(10), cod_sql TINYTEXT, dado_ant VARCHAR(50), dado_novo VARCHAR(50), campo varchar(20))

	BEGIN

		INSERT INTO tbl_registro (tabela_alt, cod_ref, acao, desc_acao, fk_id_login,  cod_sql, dado_ant, dado_novo, campo)
		VALUES (tabela_alt, cod_ref, acao, desc_acao, id_login, cod_sql, dado_ant, dado_novo, campo);
	
	END $

Delimiter ;

#-------------------------------------------------------------------------------------------------------------
