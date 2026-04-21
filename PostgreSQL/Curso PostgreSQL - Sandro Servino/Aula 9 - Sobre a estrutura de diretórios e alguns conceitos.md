# Curso PostgreSQL Completo

**Instrutor:** Sandro Servino  
**LinkedIn:** [https://www.linkedin.com/in/sandroservino/](https://www.linkedin.com/in/sandroservino/?originalSubdomain=pt)

---

## Estrutura de Diretórios do PostgreSQL 17 (`data/`)

No PostgreSQL 17, a estrutura de diretórios dentro do diretório `data` segue um padrão semelhante ao das versões anteriores, mas pode ter algumas mudanças sutis dependendo das configurações e do sistema operacional. O diretório `data` é o local onde o PostgreSQL armazena seus arquivos de configuração, logs, e, principalmente, os dados do banco.

**Localização:**

```
C:\Program Files\PostgreSQL\17\data
```

---

### `base/`

Contém os diretórios e arquivos dos bancos de dados individuais. Cada banco de dados tem um diretório próprio, cujo nome é o **OID** do banco. Dentro de cada diretório de banco, os arquivos de tabelas e índices são armazenados.

#### O que é OID no PostgreSQL?

**OID (Object Identifier)** é um identificador numérico único atribuído a objetos do banco de dados, como tabelas, bancos de dados e outras entidades. No caso dos bancos de dados, cada um recebe um OID único no momento da criação.

#### Como descobrir o OID do banco de dados?

Para saber qual desses diretórios pertence ao seu banco de dados chamado `bancox`, execute este comando no psql:

```sql
SELECT oid, datname FROM pg_database WHERE datname = 'bancox';
SELECT oid, datname FROM pg_database;
```

> **💡 DICA:**
>
> Os bancos de dados `template0` e `template1` são bancos especiais no PostgreSQL usados como modelos para a criação de novos bancos de dados. Eles não aparecem no pgAdmin por padrão porque são bancos do sistema e não devem ser alterados diretamente.

#### 📌 O que é o `template1`?

O `template1` é o modelo padrão para a criação de novos bancos de dados.

Quando você executa:

```sql
CREATE DATABASE meu_banco;
```

O PostgreSQL copia todos os objetos do `template1` para o novo banco. Você pode modificar o `template1` (por exemplo, adicionando extensões), e essas mudanças serão replicadas em novos bancos criados a partir dele.

**Exemplo:**

```sql
\c template1
CREATE EXTENSION IF NOT EXISTS nome_da_extensao;
```

#### 📌 O que é o `template0`?

O `template0` é um modelo imutável, usado quando você precisa criar um banco de dados "limpo", sem customizações. Ele não pode ser modificado e é usado para restaurar o estado original de um banco. Se precisar criar um banco sem customizações do `template1`, use:

```sql
CREATE DATABASE meu_banco TEMPLATE template0;
```

---

### `global/`

O diretório `global/` armazena informações globais que são compartilhadas entre todos os bancos de dados da instância ou do cluster Postgres.

#### Principais Arquivos no Diretório `global/`

- **`pg_filenode.map`:** Mapeia os identificadores internos (filenodes) para os arquivos físicos que armazenam as tabelas e índices no sistema de arquivos.

- **`pg_internal.init`:** Utilizado para inicializar a estrutura interna do banco de dados, configurando aspectos essenciais para o funcionamento do Postgres.

- **`pg_control`:** Contém informações críticas sobre o estado do banco de dados, como a versão do PostgreSQL, o número do último checkpoint e detalhes sobre os arquivos WAL (Write-Ahead Logging). Este arquivo é fundamental para a recuperação do banco de dados após falhas.

- **`config_exec_params`:** Armazena parâmetros de configuração utilizados pelo PostgreSQL durante a execução, influenciando o comportamento do sistema em tempo de operação.

> Esses arquivos são essenciais para a operação interna do PostgreSQL e devem ser manipulados com cautela. Alterações inadequadas podem comprometer a integridade e a estabilidade do banco de dados.

---

### `pg_wal/`

O diretório `pg_wal/` no PostgreSQL armazena os arquivos de **Write-Ahead Logging (WAL)**, que registram todas as operações de mudanças no banco de dados antes de serem aplicadas no arquivo final de dados. Esses arquivos são fundamentais para:

- Recuperação de falhas (permite restaurar o banco em caso de crash).
- Replicação (sincronização entre servidores primário e réplica).
- Point-in-Time Recovery (PITR) (recuperação até um ponto específico no tempo).
- O PostgreSQL mantém esses arquivos até que sejam arquivados ou não sejam mais necessários.

> Antes do PostgreSQL 10, esse diretório era chamado de `pg_xlog/`.

#### WAL e o Conceito ACID

O conceito **ACID** no PostgreSQL (e em bancos de dados transacionais em geral) se refere a quatro propriedades fundamentais para garantir a integridade dos dados:

- **Atomicidade (A - Atomicity):** Uma transação deve ser tudo ou nada. Se qualquer parte falhar, todas as alterações são revertidas.

- **Consistência (C - Consistency):** O banco deve sempre permanecer em um estado válido antes e depois da transação.

- **Isolamento (I - Isolation):** Transações concorrentes não devem interferir umas nas outras de maneira indesejada. Por exemplo, dois processos não podem alterar o mesmo dado no mesmo momento, e o banco de dados protege através de locks.

- **Durabilidade (D - Durability):** Após um commit, os dados devem ser gravados permanentemente, mesmo em caso de falha do sistema.

#### Como o WAL garante ACID?

O Write-Ahead Logging (WAL) desempenha um papel crucial para garantir ACID:

- O PostgreSQL escreve todas as alterações nos files do WAL log **antes** de aplicá-las nos files de dados do banco de dados. Isso significa que, mesmo que ocorra uma falha antes de os dados serem gravados nos arquivos de dados no disco, as mudanças podem ser recuperadas ao reiniciar o Postgres, através da leitura das transações completadas que foram registradas nos files do WAL Log no disco.

- Se uma transação falha no meio do processo, as operações registradas no WAL Log sem o commit podem ser desfeitas, garantindo que nenhuma mudança parcial permaneça.

- No caso de um crash, o PostgreSQL quando reinicializa lê os registros do WAL log e reexecuta as transações comitadas (mas que não tinham sido ainda garantidas nos files de dados no disco) ou desfaz transações incompletas para restaurar o banco a um estado consistente.

> Dessa forma, o WAL log não só melhora a segurança e confiabilidade do PostgreSQL, como também viabiliza a replicação e o Point-in-Time Recovery (PITR).

---

### `pg_commit_ts/`

Contém timestamps de commits, se o recurso estiver habilitado. Esse recurso continua sendo opcional e depende da configuração `track_commit_timestamp`.

#### Para que isso é usado?

- **Replicação lógica:** Ajuda a resolver conflitos em replicações multi-master.
- **Monitoramento e auditoria:** Permite verificar a ordem dos commits e quando uma transação foi finalizada.

Se `track_commit_timestamp` estiver desligado (valor padrão), o diretório `pg_commit_ts/` fica vazio.

Para habilitar esse recurso, configure o parâmetro no arquivo `postgresql.conf`:

```
track_commit_timestamp = on
```

---

### `pg_logical/`

O diretório `pg_logical/` no PostgreSQL armazena informações relacionadas à **replicação lógica**. Esse recurso permite replicação de dados entre diferentes instâncias do PostgreSQL, capturando as mudanças de dados (inserções, atualizações, exclusões) em tempo real.

A replicação lógica é usada em cenários como replicação seletiva de tabelas ou replicação entre diferentes versões de PostgreSQL, e é comumente utilizada para distribuição de dados ou migração de dados.

---

### `pg_notify/`

Armazena dados sobre notificações assíncronas (LISTEN/NOTIFY).

O PostgreSQL permite que processos do banco de dados enviem e recebam notificações sem precisar verificar constantemente as tabelas (evitando polling).

O mecanismo **LISTEN/NOTIFY** do PostgreSQL tem algumas semelhanças com o Service Broker do SQL Server (serviço de mensageria):

- ✅ **Comunicação assíncrona:** Ambos permitem que processos do banco se comuniquem sem precisar consultar tabelas constantemente.
- ✅ **Eventos internos no banco:** Podem ser usados para notificar processos sobre mudanças ou eventos importantes.
- ✅ **Desempenho melhor que polling:** Eliminam a necessidade de consultas frequentes para detectar alterações.
- ✅ Pode ser usado como parte de um sistema de cache para conexões de usuários.

---

### `pg_replslot/`

O diretório `pg_replslot/` armazena informações relacionadas à replicação no PostgreSQL, tanto para replicação física quanto lógica.

#### Objetivo

- **Guardar registros de mudanças no banco:** Garante que os registros de alterações feitos no banco de dados sejam mantidos disponíveis até que sejam consumidos por outro sistema ou servidor.
- **Sincronização entre servidores:** Utilizado para sincronizar dados entre servidores, impedindo que registros importantes sejam apagados antes de serem replicados.
- **Controle de dados replicados:** Facilita o processo de replicação, ajudando a controlar quais dados foram lidos e replicados para outras instâncias do banco.

#### Por que existe outro diretório para replicação lógica?

O PostgreSQL oferece dois tipos de replicação: **física** e **lógica**.

- A **replicação física** replica de forma binária todos os arquivos da instância Postgres e não permite selecionar objetos específicos.
- A **replicação lógica** tem um controle mais detalhado e flexível sobre quais dados serão replicados, podendo por exemplo replicar apenas um determinado banco de dados ou mesmo uma tabela específica.

Portanto:

- `pg_logical/` é dedicado a armazenar informações específicas sobre a replicação lógica.
- `pg_replslot/` gerencia a replicação de forma mais geral (incluindo a replicação física).

---

### `pg_serial/`

Contém informações sobre transações serializáveis.

#### O que são transações serializáveis?

No PostgreSQL, o nível de isolamento **serializável** é o mais alto de todos os níveis de isolamento de transações. Ele garante que as transações sejam executadas de forma que o resultado final seja o mesmo se as transações fossem realizadas de forma sequencial (uma após a outra), sem interferência entre elas, mesmo que estejam sendo executadas de forma concorrente.

#### Os quatro níveis de isolamento de transações (ISO)

1. **Read Uncommitted (Leitura não confirmada)**
   - Permite que uma transação leia dados que ainda não foram confirmados por outras transações ("dirty reads").
   - **Problema:** Pode resultar em leituras imprecisas, pois as transações podem ler dados que depois podem ser desfeitos com um rollback.

2. **Read Committed (Leitura confirmada)**
   - Garante que uma transação leia apenas dados que foram confirmados (committed) por outras transações.
   - **Problema:** Pode ocorrer o fenômeno de _non-repeatable reads_, onde, se você ler um valor em uma transação e depois tentar ler o mesmo valor novamente, ele pode ter mudado devido a outra transação confirmada.

3. **Repeatable Read (Leitura repetível)**
   - Garante que, durante toda a transação, os dados lidos não serão alterados por outras transações, evitando o problema de _non-repeatable reads_.
   - **Problema:** Pode ocorrer _phantom reads_ (leituras fantasmas), onde novas linhas podem ser inseridas por outras transações que afetam o resultado da sua consulta.

4. **Serializable (Serializável)**
   - É o nível de isolamento mais alto. Garante que o comportamento da transação será equivalente a se as transações fossem executadas sequencialmente, uma após a outra, sem sobreposição.
   - **Garantia:** Evita todos os tipos de anomalias, incluindo _dirty reads_, _non-repeatable reads_ e _phantom reads_. Porém, pode causar grandes bloqueios e diminuir muito a concorrência, trazendo grandes problemas de performance.

> **Padrão do PostgreSQL 17:** O nível de isolamento padrão é o **Read Committed**.

Se você quiser usar um nível de isolamento mais restrito, como Repeatable Read ou Serializable, pode configurar isso explicitamente na transação com o comando:

```sql
SET TRANSACTION ISOLATION LEVEL <nivel>;
```

---

### `pg_snapshots/`

O diretório `pg_snapshots/` no PostgreSQL armazena snapshots de transações, especialmente úteis para o nível de isolamento Repeatable Read e Read Committed.

Um **snapshot** é uma visão consistente do banco de dados em um determinado ponto no tempo. Quando uma transação começa, o PostgreSQL tira um snapshot para garantir que ela veja os mesmos dados até seu término, mesmo que outras transações façam alterações.

> **OBS:** O PostgreSQL, assim como o MySQL (InnoDB) e o Oracle, usa **MVCC (Multiversion Concurrency Control)**, permitindo que `SELECT` não bloqueie `UPDATE`/`DELETE` e vice-versa. Isso melhora a concorrência e evita bloqueios desnecessários.
>
> No SQL Server, o comportamento padrão é pessimista, onde `SELECT` pode bloquear `UPDATE`/`DELETE` e vice-versa. No entanto, esse comportamento pode ser alterado ativando o parâmetro `READ_COMMITTED_SNAPSHOT` de um determinado banco de dados, o que faz o SQL Server adotar um mecanismo similar ao MVCC.

---

### `pg_stat/`

Armazena estatísticas detalhadas sobre a atividade da instância Postgres e dos bancos de dados hospedados nesta instância, coletadas pelo sistema de monitoramento interno do PostgreSQL.

As estatísticas são informações coletadas pelo PostgreSQL sobre o uso do banco de dados, como:

- Leituras e gravações de dados.
- Operações de consulta (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).
- Uso de índices.
- Bloqueios de tabelas e registros.
- Desempenho das transações.

Essas estatísticas ajudam os administradores de banco de dados (DBAs) a entender como o banco de dados está sendo usado e onde há potenciais problemas de desempenho.

---

### `pg_stat_tmp/`

Armazena estatísticas temporárias em execução. Essas estatísticas são dados voláteis — não são persistentes e são apenas temporárias. O conteúdo é recriado ao reiniciar o PostgreSQL.

Ele contém arquivos temporários usados pelo coletor de estatísticas do PostgreSQL. Essas estatísticas incluem informações sobre:

1. **Uso de tabelas e índices:** número de páginas lidas e escritas; quantidade de tuplas (linhas) inseridas, atualizadas e excluídas.
2. **Atividade do Autovacuum:** quantidade de autoanálises (autovacuum analyze) realizadas; estatísticas sobre auto-vacuums executados.
3. **Atividade do backend (sessões de usuários):** informações temporárias sobre as conexões e atividades recentes.
4. **Número de commits e rollbacks:** contagem temporária de transações confirmadas e desfeitas antes de serem persistidas.
5. **Estatísticas de E/S (I/O):** quantidade de blocos de disco lidos e gravados.

#### Diferença entre `pg_stat/` e `pg_stat_tmp/`

| Diretório      | Descrição                                                                    |
| -------------- | ---------------------------------------------------------------------------- |
| `pg_stat/`     | Contém estatísticas mais permanentes e gerais sobre a atividade do Postgres. |
| `pg_stat_tmp/` | Armazena estatísticas temporárias, descartadas ao reiniciar o PostgreSQL.    |

---

### `pg_subtrans/`

O diretório `pg_subtrans/` no PostgreSQL armazena informações sobre **subtransações**, que são transações dentro de outras transações. As subtransações são usadas para fornecer um controle mais granular sobre transações compostas, permitindo que o banco de dados trate falhas e reversões de maneira eficiente, sem precisar reverter a transação principal inteira.

#### O que são subtransações?

Uma subtransação é uma transação que ocorre dentro de uma transação principal. Elas permitem que certas partes de uma transação maior possam ser completadas ou revertidas independentemente, sem afetar toda a transação. Isso é útil, por exemplo, quando se quer confirmar (`commit`) parte de uma transação, mas ainda manter a possibilidade de desfazer (`rollback`) outras partes.

---

### `pg_tblspc/`

O diretório `pg_tblspc/` no PostgreSQL armazena links simbólicos que apontam para os diretórios físicos onde o PostgreSQL armazenará os arquivos dos **tablespaces**.

Um **tablespace** é um container lógico no PostgreSQL, que possui diretórios físicos no disco onde os dados e objetos do banco de dados (como tabelas, índices, etc.) são armazenados. Ele permite a distribuição dos dados em diferentes dispositivos de armazenamento.

Quando um tablespace é criado no PostgreSQL (usando o comando `CREATE TABLESPACE`), você especifica um caminho de diretório no sistema de arquivos onde o PostgreSQL deve armazenar os dados. O PostgreSQL, então, cria um link simbólico dentro do diretório `pg_tblspc/`, apontando para esse diretório de dados físico.

---

### `pg_twophase/`

Contém informações sobre transações preparadas em um ambiente de **two-phase commit (2PC)**.

O 2PC é um processo geralmente utilizado em ambientes distribuídos (como replicação e clusters), onde várias instâncias de banco de dados precisam garantir que uma transação seja completada de forma consistente em todos os lugares.

O diretório `pg_twophase/` assegura que as transações possam ser completadas corretamente ou revertidas, mesmo após falhas ou reinicializações do sistema.

---

### `pg_multixact/`

O diretório `pg_multixact/` no PostgreSQL armazena informações sobre múltiplos bloqueios de transações quando mais de uma transação precisa bloquear a mesma linha ao mesmo tempo.

No PostgreSQL, quando duas ou mais transações precisam compartilhar o bloqueio de uma mesma linha, o banco cria um **MultiXact** (ou "transação múltipla"). Esse mecanismo permite que mais de uma transação seja "dona" de um bloqueio ao mesmo tempo.

> Locks serão abordados em detalhes no futuro.

---

### `log/`

Contém arquivos de log do PostgreSQL. É o diretório padrão da instalação.

**Localização:**

```
C:\Program Files\PostgreSQL\17\data\log
```

> Sempre que tiver algum problema, como por exemplo o PostgreSQL não dar start, verifique o último arquivo de log, abra o conteúdo e procure os erros.

**Exemplo de erro no log:**

```
2025-03-16 08:18:16.738 GMT [13224] FATAL:  database "teste" does not exist
```

---

## Arquivos Importantes no Diretório Raiz (`data/`)

| Arquivo           | Descrição                                                   |
| ----------------- | ----------------------------------------------------------- |
| `postgresql.conf` | Arquivo principal de configuração do PostgreSQL.            |
| `pg_hba.conf`     | Configuração de autenticação (métodos de conexão).          |
| `pg_ident.conf`   | Mapeamento de identidades de usuários.                      |
| `PG_VERSION`      | Arquivo que contém a versão do PostgreSQL usada no cluster. |

---

### 1. `postgresql.conf` – Arquivo Principal de Configuração

Este é o principal arquivo de configuração do PostgreSQL e controla diversos aspectos do funcionamento do Postgres. Ele define desde parâmetros básicos, como localização dos logs, até otimizações de desempenho e comportamento da replicação.

#### 📌 Localização

```
/var/lib/postgresql/17/data/postgresql.conf   (Linux)
C:\Program Files\PostgreSQL\17\data\postgresql.conf   (Windows)
```

#### 🔧 Principais configurações

**Configurações Gerais:**

```
data_directory = '/var/lib/postgresql/17/data'
hba_file = '/var/lib/postgresql/17/data/pg_hba.conf'
ident_file = '/var/lib/postgresql/17/data/pg_ident.conf'
```

**Configurações de Rede e Conexão:**

```
listen_addresses = 'localhost'
port = 5432
max_connections = 100
```

**Configurações de Memória e Performance:**

```
shared_buffers = 128MB
work_mem = 4MB
maintenance_work_mem = 64MB
```

**Configuração de Logs:**

```
logging_collector = on
log_directory = 'pg_log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
```

**Configuração de Autovacuum:**

```
autovacuum = on
autovacuum_vacuum_threshold = 50
```

**Configuração de Replicação e Backup:**

```
wal_level = replica
max_wal_senders = 10
archive_mode = on
```

> **📌 Modificação:** Para alterar qualquer configuração, edite o arquivo e reinicie o PostgreSQL.

---

### 2. `pg_hba.conf` – Configuração de Autenticação

Esse arquivo define quais usuários podem acessar o banco de dados, de quais endereços IP e qual método de autenticação será utilizado.

#### 📌 Localização

```
C:\Program Files\PostgreSQL\17\data\pg_hba.conf   (Windows)
/var/lib/postgresql/17/data/pg_hba.conf   (Linux)
```

#### 🔒 Formato das linhas

Cada linha segue a estrutura:

```
# Tipo      Banco       Usuário      Endereço          Método de Autenticação
host        all         xpto         192.168.1.0/24    peer map=mymap
```

| Campo                      | Descrição                                                 |
| -------------------------- | --------------------------------------------------------- |
| **Tipo**                   | `local`, `host`, `hostssl`, `hostnossl`                   |
| **Banco**                  | Nome do banco de dados (`all` significa todos)            |
| **Usuário**                | Nome do usuário (`all` significa qualquer usuário)        |
| **Endereço**               | IP ou intervalo (ex: `192.168.1.100` ou `192.168.1.0/24`) |
| **Método de Autenticação** | `md5`, `scram-sha-256`, `trust`, `peer`, `ident`          |

**Métodos de autenticação:**

- `md5` → Solicita senha criptografada.
- `scram-sha-256` → Autenticação mais segura que md5.
- `trust` → Permite acesso sem senha (não recomendado).
- `peer` → Permite autenticação pelo nome do usuário do SO.
- `ident` → Similar ao peer, mas usa um serviço externo.

> **OBS:** `local` é apenas para conexões via Unix domain socket.

#### 📌 Exemplo de configuração

```
# Permite conexões locais sem senha para o usuário postgres
local       all         postgres                          peer map=mymap

# Permite conexões de qualquer usuário vindo de 192.168.1.0/24 usando senha MD5
host        all         all             192.168.1.0/24    md5

# Permite conexões remotas apenas para o usuário replicator via senha criptografada
host        replication replicator      10.0.0.5/32       scram-sha-256
```

#### 📌 Modificação

Após qualquer alteração, é necessário recarregar as configurações com:

```bash
pg_ctl reload
```

Ou:

```bash
systemctl reload postgresql
```

---

### 3. `pg_ident.conf` – Mapeamento de Identidades de Usuários

Esse arquivo permite mapear usuários do sistema operacional para usuários do PostgreSQL. Ele é útil para autenticação via `peer` ou `ident`.

#### 📌 Localização

```
C:\Program Files\PostgreSQL\17\data\pg_ident.conf   (Windows)
/var/lib/postgresql/17/data/pg_ident.conf   (Linux)
```

#### 🔄 Formato das linhas

```
# MAPNAME       SYSTEM-USERNAME         PG-USERNAME
mymap           sandro                  xpto
mymap           ricardo                 xpto2
```

#### 📌 Como funciona?

Se no `pg_hba.conf` estiver configurado assim:

```
local all all peer map=mymap
```

O PostgreSQL verificará o `pg_ident.conf` e permitirá que `sandro` (usuário do sistema) se autentique como `xpto` (usuário do PostgreSQL).

#### 📌 Modificação

Após mudanças, recarregar com:

```bash
pg_ctl reload
```

---

### 4. `PG_VERSION` – Arquivo com a Versão do PostgreSQL

Arquivo simples que contém apenas um número representando a versão do Postgres instalado.

#### 📌 Localização

```
C:\Program Files\PostgreSQL\17\data\PG_VERSION   (Windows)
/var/lib/postgresql/17/data/PG_VERSION   (Linux)
```

#### 📌 Conteúdo

```
17
```

---

## Desligando o Servidor PostgreSQL de Forma Segura

A forma mais segura de parar o serviço PostgreSQL no Windows é utilizando o Gerenciador de Serviços ou os comandos apropriados no terminal.

### 1. Pelo Gerenciador de Serviços

1. Pressione `Win + R`, digite `services.msc` e pressione Enter.
2. Localize o serviço chamado algo como `PostgreSQL - versão` (por exemplo, `PostgreSQL - 15`).
3. Clique com o botão direito no serviço e selecione **Parar**.
4. Aguarde até que o status do serviço mude para "Parado".

> ⚠️ **ATENÇÃO:** EVITE SIMPLESMENTE DAR UM SHUTDOWN NO WINDOWS SERVER OU PIOR NA VM. ANTES PARE O POSTGRESQL E ASSIM TERÁ A GARANTIA DE QUE SEU BANCO DE DADOS ESTARÁ ÍNTEGRO. É RARO DAR PROBLEMA NO BANCO MESMO COM PARADAS INESPERADAS DO WINDOWS OU DO SERVIDOR, MAS MELHOR PREVENIR DO QUE REMEDIAR.

---

### 2. Via Linha de Comando (DOS como Administrador)

> **OBS:** SE FOR PARA O DOS SEM MODO ADMINISTRADOR NÃO PODERÁ PARAR DEVIDO À FALTA DE PRIVILÉGIO.

Navegue até a pasta de instalação do PostgreSQL:

```
CD C:\Program Files\PostgreSQL\17\bin
```

**Parar o serviço:**

```
net stop postgresql-x64-17
```

**Ver o status de um serviço:**

```
sc query postgresql-x64-17
```

O comando `net stop postgresql-x64-17` envia um sinal de parada padrão ao serviço do PostgreSQL:

- ✔️ O PostgreSQL aguarda todas as conexões ativas terminarem.
- ✔️ Nenhuma transação ativa é interrompida abruptamente.
- ✔️ Pode demorar se houver conexões longas.

---

### Outros Comandos para Parar o PostgreSQL

**1️⃣ Parada segura** (aguarda conexões finalizarem normalmente)

```
pg_ctl -D "C:\Program Files\PostgreSQL\17\data" stop -m smart
```

- ✔️ Método mais seguro.
- ✔️ Espera as conexões terminarem antes de desligar.

**2️⃣ Parada rápida** (finaliza conexões ativas imediatamente)

```
pg_ctl -D "C:\Program Files\PostgreSQL\17\data" stop -m fast
```

- ⚡ Finaliza as conexões ativas rapidamente.
- ⚡ Mais rápido, mas pode causar rollback de transações em andamento.

**3️⃣ Parada forçada** (mata os processos sem esperar nada)

```
pg_ctl -D "C:\Program Files\PostgreSQL\17\data" stop -m immediate
```

- 🚨 Desliga imediatamente, sem esperar conexões finalizarem.
- 🚨 Pode exigir recuperação na próxima inicialização.
- 🚨 **Use só em emergências**, pois pode haver até perda de dados ou o serviço pode não subir dependendo do que estava rodando!

---

### Resultado esperado ao parar o serviço

```
C:\Program Files\PostgreSQL\17\bin>pg_ctl -D "C:\Program Files\PostgreSQL\17\data" stop
waiting for server to shut down.... done
server stopped
```

> Se aparecer alguma tela do Firewall pedindo permissão para o serviço PostgreSQL ser iniciado, pode permitir.

---

### Verificar status e reiniciar o serviço

**Verificar status:**

```
pg_ctl -D "C:\Program Files\PostgreSQL\17\data" status
```

Ou via serviços do Windows.

**Iniciar novamente (como Administrador no DOS):**

```
net start postgresql-x64-17
```

**Ver o status:**

```
sc query postgresql-x64-17
```

---

_Fim do material._
