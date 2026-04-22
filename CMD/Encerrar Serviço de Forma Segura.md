# Procedimento de Remoção Segura: PostgreSQL em SSD Portátil

Este documento descreve as etapas obrigatórias para desconectar um SSD portátil que hospeda um serviço do PostgreSQL. O descumprimento deste protocolo pode resultar em corrupção de dados, perda de transações ou falha total na inicialização do cluster de banco de dados em conexões futuras.

---

## 1. Contexto de Risco

O PostgreSQL é um sistema de banco de dados ACID. Ele mantém arquivos de log (WAL) e buffers em memória que precisam ser sincronizados com o disco de forma organizada. Retirar o SSD com o serviço ativo interrompe esse ciclo de escrita bruscamente.

---

## 2. Passo a Passo de Remoção

### Passo 1: Encerrar Conexões de Clientes

Antes de desligar o servidor, feche todas as ferramentas que possuem conexões ativas com o banco de dados.

- **pgAdmin 4**: Encerre o aplicativo e o ícone na bandeja do sistema.
- **QGIS / Ferramentas GIS**: Como as bases PostGIS costumam ser pesadas, certifique-se de que nenhum projeto que utilize camadas do SSD esteja aberto.
- **IDEs e Terminais**: Feche o psql, VS Code ou qualquer terminal aberto no diretório do drive H:.

---

### Passo 2: Parar o Serviço do PostgreSQL

Esta é a etapa mais crítica. O serviço deve ser interrompido para que os arquivos de trava (lock files) sejam removidos e os buffers sejam descarregados.

#### Opção A: Via Prompt de Comando (Recomendado)

Abra o CMD como Administrador e execute:

```dos
net stop postgresql-x64-18
```

#### Opção B: Via pg_ctl (Caso o serviço não esteja registrado)

```dos
"H:\Program Files\PostgreSQL\18\bin\pg_ctl.exe" stop -D "H:\Program Files\PostgreSQL\18\data"
```

---

### Passo 3: Verificação de Processos

Certifique-se de que o motor do banco de dados encerrou completamente:

- Abra o Gerenciador de Tarefas (Ctrl + Shift + Esc).
- Vá na aba **Detalhes**.
- Verifique se não existe nenhum processo chamado **postgres.exe** em execução.

---

### Passo 4: Remoção Lógica no Windows

Utilize o recurso de ejeção do sistema operacional para desmontar o volume:

- Localize o ícone **Remover Hardware e Ejetar Mídia com Segurança** na bandeja do sistema (perto do relógio).
- Selecione o drive correspondente ao seu SSD Portátil.
- Aguarde a mensagem: **"O hardware pode ser removido com segurança"**.

---

### Passo 5: Remoção Física

Somente após a confirmação do Windows, desconecte o cabo USB/Thunderbolt do dispositivo.

---

## 3. Resolução de Problemas

### Erro: "O dispositivo está em uso"

Se o Windows impedir a ejeção, não force a remoção física. Isso geralmente ocorre por:

- **Serviço ainda ativo**: Repita o comando `net stop`.
- **Explorer aberto**: Verifique se não há janelas do Explorador de Arquivos abertas em pastas do drive H:.
- **Logs pendentes**: Em bancos PostGIS volumosos, o processo de checkpoint pode demorar alguns segundos a mais para gravar tudo no SSD.

---

### O que fazer se o SSD foi removido acidentalmente?

Caso o drive tenha sido desconectado sem estes passos:

- Reconecte o SSD.
- Localize a pasta `data` e verifique se o arquivo `postmaster.pid` ainda existe. Se o serviço não iniciar, pode ser necessário deletar este arquivo manualmente.
- Verifique os logs na pasta `data\pg_log` para assegurar que o PostgreSQL conseguiu realizar a recuperação automática (crash recovery).

---

**Documentação atualizada em:** 22/04/2026
