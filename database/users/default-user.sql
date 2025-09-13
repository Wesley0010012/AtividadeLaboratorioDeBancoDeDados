---------------------------------------
-- USUÁRIOS
-- Usuário de teste
---------------------------------------
CREATE USER meu_usuario IDENTIFIED BY minha_senha DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp QUOTA UNLIMITED ON users;
GRANT CONNECT,
    RESOURCE TO meu_usuario;