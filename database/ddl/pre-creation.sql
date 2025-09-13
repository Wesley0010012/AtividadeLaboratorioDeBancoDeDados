---------------------------------------
-- SCRIPT DE PRÉ-CRIAÇÃO DE ESTRUTURAS
-- Este script executa a criação base de relações do minimundo
---------------------------------------
-- Cria tabelas
@/opt/scripts/ddl/structures.sql;

-- Inclui comentários
@/opt/scripts/ddl/comments.sql;

-- Inclui sequences
@/opt/scripts/ddl/sequences.sql;

-- Inclui triggers
@/opt/scripts/ddl/triggers.sql;

-- Inclui tabelas historiamento
@/opt/scripts/ddl/history.sql;

-- Inclui triggers historiamento
@/opt/scripts/ddl/history-triggers.sql;
