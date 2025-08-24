import csv

orders_csv_file = "../extracoes/olist_orders_dataset.csv"
sql_situacao_compra_file = "../database/dml/inserts_situacao_compra.sql"

situacoes = set()

with open(orders_csv_file, newline="", encoding="utf-8-sig") as f:
    reader = csv.DictReader(f)
    reader.fieldnames = [name.strip() for name in reader.fieldnames]

    for row in reader:
        status = (row.get("order_status") or "").strip().replace("'", "''")
        if status:
            situacoes.add(status)


with open(sql_situacao_compra_file, "w", encoding="utf-8") as f:
    for i, status in enumerate(sorted(situacoes), start=1):
        f.write(
            f"INSERT INTO SITUACAO_COMPRA (STC_ID, STC_STATUS) VALUES ({i}, '{status}');\n"
        )
