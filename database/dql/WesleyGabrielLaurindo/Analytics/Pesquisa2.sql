-------------------------------------------
--- PESQUISA ANALÍTICA DE NÚMERO 2
--- Análise de variação de vendas por produto
---
--- Objetivo: identificar produtos com maior volatilidade
--- nas vendas ao longo do tempo, considerando dados
--- atuais e históricos, permitindo detectar tendências,
--- sazonalidades, oportunidades de promoção e ajustes
--- de estoque para otimizar o desempenho comercial.
-------------------------------------------
WITH vendas AS (
    SELECT i.ITC_PRD_ID AS PRODUTO_ID,
        TO_CHAR(c.CMP_DATA_COMPRA, 'YYYY-MM') AS MES,
        SUM(i.ITC_QUANTIDADE) AS QTDE_VENDIDA
    FROM COMPRA c
        JOIN ITEMS_COMPRA i ON c.CMP_ID = i.ITC_CMP_ID
    GROUP BY i.ITC_PRD_ID,
        TO_CHAR(c.CMP_DATA_COMPRA, 'YYYY-MM')
    UNION ALL
    SELECT hi.HITC_PRD_ID AS PRODUTO_ID,
        TO_CHAR(hc.HCMP_DATA_COMPRA, 'YYYY-MM') AS MES,
        SUM(hi.HITC_QUANTIDADE) AS QTDE_VENDIDA
    FROM H_COMPRA hc
        JOIN H_ITEMS_COMPRA hi ON hc.HCMP_ID = hi.HITC_CMP_ID
    GROUP BY hi.HITC_PRD_ID,
        TO_CHAR(hc.HCMP_DATA_COMPRA, 'YYYY-MM')
)
SELECT PRODUTO_ID,
    MIN(QTDE_VENDIDA) AS MIN_VENDAS,
    MAX(QTDE_VENDIDA) AS MAX_VENDAS,
    MAX(QTDE_VENDIDA) - MIN(QTDE_VENDIDA) AS VARIACAO
FROM vendas
GROUP BY PRODUTO_ID
HAVING MAX(QTDE_VENDIDA) > MIN(QTDE_VENDIDA)
ORDER BY VARIACAO DESC;