# Curso PostGreSQL Completo

Instrutor: Sandro Servino
- https://www.linkedin.com/in/sandroservino/?originalSubdomain=pt

## Modelo De Dados

DEIXO AQUI UM CONCEITO E ALGUMS VIDEOS GRATUITOS PARA VC APRENDER MODELAGEM DE DADOS E LOGO IREI
DEMONSTRAR NO PGADMIN COMO VC PODE CRIAR MODELO DE DADOS FISICO E JA CRIAR AS TABELAS NO BANCO
### De Dados Postgresql

## Conceitos Basicos

O conceito de modelagem de dados surgiu da necessidade de organizar, estruturar e representar
informações de forma eficiente para facilitar o armazenamento, recuperação e manipulação de dados.

A modelagem de dados é essencial para organizar e estruturar as informações
em um sistema de banco de dados de forma eficiente, atendendo as necessidades do negocio
de forma imediata e preferencialmente sendo ja flexivel dentro do possivel para atender necessidades futuras,
e ainda ja sendo pensando de uma forma estrategia para ganhos de performance.

## Um Pequeno Historico

Suas raízes estão na evolução dos bancos de dados e na teoria da informação.
Aqui estão alguns marcos importantes:

### 1. Anos 1960 - Bancos de Dados Hierárquicos e em Rede

A modelagem de dados começou a se desenvolver com os primeiros sistemas de banco de dados,
como o IDS (Integrated Data Store) de Charles Bachman.

O modelo hierárquico (ex: IBM IMS) organizava dados em uma estrutura de árvore.

O modelo em rede (ex: CODASYL DBTG) permitia relacionamentos mais complexos entre dados,
mas ainda era difícil de gerenciar.

### 2. Anos 1970 - Modelo Relacional

Em 1970, Edgar F. Codd introduziu o modelo relacional, revolucionando a forma como os dados
eram organizados. Ele usou conceitos da álgebra relacional para estruturar dados em tabelas (ou relações).

Isso levou à criação do SQL e de sistemas como o Oracle, DB2 e SQL Server.

### 3. Anos 1980 - Modelagem Conceitual e ER (Entidade-Relacionamento)

Peter Chen propôs o Modelo Entidade-Relacionamento (ER), que ajudou a visualizar e planejar
bancos de dados de forma mais intuitiva.

Ferramentas como o Diagrama ER começaram a ser usadas para modelagem de dados antes
da implementação no banco.

### 4. Anos 1990 - Modelos Orientados a Objetos e Modelagem Dimensional

Com a ascensão da Programação Orientada a Objetos (POO), surgiram bancos de dados orientados a objetos.

Ralph Kimball introduziu a Modelagem Dimensional, essencial para Data Warehouses, usando conceitos
de fato, dimensão e estrela.

### 5. Anos 2000 - Big Data e Bancos NoSQL

Com a explosão de dados não estruturados, surgiram bancos NoSQL (ex: MongoDB, Cassandra),
trazendo novas formas de modelagem baseadas em documentos, colunas, grafos e chave-valor.

### 6. Presente e Futuro - Modelagem para IA e Data Lakes

Hoje, a modelagem de dados se adapta a ambientes cloud, machine learning e data lakes,
exigindo flexibilidade para lidar com diferentes formatos de dados.

A modelagem de dados continua evoluindo conforme as necessidades de armazenamento e
processamento mudam, mas seus princípios fundamentais ainda são baseados nos conceitos
desenvolvidos ao longo dessas décadas.

```sql
---

VER EXEMPLO DE CONCEITOS DE MODELAGEM DE DADOS PARA BANCOS DE DADOS RELACIONAIS DE UM OTIMO
### Curso Gratuito No Youtube.

- https://www.youtube.com/watch?v=Q_KTYFgvu1s&list=PLucm8g_ezqNoNHU8tjVeHmRGBFnjDIlxD

- https://www.youtube.com/watch?v=eRaAMNjCFYw
- https://www.youtube.com/watch?v=6ER9lWOk-cY
- https://www.youtube.com/watch?v=usA8QKvEHWw

```sql
-----

## Lab 1

### 1. VAMOS NOS CONECTAR NO SERVIDOR POSTGRESQL USANDO O PGADMIN E
### Vamos Criar Um Banco De Dados Novo Chamado: Livraria.

### Vc Ja Viu Como Criar Graficamente E Podemos Criar Via Comando:

```sql
CREATE DATABASE livraria;

Poderiamos já criar as tabelas dentro do banco de dados livraria
desta forma.

### Abra Uma Sessao No Pgadmin No Banco Livraria E Rode:

```sql
CREATE TABLE autor (id int, nome varchar(30));

```sql
-----

## Lab 2

Vamos começar a criar um modelo de dados simples. Para isto CONECTE NO BANCO DE DADOS
### Que Voce Quer Criar Um Modelo De Dados E No Menu Superior Selecione:
Tools e ERD Tools.

Vamos criar livro, autor e editora.

Selecione o simbolo + para criar nossa tabela.

Crie por exemplo na tabela LIVRO o campo ID_LIVRO como
Primary KEY e crie um novo campo chamado DESC_LIVRO COMO CHARACTER de 70.
Faca o mesmo para as outras tabelas.

## Relacionamentos

### Vamos Fazer O Relacionamento Entre A Tabela Livro E Autor.
Vamos considerar inicialmente que 1 livro pode ter 1 ou N autores.
Vamos criar um campo na tabela AUTOR(lado N), chamado id_livro que sera a FK.

PARA FAZERMOS O RELACIONAMENTO POR EXEMPLO 1xN, SELECIONE A TABELA
### Filha, Ou Do Lado Do N, Em Nosso Exemplo Vamos Editar A Tabela
### Autor.

Edite a tabela AUTOR e Vá na ABA Constraints e depois
Foreign Key. No campo Name de o nome para esta FK. Chame fklivro.
Na na aba Columns e no campo local column selecione o campo ou os
campos que formarao a fk da tabela AUTOR que esta configurando, nesse
caso id_livro e no campo referentes selecione a tabela LIVRO
que sera a tabela do lado 1 ou tabela pai e no
campo referencing selecione o campo id_livro que é a PK e clique no botao ADD.
Na aba Action selecione a opcao RESTRICT para on update e para on delete.

### Vamos Agora Fazer Um Novo Relacionamento De Uma Forma Mais Simples.

### Faca O Mesmo Para A Relacao 1 Editora Tem N Autores. Clique Na Tabela
### Filha (N) Ou Seja A Tabela Autor, E Clique No Botao
### 1-M. Selecione No Campo Local Columns O Campo Que Sera Fk Na Tabela
### Autor, Ou Seja, Selecione O Campo Id_Editora E
### Na Coluna Referenced Table Selecione A Tabela Pai Da Relacao Ou Tabela
### Do Lado 1, No Nosso Caso A Tabela Editora E No Campo Referenced Column
### Selecione O Campo Id_Editora Que É O Campo Pk Da Tabela Editora.

### Se Quiser Fazer Uma Relacao 1X1 É Feito Por Exemplo Quando Tem Uma Tabela
### Geralmente Um Subtipo De Outra Onde A Pk De Uma Tabela Se Relaciona A Um
### Pk De Outra.

### No Futuro, Quem Sabe A Comunidade Nao Vai Criar Uma Forma De
### Apenas Arrastar Um Campo Sobre O Outro E Tornar Este Processo Mais
### Simples. Fica A Dica Comunidade.

### Obs: Pergunte Sempre Para O Cliente Ou Negocio, Mas Neste Caso
### Um Autor Nao Pode Ter Escrito Mais De 1 Livro?
### Se A Resposta For Sim Sera Um Nxn E Nao 1Xn.

## Relacionamento Nxn

### Vamos Refazer A Relacao Entao. Delete A Relacao
EXISTENTE, E DEPOIS CLIQUE EM QUALQUER UMA DAS TABELAS, EXEMPLO LIVRO E SELECIONE
### O Botao M-M E Indique Em Local Column O Campo Que Forma A Pk Da Tabela
### Selecionada, No Caso Id_Livro E Na Coluna Referenced Table Selecione
### A Tabela Autor, E No Campo Referenced Column Selecione A Pk Da Tabela
### Autor, No Caso Id_Autor.

### Sera Criado Uma Nova Tabela Chamada
### Tabela Associativa Que Quardara Os Relacionamentos Entre As Duas Tabelas
### E Agora Neste Caso Nao Precisamos Mais Da Fk Id_Livro Dentro Da Tabela
### Autor, Entao Pode Deletar Este Campo.

Poderiamos fazer o mesmo entre a tabela EDITORA E LIVRO, mas podemos
alterar a tabela associativa entre as duas tabelas e criar um ternaria,
entre AUTOR, EDITORA E LIVRO.

Outra fonte legal da fundacao bradesco para vc estudar:
- https://lms.ev.org.br/mpls/Custom/Cds/COURSES/2484-MOD_DADOS_BT/pag/2_3_8.html
- https://lms.ev.org.br/mpls/Custom/Cds/COURSES/2484-MOD_DADOS_BT/pag/2_0_0.html

Vamos entao deletar a relacao que existe entre editora e tabela de autor
vamos deletar o campo id_editora da tabela autor, e vamos criar
na nova tabela associativa criada o campo ID_EDITORA, E JA PODEMOS
### Alterar O Nome Desta Nova Tabela Para Por Exemplo: Livro_Autor_Editora.
### Vamos Marcar Os 3 Campos Como Nao Aceitando Null E Que Eles Serao Pk.

### Selecione O Lado N Da Relacao, Ou Seja A Tabela  Livro_Autor_Editora,
### E Clique No Botao 1-M. No Campo Local Column Selecione Id_Editora
### E Referenced Table Selecione A Tabela Editora E No Campo Referenced Column
### Selecione Id_Editora.

### Agora Vamos Criar Uma Nova Tabela Chamada Funcionario, Com
### Id_Funcionario Como Pk, Nome_Funcionario E Um Campo Id_Chefe E Vamos Fazer Um
### Auto Relacionamento.

### Clique No Botao 1-M, Selecione Como Local Column
### A Coluna Id_Chefe Que Sera A Fk, Selecione Na Coluna Referenced Table
### A Propria Tabela Ou Seja Funcionario E Na Coluna Referenced Column
### Selecione A Pk, Ou Seja, O Campo Id_Funcionario.

### Agora Como Desafio Para Vc Pensar E Fazer:

Crie agora uma tabela para cliente com idcliente e desccliente
e crie uma tabela que guardara a informacao de qual cliente
emprestou qual livro e quando ocorreu e data prevista de entrega do livro.
Esta sera uma tabela associativa se chamara EMPRESTIMO.
Pense depois que se voce fizer
esta relacao direta com a tabela livro, e se este livro tiver
varios exemplares para serem emprestados como faria? Nao poderia criar
varios livros com codigos diferentes na PK com nome do livro igual, mesmo
colocando na frente do nome do livro exemplar 1, exemplar 2,... porque
voce teria problemas depois para saber quantas vezes este titulo do livro
foi emprestado.

E depois relacione a tabela FUNCIONARIO com A TABELA EMPRESTIMO, E ASSIM
### Vc Sabera Qual Exemplar Do Titulo Do Livro Foi Emprestado, Para Qual Cliente,
### Qual Funcionario Emprestou, A Data Do Emprestimo E A Previsao De Entrega.

```sql
---------------------- ATE AQUI

### Agora Vamos Gerar Os Scripts Destas Tabelas E Relacionamentos E Vamos Criar
### Dentro Do Banco De Dados Livraria. Clique No Botao Generate Sql
### Com A Opcao With Drop Table Desligada.
SERA GERADO O SCRIPTS PARA CRIACAO DAS TABELAS E RELACIONAMENTOS. MANDE EXECUTAR O SCRIPT.
### De Um Refresh No Banco De Dados Livraria E Veja As Tabelas Criadas.
ABRA AS TABELAS E VEJA EM CONTRAINTS AS CONTRAINTS RELACIONADAS AS PKS E FKS CRIADAS.

### Salve O Modelo De Dados Criado Tambem
### Com O Simbolo De Disquete E No Futuro Se Quiser Abrir Um Projeto Basta
### Usar O Simbolo De Ficha Ao Lado Do Disquete.

### Uma Curiosidade, Va No Banco De Dados Cliente, E Clique Com Botao
### Direito Do Mouse E Selecione A Option "Erd For Database". Vera
### O Modelo Criado Com As Tabelas Deste Banco De Dados.
### Vc Tambem Pode Arrastar Uma Tabela Existente Para Dentro Do Modelo De Dados.

```sql
---

## Lab 3

Aqui segue um outro desafio para voce.

### Lembre-Se Que Nao Existe Um Modelo De Dados Certo Ou Errado,
a maior preocupação é que ele atenda o negócio, mas claro existem técnicas
para atender as formas normais que podem impedir/minimizar redundancias de informação e
futuros problema de integridade e performance.

RESUMO DA NECESSIDADE: Um clube lhe contratou para criar um modelo de dados
para um sistema a ser desenvolvido que tem como objetivo
controlar os socios e dependentes e os pagamentos dos mesmos. O sistema
precisa ter um cadastro dos socios e seus dependentes,
sendo necessário armazenar o local onde os mesmos moram e formas de contato
como telefone e email. Ainda é necessário controlar se existem mensalidades em aberto sem pagamento,
se os sócios estão pagando com cartão de crédito ou outra forma, datas de pagamentos e valores pagos.

Então já sabemos que precisamos ter algumas
entidades (modelo de dados logico) para guardar estas
informacoes, e que serao persistidos no banco de dados como tabelas:
socio, dependente, endereco, meios de contato, pagamento, meio pagamento

CRIE UM BANCO DE DADOS CHAMADO CLUBE E GERE OS SCRIPTS A PARTIR DO MODELO DE DADOS CRIADO E
### Crie Dentro Do Banco Clube.

### Agora, Veja As Aulas Onde Proponho Como Poderia Ter Sido Criado Este
## Modelo De Dados, Veja O Que Acha.

### Atencao:
Pode pensar em alternativas para o modelo que eu demostrei.
Será por exemplo, para ganhos de performance
eu precisaria colocar o telefone principal e o email principal em uma tabela associativa, ou poderia
para ganhos de performance manter pelo menos 1 telefone principal e 1 email principal na tabela do socio?


```sql
---

## Lab 4

### Voltando Ao Modelo De Dados

### Vamos Agora Fazer Uma Engenharia Reversa.

### Crie Um Banco De Dados Novo Para Isto Chamado Cliente.

```sql
CREATE DATABASE CLIENTE;

Vou deixar o script como recurso da aula, chamado 003.Script1.sql.
Baixe da aula e tente importar para dentro do pgadmin e vamos ver
o modelo de dados a partir desse script depois.

Para abrir o script, conecte no banco de dados cliente e
selecione o icone ficheiro e selecione o arquivo e rode depois.

### Agora, Só Precisamos Rodar O Script E Gerar As Tabelas
### Dentro Do Banco De Dados Cliente.

__

### Obs: Se Nao Conseguiu Fazer O Processo Anterior, Rode O Codigo Abaixo Dentro
### Do Banco De Dados Cliente.

```sql
-- COMECA AQUI

### Conecte No Banco De Dados Cliente

```sql
-- Create Table supplier
```sql
CREATE TABLE supplier (
id SERIAL PRIMARY KEY,
companyname VARCHAR(40),
contactname VARCHAR(50),
contacttitle VARCHAR(40),
city VARCHAR(40),
country VARCHAR(40),
phone VARCHAR(30),
fax VARCHAR(30)
);

```sql
-- Create Table product
```sql
CREATE TABLE product (
id SERIAL PRIMARY KEY,
productname VARCHAR(50),
supplierid INT NOT NULL,
unitprice NUMERIC(12,2),
package VARCHAR(30),
isdiscontinued BOOLEAN DEFAULT FALSE,
CONSTRAINT fk_product_supplier FOREIGN KEY (supplierid)
REFERENCES supplier (id)
);

```sql
-- Create Table customer
```sql
CREATE TABLE customer (
id SERIAL PRIMARY KEY,
firstname VARCHAR(40),
lastname VARCHAR(40),
city VARCHAR(40),
country VARCHAR(40),
phone VARCHAR(20)
);

```sql
-- Create Table orders (evitando palavra reservada "order")
```sql
CREATE TABLE orders (
id SERIAL PRIMARY KEY,
orderdate DATE,
ordernumber VARCHAR(10),
customerid INT NOT NULL,
totalamount NUMERIC(12,2),
CONSTRAINT fk_orders_customer FOREIGN KEY (customerid)
REFERENCES customer (id)
);

```sql
-- Create Table orderitem
```sql
CREATE TABLE orderitem (
id SERIAL PRIMARY KEY,
orderid INT NOT NULL,
productid INT NOT NULL,
unitprice NUMERIC(12,2),
quantity INT,
CONSTRAINT fk_orderitem_product FOREIGN KEY (productid)
REFERENCES product (id),
CONSTRAINT fk_orderitem_order FOREIGN KEY (orderid)
REFERENCES orders (id)
);



```sql
-- TERMINA AQUI

```sql
-------

## Lab 5

### Vamos Ver Agora Se Existem Dados Nestas Tabelas:

```sql
SELECT * FROM Supplier;
```sql
SELECT * FROM Product;
```sql
SELECT * FROM Customer;
```sql
SELECT * FROM Orderitem;

```sql
SELECT * FROM orders;
```sql
SELECT * FROM "orders";

```sql
-- dica:Em alguns bancos de dados, "ORDER" como é uma palavra reservada e não pode ser usada
diretamente como um nome de tabela, iria dar um erro, e ai voce teria que colocar entre aspas.

```sql
-- Vamos inserir alguns dados:

```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(1,'Maria','Anfefeefeders','Berlin','Germany','030-0074321');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(2,'Ana','Truefeejillo','México D.F.','Mexico','(56) 555-4729');
```sql
INSERT INTO Customer (id,FirstName,LastName,City,Country,Phone)VALUES(3,'Antonio','Moreddno','México D.F.','Mexico','(56) 555-3932');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(4,'Thomas','Hadddrdy','London','UK','(256) 555-7788');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(5,'Christina','Beddfrglund','Luleå','Sweden','0921-12 34 65');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(6,'Hanna','Moos','Mannhddddseim','Germany','0621-08460');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(7,'Frédérique','Citgggdeseaux','Strasbourg','France','88.60.15.31');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(8,'Martín','Sommfefer','Madrid','Spain','(91) 555 22 82');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(9,'Laurence','Lefefebihan','Marseille','France','91.24.45.40');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(10,'Elizabeth','Lifefessncoln','Tsawassen','Canada','(604) 555-4729');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(11,'Victoria','Ashscceworth','London','UK','(256) 555-1212');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(12,'Patricio','Siggrmpson','Buenos Aires','Argentina','(1) 135-5555');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(13,'Francisco','Chggrggrang','México D.F.','Mexico','(5) 555-3392');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(14,'Yang','Waggrng','Bern','Switzerland','0452-076545');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(15,'Pedro','Afddronso','Sao Paulo','Brazil','(11) 555-7647');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(16,'Elizabeth','Brvvdown','London','UK','(256) 555-2282');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(17,'Sven','Ottffvflieb','Aachen','Germany','0241-039123');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(18,'Janine','Labvvfrune','Nantes','France','40.67.88.88');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(19,'Ann','Devfvfon','London','UK','(256) 555-0297');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(20,'Roland','Menffvdel','Graz','Austria','7675-3425');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(21,'Aria','Crvvvuz','Sao Paulo','Brazil','(11) 555-9857');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(22,'Diego','Roffvel','Madrid','Spain','(91) 555 94 44');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(23,'Martine','Radcddvvncé','Lille','France','20.16.10.16');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(24,'Maria','Lavfvfrsson','Bräcke','Sweden','0695-34 67 21');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(25,'Peter','Frvfvanken','München','Germany','089-0877310');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(26,'Carine','Scvffhmitt','Nantes','France','40.32.21.21');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(27,'Paolo','Accfffffcorti','Torino','Italy','011-4988260');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(28,'Lino','Roccccdriguez','Lisboa','Portugal','(1) 354-2534');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(29,'Eduardo','Saavvvvedra','Barcelona','Spain','(93) 203 4560');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(30,'José','Pedvvro Freyre','Sevilla','Spain','(95) 555 82 82');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(31,'André','Fovvvdnseca','Campinas','Brazil','(11) 555-9482');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(32,'Howard','Snyddder','Eugene','USA','(503) 555-7555');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(33,'Manuel','Pervveira','Caracas','Venezuela','(2) 283-2951');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(34,'Mario','Ponvvdtes','Rio de Janeiro','Brazil','(21) 555-0091');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(35,'Carlos','Hevvddrnández','San Cristóbal','Venezuela','(5) 555-1340');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(36,'Yoshi','Latvvddimer','Elgin','USA','(503) 555-6874');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(37,'Patricia','McKvdvdvenna','Cork','Ireland','2967 542');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(38,'Helen','Benvvddvnett','Cowes','UK','(198) 555-8888');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(39,'Philip','Crfffamer','Brandenburg','Germany','0555-09876');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(40,'Daniel','Toccenini','Versailles','France','30.59.84.10');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(41,'Annette','Roccccculet','Toulouse','France','61.77.61.10');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(42,'Yoshi','Tanncccamuri','Vancouver','Canada','(604) 555-3392');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(43,'John','Stecccel','Walla Walla','USA','(509) 555-7969');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(44,'Renate','Mcdessner','Frankfurt a.M.','Germany','069-0245984');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(45,'Jaime','Yorccdres','San Francisco','USA','(415) 555-5938');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(46,'Carlos','Goccnzález','Barquisimeto','Venezuela','(9) 331-6954');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(47,'Felipe','Izccdquierdo','I. de Margarita','Venezuela','(8) 34-56-12');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(48,'Fran','Wilcddson','Portland','USA','(503) 555-9573');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(49,'Giovanni','Rocddvelli','Bergamo','Italy','035-640230');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(50,'Catherine','Decccwey','Bruxelles','Belgium','(02) 201 24 67');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(51,'Jean','Fresccdnière','Montréal','Canada','(514) 555-8054');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(52,'Alexander','Feccduer','Leipzig','Germany','0342-023176');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(53,'Simon','Crowcdther','London','UK','(56) 555-7733');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(54,'Yvonne','Monccddcccada','Buenos Aires','Argentina','(1) 135-5333');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(55,'Rene','Phiccddllips','Anchorage','USA','(907) 555-7584');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(56,'Henriette','Pccddfalzheim','Köln','Germany','0221-0644327');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(57,'Marie','Beccddrtrand','Paris','France','(1) 42.34.22.66');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(58,'Guillermo','Fcddcernández','México D.F.','Mexico','(5) 552-3745');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(59,'Georg','Pipccddps','Salzburg','Austria','6562-9722');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(60,'Isabel','de Caccddstro','Lisboa','Portugal','(1) 356-5634');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(61,'Bernardo','Baccdtista','Rio de Janeiro','Brazil','(21) 555-4252');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(62,'Lúcia','Carccddvalho','Sao Paulo','Brazil','(11) 555-1189');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(63,'Horst','Klccddoss','Cunewalde','Germany','0372-035188');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(64,'Sergio','Gutccddiérrez','Buenos Aires','Argentina','(1) 123-5555');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(65,'Paula','Wccddilson','Albuquerque','USA','(505) 555-5939');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(66,'Maurizio','Moccddroni','Reggio Emilia','Italy','0522-556721');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(67,'Janete','Liccdmeira','Rio de Janeiro','Brazil','(21) 555-3412');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(68,'Michael','Hccddolz','Genève','Switzerland','0897-034214');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(69,'Alejandra','Cacddddmino','Madrid','Spain','(91) 745 6200');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(70,'Jonas','Bccddcergulfsen','Stavern','Norway','07-98 92 35');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(71,'Jose','Paccddccvarotti','Boise','USA','(208) 555-8097');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(72,'Hari','Kumccddar','London','UK','(56) 555-1717');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(73,'Jytte','Pccdcdetersen','Kobenhavn','Denmark','31 12 34 56');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(74,'Dominique','Peccddrrier','Paris','France','(1) 47.55.60.10');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(75,'Art','Braccddunschweiger','Lander','USA','(307) 555-4680');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(76,'Pascale','Caddcdrtrain','Charleroi','Belgium','(071) 23 67 22 20');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(77,'Liz','Nixeeeon','Portland','USA','(503) 555-3612');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(78,'Liu','Weeeong','Butte','USA','(406) 555-5834');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(79,'Karin','Joecesephs','Münster','Germany','0251-031259');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(80,'Miguel','Angdeel Paolino','México D.F.','Mexico','(5) 555-2933');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(81,'Anabela','Domieedngues','Sao Paulo','Brazil','(11) 555-2167');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(82,'Helvetius','Naeddgy','Kirkland','USA','(206) 555-8257');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(83,'Palle','Ibsedden','Århus','Denmark','86 21 32 43');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(84,'Mary','Savdedeley','Lyon','France','78.32.54.86');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(85,'Paul','Heeeddeenriot','Reims','France','26.47.15.10');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(86,'Rita','Müleddler','Stuttgart','Germany','0711-020361');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(87,'Pirkko','Koseddekitalo','Oulu','Finland','981-443655');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(88,'Paula','Pareeddente','Resende','Brazil','(14) 555-8122');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(89,'Karl','Jabloedednski','Seattle','USA','(206) 555-4112');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(90,'Matti','Kartdeetunen','Helsinki','Finland','90-224 8858');
```sql
INSERT INTO Customer (Id,FirstName,LastName,City,Country,Phone)VALUES(91,'Zbyszek','Piesddeedtrzeniewicz','Warszawa','Poland','(26) 642-7012');

```sql
-- MARQUE TODO ESTE BLOCO COM CTRL+A e execute

```sql
select * from Customer;
```sql
select count(*) from customer;

```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(1,'Exotic Liquids','CharlDDDDSotte Cooper','London','UK','(56) 555-2222',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(2,'New Orleans Cajun Delights','ShelDDDSSley Burke','New Orleans','USA','(100) 555-4822',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(3,'Grandma Kelly''s Homestead','RegEEWina Murphy','Ann Arbor','USA','(313) 555-5735','(313) 555-3349');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(4,'Tokyo Traders','YosEEEhi Nagase','Tokyo','Japan','(03) 3555-5011',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(5,'Cooperativa de Quesos ''Las Cabras''','AntoEEenio del Valle Saavedra','Oviedo','Spain','(98) 598 76 54',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(6,'Mayumi''s','Mayueedfemi Ohno','Osaka','Japan','(06) 431-7877',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(7,'Pavlova, Ltd.','Ian Devefeling','Melbourne','Australia','(03) 444-2343','(03) 444-6588');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(8,'Specialty Biscuits, Ltd.','Peter Wilsefeon','Manchester','UK','(161) 555-4448',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(9,'PB Knäckebröd AB','Lars Peterefeson','Göteborg','Sweden','031-987 65 43','031-987 65 91');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(10,'Refrescos Americanas LTDA','Carlos Diafefez','Sao Paulo','Brazil','(56) 555 4640',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(11,'Heli Süßwaren GmbHKG','Petra Winefekler','Berlin','Germany','(010) 9984510',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(12,'Plutzer Lebensmittelgroßmärkte AG','Martin Beefein','Frankfurt','Germany','(069) 992755',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(13,'Nord-Ost-Fisch Handelsgesellschaft mbH','Sven Peteefersen','Cuxhaven','Germany','(04721) 8713','(04721) 8714');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(14,'Formaggi Fortini s.r.l.','Elio Rosfeesi','Ravenna','Italy','(0544) 60323','(0544) 60603');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(15,'Norske Meierier','Beate Vilfefeeid','Safndvika','Norway','(0)2-953010',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(16,'Bigfoot Breweries','Cheryl Sayfeeffelor','Bend','USA','(503) 555-9931',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(17,'Svensk Sjöföda AB','Michael Björn','Stockholm','Sweden','08-123 45 67',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(18,'Aux joyeux ecclésiastiques','Guylène Noffedier','Paris','France','(1) 03.83.00.68','(1) 03.83.00.62');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(19,'New England Seafood Cannery','Robb Merchffeant','Boston','USA','(617) 555-3267','(617) 555-3389');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(20,'Leka Trading','Chandra Lefeka','Singapore','Singapore','555-8787',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(21,'Lyngbysild','Niels Peteffersen','Lyngby','Denmark','43844108','43844115');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(22,'Zaanse Snoepfabriek','Dirk Luchffete','Zaandam','Netherlands','(12345) 1212','(12345) 1210');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(23,'Karkki Oy','Anne Heikkofefffeeffenen','Lappeenranta','Finland','(953) 10956',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(24,'G''day, Mate','Wendy Mackenzie','Sydney','Australia','(02) 555-5914','(02) 555-4873');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(25,'Ma Maison','Jean-Guy Lauzon','Montréal','Canada','(514) 555-9022',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(26,'Pasta Buttini s.r.l.','Giovanni Giudfffici','Salerno','Italy','(089) 6547665','(089) 6547667');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(27,'Escargots Nouveaux','Marie Delaefemare','Montceau','France','85.57.00.07',NULL);
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(28,'Gai pâturage','Eliane Noz','Annefefecy','France','38.76.98.06','38.76.98.58');
```sql
INSERT INTO Supplier (Id,CompanyName,ContactName,City,Country,Phone,Fax)VALUES(29,'Forêts d''érables','Chantal Gouffeelet','Ste-Hyacinthe','Canada','(514) 555-2955','(514) 555-2921');

```sql
select * from SUPPLIER;
```sql
select count(*) from SUPPLIER;

Posso inserir assim tambem:

```sql
INSERT INTO Product (Id, ProductName, SupplierId, UnitPrice, Package, IsDiscontinued)
```sql
VALUES
(1, 'Chai', 1, 18.00, '10 boxes x 20 bags', FALSE),
(2, 'Chang', 1, 19.00, '24 - 12 oz bottles', FALSE),
(3, 'Aniseed Syrup', 1, 10.00, '12 - 550 ml bottles', FALSE),
(4, 'Chef Anton''s Cajun Seasoning', 2, 22.00, '48 - 6 oz jars', FALSE),
(5, 'Chef Anton''s Gumbo Mix', 2, 21.35, '36 boxes', TRUE),
(6, 'Grandma''s Boysenberry Spread', 3, 25.00, '12 - 8 oz jars', FALSE),
(7, 'Uncle Bob''s Organic Dried Pears', 3, 30.00, '12 - 1 lb pkgs.', FALSE),
(8, 'Northwoods Cranberry Sauce', 3, 40.00, '12 - 12 oz jars', FALSE),
(9, 'Mishi Kobe Niku', 4, 97.00, '18 - 500 g pkgs.', TRUE),
(10, 'Ikura', 4, 31.00, '12 - 200 ml jars', FALSE),
(11, 'Queso Cabrales', 5, 21.00, '1 kg pkg.', FALSE),
(12, 'Queso Manchego La Pastora', 5, 38.00, '10 - 500 g pkgs.', FALSE),
(13, 'Konbu', 6, 6.00, '2 kg box', FALSE),
(14, 'Tofu', 6, 23.25, '40 - 100 g pieces', FALSE),
(15, 'Genen Shouyu', 7, 15.50, '24 - 250 ml bottles', FALSE),
(16, 'Pavlova', 8, 17.45, '32 - 500 g boxes', FALSE),
(17, 'Alice Mutton', 9, 39.00, '20 - 1 kg tins', TRUE),
(18, 'Carnarvon Tigers', 9, 62.50, '16 kg box', FALSE),
(19, 'Teatime Chocolate Biscuits', 10, 9.20, '10 boxes x 12 biscuits', FALSE),
(20, 'Sir Rodney''s Marmalade', 10, 81.00, '30 gift boxes', FALSE),
(21, 'Snow Plow', 11, 13.00, '16 - 1 lb pkgs.', TRUE),
(22, 'Ravioli Angelo', 12, 19.50, '24 - 250 g pkgs.', FALSE),
(23, 'Escargots de Bourgogne', 13, 13.25, '24 pieces', FALSE),
(24, 'Ravioli, Spinach and Ricotta', 13, 9.99, '12 pieces', FALSE),
(25, 'Manjimup Dried Apples', 14, 53.00, '50 - 300 g pkgs.', FALSE),
(26, 'Perth Pasties', 14, 32.00, '6 pies', FALSE),
(27, 'Tarte au sucre', 15, 49.00, '48 pieces', TRUE),
(28, 'Lemon Meringue Pie', 15, 4.99, '6 pies', TRUE),
(29, 'Naan', 16, 11.99, '12 pieces', FALSE),
(30, 'Butter Chicken', 16, 9.99, '24 - 500 g pkgs.', FALSE);

```sql
select * from PRODUCT;
```sql
select count(*) from PRODUCT;

```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(1,'01-JAN-2023',78,1863.40,'542379');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(2,'01-JAN-2023',78,1863.40,'542379');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(3,'01-JAN-2023',34,1813.00,'542380');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(4,'01-JAN-2023',84,670.80,'542381');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(5,'02-JAN-2023',76,3730.00,'542382');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(6,'03-JAN-2023',34,1444.80,'542383');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(7,'04-JAN-2023',14,625.20,'542384');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(8,'01-JAN-2023',68,2490.50,'542385');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(9,'01-JAN-2023',88,517.80,'542386');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(10,'01-JAN-2023',35,1119.90,'542387');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(11,'07-JAN-20234',20,2018.60,'542388');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(12,'01-JAN-2023',13,100.80,'542389');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(13,'03-JAN-2023',56,1746.20,'542390');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(14,'03-JAN-2023',61,448.00,'542391');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(15,'03-JAN-2023',65,624.80,'542392');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(16,'03-JAN-2023',20,2464.80,'542393');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(17,'04-JAN-2023',24,724.50,'542394');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(18,'04-JAN-2023',7,1176.00,'542395');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(19,'04-JAN-2023',87,364.80,'542396');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(20,'04-JAN-2023',25,4031.00,'542397');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(21,'04-JAN-2023',33,1101.20,'542398');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(22,'04-JAN-2023',89,676.00,'542399');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(23,'04-JAN-2023',87,1376.00,'542400');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(24,'05-JAN-2023',75,48.00,'542401');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(25,'04-JAN-2023',65,1456.00,'542402');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(26,'04-JAN-2023',63,2142.40,'542403');
```sql
INSERT into "orders" (Id,OrderDate,CustomerId,TotalAmount,OrderNumber)VALUES(27,'04-JAN-2023',85,538.60,'542404');

```sql
select * from "orders";
```sql
select count(*) from "orders";

```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(1,1,11,14.00,12);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(66,26,10,24.80,24);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(4,2,14,18.60,9);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(9,4,22,16.80,6);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(7,3,4,42.40,35);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(8,3,6,16.80,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(10,4,6,15.60,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(11,4,6,16.80,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(12,5,7,64.80,40);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(13,5,8,2.00,25);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(14,5,5,27.20,40);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(15,6,6,10.00,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(16,6,3,14.40,42);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(17,6,4,16.00,40);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(18,7,2,3.60,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(19,7,5,19.20,21);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(20,7,4,8.00,21);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(21,8,2,15.20,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(22,8,6,13.90,35);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(23,8,6,15.20,25);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(24,8,9,44.00,30);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(25,9,3,26.20,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(26,2,1,10.40,12);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(27,1,2,35.10,25);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(28,4,3,14.40,6);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(29,5,4,10.40,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(30,11,2,15.20,50);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(31,11,5,17.00,65);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(32,11,3,25.60,6);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(33,12,2,8.00,10);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(34,12,3,20.80,1);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(35,13,1,7.70,16);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(36,13,7,15.60,50);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(37,13,2,39.40,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(38,13,1,12.00,21);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(39,14,1,8.00,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(40,14,5,14.40,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(41,15,5,17.00,12);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(42,15,7,24.00,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(43,15,6,30.40,2);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(44,16,6,13.90,60);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(45,16,4,3.60,28);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(46,16,1,20.70,60);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(47,16,4,8.00,36);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(48,17,2,15.20,35);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(49,17,1,7.70,25);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(50,18,7,31.20,30);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(51,18,1,12.00,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(52,19,2,30.40,12);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(53,20,1,14.70,50);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(54,20,9,44.00,70);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(55,20,6,14.40,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(56,21,9,99.00,10);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(57,21,2,27.80,4);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(58,22,3,2.00,60);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(59,22,2,27.80,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(60,23,6,15.20,30);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(61,23,3,36.80,25);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(62,24,3,2.00,24);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(63,25,1,64.80,6);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(64,25,3,10.00,40);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(65,25,7,27.80,24);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(67,26,3,10.00,15);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(68,26,3,2.00,20);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(69,26,4,14.70,60);
```sql
INSERT into orderitem (Id,OrderId,ProductId,UnitPrice,Quantity)VALUES(6,3,1,7.70,10);

```sql
select * from orderitem;
```sql
select count(*) from orderitem;

### Nas Proximas Aulas Vamos Aprender A Usar Os Principais Comandos
### Da Linguagem Sql Para Operacoes
### Importantes Como Select, Delete, Update, Views, Stored Procedures, Triggers.

```sql
-----------------------------------------------------------------------------------------

## Fim









