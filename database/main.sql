---------------------------------------
-- SCRIPT MASTER DE CRIAÇÃO DO BANCO
-- Este script executa outros scripts
---------------------------------------

-- Cria tabelas
@/opt/scripts/ddl/structures.sql

-- Inclui comentários
@/opt/scripts/ddl/comments.sql

-- Popula estados
@/opt/scripts/dml/inserts_estados.sql

-- Popula cidades
@/opt/scripts/dml/inserts_cidades.sql

-- Fim
PROMPT Banco de dados recriado com sucesso!