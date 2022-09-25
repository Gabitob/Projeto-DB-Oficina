-- drop database oficina;

create database oficina;
use oficina;

create table LoginClients(
idLoginClient int auto_increment primary key,
userName varchar(45) not null unique,
passwords char(10) not null,
lastLogin timestamp
);

create table ClientsCNPJ(
idClientCNPJ int auto_increment primary key,
idLClientCNPJ int not null,
companyName varchar(45) not null,
CNPJ char(14) not null,
tradingName varchar(45) not null,
address varchar(255) not null,
contact char(11),
email varchar(50) not null,
constraint unique_client_cnpj unique(CNPJ),
constraint fk_clientcnpj_login foreign key(idLClientCNPJ) references LoginClients(idLoginClient)
);

create table ClientsCPF(
idClientCPF int auto_increment primary key,
idLClientCPF int not null,
Fname varchar(10) not null,
Minit varchar(5) not null,
Lname varchar(20) not null,
CPF char(11) not null,
Bdate date not null,
address varchar(255) not null,
contact char(11),
email varchar(50) not null,
constraint unique_client_cpf unique(CPF),
constraint fk_clientcpf_login foreign key(idLClientCPF) references LoginClients(idLoginClient)
);

create table OS(
idOs int auto_increment primary key,
idOloginclient int,
osStatus enum('Canceled','Confirmed','Processing') default 'Processing',
osDescription varchar(255),
serviceValue float,
serviceDate date not null,
constraint fk_order_loginclient foreign key(idOloginclient) references LoginClients(idLoginClient)
);

create table Mecanic(
idMecanic int auto_increment primary key,
CPF CHAR(9) not null,
address varchar(255) not null,
contact char(11)
);

create table Service(
idSloginClient int,
idSorder int,
idMec int,
serviceType varchar(255),
constraint fk_service_loginclient foreign key(idSloginClient) references LoginClients(idLoginClient),
constraint fk_service_os foreign key(idSorder) references OS(idOs),
constraint fk_service_mec foreign key(idMec) references Mecanic(idMecanic)
);

create table Payments(
idPayment int auto_increment primary key,
idPayOs int,
typePayment enum('Cash','CreditCard') default 'CreditCard',
totalPrice decimal(5,2) not null,
paymentStatus enum('Authorized','Not Authorized','Processing','Chargeback') default 'Processing',
constraint fk_pay_os foreign key(idPayOs) references OS(idOs)
);

create table CreditCard(
idCredicard int auto_increment primary key,
idPayCredCard int,
credCardFlag varchar(20) not null,
cardNumber char(16) not null,
expirationDate date not null,
cardHolderName varchar(45) not null,
securityCode char(3) not null,
constraint fk_pay_creditcard foreign key(idPayCredCard) references Payments(idPayment)
);

create table Cash(
idCash int auto_increment primary key,
idPayCash int,
pix enum('Pix CPF','Pix email','Pix cellphone','Pix random'),
constraint fk_pay_cash foreign key(idPayCash) references Payments(idPayment)
);


-- insert

INSERT INTO LoginClients
values 
	(1,'nivaldo','njtsb1','2022-09-10 15:50'),
    (2,'jose','njtsb2','2022-09-10 15:51'),
	(3,'tadeu','njtsb3','2022-09-10 15:52'),
	(4,'lossantos','njtsb4','2022-09-10 15:53'),
	(5,'beirao','njtsb5','2022-09-10 15:54'),
	(6,'makro','mkr01','2022-09-10 15:55'),
    (7,'martins','mrt02','2022-09-10 15:56'),
	(8,'viavarejo','via03','2022-09-10 15:57'),
	(9,'magalu','magalu04','2022-09-10 15:58'),
	(10,'Casa&Cia','C&C05','2022-09-10 15:59');

INSERT INTO ClientsCNPJ
values (1,1,'Antero F. Junior',12345678901, 'Makro Atacadista','SP-270, Jardim Novo Mundo, Sorocaba', 789456123,'makroatacadista@gmail.com'),
	   (2,2,'Rubens B. Martins',12345678902, 'Martins Distribuidor', 'Avenida José Andraus Gassani, 10, Uberlândia', 789123456,'martinsdistribuidor@gmail.com'),
       (3,3,'Raphael O. Klein',12345678903, 'Via Varejo', 'Rua Samuel Klein, 93, São Caetano do Sul', 456789123,'viavarejo@gmail.com'),
	   (4,4,'Luiza H. Trajano',12345678904, 'Magazine Luiza', 'Avenida Rio Negro, 1100, Franca', 456123789,'magalu@gmail.com'),
	   (5,5,'Antonio C. TERTULIANO',12345678905, 'Casa & Cia Utilidades', 'Avenida Dr. Armando Pannunzio, 1180, Sorocaba', 123789456,'casaecia@gmail.com');
       
INSERT INTO ClientsCPF
values (1,1,'Nivaldo','J','Tadeu',01234567890,'1990-09-12','Rua Joao Nagliatti, 220, Miracatu',123456789,'nivaldo@hotmail.com'),
       (2,2,'Jose','T','Nivaldo',12345678901,'1989-01-07','Rua Joao Nagliatti, 280, Miracatu',234567890,'jose@gmail.com'),
       (3,3,'Tadeu','S','Jose',23456789012,'1997-02-01','Rua Quatro, 440, Miracatu',3456789012,'tadeu@hotmail.com'),
       (4,4,'Los Santos','B','Beirao',34567890123,'2007-11-26','Rua Candido dos Santos Coelho, 440, Miracatu',4567890123,'lossantos@gmail.com'),
       (5,4,'Beirao','N','Santos',45678901234,'2011-12-01','Vila Kamaitti, 440, Miracatu',5678901234,'beirao@gmail.com');

INSERT INTO OS
Values
	(default,1,'Confirmed','Revisão',10,'2022-09-12'),
	(default,2,Default,'Pneus',20,'2022-09-12'),
	(default,3,'Confirmed','Tração',10,'2022-09-12'),
	(default,4,'Canceled','Parabrisa',10,'2022-09-12'),
	(default,5,'Confirmed','Óleo',10,'2022-09-12'),
    (default,6,'Confirmed','Revisão',50,'2022-09-12'),
	(default,7,Default,'Motor',100,'2022-09-12'),
	(default,8,'Confirmed','Eixo',500,'2022-09-12'),
	(default,9,'Canceled','Óleo',150,'2022-09-12'),
	(default,10,'Confirmed','Gás',60,'2022-09-12');

-- mecanico

INSERT INTO Mecanic
VALUES
	(1,076071925,'Rua João Pessoa 2',73988714806),
    (2,076071935,'Rua Fogo Quente 3',73988715265),
    (3,076071945,'Rua Água Molhada 4',73988713478);


-- SERVIÇOS


INSERT INTO Payments
VALUES
	(1,1,'CreditCard',179.00,'Authorized'),
    (2,2,'Cash',360.00,'Authorized'),
    (3,3,'CreditCard',559.00,'Not Authorized'),
    (4,4,default,769.00,'Chargeback'),
    (5,5,'CreditCard',780.90,'Authorized'),
    (6,6,'CreditCard',379.00,'Authorized'),
    (7,7,'Cash',360.00,'Authorized'),
    (8,8,'CreditCard',555.00,'Not Authorized'),
    (9,9,default,469.00,'Processing'),
    (10,10,'CreditCard',790.90,'Authorized');

INSERT INTO CreditCard
VALUES
	(1,1,'MasterCard',1234567890123456,'2022-09-15','SEVERINO S SILVA',656),
    (2,2,'Visa',0123456789012345,'2022-09-15','EDUARDO V RIBEIRO',989),
    (3,3,'America Express',2345678901234567,'2022-09-15','AMANDA G QUEIROZ',102),
    (4,4,'ELO',9012345678901234,'2022-09-15','RITA C TERTULIANO',234),
    (5,5,'MasterCard',3456789012345678,'2022-09-15','ANTONIO T SOUZA',432);

INSERT INTO Cash
VALUES
	(1,1,'PIX CPF'),
    (2,2,'PIX email'),
    (3,3,'PIX CPF'),
    (4,4,'PIX cellphone'),
    (5,5,'PIX random');



-- QUERIES

SELECT Fname AS nome, Lname AS sobrenome, email AS email, address as endereço, idClientcpf as n_cliente FROM clientscpf order by lname;

select * from LoginClients l, OS o where l.idLoginClient = idOloginClient;

select concat(Fname,' ',Lname) as Client, idOs, osStatus from ClientsCPF c, OS o where idClientCPF = idOLoginClient;

select * from OS o, Payments p where o.idOs = idPayOs;
    
Select * from LoginClients inner join OS on IdLoginClient = idOloginClient;
							
select * from LoginClients l inner join OS o on l.idLoginClient = o.idOloginClient
							 inner join Service s on s.idSorder = o.idOs;
					                    
select * from payments p, Creditcard c where p.idPayment= idpayCredcard;







