---------------------------------------
-- RELAÇÕES
-- Define as entidades do minimundo
---------------------------------------
-- RELACAO CEP
CREATE TABLE CEP (
    CEP_ID NUMBER (9),
    CEP_LATITUDE NUMBER (9, 6),
    CEP_LONGITUDE NUMBER (9, 6),
    CEP_CDD_ID NUMBER (4)
) LOGGING;
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