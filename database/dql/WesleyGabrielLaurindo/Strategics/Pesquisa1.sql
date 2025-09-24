-------------------------------------------
--- PESQUISA ESTRATÉGICA DE NÚMERO 1
--- Identificação das categorias com maior
--- número de produtos catalogados no sistema
--- 
--- Objetivo: analisar o portfólio de produtos para
--- definir estratégias de marketing mais eficazes,
--- incluindo promoções, campanhas direcionadas e
--- ações de destaque para categorias com maior
--- potencial de engajamento junto aos clientes.
-------------------------------------------
SELECT ctp.CTP_NOME AS CATEGORIA,
    COUNT(DISTINCT pc.PRC_PRD_ID) AS TOTAL_PRODUTOS
FROM CATEGORIA_PRODUTO ctp
    LEFT JOIN PRODUTO_CATEGORIA pc ON pc.PRC_CTP_ID = ctp.CTP_ID
GROUP BY ctp.CTP_NOME
ORDER BY TOTAL_PRODUTOS DESC;