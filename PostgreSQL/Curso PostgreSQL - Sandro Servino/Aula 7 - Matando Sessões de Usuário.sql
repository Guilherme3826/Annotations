CREATE DATABASE teste;

SELECT pid, datname, usename, client_addr, state
FROM pg_stat_activity -- Exibe as sessões ativas no banco de dados --
WHERE datname = 'teste'

DROP DATABASE teste; -- Comando para excluir o banco de dados, mas não funciona se houver sessões ativas --

SELECT pg_terminate_backend(22360) -- Comando para encerrar a sessão ativa com o PID 11604, necessário para excluir o banco de dados --
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'teste'; -- Comando para encerrar todas as sessões ativas no banco de dados teste, necessário para excluir o banco de dados --

DROP DATABASE teste  WITH (FORCE); -- Comando para excluir o banco de dados mesmo que haja sessões ativas, disponível a partir do PostgreSQL 13 --



