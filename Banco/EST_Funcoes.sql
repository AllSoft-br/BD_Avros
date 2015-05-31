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
		ELSE
			SET @conversao = 'Feminino';
		END IF;

	RETURN @conversao;

END $
DELIMITER ;

#SELECT conv_sexo(0);
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



/*
#------------------------------------------------------------------------------------------------------------------------------------------------
#FUNÇÃO QUE CALCULA O TEMPO QUE FOI CRIADO O LOGIN
#Digita o ID do login cadastrado, seleciona a data e hora de criação e retorna desde que foi criada
DELIMITER $
CREATE FUNCTION tempo_login(cod_login INT(10)) RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN

		DECLARE dia_cadastro TIMESTAMP;
		DECLARE ano, mes, dia, hora, final VARCHAR(40);

		SET @dia_cadastro = (SELECT data_criacao FROM tbl_login WHERE id_login = cod_login);
		#Retorna a data completa da criação do login

		SET @ano = (SELECT TIMESTAMPDIFF(YEAR, @dia_cadastro, NOW()));
		#Retorna a diferença do ano da criação do login até hoje

		SET @mes = (SELECT TIMESTAMPDIFF(MONTH, @dia_cadastro, NOW()));
		#Retorna a diferença de mêses da criação do login até hoje

		SET @dia = (SELECT TIMESTAMPDIFF(DAY, @dia_cadastro, NOW()));
		#Retorna a diferença de dias da criação do login até hoje

		SET @hora = (SELECT SEC_TO_TIME((SELECT TIMESTAMPDIFF(SECOND, @dia_cadastro, NOW()))));
		#Retorna a diferença do ano da criação do login até hoje

		RETURN @tempo_cadastro;
END $
DELIMITER ;



DROP FUNCTION calcula_data;

SELECT calcula_data(6);
SELECT * FROM tbl_login;
#------------------------------------------------------------------------------------------------------------------------------------------------

SELECT TIMEDIFF('2015-05-31', '2015-03-15');