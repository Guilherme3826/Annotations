# Conexão e Comandos Básicos via Terminal (psql)

---

## Conectar ao banco de dados

```bash
psql -h localhost -U postgres -d dbGisSSD
```

| Parâmetro | Descrição              |
| --------- | ---------------------- |
| `-h`      | Host (servidor)        |
| `-U`      | Usuário                |
| `-d`      | Nome do banco de dados |

---

## Comandos de navegação

**Listar todos os bancos de dados existentes:**

```
\l
```

**Conectar a um banco de dados:**

```
\c bancox
```

**Verificar em qual banco você está conectado:**

```
\conninfo
```

---

## Gerenciamento de tabelas

**Criar uma tabela com coluna `id` (auto-incremento) e coluna `nome`:**

```sql
CREATE TABLE exemplo (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);
```

**Excluir a tabela:**

```sql
DROP TABLE exemplo;
```
