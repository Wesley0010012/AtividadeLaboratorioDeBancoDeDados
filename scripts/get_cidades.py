import csv

sellers_csv_file = "../extracoes/olist_sellers_dataset.csv"
clients_csv_file = "../extracoes/olist_customers_dataset.csv"
geolocation_csv_file = "../extracoes/olist_geolocation_dataset.csv"
sql_cidades_file = "../database/dml/inserts_cidades.sql"

cidades = set()
for file, city_column, state_column in [
    (sellers_csv_file, "seller_city", "seller_state"),
    (clients_csv_file, "customer_city", "customer_state")
]:
    with open(file, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            cidade = row[city_column].strip().replace("'", "''")
            estado = row[state_column].strip().replace("'", "''")
            cidades.add((cidade, estado))

with open(geolocation_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        cidade = row["geolocation_city"].strip().replace("'", "''")
        estado = row["geolocation_state"].strip().replace("'", "''")
        cidades.add((cidade, estado))

with open(sql_cidades_file, "w", encoding="utf-8") as f:
    for i, (cidade, estado) in enumerate(sorted(cidades), start=1):
        f.write(
            f"INSERT INTO CIDADE (CDD_ID, CDD_NOME, CDD_ETD_ID) "
            f"VALUES ({i}, '{cidade}', (SELECT ETD_ID FROM ESTADO WHERE ETD_NOME = '{estado}'));\n"
        )
