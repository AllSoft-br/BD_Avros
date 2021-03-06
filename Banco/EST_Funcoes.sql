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
	IF @qntd_reg > 0 OR calcula_idade(cod_cliente) > 18 THEN
		SET @possui_representante = TRUE; #Se for verdadeiro retorna 1
	ELSE
		SET @possui_representante = FALSE; #Se for falso retorna 0
	END IF;

	RETURN @possui_representante;

END $
DELIMITER ;

#SELECT is_autorizado(1);
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE Verifica se o representante tem um cliente cadastrado em seu nome
#Digita o ID do representante que retorna a idade dele
DELIMITER $
CREATE FUNCTION representa_cliente(codigo_representante INT(10)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	
	DECLARE nrelacoes INT(10);
	DECLARE representa BOOLEAN;

	SET @nrelacoes = (SELECT COUNT(id_rel) FROM tbl_rel WHERE fk_id_representante = codigo_representante);

	IF @nrelacoes > 0 THEN
		SET @representa = TRUE;
	ELSE
		SET @representa = FALSE;
	END IF;

	RETURN @representa;

END $
DELIMITER ;

#SELECT representa_cliente(1);
#SELECT * FROM tbl_representante;
#SELECT * FROM tbl_rel;
#SELECT * FROM tbl_cliente;
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CONVERTE O VALOR BOOLEAN EM UM VARCHAR
#Digita o valor do boolean que converte nas palavras "Comum" ou "Administrador"
DELIMITER $
CREATE FUNCTION conv_admin(admin BOOLEAN) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	
	DECLARE conversao VARCHAR(30);

		IF admin = 0 THEN
			SET @conversao = 'Comum';
		ELSE
			SET @conversao = 'Administrador';
		END IF;

	RETURN @conversao;

END $
DELIMITER ;

#SELECT conv_admin(0);
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CONVERTE O VALOR BOOLEAN EM UM VARCHAR
#Digita o valor do boolean que converte nas palavras "Inativo" ou "Ativo"
DELIMITER $
CREATE FUNCTION conv_ativo(ativo BOOLEAN) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	
	DECLARE conversao VARCHAR(30);

		IF ativo = 0 THEN
			SET @conversao = 'Inativo';
		ELSE
			SET @conversao = 'Ativo';
		END IF;

	RETURN @conversao;

END $
DELIMITER ;

#SELECT conv_ativo(0);
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CONVERTE O VALOR BOOLEAN EM UM VARCHAR
#Digita o valor do boolean que converte nas palavras "Masculino" ou "Feminino"
DELIMITER $
CREATE FUNCTION conv_sexo(sexo BOOLEAN) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	
	DECLARE conversao VARCHAR(30);

		IF sexo = 0 THEN
			SET @conversao = 'Masculino';
		ELSEIF sexo = 1 then
			SET @conversao = 'Feminino';
		else
			SET @conversao = '-';
		END IF;

	RETURN @conversao;

END $
DELIMITER ;

#SELECT conv_sexo(null);
#------------------------------------------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CONVERTE O VALOR BOOLEAN EM UM VARCHAR
#Digita o valor do boolean que converte nas palavras "CONCLUIDA" ou "NÃO CONCLUIDA"
DELIMITER $
CREATE FUNCTION conv_concluido(concluido BOOLEAN) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	
	DECLARE conversao VARCHAR(30);

		IF concluido = 0 THEN
			SET @conversao = 'Não concluido';
		ELSE
			SET @conversao = 'Concluido';
		END IF;

	RETURN @conversao;

END $
DELIMITER ;

#SELECT conv_concluido(0);
#------------------------------------------------------------------------------------------------------------------------------------------------
