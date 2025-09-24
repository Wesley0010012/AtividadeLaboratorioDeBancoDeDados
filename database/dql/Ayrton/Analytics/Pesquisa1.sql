WITH VALORES_POR_MES AS (
    SELECT TO_CHAR(c.HCMP_DATA_COMPRA, 'YYYY') AS ANO,
        TO_CHAR(c.HCMP_DATA_COMPRA, 'MM') AS MES,
        i.HITC_PRECO * i.HITC_QUANTIDADE AS VALOR
    FROM H_COMPRA c
        JOIN H_ITEMS_COMPRA i ON c.HCMP_ID = i.HITC_CMP_ID
),
MEDIA_POR_MES AS (
    SELECT ANO,
        MES,
        AVG(VALOR) AS VALOR_MEDIO_MES
    FROM VALORES_POR_MES
    GROUP BY ANO,
        MES
),
MODA_POR_ANO AS (
    SELECT ANO,
        VALOR
    FROM (
            SELECT ANO,
                VALOR,
                COUNT(*) AS QTD,
                RANK() OVER (
                    PARTITION BY ANO
                    ORDER BY COUNT(*) DESC
                ) AS RNK
            FROM VALORES_POR_MES
            GROUP BY ANO,
                VALOR
        )
    WHERE RNK = 1
),
MELHOR_MES AS (
    SELECT ANO,
        MES
    FROM (
            SELECT ANO,
                MES,
                RANK() OVER (
                    PARTITION BY ANO
                    ORDER BY VALOR_MEDIO_MES DESC
                ) AS RNK
            FROM MEDIA_POR_MES
        )
    WHERE RNK = 1
)
SELECT v.ANO,
    AVG(v.VALOR) AS VALOR_MEDIO,
    MEDIAN(v.VALOR) AS VALOR_MEDIANO,
    MAX(m.VALOR) AS VALOR_MODA,
    bm.MES AS MELHOR_MES
FROM VALORES_POR_MES v
    LEFT JOIN MODA_POR_ANO m ON v.ANO = m.ANO
    LEFT JOIN MELHOR_MES bm ON v.ANO = bm.ANO
GROUP BY v.ANO,
    bm.MES
ORDER BY v.ANO;