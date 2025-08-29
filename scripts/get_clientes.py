import csv

clientes_csv_file = "../extracoes/olist_customers_dataset.csv"
sql_ceps_file = "../database/dml/inserts_ceps.sql"
sql_clientes_file = "../database/dml/inserts_clientes.sql"


cep_dict = {}
with open(sql_ceps_file, newline="", encoding="utf-8") as f:
    for line in f:
        if line.strip().upper().startswith("INSERT INTO CEP"):
            parts = line.split("VALUES")[1].strip().strip("();").split(",")
            cep = parts[0].strip()
            cep_dict[cep] = int(cep)

unique_clientes = set()
cli_index = 1

with open(clientes_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    with open(sql_clientes_file, "w", encoding="utf-8") as sql_out:
        for row in reader:
            assinatura = row["customer_unique_id"].strip().replace("'", "''")
            cep = row["customer_zip_code_prefix"].strip()

            key = (assinatura, cep)
            if key in unique_clientes:
                continue
            unique_clientes.add(key)

            cli_cep_id = cep_dict.get(cep)
            if not cli_cep_id:
                print(f"[AVISO] CEP não encontrado para cliente {assinatura}: {cep}")
                continue

            sql_out.write(
                f"INSERT INTO CLIENTE (CLI_ID, CLI_ASSINATURA, CLI_CEP_ID) "
                f"VALUES ({cli_index}, '{assinatura}', {cli_cep_id});\n"
            )
            cli_index += 1
