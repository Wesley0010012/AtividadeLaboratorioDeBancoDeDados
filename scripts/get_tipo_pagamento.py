import csv

pagamentos_csv_file = "../extracoes/olist_order_payments_dataset.csv"
sql_tipo_pagamento_file = "../database/dml/inserts_tipo_pagamento.sql"

tipos_pagamento = set()

with open(pagamentos_csv_file, newline="", encoding="utf-8-sig") as f:
    reader = csv.DictReader(f)
    reader.fieldnames = [name.strip() for name in reader.fieldnames]

    for row in reader:
        tipo = (row.get("payment_type") or "").strip().replace("'", "''")
        if tipo:
            tipos_pagamento.add(tipo)

with open(sql_tipo_pagamento_file, "w", encoding="utf-8") as f:
    for i, tipo in enumerate(sorted(tipos_pagamento), start=1):
        f.write(
            f"INSERT INTO TIPO_PAGAMENTO (TPG_ID, TPG_CATEGORIA) VALUES ({i}, '{tipo}');\n"
        )
