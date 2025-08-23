---------------------------------------
-- RELAÇÕES
-- Define as entidades do minimundo
---------------------------------------
-- RELACAO CIDADE
CREATE TABLE CIDADE (
    CDD_ID NUMBER (4),
    CDD_NOME VARCHAR2 (40 CHAR),
    CDD_ETD_ID NUMBER (2)
) LOGGING;
-- RELACAO ESTADO
CREATE TABLE ESTADO (
    ETD_ID NUMBER (2),
    ETD_NOME VARCHAR2 (25)
) LOGGING;