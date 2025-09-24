-------------------------------------------
--- PESQUISA ESTRATÉGICA DE NÚMERO 1
--- Identificar as categorias que mais
--- tem produtos catalogados no Sistema
--- Objetivo: gerar estratégias de marketing
--- direcionado à estes clientes com produtos
--- mais chamativos, assim como promoções
-------------------------------------------
SELECT ctp.CTP_NOME AS CATEGORIA,
    COUNT(DISTINCT pc.PRC_PRD_ID) AS TOTAL_PRODUTOS
FROM CATEGORIA_PRODUTO ctp
    LEFT JOIN PRODUTO_CATEGORIA pc ON pc.PRC_CTP_ID = ctp.CTP_ID
GROUP BY ctp.CTP_NOME
ORDER BY TOTAL_PRODUTOS DESC;