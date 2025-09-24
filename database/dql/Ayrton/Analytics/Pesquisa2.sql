WITH todas_compras AS (
    SELECT cid.CDD_ID,
        cid.CDD_NOME,
        cmp.CMP_ID AS compra_id,
        itc.ITC_QUANTIDADE AS quantidade,
        itc.ITC_PRECO AS preco
    FROM COMPRA cmp
        JOIN CLIENTE cli ON cmp.CMP_CLI_ID = cli.CLI_ID
        JOIN CEP cep ON cli.CLI_CEP_ID = cep.CEP_ID
        JOIN CIDADE cid ON cep.CEP_CDD_ID = cid.CDD_ID
        JOIN ITEMS_COMPRA itc ON cmp.CMP_ID = itc.ITC_CMP_ID
    UNION ALL
    SELECT hcid.HCDD_ID AS CDD_ID,
        hcid.HCDD_NOME AS CDD_NOME,
        hc.HCMP_ID AS compra_id,
        hitc.HITC_QUANTIDADE AS quantidade,
        hitc.HITC_PRECO AS preco
    FROM H_COMPRA hc
        JOIN H_CLIENTE hcli ON hc.HCMP_CLI_ID = hcli.HCLI_ID
        JOIN H_CEP hcep ON hcli.HCLI_CEP_ID = hcep.HCEP_ID
        JOIN H_CIDADE hcid ON hcep.HCEP_CDD_ID = hcid.HCDD_ID
        JOIN H_ITEMS_COMPRA hitc ON hc.HCMP_ID = hitc.HITC_CMP_ID
)
SELECT CDD_ID,
    CDD_NOME,
    COUNT(DISTINCT compra_id) AS total_compras,
    SUM(quantidade) AS total_itens,
    SUM(quantidade * preco) AS faturamento_total,
    ROUND(
        SUM(quantidade * preco) / COUNT(DISTINCT compra_id),
        2
    ) AS ticket_medio
FROM todas_compras
GROUP BY CDD_ID,
    CDD_NOME
ORDER BY faturamento_total DESC
FETCH FIRST 3 ROWS ONLY;