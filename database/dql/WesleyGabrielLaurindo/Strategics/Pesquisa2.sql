SELECT tpg.TPG_CATEGORIA AS "TIPO_PAGAMENTO",
        COUNT(tnp.TNP_ID) AS "TOTAL_TRANSACOES",
        SUM(tnp.TNP_VALOR_PAGO) AS "TOTAL_RECEITA"
FROM (
                SELECT TNP_ID AS TNP_ID,
                        TNP_VALOR_PAGO AS TNP_VALOR_PAGO,
                        TNP_TPG_ID AS TNP_TPG_ID
                FROM TRANSACOES_PAGAMENTO
                UNION ALL
                SELECT HTNP_ID AS TNP_ID,
                        HTNP_VALOR_PAGO AS TNP_VALOR_PAGO,
                        HTNP_TPG_ID AS TNP_TPG_ID
                FROM H_TRANSACOES_PAGAMENTO
        ) tnp
        JOIN (
                SELECT TPG_ID AS TPG_ID,
                        TPG_CATEGORIA AS TPG_CATEGORIA
                FROM TIPO_PAGAMENTO
                UNION ALL
                SELECT HTPG_ID AS TPG_ID,
                        HTPG_CATEGORIA AS TPG_CATEGORIA
                FROM H_TIPO_PAGAMENTO
        ) tpg ON tpg.TPG_ID = tnp.TNP_TPG_ID
GROUP BY tpg.TPG_CATEGORIA
ORDER BY "TOTAL_RECEITA" DESC;