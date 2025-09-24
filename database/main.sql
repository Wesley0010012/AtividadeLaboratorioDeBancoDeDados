---------------------------------------
-- SCRIPT MASTER DE CRIAÇÃO DO BANCO
-- Este script executa outros scripts
---------------------------------------

-- PRÉ-CRIAÇÃO
@/opt/scrips/ddl/pre-creation.sql;

-- MIGRATIONS
@/opt/scripts/dml/migrations.sql;

-- PÓS-CRIAÇÃO
@/opt/scripts/ddl/post-creation.sql;

-- Fim
PROMPT Banco de dados recriado com sucesso!