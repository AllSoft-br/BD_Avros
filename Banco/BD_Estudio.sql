
CREATE DATABASE bd_estudio
CHARSET = Latin1 COLLATE = latin1_swedish_ci;

USE bd_estudio;

#------------------------------------------------------------------------------------------------------------
#Tabela dados da empresa
CREATE TABLE empresa_dados(
  cnpj CHAR(18) UNIQUE NOT NULL,
  razao_social VARCHAR(50) NOT NULL,
  tel VARCHAR(20),
  uf VARCHAR(30),
  cidade VARCHAR(30),
  bairro VARCHAR(30),  
  logradouro VARCHAR(30),
  cep CHAR(9),
  nro VARCHAR(8),
  complemento VARCHAR(100),
  PRIMARY KEY(cnpj));
#------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------
#Tabela Login
CREATE TABLE tbl_login (
  id_login INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  CPF CHAR(11) UNIQUE NOT NULL,
  login VARCHAR(30) UNIQUE NOT NULL,
  senha VARCHAR(16) NOT NULL,
  admin BOOLEAN DEFAULT '0', # 1 = Administrador, 0 = Comum
  ativo BOOLEAN DEFAULT '1', # 1 = Ativo, 0 = Inativo
  data_criacao TIMESTAMP DEFAULT NOW(), #Data que o login  foi criado
  PRIMARY KEY (id_login));
#-----------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------
#Tabela Cliente
CREATE TABLE tbl_cliente (
  id_cli INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  CPF CHAR(11) UNIQUE NOT NULL,
  sexo BOOLEAN, # 0 = Masculino, 1 = Feminino
  data_nasc DATE NOT NULL,
  tel VARCHAR(20),
  estado VARCHAR(30),
  cidade VARCHAR(30),
  bairro VARCHAR(30),
  fk_id_login INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (id_cli),

  INDEX idx_fk_cliente_login (fk_id_login ASC),

  CONSTRAINT fk_tbl_cliente_login
    FOREIGN KEY (fk_id_login) #Criação da chave estrangeira
    REFERENCES tbl_login (id_login)
    ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
    ON UPDATE NO ACTION); #Permite que as chaves sejam excluidas e atualizadas
#------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------
#Tabela Representante
CREATE TABLE tbl_representante (
  id_representante INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  CPF CHAR(11) UNIQUE NOT NULL,
  sexo BOOLEAN, # 0 = masculino, 1 = feminino
  data_nasc DATE NOT NULL,
  tel VARCHAR(20),
  PRIMARY KEY (id_representante));
#------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------
#Tabela Grau de Parentesco
CREATE TABLE tbl_parentesco(
id_parentesco INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
tipo_parentesco VARCHAR(20) NOT NULL, #Se é pai, mãe, avó, etc.
PRIMARY KEY(id_parentesco));
#------------------------------------------------------------------------------------------------------------



#------------------------------------------------------------------------------------------------------------
#Tabela responsável por relacionar a tabela Cliente, Responsável e Parentesco
CREATE TABLE tbl_rel (
  id_rel INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  fk_id_cli INT(10) UNSIGNED NOT NULL, #Campo que recebe a FK da tabela cliente
  fk_id_parentesco INT(10) UNSIGNED NOT NULL, #Campo que recebe a FK da tabela Parentesco
  fk_id_representante INT(10) UNSIGNED NOT NULL, #Campo que recebe a FK da tabela Responsável
  PRIMARY KEY(id_rel),

  INDEX idx_fk_rel_cliente (fk_id_cli ASC),
  INDEX idx_fk_rel_parentesco (fk_id_parentesco ASC),
  INDEX idx_fk_rel_representante (fk_id_representante ASC),
  
 CONSTRAINT fk_tbl_rel_cliente
    FOREIGN KEY (fk_id_cli) #Criação da chave estrangeira para a tabela Cliente
    REFERENCES bd_estudio.tbl_cliente (id_cli)
    ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
    ON UPDATE NO ACTION, #Permite que as chaves sejam excluidas e atualizadas
 
  CONSTRAINT fk_tbl_rel_parentesco
    FOREIGN KEY (fk_id_parentesco) #Criação da chave estrangeira da tabela Parentesco
    REFERENCES bd_estudio.tbl_parentesco (id_parentesco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT fk_tbl_rel_representante
    FOREIGN KEY (fk_id_representante) #Criação da chave estrangeira da tabela Responsável
    REFERENCES bd_estudio.tbl_representante (id_representante)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
#------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------
#Tabela Orçamento
CREATE TABLE tbl_orcamento (
  id_orc INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP, #Busca a hora atual do sistema
  desc_tattoo TINYTEXT,
  tipo_pagamento VARCHAR(30) NOT NULL, #Cartão, dinheiro ou Não especificado
  valor_total DECIMAL(10,2) NOT NULL,
  qntd_sessao INT(10) NOT NULL,
  fk_id_cli_orc INT(10) UNSIGNED NOT NULL, #Criação do campo da chave estrangeira da tabela Cliente
  PRIMARY KEY (id_orc),

  INDEX idx_fk_orcamento_cliente (fk_id_cli_orc ASC),

  CONSTRAINT fk_tbl_orcamento_cliente
    FOREIGN KEY (fk_id_cli_orc) #Criação da chave estrangeira
    REFERENCES tbl_cliente (id_cli)
    ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
    ON UPDATE NO ACTION); #Permite que as chaves sejam excluidas e atualizadas
#------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------
#Tabela Sessão
CREATE TABLE tbl_sessao (
  id_sessao INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  concluida BOOLEAN DEFAULT 0, #0 não concluida, 1 concluida
  valor_sessao DECIMAL(10,2) NOT NULL,
  tipo_pagamento VARCHAR(30) NOT NULL, #Cartão, dinheiro ou Não especificado
  data_agendada DATE NOT NULL,
  hora_agendada TIME NOT NULL,
  desconto DECIMAL(10,2) NULL DEFAULT '0.00',
  fk_id_orc INT(10) UNSIGNED NOT NULL, #Chave estrangeira tabela Orçamento
  PRIMARY KEY (id_sessao),

  INDEX idx_fk_sessao_orcamento (fk_id_orc ASC),
  CONSTRAINT fk_tbl_sessao_orcamento
    FOREIGN KEY (fk_id_orc) #Criando a Chave Estrangeira
    REFERENCES tbl_orcamento (id_orc)
    ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
    ON UPDATE NO ACTION); #Permite que as chaves sejam excluidas e atualizadas
#-----------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------
#Tabela Orçamento Concluidos - Tabela onde os arquivos só serão jogados após a conclusão das sessões
CREATE TABLE tbl_orccon (
  id_orccon INT(10) UNSIGNED NOT NULL,
  criado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP, #Busca a hora atual do sistema
  desc_tattoo TINYTEXT,
  tipo_pagamento VARCHAR(30) NOT NULL, #Cartão, dinheiro ou Não especificado
  valor_total DECIMAL(10,2) NOT NULL,
  qntd_sessao INT(10) NOT NULL,
  dt_ins TIMESTAMP DEFAULT NOW(),
  fk_id_cli_orccon INT(10) UNSIGNED NOT NULL, #Criação do campo da chave estrangeira da tabela Cliente
  PRIMARY KEY (id_orccon),

  INDEX idx_fk_orccon_cliente (fk_id_cli_orccon ASC),

  CONSTRAINT fk_tbl_orccon_cliente
    FOREIGN KEY (fk_id_cli_orccon) #Criação da chave estrangeira
    REFERENCES tbl_cliente (id_cli)
    ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
    ON UPDATE NO ACTION); #Permite que as chaves sejam excluidas e atualizadas
#------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------
#Tabela Sessões Concluídas - Tabela onde os arquivos só serão jogados após a conclusão das sessões
CREATE TABLE tbl_sescon (
  id_sescon INT(10) UNSIGNED NOT NULL,
  concluida BOOLEAN DEFAULT 0, #0 não concluida, 1 concluida
  valor_sessao DECIMAL(10,2) NOT NULL,
  tipo_pagamento VARCHAR(30) NOT NULL, #Cartão, dinheiro ou Não especificado
  data_agendada DATE NOT NULL,
  hora_agendada TIME NOT NULL,
  desconto DECIMAL(10,2) NULL DEFAULT '0.00',
  dt_ins TIMESTAMP DEFAULT NOW(),
  fk_id_orccon INT(10) UNSIGNED NOT NULL, #Chave estrangeira tabela Orçamento
  PRIMARY KEY (id_sescon),

  INDEX idx_fk_sescon_orccon (fk_id_orccon ASC),

  CONSTRAINT fk_tbl_sescon_orccon
    FOREIGN KEY (fk_id_orccon) #Criando a Chave Estrangeira
    REFERENCES tbl_orccon (id_orccon)
    ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
    ON UPDATE NO ACTION); #Permite que as chaves sejam excluidas e atualizadas
#-----------------------------------------------------------------------------------------------------------




#-----------------------------------------------------------------------------------------------------------
#Tabela Auditoria
CREATE TABLE tbl_registro(
	id_reg INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	tabela_alt VARCHAR(30), #Nome da tabela que recebeu a ação
	cod_ref INT(10), #Campo que vai referenciar o ID da pessoa/objeto da tabela alterada
	acao VARCHAR(15) NOT NULL, #Ação feita, insert/update/delete
	desc_acao TINYTEXT, #Recebe o código usado na alteração
	cod_sql TEXT, #Guarda o código SQL usado
	dado_ant TINYTEXT, #Guarda o dado antes da modificação
	campo VARCHAR(20), #Campo da modificação
	dado_novo TINYTEXT, #Guarda o dado após a modificação
	data_alt TIMESTAMP DEFAULT NOW(), #Data alteração
	fk_id_login INT(10) UNSIGNED, #Chave estrangeira que liga com a tabela login, porque só que irá realizar qualquer ação são eles
	PRIMARY KEY(id_reg),
	
	INDEX idx_fk_registro_login (fk_id_login ASC),

	CONSTRAINT fk_tbl_registro_login
		FOREIGN KEY (fk_id_login) #Criação da chave estrangeira para a tabela Cliente
		REFERENCES bd_estudio.tbl_login (id_login)
		ON DELETE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
		ON UPDATE NO ACTION #Permite que as chaves sejam excluidas e atualizadas
);
#-----------------------------------------------------------------------------------------------------------