import csv

vendedores_csv_file = "../extracoes/olist_sellers_dataset.csv"
sql_ceps_file = "../database/dml/inserts_ceps.sql"
sql_vendedores_file = "../database/dml/inserts_vendedores.sql"

cep_dict = {}
with open(sql_ceps_file, newline="", encoding="utf-8") as f:
    for line in f:
        if line.strip().upper().startswith("INSERT INTO CEP"):
            parts = line.split("VALUES")[1].strip().strip("();").split(",")
            cep = parts[0].strip()
            cep_dict[cep] = int(cep)

unique_vendedores = set()
vdd_index = 1

with open(vendedores_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    with open(sql_vendedores_file, "w", encoding="utf-8") as sql_out:
        for row in reader:
            assinatura = row["seller_id"].strip().replace("'", "''")
            cep = row["seller_zip_code_prefix"].strip()

            key = (assinatura, cep)
            if key in unique_vendedores:
                continue
            unique_vendedores.add(key)

            vdd_cep_id = cep_dict.get(cep)
            if not vdd_cep_id:
                print(f"[AVISO] CEP não encontrado para vendedor {assinatura}: {cep}")
                continue

            sql_out.write(
                f"INSERT INTO VENDEDOR (VDD_ID, VDD_ASSINATURA, VDD_CEP_ID) "
                f"VALUES ({vdd_index}, '{assinatura}', {vdd_cep_id});\n"
            )
            vdd_index += 1
