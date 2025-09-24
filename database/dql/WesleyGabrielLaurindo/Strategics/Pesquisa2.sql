-------------------------------------------
--- PESQUISA ESTRATÉGICA DE NÚMERO 2
--- Análise do volume e valor das transações
--- por tipo de pagamento
---
--- Objetivo: identificar quais métodos de pagamento
--- são mais utilizados e geram maior receita,
--- permitindo otimizar políticas financeiras,
--- ajustar condições de pagamento e direcionar
--- estratégias comerciais para maximizar faturamento.
-------------------------------------------
SELECT tpg.TPG_CATEGORIA AS "TIPO_PAGAMENTO",
        COUNT(tnp.TNP_ID) AS "TOTAL_TRANSACOES",
        TO_CHAR(
                SUM(tnp.TNP_VALOR_PAGO),
                'L999G999G990D99',
                'NLS_CURRENCY=''R$'' NLS_NUMERIC_CHARACTERS='',.'''
        ) AS "TOTAL_RECEITA"
FROM (
                SELECT TNP_ID AS TNP_ID,
                        TNP_VALOR_PAGO AS TNP_VALOR_PAGO,
                        TNP_TPG_ID AS TNP_TPG_ID
                FROM TRANSACOES_PAGAMENTO
        ) tnp
        JOIN (
                SELECT TPG_ID AS TPG_ID,
                        TPG_CATEGORIA AS TPG_CATEGORIA
                FROM TIPO_PAGAMENTO
        ) tpg ON tpg.TPG_ID = tnp.TNP_TPG_ID
GROUP BY tpg.TPG_CATEGORIA
ORDER BY SUM(tnp.TNP_VALOR_PAGO) DESC;