/* * Conexão ao banco de dados via Terminal (psql)
 * -h: Host (servidor)
 * -U: Usuário
 * -d: Nome do banco de dados
 */

psql -h localhost -U postgres -d dbGisSSD

\l -- Listar todos os banco de dado exisntentes
\c bancox -- Se conectar ao banco X
\conninfo -- Saber em qual banco você está conectado

CREATE TABLE exemplo (id SERIAL PRIMARY KEY, nome VARCHAR(100)); -- Comando para criar uma tabela chamada exemplo com uma coluna id do tipo SERIAL (auto-incremento) e uma coluna nome do tipo VARCHAR(100) --
DROP TABLE exemplo; -- Comando para excluir a tabela exemplo --