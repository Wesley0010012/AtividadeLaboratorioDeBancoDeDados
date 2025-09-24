-------------------------------------------
--- PESQUISA ANALÍTICA DE NÚMERO 1
--- Análise mensal da satisfação dos clientes
--- com base nas avaliações de compras
---
--- Objetivo: monitorar a média de satisfação e o
--- volume de avaliações ao longo do tempo, tanto
--- para dados atuais quanto históricos, permitindo
--- identificar tendências, períodos críticos e
--- oportunidades de melhoria no atendimento e
--- na experiência do cliente.
-------------------------------------------
SELECT TO_CHAR(ac.ALC_DATA_HORA_CRIACAO, 'YYYY-MM') AS PERIODO,
    ROUND(AVG(ac.ALC_SCORE), 2) AS MEDIA_SATISFACAO,
    COUNT(ac.ALC_ID) AS TOTAL_AVALIACOES
FROM AVALIACAO_COMPRA ac
GROUP BY TO_CHAR(ac.ALC_DATA_HORA_CRIACAO, 'YYYY-MM')
UNION ALL
SELECT TO_CHAR(hac.HALC_DATA_HORA_CRIACAO, 'YYYY-MM') AS PERIODO,
    ROUND(AVG(hac.HALC_SCORE), 2) AS MEDIA_SATISFACAO,
    COUNT(hac.HALC_ID) AS TOTAL_AVALIACOES
FROM H_AVALIACAO_COMPRA hac
GROUP BY TO_CHAR(hac.HALC_DATA_HORA_CRIACAO, 'YYYY-MM')
ORDER BY PERIODO;