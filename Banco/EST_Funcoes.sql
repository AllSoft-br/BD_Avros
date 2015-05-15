#---------------------------------------------------------------------------------------------------------------------------------------------
#Funções do banco

DELIMITER $
CREATE FUNCTION formatar_moeda(valor FLOAT) RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
	DECLARE formatado VARCHAR(15);
	SET formatado = FORMAT(valor, 2);
	SET formatado = REPLACE(formatado, ".", "#");
	SET formatado = REPLACE(formatado, ",", ".");
	SET formatado = REPLACE(formatado, "#", ",");
	RETURN CONCAT('R$', formatado);
END $
DELIMITER ;

SELECT valor, formatar_moeda(valor) FROM tbl_produto;
#------------------------------------------------------------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $
CREATE FUNCTION calcula_idade(idade INT(10)) RETURNS INT(10)
DETERMINISTIC
BEGIN

	DECLARE idade INT(10);
	SET @idade = (SELECT YEAR(FROM_DAYS(TO_DAYS(NOW()) - TO_DAYS((SELECT data_nasc FROM tbl_cliente WHERE id_cliente = id_cliente)))) AS Idade);
	RETURN idade;

END $
DELIMITER ;

DROP function calcula_idade;

SELECT data_nasc, calcula_idade(idade) FROM tbl_cliente WHERE id_cliente = 2;
#------------------------------------------------------------------------------------------------------------------------------------------------