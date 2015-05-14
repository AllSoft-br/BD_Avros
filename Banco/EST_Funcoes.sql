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




DELIMITER $
CREATE FUNCTION calcula_idade(id_cliente INT(10)) RETURNS INT(15)
DETERMINISTIC
BEGIN

	SELECT YEAR(FROM_DAYS(TO_DAYS(NOW()) - TO_DAYS('1994-12-04'))) AS Idade;
	
END $
DELIMITER ;


