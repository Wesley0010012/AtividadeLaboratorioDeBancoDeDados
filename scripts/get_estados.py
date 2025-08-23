import csv

sellers_csv_file = "../extracoes/olist_sellers_dataset.csv"
clients_csv_file = "../extracoes/olist_customers_dataset.csv"

estados = set()

with open(sellers_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)

    for row in reader:
        estado = row["seller_state"].strip().replace("'", "''")
        estados.add(estado)

with open(clients_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)

    for row in reader:
        estado = row["customer_state"].strip().replace("'", "''")
        estados.add(estado)

with open("../database/dml/inserts_estados.sql", "w", encoding="utf-8") as f:
    for i, estado in enumerate(sorted(estados), start=1):
        f.write(f"INSERT INTO ESTADO (ETD_ID, ETD_NOME) VALUES ({i}, '{estado}');\n")

print("Geração de estados concluída")
