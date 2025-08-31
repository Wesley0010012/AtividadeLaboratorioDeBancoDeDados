---------------------------------------
-- SCRIPT MASTER DE CRIAÇÃO DO BANCO
-- Este script executa outros scripts
---------------------------------------

-- Cria tabelas
@/opt/scripts/ddl/structures.sql

-- Inclui comentários
@/opt/scripts/ddl/comments.sql

-- Inclui sequences
@/opt/scripts/ddl/sequences.sql

-- Inclui triggers
@/opt/scripts/ddl/triggers.sql

-- Popula estados
@/opt/scripts/dml/inserts_estados.sql

-- Popula cidades
@/opt/scripts/dml/inserts_cidades.sql

-- Popula ceps
@/opt/scripts/dml/inserts_ceps.sql

-- Popula clientes
@/opt/scripts/dml/inserts_clientes.sql

-- Popula vendedores
@/opt/scripts/dml/inserts_vendedores.sql

-- Popula situacao compra
@/opt/scripts/dml/inserts_situacao_compra.sql

-- Popula tipo pagamento
@/opt/scripts/dml/inserts_tipo_pagamento.sql

-- Popula categorias produto
@/opt/scripts/dml/inserts_categorias_produto.sql

-- Fim
PROMPT Banco de dados recriado com sucesso!