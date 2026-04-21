# Comandos de Gerenciamento de Banco de Dados no PostgreSQL

---

## Criar um banco de dados

```sql
CREATE DATABASE teste;
```

---

## Verificar sessões ativas

Exibe as sessões ativas no banco de dados:

```sql
SELECT pid, datname, usename, client_addr, state
FROM pg_stat_activity
WHERE datname = 'teste';
```

---

## Excluir um banco de dados

O comando abaixo exclui o banco de dados, mas **não funciona se houver sessões ativas**:

```sql
DROP DATABASE teste;
```

---

## Encerrar sessões ativas

Caso existam sessões ativas, é necessário encerrá-las antes de excluir o banco.

**Encerrar uma sessão específica pelo PID:**

```sql
SELECT pg_terminate_backend(22360);
```

**Encerrar todas as sessões ativas do banco `teste`:**

```sql
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'teste';
```

---

## Excluir o banco forçando o encerramento das sessões

Disponível a partir do **PostgreSQL 13**, o parâmetro `WITH (FORCE)` encerra automaticamente as sessões ativas e exclui o banco:

```sql
DROP DATABASE teste WITH (FORCE);
```
