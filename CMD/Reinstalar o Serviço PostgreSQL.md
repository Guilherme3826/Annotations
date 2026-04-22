# Guia: Registro e Remoção do Serviço PostgreSQL no Windows

> **Cenário:** PostgreSQL instalado em SSD portátil ou migrado de outra instalação do Windows, onde o serviço não existe (ou existe como "fantasma") no sistema atual.

---

## Pré-requisitos

- Prompt de Comando (CMD) aberto **como Administrador**
- SSD com PostgreSQL conectado e com letra de unidade definida (ex: `H:`)
- Conhecer o caminho da pasta `data` (onde ficam os bancos de dados)

### Como encontrar a pasta DATA

A pasta `data` contém os arquivos `postgresql.conf` e `PG_VERSION`. Locais comuns:

```
H:\Program Files\PostgreSQL\18\data
H:\PostgreSQL\data
```

Para confirmar, procure por `postgresql.conf` dentro do drive do SSD.

---

## Parte 1 — Diagnóstico Inicial

Antes de qualquer ação, verifique o estado atual do serviço:

```cmd
sc qc postgresql-x64-18
```

| Resultado                                      | Significado                                             |
| ---------------------------------------------- | ------------------------------------------------------- |
| Exibe informações normalmente                  | Serviço registrado e funcional                          |
| `OpenService FALHA 1060`                       | Serviço **não** existe no Windows atual                 |
| `pg_ctl` diz "já registrado" mas `sc qc` falha | **Serviço fantasma** (resquício de instalação anterior) |

---

## Parte 2 — Remoção do Serviço Anterior

Se o serviço anterior está corrompido, inativo ou aponta para o caminho errado, remova-o antes de criar um novo.

### Opção A — Usando pg_ctl (preferida)

```cmd
"H:\Program Files\PostgreSQL\18\bin\pg_ctl.exe" unregister -N "postgresql-x64-18"
```

### Opção B — Usando sc delete (caso pg_ctl falhe)

```cmd
sc delete "postgresql-x64-18"
```

**Saída esperada após a remoção:**

```
[SC] DeleteService ÊXITO
```

> **Nota:** Após o `sc delete`, pode ser necessário reiniciar o computador para que o Windows limpe completamente a entrada do Registro.

---

## Parte 3 — Registro do Novo Serviço

Com o nome de serviço livre, registre-o apontando para os arquivos do SSD portátil.

### Comando básico (porta padrão 5432)

```cmd
"H:\Program Files\PostgreSQL\18\bin\pg_ctl.exe" register -N "postgresql-x64-18" -D "H:\Program Files\PostgreSQL\18\data"
```

### Comando com porta personalizada (ex: 6526)

```cmd
"H:\Program Files\PostgreSQL\18\bin\pg_ctl.exe" register -N "postgresql-x64-18" -D "H:\Program Files\PostgreSQL\18\data" -o "-p 6526"
```

**Parâmetros explicados:**

| Parâmetro                | Descrição                                          |
| ------------------------ | -------------------------------------------------- |
| `register`               | Cria o serviço no Registro do Windows              |
| `-N "postgresql-x64-18"` | Nome do serviço (pode ser personalizado)           |
| `-D "caminho\data"`      | Caminho para a pasta de dados do PostgreSQL        |
| `-o "-p 6526"`           | Parâmetros extras passados ao servidor (ex: porta) |

### Verificar se o registro foi bem-sucedido

```cmd
sc qc postgresql-x64-18
```

Procure pela linha `BINARY_PATH_NAME` — ela deve conter o caminho do `postgres.exe` e o `-D` apontando para a pasta correta no drive `H:`.

---

## Parte 4 — Permissões de Acesso à Pasta DATA

Serviços do Windows rodam sob a conta `NetworkService`, que frequentemente **não tem acesso** a drives externos ou pastas migradas de outro sistema. Este passo é crucial para SSDs portáteis.

### Via Interface Gráfica

1. Clique com o botão direito na pasta `H:\Program Files\PostgreSQL\18\data`
2. Acesse **Propriedades** → aba **Segurança** → botão **Editar**
3. Clique em **Adicionar** → digite `Todos` (ou `Everyone` em inglês) → confirme
4. Marque **Controle Total** para o grupo adicionado
5. Clique em **OK** em todas as janelas

### Via Linha de Comando (como Administrador)

```cmd
icacls "H:\Program Files\PostgreSQL\18\data" /grant "Todos:(OI)(CI)F" /T
```

---

## Parte 5 — Inicialização e Captura de Erros

### Iniciar via Serviço do Windows

```cmd
net start postgresql-x64-18
```

### Iniciar manualmente no console (melhor para diagnóstico)

Este método exibe todos os erros diretamente no terminal, sem depender do gerenciador de serviços:

```cmd
"H:\Program Files\PostgreSQL\18\bin\postgres.exe" -D "H:\Program Files\PostgreSQL\18\data" -p 6526
```

---

## Parte 6 — Diagnóstico de Erros Comuns

### Erro: `postmaster.pid` já existe

```
FATAL: lock file "postmaster.pid" already exists
```

**Causa:** O PostgreSQL foi desligado de forma abrupta (ex: remoção do SSD sem encerrar o serviço) e deixou um arquivo de trava.

**Solução:** Delete o arquivo manualmente:

```cmd
del "H:\Program Files\PostgreSQL\18\data\postmaster.pid"
```

Em seguida, tente iniciar novamente.

---

### Erro: Porta já em uso

```
FATAL: could not bind IPv4 address "0.0.0.0": Address already in use
```

**Causa:** Outro processo está usando a porta configurada (ex: 6526 ou 5432).

**Solução:** Identifique o processo que ocupa a porta:

```cmd
netstat -ano | findstr ":6526"
```

O último número é o PID. Encerre-o pelo Gerenciador de Tarefas ou:

```cmd
taskkill /PID <numero_do_pid> /F
```

---

### Erro: Arquivo de configuração não encontrado

```
FATAL: could not open configuration file "...\postgresql.conf"
```

**Causa:** O caminho passado com `-D` está incorreto ou a pasta `data` está em outro local.

**Solução:** Verifique o caminho correto:

```cmd
dir "H:\Program Files\PostgreSQL\18\data\postgresql.conf"
```

Se não encontrar, procure em todo o drive:

```cmd
dir /S /B H:\postgresql.conf
```

---

### Erro: Acesso negado (Permission Denied)

```
FATAL: could not open file "...": Permission denied
```

**Causa:** A conta que executa o serviço não tem permissão de leitura/escrita na pasta `data`.

**Solução:** Repita o Passo 4 (configuração de permissões).

---

## Parte 7 — Configuração de Variáveis de Ambiente (PATH)

Para usar comandos como `psql`, `pg_isready` ou `pg_ctl` de qualquer pasta no terminal:

### Via Interface Gráfica

1. Pressione `Win` e pesquise por **"Editar as variáveis de ambiente do sistema"**
2. Clique em **Variáveis de Ambiente**
3. Em **Variáveis do Sistema**, selecione `Path` e clique em **Editar**
4. Clique em **Novo** e adicione:
   ```
   H:\Program Files\PostgreSQL\18\bin
   ```
5. Clique em **OK** em todas as janelas
6. **Feche e abra um novo CMD** para as alterações surtirem efeito

### Validação

```cmd
pg_isready -p 6526
```

Saída esperada se o servidor estiver ativo:

```
localhost:6526 - accepting connections
```

---

## Parte 8 — Atenção para SSDs Portáteis

| Situação                                             | Problema                                              | Solução                                                 |
| ---------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------- |
| SSD recebe letra diferente (ex: `G:` em vez de `H:`) | O serviço registrado em `H:` não encontra os arquivos | Fixar a letra da unidade via **Gerenciamento de Disco** |
| SSD desconectado sem parar o serviço                 | Arquivo `postmaster.pid` corrompido                   | Deletar o `postmaster.pid` antes de reiniciar           |
| Migração de outro Windows                            | Serviço não registrado no Windows atual               | Seguir os Passos 2 e 3 deste guia                       |

### Como fixar a letra do drive no Windows

1. Pressione `Win + X` → **Gerenciamento de Disco**
2. Clique com o botão direito no volume do SSD portátil
3. Selecione **Alterar letra de unidade e caminho...**
4. Defina a letra `H:` (ou a que preferir) e confirme

---

## Resumo dos Comandos

```cmd
:: 1. Verificar estado do serviço
sc qc postgresql-x64-18

:: 2. Remover serviço antigo
"H:\Program Files\PostgreSQL\18\bin\pg_ctl.exe" unregister -N "postgresql-x64-18"
:: ou, se o anterior falhar:
sc delete "postgresql-x64-18"

:: 3. Registrar o serviço novamente
"H:\Program Files\PostgreSQL\18\bin\pg_ctl.exe" register -N "postgresql-x64-18" -D "H:\Program Files\PostgreSQL\18\data" -o "-p 6526"

:: 4. Iniciar o serviço
net start postgresql-x64-18

:: 5. Verificar conectividade
pg_isready -p 6526

:: 6. Iniciar manualmente para ver erros (se net start falhar)
"H:\Program Files\PostgreSQL\18\bin\postgres.exe" -D "H:\Program Files\PostgreSQL\18\data" -p 6526
```

---

_Documentação gerada com base na instalação PostgreSQL 18 em ambiente Windows 10/11 com SSD portátil._
