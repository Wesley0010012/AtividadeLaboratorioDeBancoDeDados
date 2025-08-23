import csv

sellers_csv_file = "../extracoes/olist_sellers_dataset.csv"
clients_csv_file = "../extracoes/olist_customers_dataset.csv"
geolocation_csv_file = "../extracoes/olist_geolocation_dataset.csv"
sql_estados_file = "../database/dml/inserts_estados.sql"

estados = set()
for file, state_column in [(sellers_csv_file, "seller_state"), (clients_csv_file, "customer_state")]:
    with open(file, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            estado = row[state_column].strip().replace("'", "''")
            estados.add(estado)

with open(geolocation_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        estado = row["geolocation_state"].strip().replace("'", "''")
        estados.add(estado)

with open(sql_estados_file, "w", encoding="utf-8") as f:
    for i, estado in enumerate(sorted(estados), start=1):
        f.write(f"INSERT INTO ESTADO (ETD_ID, ETD_NOME) VALUES ({i}, '{estado}');\n")
