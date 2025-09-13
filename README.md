# AtividadeLaboratorioDeBancoDeDados

Atividade para nota final de Laboratório de Banco de Dados

# Como criar um usuário em container

- Entre no container do database:

```sh
docker exec -it oracle21c-labdb sqlplus / as sysdba
```

- Execute o script de usuário padrão:

```SQL
@/opt/scripts/users/default-user.sql;
```

- Connect com o novo usuário criado:

```sh
docker exec -it oracle21c-labdb sqlplus meu_usuario/minha_senha@//localhost:1521/ORCLPDB1
```
