#---------------------------------------------------------------------------------------------------------------------------------------------
#Funções do banco
#Função que formata a moeda
#Digita o ID do orçamento e retorna o valor do orçamento convertido em moeda brasileira
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

#SELECT formatar_moeda(1);
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CALCULA A IDADE
#Digita o ID do cliente que retorna a idade dele
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

#SELECT calcula_idade(1);
#------------------------------------------------------------------------------------------------------------------------------------------------




#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO que verifica se o cliente é menor e possui um representante cadastrado
DELIMITER $
CREATE FUNCTION is_autorizado(cod_cliente INT(10)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	
	DECLARE possui_representante BOOLEAN;
	DECLARE qntd_reg INT(10);

	SET @qntd_reg = (SELECT COUNT(id_rel) FROM tbl_rel WHERE fk_id_cli = cod_cliente);
	#Guarda na variável um número inteiro que conta se o cliente digitado no parâmetro de entrada possui alguma relação

	#Compara se o COUNT retornou algum registro e se esse cliente digitado no parâmetro de entrada é maior de idade
	IF @qntd_reg > 0 AND calcula_idade(cod_cliente) > 18 THEN
		SET @possui_representante = TRUE; #Se for verdadeiro retorna 1
	ELSE
		SET @possui_representante = FALSE; #Se for falso retorna 0
	END IF;

	RETURN @possui_representante;

END $
DELIMITER ;

#SELECT is_autorizado(1);
#------------------------------------------------------------------------------------------------------------------------------------------------
