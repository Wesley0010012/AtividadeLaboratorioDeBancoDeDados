-------------------------------------------
--- PESQUISA ANALÍTICA DE NÚMERO 3
--- Análise do prazo médio de entrega por mês
---
--- Objetivo: monitorar a eficiência do processo de
--- entrega, considerando compras atuais e históricas,
--- permitindo identificar tendências, atrasos recorrentes
--- e oportunidades de melhoria na logística e satisfação
--- do cliente.
-------------------------------------------
WITH prazos AS (
    SELECT TRUNC(CMP_DATA_COMPRA, 'MM') AS mes,
        CMP_ENTREGA__PREVISTA - CMP_DATA_COMPRA AS prazo
    FROM COMPRA
    UNION ALL
    SELECT TRUNC(HCMP_DATA_COMPRA, 'MM') AS mes,
        HCMP_ENTREGA__PREVISTA - HCMP_DATA_COMPRA AS prazo
    FROM H_COMPRA
)
SELECT mes,
    ROUND(AVG(prazo), 2) AS prazo_medio_dias
FROM prazos
GROUP BY mes
ORDER BY mes;