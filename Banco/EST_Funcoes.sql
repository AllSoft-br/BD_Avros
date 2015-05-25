#---------------------------------------------------------------------------------------------------------------------------------------------
#Funções do banco
#Função que formata a moeda
DELIMITER $
CREATE FUNCTION formatar_moeda(id_orcamento INT) RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN

	DECLARE formatado VARCHAR(15);
	DECLARE valor FLOAT;

	SET @valor = (SELECT valor_total FROM tbl_orcamento WHERE id_orc = id_orcamento);
	SET formatado = FORMAT(@valor, 2);
	SET formatado = REPLACE(formatado, ".", "#");
	SET formatado = REPLACE(formatado, ",", ".");
	SET formatado = REPLACE(formatado, "#", ",");
	RETURN CONCAT('R$', formatado);
END $
DELIMITER ;
<<<<<<< HEAD

SELECT formatar_moeda(1);
=======
>>>>>>> e7c66fff2016dc5ffd2d10d11420701523b33499
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CALCULA A IDADE
DELIMITER $
CREATE FUNCTION calcula_idade(cod_cliente INT(10)) RETURNS INT(10)
DETERMINISTIC
BEGIN
	
	DECLARE idade INT(10);
	DECLARE data_nascimento CHAR(12);

	SET @data_nascimento = (SELECT data_nasc FROM tbl_cliente WHERE id_cli = cod_cliente);
	SET @idade = (SELECT YEAR(FROM_DAYS(TO_DAYS(NOW()) - TO_DAYS(@data_nascimento))) AS Idade);
	RETURN @idade;

END $
DELIMITER ;
<<<<<<< HEAD

SELECT calcula_idade(1);
#------------------------------------------------------------------------------------------------------------------------------------------------



/*
#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CALCULA A IDADE
DELIMITER $
CREATE FUNCTION is_representado(cod_cliente INT(10)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	
	DECLARE idade INT(10);
	DECLARE fk_id_representante CHAR(12);

	SET @fk_representante = (SELECT fk_id_representante FROM tbl_rel WHERE fk_id_representante = cod_cliente);
	SET @idade = (SELECT YEAR(FROM_DAYS(TO_DAYS(NOW()) - TO_DAYS(@data_nascimento))) AS Idade);
	RETURN @idade;

END $
DELIMITER ;

SELECT calcula_idade(1);
#------------------------------------------------------------------------------------------------------------------------------------------------
*/
=======
#------------------------------------------------------------------------------------------------------------------------------------------------
>>>>>>> e7c66fff2016dc5ffd2d10d11420701523b33499
