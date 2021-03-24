drop database if exists bd_sistemaabc;
create database if not exists bd_sistemaabc
default character set utf8
default collate utf8_general_ci;

use bd_sistemaabc;

create table tb_cargo(
	pk_codcargo int(4) zerofill not null auto_increment primary key,
    nome varchar(150) not null unique,
    pisosalarial decimal(7,2) not null
)engine = InnoDB;

create table tb_endereco(
	pk_codendereco int(4) zerofill not null auto_increment primary key,
    rua varchar(255) not null,
    numero int(6) not null,
    complemento varchar(100) default 'Casa',
    cep char(9) not null,
    bairro varchar(150) not null,
    cidade varchar (100) not null
)engine = InnoDB;

create table tb_contato(
	pk_codcontato int(4)zerofill not null auto_increment primary key,
    ddd tinyint(2) not null,
    numero varchar(15) not null,
    tipo varchar(50) default 'Celular',
    email varchar(100)
)engine = InnoDB;

create table tb_cliente(
	pk_codcliente int(4)zerofill not null auto_increment primary key,
    nome varchar(100) not null,
    cpf char(14) not null unique,
    senha varchar(16) not null
)engine = InnoDB;
    
create table tb_produto(
	pk_codproduto int(5)zerofill not null auto_increment primary key,
    nome varchar(200) not null,
    categoria varchar(255),
    precounitario decimal(7,2) not null
)engine = InnoDB;

create table tb_funcionario(
	pk_codfuncionario int(4)zerofill not null auto_increment primary key,
    nome varchar(100) not null,
    cpf char(14) not null unique,
    senha varchar(16) not null,
    fk_codfuncionariogerente int(4) zerofill,
    fk_codendereco int(4) zerofill not null,
    fk_codcargo int(4) zerofill not null,
    
    foreign key (fk_codfuncionariogerente) references tb_funcionario(pk_codfuncionario),
    foreign key (fk_codendereco) references tb_endereco(pk_codendereco),
    foreign key (fk_codcargo) references tb_cargo(pk_codcargo)
    
)engine = InnoDB;

create table tb_venda(
	pk_codvenda int(5) zerofill not null auto_increment primary key,
    datavenda timestamp default current_timestamp(),
    valortotal decimal(7,2) not null,
    fk_codfuncionario int(4) zerofill,
    fk_codcliente int(4) zerofill not null,
    
    foreign key (fk_codfuncionario) references tb_funcionario(pk_codfuncionario),
    foreign key (fk_codcliente) references tb_cliente(pk_codcliente)
)engine = InnoDB;

create table tb_produto_has_tb_venda(
	fk_codproduto int(5) zerofill not null,
    fk_codvenda int(5) zerofill not null,
    quantidade tinyint(3) not null,
    
    foreign key (fk_codproduto) references tb_produto(pk_codproduto),
    foreign key (fk_codvenda)references tb_venda(pk_codvenda),
    primary key (fk_codproduto,fk_codvenda)

)engine = InnoDB;

create table tb_contato_has_tb_cliente(
	fk_codcontato int(4) zerofill not null,
    fk_codcliente int(4) zerofill not null,
    
    foreign key (fk_codcontato) references tb_contato(pk_codcontato),
    foreign key (fk_codcliente)references tb_cliente(pk_codcliente),
    primary key (fk_codcontato,fk_codcliente)

)engine = InnoDB;

create table tb_contato_has_tb_funcionario(
	fk_codcontato int(4) zerofill not null,
    fk_codfuncionario int(4) zerofill not null,
    
    foreign key (fk_codcontato) references tb_contato(pk_codcontato),
    foreign key (fk_codfuncionario)references tb_funcionario(pk_codfuncionario),
    primary key (fk_codcontato,fk_codfuncionario)

)engine = InnoDB;

create table tb_endereco_has_tb_cliente(
	fk_codendereco int(4) zerofill not null,
    fk_codcliente int(4) zerofill not null,
    
    foreign key (fk_codendereco) references tb_endereco(pk_codendereco),
    foreign key (fk_codcliente)references tb_cliente(pk_codcliente),
    primary key (fk_codendereco,fk_codcliente)

)engine = InnoDB;

/*Inserindo dados do cargo*/

	insert into tb_cargo(nome,pisosalarial)
	values
	('Gerente','2000'),
	('Vendedor','1000');

 /*Fim da inserção dos dados do cargo*/ 
 
 

/*Inserindo dados do endereço*/

	insert into tb_endereco(rua,numero,complemento,cep,bairro,cidade)
	values
		  ('Paraíba','358','Ap 104 bloco H','94110-180','Centro','Porto Alegre'),
		  ('Rio Grande do Norte','445','Ap 303 bloco J','90100-250','Passo do Hilário','Gravataí'),
		  ('Voluntários', '1600', 'Ap 102','92100-108' ,'Centro', 'Porto Alegre');

	insert into tb_endereco(rua,numero,cep,bairro,cidade)
	values ('Boqueirão', '1980', '93110-340','Igara', 'Canoas'),
		  ('Pernambuco','3312','94200-400','Passo da Areia','Canoas');
      
 /*Fim da inserção dos dados do endereço*/   
 

/*Inserindo dados do contato*/

	insert into tb_contato(ddd,numero)
	values('51','991296924'),
		  ('54','999598946'),
		  ('51', '992905406'),
		  ('11', '997020943');

	insert into tb_contato(ddd,numero,tipo,email)
	values('51', '30420000', 'Residencial', 'badanha.silva@gmail.com');

	insert into tb_contato(ddd,numero,email)
	values('55','991593300','leandro.silva@qi.edu.br');

	insert into tb_contato(ddd,numero,tipo)
	values('51', '33401800', 'Comercial');
	
/*Fim da inserção dos dados do contato*/


/*Inserindo dados do cliente*/

	insert into tb_cliente(nome,cpf,senha)
	values
	('Juca','123.456.789-10','123'), 
	('Badanha', '888.234.987-13', '435'),
	('Maria', '727.636.076-24', '876'),
	('Ivo', '324.765.098-42', '365'),
	('Ana', '346.987.546-09', '067');

/*Fim da inserção dos dados do cliente*/

/*Inserindo dados do produto*/

	insert into tb_produto(nome,precounitario)
	values
	('SmartTV 55 polegadas','1889.90'),
	('Home Theater', '890.99'),
	('Cabo HDMI', '35.50');

	insert into tb_produto(nome,categoria,precounitario)
	 values
	 ('Iphone X', 'Smartfone', '4259.90'),
	 ('Micro System ', 'Audio', '1999.90');
     
/*Fim da inserção dos dados do produto*/

/*Inserindo dados do funcionário*/

	insert into tb_funcionario(nome,cpf,senha,fk_codendereco,fk_codcargo)
	values('Leandro','929058890-54','321','1','1');

	insert into tb_funcionario(nome,cpf,senha,fk_codfuncionariogerente,fk_codendereco,fk_codcargo)
	values
	('João', '365.487.645-73', '654', '1', '3', '2'),
	('Badanha', '234.456.976-98', '325', '1', '2', '2'),
	('Joana', '123.098.465-01', '978', '1', '2', '2'),
	('Lorena', '654.645.002-00', '026', '1', '1', '2');

/*Fim da inserção dos dados do funcionário*/


/*Inserindo dados da venda*/

	insert into tb_venda(valortotal,fk_codcliente)
	values
	('10500','1'),
	('5000','2'),
	('2550','1'),
	('1350','4'),
	('20000','5');

	insert into tb_venda(valortotal,fk_codfuncionario,fk_codcliente)
	values
	('3450','1','5'),
	('6455','2','4'),
	('12546','5','3'),
	('35.50','4','1'),
	('18356','5','2');
    
/*Fim da inserção dos dados da venda*/


/*Inserindo dados do produto_venda*/

	insert into tb_produto_has_tb_venda(fk_codproduto,fk_codvenda,quantidade)
	values
	('1','1','10'),
	('1','2','5'),
	('1','3','1'),
	('2','1','3'),
	('2','4','1'),
	('3','1','5'),
	('4','4','6'),
	('4','5','4'),
	('5','1','2');
    
/*Fim da inserção dos dados do produto_venda*/


/*Inserindo dados do contato_cliente*/

	insert into tb_contato_has_tb_cliente(fk_codcontato,fk_codcliente)
	values
	('3','2'),
	('2','1'),
	('5','2'),
	('3','4'),
	('1','1');

/*Fim da inserção dos dados do contato_cliente*/

/*Inserindo dados do contato_funcionario*/

	insert into tb_contato_has_tb_funcionario(fk_codcontato,fk_codfuncionario)
	values
	('4','1'),
	('5','2'),
	('6','3'),
	('6','4'),
	('7','1');
    
/*Fim da inserção dos dados do contato_funcionario*/


/*Inserindo dados do endereço_cliente*/

	insert into  tb_endereco_has_tb_cliente(fk_codendereco,fk_codcliente)
	values
	('4','1'),
	('4','5'),
	('5','3'),
	('5','4'),
	('4','4');

/*Fim da inserção dos dados do endereço_cliente*/


