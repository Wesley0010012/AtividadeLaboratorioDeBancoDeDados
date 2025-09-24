-------------------------------------------
--- PESQUISA ESTRATÉGICA DE NÚMERO 1
--- Identificar os 100 clientes que mais 
--- gastaram no Sistema atualmente
--- Objetivo: gerar estratégias de marketing
--- direcionado à estes clientes com produtos
--- mais chamativos, assim como promoções
-------------------------------------------
SELECT cli.CLI_ASSINATURA AS "CLIENTE",
        SUM(itc.ITC_QUANTIDADE * itc.ITC_PRECO) AS "TOTAL_GASTO"
FROM (
                SELECT CMP_ID AS CMP_ID,
                        CMP_CLI_ID AS CMP_CLI_ID
                FROM COMPRA
        ) cmp
        JOIN (
                SELECT CLI_ID AS CLI_ID,
                        CLI_ASSINATURA AS CLI_ASSINATURA
                FROM CLIENTE
        ) cli ON cli.CLI_ID = cmp.CMP_CLI_ID
        JOIN (
                SELECT ITC_CMP_ID AS ITC_CMP_ID,
                        ITC_QUANTIDADE AS ITC_QUANTIDADE,
                        ITC_PRECO AS ITC_PRECO
                FROM ITEMS_COMPRA
        ) itc ON itc.ITC_CMP_ID = cmp.CMP_ID
GROUP BY cli.CLI_ASSINATURA
ORDER BY "TOTAL_GASTO" DESC
FETCH FIRST 100 ROWS ONLY;