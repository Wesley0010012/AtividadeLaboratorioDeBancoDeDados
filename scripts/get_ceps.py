import csv
import unicodedata

geolocation_csv_file = "../extracoes/olist_geolocation_dataset.csv"
sql_cidades_file = "../database/dml/inserts_cidades.sql"
sql_ceps_file = "../database/dml/inserts_ceps.sql"

def remove_acentos(texto):
    if not texto:
        return ""
    return "".join(
        c for c in unicodedata.normalize("NFD", texto)
        if unicodedata.category(c) != "Mn"
    )

cidade_dict = {}
with open(sql_cidades_file, newline="", encoding="utf-8") as f:
    for line in f:
        if line.strip().upper().startswith("INSERT INTO CIDADE"):
            parts = line.split("VALUES")[1].strip().strip("();").split(",")
            cdd_id = int(parts[0].strip())
            cdd_nome = parts[1].strip().strip("'").replace("''", "'")
            cdd_nome_normalizado = remove_acentos(cdd_nome).strip().upper()
            cidade_dict[cdd_nome_normalizado] = cdd_id

unique_ceps = set()
with open(geolocation_csv_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    with open(sql_ceps_file, "w", encoding="utf-8") as sql_out:
        for row in reader:
            cep = row["geolocation_zip_code_prefix"].strip()
            lat = row["geolocation_lat"].strip()
            lng = row["geolocation_lng"].strip()
            cidade = row["geolocation_city"].split(",")[0].strip()
            cidade_normalizada = remove_acentos(cidade).strip().upper()

            key = (cep, lat, lng)
            if key in unique_ceps:
                continue
            unique_ceps.add(key)

            cdd_id = cidade_dict.get(cidade_normalizada)
            if not cdd_id:
                print(f"[AVISO] Cidade não encontrada: {cidade} ({row['geolocation_state']})")
                continue

            sql_out.write(
                f"INSERT INTO CEP (CEP_ID, CEP_LATITUDE, CEP_LONGITUDE, CEP_CDD_ID) "
                f"VALUES ({cep}, {lat}, {lng}, {cdd_id});\n"
            )
