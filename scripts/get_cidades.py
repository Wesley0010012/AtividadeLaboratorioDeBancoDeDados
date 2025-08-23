import csv

sellers_csv_file = "../extracoes/olist_sellers_dataset.csv"
clients_csv_file = "../extracoes/olist_customers_dataset.csv"

cidades = set()
with open(sellers_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        cidade = row["seller_city"].strip().replace("'", "''")
        estado = row["seller_state"].strip().replace("'", "''")
        cidades.add((cidade, estado))

with open(clients_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        cidade = row["customer_city"].strip().replace("'", "''")
        estado = row["customer_state"].strip().replace("'", "''")
        cidades.add((cidade, estado))

with open("../database/dml/inserts_cidades.sql", "w", encoding="utf-8") as f:
    for i, (cidade, estado) in enumerate(sorted(cidades), start=1):
        f.write(
            f"INSERT INTO CIDADE (CDD_ID, CDD_NOME, CDD_ETD_ID) "
            f"VALUES ({i}, '{cidade}', (SELECT ETD_ID FROM ESTADO WHERE ETD_NOME = '{estado}'));\n"
        )

print("Geração de cidades concluída")
