-------------------------------------------
--- PESQUISA ANALÍTICA DE NÚMERO 1
--- Identificar os 100 clientes que menos 
--- gastaram no Sistema atualmente
--- Objetivo: gerar estratégias de marketing
--- direcionado à fidelização destes clientes
-------------------------------------------
SELECT cli.CLI_ASSINATURA AS "CLIENTE",
    SUM(itc.ITC_QUANTIDADE * itc.ITC_PRECO) AS "TOTAL_GASTO"
FROM (
        SELECT CMP_ID AS CMP_ID,
            CMP_CLI_ID AS CMP_CLI_ID
        FROM COMPRA
        UNION ALL
        SELECT HCMP_ID AS CMP_ID,
            HCMP_CLI_ID AS CMP_CLI_ID
        FROM H_COMPRA
    ) cmp
    JOIN (
        SELECT CLI_ID AS CLI_ID,
            CLI_ASSINATURA AS CLI_ASSINATURA
        FROM CLIENTE
        UNION ALL
        SELECT HCLI_ID AS CLI_ID,
            HCLI_ASSINATURA AS CLI_ASSINATURA
        FROM H_CLIENTE
    ) cli ON cli.CLI_ID = cmp.CMP_CLI_ID
    JOIN (
        SELECT ITC_CMP_ID AS ITC_CMP_ID,
            ITC_QUANTIDADE AS ITC_QUANTIDADE,
            ITC_PRECO AS ITC_PRECO
        FROM ITEMS_COMPRA
        UNION ALL
        SELECT HITC_CMP_ID AS ITC_CMP_ID,
            HITC_QUANTIDADE AS ITC_QUANTIDADE,
            HITC_PRECO AS ITC_PRECO
        FROM H_ITEMS_COMPRA
    ) itc ON itc.ITC_CMP_ID = cmp.CMP_ID
GROUP BY cli.CLI_ASSINATURA
ORDER BY "TOTAL_GASTO" ASC
FETCH FIRST 100 ROWS ONLY;