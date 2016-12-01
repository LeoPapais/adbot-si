####################################################################
#                                                                  #
# PMR2490 - Sistemas de Informação                                 #
# Script do banco de dados do sistema de informação AdBot em MySQL #
# Turma: 50 (2016)  Professor: Marcos Ribeiro Pereira Barretto     #
# Turma: 4(B) (2016)  Professor: José Reinaldo Silva               #
#                                                                  #
# Alexandre Muller Jones - 8038149                                 #
# Arthur Franco Perin Cruz - 8537480                               #
# Benjamin Teng Lin - 7626626                                      #
# Breno Spinelli Coelho - 8584431                                  #
# Daniela Moreira Silva - 7629928                                  #
# Diego Hayashi Alonso - 8038128                                   #
# Douglas Padovani Marcon - 8583684                                #
# Felipe Hideki Ogawa - 8610381                                    #
# Gabriel Ren Ishikawa - 8588122                                   #
# Gabriel Ribeiro Reis - 8038351                                   #
# Hugo Abreu Santana - 7631188                                     #
# Leonardo Pereira Papais - 8037861                                #
# Nelson Kenzo Tamashiro - 8125000                                 #
# Victor Jose de Souza Teodoro - 7629341                           #
#                                                                  #
# Desenvolvido em MySQL® 5.7 com Workbench 6.3                     #
#                                                                  #
####################################################################

### Histórico de edição deste arquivo
# [15/09/2016] Diego - Versão inicial
# [01/10/2016] Diego - Acrescentando variáveis necessárias para os
#                      novos casos de uso propostos para o projeto
# [22/10/2016] Diego - Mudança na estrutura do banco de dados conforme
#                      a aula do dia 21/10/2016 do professor Barretto
# [30/10/2016] Diego - Mudanças no banco de dados após conversa com
#                      o professor Barretto via Skype (29/10/2016) e
#                      redefinição de casos de uso
# [03/11/2016] Diego - Mudanças adicionais para adequar os novos casos
#                      de uso.
# [04/11/2016] Diego - Mudanças adicionais para adequar os novos casos
#                      de uso.
# [22/11/2016] Diego - Arrumando o modo de fazer relacionamento 1:N. Segundo
#                      o professor Barretto, é errado colocar uma tabela para
#                      resolver relacionamentos do tipo 1:N, 1:1 e N:1. Somente
#                      nos casos de relacionamentos N:N (que são os únicos que foram 
#                      vistos nas aulas de laboratório do professor José Reinaldo), 
#                      é que devem ser utilizadas tabelas para resolvê-los.
#                    - Novo modelo de usuário no sistema: Uma única entidade
#


#####################################################################
################## CRIAR BANCO DE DADOS E USÁ-LO ####################
#####################################################################

drop database if exists bd_adbot; # Apagar banco de dados se já criou antes com esse nome

create database bd_adbot; # Criar banco de dados

use bd_adbot; # Usar o banco de dados empresa


####################################################################
############################ ENTIDADES #############################
####################################################################

####################################################################
######### Usuarios

create table Usuario
(
	ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, # Chave primária "artificial": NÂO É PARA EDITÁ-LA AO CRIAR UMA NOVA ENTIDADE. SEU NÚMERO É GERADO AUTOMATICAMENTE AO CRIAR UMA NOVA ENTIDADE
	UserName varchar(10) NOT NULL UNIQUE, # "Nome de usuário": Pode usá-lo para entrar no sistema, então é uma variável UNIQUE
	Nome varchar(25),      # Nome
	Sobrenome varchar(50), # Sobrenome    
	Senha varchar(30),     # Senha
	E_mail varchar(25),    # E-mail
	Tipo_Usuario varchar(25) CHECK (Tipo_Usuario IN ("Advertiser", "Publisher", "Administrador")), 
                                         # ID de Advertiser, Publisher ou Administrador (* Administrador só pode 
					  # ser cadastrado pelo Database Administrator (Não pode dar para fazer via HTML/JSP))
    Bloqueio bit(1) default 0,  # Decidido pelo Administrador: Bloqueado (1), não bloqueado (0) (* O único capaz de bloquear o Administrador é o DBA (DataBase Administrator))
    Conta_de_banco varchar(25), # ADVERTISER E PUBLISHER: Conta de banco
	Credito_disponivel decimal(20,2) default 0.00 CHECK (Credito_disponivel BETWEEN 0 AND 100000), # ADVERTISER: Limite do crédito que pode ser gasto no total pelas Campaigns                       
	Data_de_cadastro datetime default NOW()  # Data (Ano-Mês-Dia Hora:Minuto:Segundo) de cadastro (* NOW() => Data/Horário atuais)
);
create index Index_Usuario_UserName on Usuario (UserName) using BTREE; # Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default
create index Index_Usuario_ID on Usuario (ID) using BTREE; # Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default

create table Campaign
(
	ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, # Chave primária "artificial": NÂO É PARA EDITÁ-LA AO CRIAR UMA NOVA ENTIDADE. SEU NÚMERO É GERADO AUTOMATICAMENTE AO CRIAR UMA NOVA ENTIDADE
	Nome varchar(500),                    # Nome da Campaign  
	Estado bit(1) default 0,              # Estado (status) da Campaign: Ativa (Despausada, 1), Inativa (Pausada, 0) 
	Autorizacao bit(1) default 1, # Decidido pelo Administrador: Autorizado (1), não-autorizado (0)
	Bid decimal(20,2) default 0.00 CHECK (Bid BETWEEN 0 AND 100), # Bid da Campaign
	clickURL varchar(200),               # clickURL da Campaign
	Total_visualizacoes int(20),         # Total de visualizações da Campaign
	Total_clicks int(20) default 0,	     # Total de clicks da Campaign
	Tipo_produto varchar(25),            # Tipo do produto anunciado pela Campaign
	Marca_produto varchar(25),           # Marca do produto anunciado pela Campaign
	Gasto_total decimal(20,2) default 0.00,  # Gasto total da Campaign
	Limite_gasto decimal(20,2) default 0.00, # Limite do total de gastos da Campaign
	Genero_alvo varchar(25) CHECK (Genero_alvo IN ("Masculino", "Feminino", "Ambos")), # Gênero alvo da Campaign: Masculino, Feminino ou Ambos
	Idade_alvo_max int CHECK (Idade_alvo_max BETWEEN 0 AND 150), # Idade alvo da Campaign
	Idade_alvo_min int CHECK (Idade_alvo_min <= Idade_alvo_max), # Idade alvo da Campaign
	Link_figura_da_impression varchar(1000), # Link da imagem mostrada na impression da propaganda da Campaign
	Black_ou_whitelist varchar(5) default "black" CHECK (Tipo_de_Lista IN ("black", "white", "desativado")), # Tipo de lista: "black" (blacklist), "white" (whitelist) ou "desativado"
	Data_de_criacao datetime default NOW(), # Data de criação da Campaign
    
	# Relacionamento anuncia
	Usuario_ID int,
	foreign key (Usuario_ID) references Usuario (ID)
);
create index Index_Campaign on Campaign (Usuario_ID) using BTREE; 
	# Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default

create table Media
(
	ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, # Chave primária "artificial": NÂO É PARA EDITÁ-LA AO CRIAR UMA NOVA ENTIDADE. SEU NÚMERO É GERADO AUTOMATICAMENTE AO CRIAR UMA NOVA ENTIDADE
	Nome varchar(500),        # Nome da Media
	Estado bit(1) default 0,  # Estado (status) da Media: Ativa (Despausada, 1), Inativa (Pausada, 0) 
	Tipo_produto varchar(25), # Tipo de produto anunciado pela Media 
	Dinheiro_arrecadado decimal(20,2),  # Total de dinheiro arrecadado pela Media 
	Total_clicks int default 0,         # Total de clicks em propaganda feitos com intermédio do ChatBot
	Total_visualizacoes int default 0,  # Total de visualizações de propagandas feitos com intermédio do ChatBot
	Endereco_REST_API_chatbot varchar(50), # Endereço para comunicação da REST API com o ChatBot (é um link específico para esse ChatBot)
	CPC_minimo decimal(20,2) default 0.00 CHECK (Bid BETWEEN 0 AND 100), # CPC (Cost per Click) mínimo que o Publisher aceita para esta Media
	TestMode bit(1) default 0,  # TestMode: Ativado (1), Desativado (0)
	Data_de_criacao datetime default NOW(),	# Data de criação da Media
      
    # Relacionamento cadastra
	Usuario_ID int,
	foreign key (Usuario_ID) references Usuario (ID)
);
create index Index_Media on Media (Usuario_ID) using BTREE; # Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default

####################################################################
######### Movimentação de dinheiro

create table Movimentacao # Entidade de movimentação de dinheiro
(
	ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, # Chave primária "artificial": NÂO É PARA EDITÁ-LA AO CRIAR UMA NOVA ENTIDADE. SEU NÚMERO É GERADO AUTOMATICAMENTE AO CRIAR UMA NOVA ENTIDADE
	Valor decimal(20,2) default 0.00, # Valor em dinheiro do item do histórico
	Descricao varchar(50),            # Descrição do item do histórico
	Data_movimentacao datetime,	      # Data (Ano-Mês-Dia Hora:Minuto:Segundo) do item do histórico
    
    # Relacionamento guarda_historico_de
	Usuario_ID int,
	foreign key (Usuario_ID) references Usuario (ID)
);
create index Index_Movimentacao on Movimentacao (Usuario_ID) using BTREE;  # Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default

####################################################################
######### Entidades especificas para Campaign

create table Item_black_whitelist # Esse item pode ser de blacklist ou de whitelist => Ver o relacionamento "black-white-list"
(
	ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, # Chave primária "artificial": NÂO É PARA EDITÁ-LA AO CRIAR UMA NOVA ENTIDADE. SEU NÚMERO É GERADO AUTOMATICAMENTE AO CRIAR UMA NOVA ENTIDADE
	IP int,  # IP do usuário de ChatBot que foi adicionado em blacklist ou whitelist 
    
    # Relacionamento restringe
	Campaign_ID int,
    foreign key (Campaign_ID) references Campaign (ID)
);
create index Index_Item_black_whitelist on Item_black_whitelist (Campaign_ID) using BTREE;  # Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default

create table Click_log
(
	ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, # Chave primária "artificial": NÂO É PARA EDITÁ-LA AO CRIAR UMA NOVA ENTIDADE. SEU NÚMERO É GERADO AUTOMATICAMENTE AO CRIAR UMA NOVA ENTIDADE
	Nome_cliente varchar(25),      # Nome do cliente de ChatBot
	Idade_cliente int,          # Idade do cliente
	IP_cliente varchar(50),     # IP do cliente de ChatBot 
	Genero_cliente varchar(25) CHECK (Genero_alvo IN ("Masculino", "Feminino", "Ambos")), # Gênero do cliente de ChatBot: Masculino, Feminino ou Ambos
	Gasto_click decimal(20,2),      # Valor do click realizado
	Data_do_click datetime default NOW(), # Data (Ano-Mês-Dia Hora:Minuto:Segundo) do click do cliente de ChatBot
    
    # Relacionamento tem_debitado
    Campaign_ID int, 
    foreign key (Campaign_ID) references Campaign (ID),

    # Relacionamento foi_clicado_por
	Media_ID int,
	foreign key (Media_ID) references Media (ID)
);
create index Index_Click_log_Media on Click_log (Media_ID) using BTREE; # Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default
create index Index_Click_log_Campaign on Click_log (Campaign_ID) using BTREE; # Índice para pesquisa rápida com árvore binária. O banco de dados usa esses índices como default


####################################################################
################## REGISTRO DO ADMINISTRADOR #######################
####################################################################

# O Administrador só pode ser cadastrado pelo Database Administrator (Não pode dar para fazer via HTML/JSP)

# 1 - Administrador
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario) 
	values ("admin", "Admin", "AdBot","admin@adbot.com", "senha", "Administrador");
					# * NOW() => Data/Horário atuais


####################################################################
#################### PREENCHENDO O BANCO DE DADOS ##################
####################################################################

# 2 - Publisher
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco) 
	values ("harry", "Harry", "Potter", "potter@hogwarts.adbot", "senha secreta", "Publisher", "CONTA12134134422");

# 3 - Publisher
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco) 
	values ("Ash", "Ash", "Ketchum", "ash@pokemon.adbot", "pikachu", "Publisher", "CONTA12134134423");

# 4 - Advertiser
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco, Credito_disponivel) 
	values ("pedro", "D. Pedro", "II", "pedro@brasil.adbot", "senha", "Advertiser", "CONTA1213413441", 5.00);

# 5 - Advertiser
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco, Credito_disponivel) 
	values ("tesla", "Nikola", "Tesla", "tesla@tesla.adbot", "tesla", "Advertiser", "CONTA1212465423", 5.00);

# 6 - Advertiser
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco, Credito_disponivel) 
	values ("joao", "João", "da Silva", "joao@joao.adbot", "joao", "Advertiser", "CONTA1212465424", 5.00);

# 7 - Advertiser
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco, Credito_disponivel) 
	values ("amazon", "Amazon", "Ads", "amazon@amazon.adbot", "amazon", "Advertiser", "CONTA1212465426", 5.00);

# 8 - Advertiser
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco, Credito_disponivel) 
	values ("voldemort", "Lord", "Voldemort", "voldemort@lord.adbot", "phoenix", "Advertiser", "CONTA0000000000", 40000.00);

# 9 - Advertiser
insert into Usuario (UserName, Nome, Sobrenome, E_mail, Senha, Tipo_Usuario, Conta_de_banco, Credito_disponivel) 
	values ("remo", "Remus", "John Lupin", "remus@lupin.adbot", "remus", "Advertiser", "CONTA5512465426", 3000.00);

# Campaigns
insert into Campaign 
	(Usuario_ID, Nome, Bid, clickURL, Tipo_produto, Marca_produto, Limite_gasto, Idade_alvo_max, Idade_alvo_min, Genero_alvo, Link_figura_da_impression) 
    values 
    (6, "Harry Potter e o Prisioneiro de Azkaban", 2.00, "www.livraria_muito_interessante.com.br/propagandaPotter3", "Livro", "Editora Rocco", 25.00, 100, 0, "Ambos", "http://3.bp.blogspot.com/-lUOvXffj0Ws/VUQvpyo1z8I/AAAAAAAAABw/rOp2jJVDjyw/s1600/hp3.jpg");

insert into Campaign 
	(Usuario_ID, Nome, Bid, clickURL, Tipo_produto, Marca_produto, Limite_gasto, Idade_alvo_max, Idade_alvo_min, Genero_alvo, Link_figura_da_impression) 
    values 
    (6, "Naruto Volume Final 72", 2.00, "www.livraria_muito_interessante.com.br/propagandaNaruto72", "Livro", "Editora Panini Comics", 25.00, 100, 0, "Ambos", "http://livrariascuritiba.vteximg.com.br/arquivos/ids/737536-500-500/cap.jpg");

insert into Campaign 
	(Usuario_ID, Nome, Bid, clickURL, Tipo_produto, Marca_produto, Limite_gasto, Idade_alvo_max, Idade_alvo_min, Genero_alvo, Link_figura_da_impression) 
    values 
    (7, "Software Engineering: A Practitioner's Approach (8 ed)", 2.00, "https://www.amazon.com.br/Software-Engineering-Practitioners-Roger-Pressman/dp/0078022126", "Livro", "Editora Pressman", 25.00, 100, 0, "Ambos", "https://images-na.ssl-images-amazon.com/images/I/517ARoAGIgL._SX393_BO1,204,203,200_.jpg");
    
insert into Campaign 
	(Usuario_ID, Nome, Bid, clickURL, Tipo_produto, Marca_produto, Limite_gasto, Idade_alvo_max, Idade_alvo_min, Genero_alvo, Link_figura_da_impression) 
    values 
    (6, "Relógio Masculino Casio Digital Esportivo A158WA-1DF", 10.00, "www.livraria_muito_interessante.com.br/propagandaRelogio", "Eletrônico", "Casio", 25.00, 100, 10, "Ambos", "https://images-submarino.b2w.io/produtos/01/00/item/113374/0/113374009_1GG.jpg");

insert into Campaign 
	(Usuario_ID, Nome, Bid, clickURL, Tipo_produto, Marca_produto, Limite_gasto, Idade_alvo_max, Idade_alvo_min, Genero_alvo, Link_figura_da_impression) 
    values 
    (9, "Silver bullet", 5.00, "https://www.warewolf.com.br", "Artefato", "", 500.00, 100, 30, "Ambos", "");
    
# Medias
insert into Media
	(Usuario_ID, Nome, Tipo_produto, Dinheiro_arrecadado, Total_clicks, Total_visualizacoes, Endereco_REST_API_chatbot, CPC_minimo) 
    values 
    (2, "Chapéu Seletor", NULL, 25.00, 15, 20, "ENDERECO", 2.00);

insert into Media
	(Usuario_ID, Nome, Tipo_produto, Dinheiro_arrecadado, Total_clicks, Total_visualizacoes, Endereco_REST_API_chatbot, CPC_minimo) 
    values 
    (3, "Meowth", NULL, 25.00, 15, 20, "ENDERECO", 2.00);
    
insert into Media
	(Usuario_ID, Nome, Tipo_produto, Dinheiro_arrecadado, Total_clicks, Total_visualizacoes, Endereco_REST_API_chatbot, CPC_minimo) 
    values 
    (3, "Cranicola", NULL, 25.00, 15, 20, "ENDERECO", 6.00);

# Click_logs
insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (1, 1, "Bóris", 35, "200.000.000.000", "Masculino", 5.00);

insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (2, 1, "James", 28, "200.000.000.000", "Masculino", 5.00);

insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (2, 1, "Holmes", 38, "200.000.000.000", "Masculino", 10.00);

insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (2, 3, "Moriarty", 55, "200.000.000.000", "Masculino", 10.00);
    
insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (2, 2, "Sasuke", 13, "200.000.000.000", "Masculino", 10.00);

insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (1, 1, "Hermione", 16, "200.000.000.000", "Feminino", 5.00);

insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (2, 1, "Rony", 16, "200.000.000.000", "Masculino", 10.00);
    
insert into Click_log (Media_ID, Campaign_ID, Nome_cliente, Idade_cliente, IP_cliente, Genero_cliente, Gasto_click)
	values (2, 4, "Robotnik", 50, "200.000.000.000", "Masculino", 10.00);


####################################################################
#################### UPDATES NO BANCO DE DADOS #####################
####################################################################

update Campaign set Estado = 1 where ID = 2;
update Campaign set Total_visualizacoes = 25, Total_clicks = 25, Gasto_total = 25.00 where ID = 1;
update Campaign set Total_visualizacoes = 50, Total_clicks = 25, Gasto_total = 25.00 where ID = 2;
update Campaign set Total_visualizacoes = 40, Total_clicks = 31, Gasto_total = 50.00 where ID = 3;
update Campaign set Total_visualizacoes = 50, Total_clicks = 31, Gasto_total = 50.00 where ID = 4;
update Usuario set Bloqueio = 1 where ID = 8;
update Campaign set Autorizacao = 0 where ID = 5;

####################################################################
############################ TESTES ################################
####################################################################
#
# show tables;
#
# describe Usuario;
# describe Advertiser;
# describe Publisher;
# describe Campaign;
# describe Media;
# describe Movimentacao;
#
# select * from Usuario;
# select * from Advertiser;
# select * from Publisher;
# select * from Campaign;
# select * from Click_log;
#
# select Nome from Usuario where ID = 6;
# select COUNT(*) from Campaign C where C.Usuario_ID = 6;
#
# select C.ID, C.Nome, M.ID, M.Nome, CL.Gasto_click, CL.Nome_cliente, CL.Nome_cliente
# 	from Usuario U, Campaign C, Media M, Click_log CL
# 	where 
# 			CL.Media_ID = M.ID 
# 			and CL.Campaign_ID = C.ID 
#             and C.Usuario_ID = U.ID
#             and U.ID = 6
#             order by C.ID, M.ID;
# 
# select U.Conta_de_banco, U.Credito_disponivel from Usuario U where U.ID = 7;
#
# select ID, Nome, Sobrenome, E_mail, Data_de_cadastro, Bloqueio, Tipo_Usuario, Conta_de_banco, Credito_disponivel from Usuario where ID = 7;
#


