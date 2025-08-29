import csv

produtos_csv_file = "../extracoes/olist_products_dataset.csv"
sql_produtos_file = "../database/dml/inserts_produtos.sql"

with open(produtos_csv_file, newline="", encoding="utf-8-sig") as f:
    reader = csv.DictReader(f)
    reader.fieldnames = [name.strip() for name in reader.fieldnames]

    with open(sql_produtos_file, "w", encoding="utf-8") as sql_file:
        for i, row in enumerate(reader, start=1):
            prd_id = i
            prd_codigo = row.get("product_id", "").strip().replace('"', "'")
            prd_largura = row.get("product_width_cm", "0").strip()
            prd_profundidade = row.get("product_length_cm", "0").strip()
            prd_preco = "0.00"  # Sem dados de preço no CSV

            sql = (
                f"INSERT INTO PRODUTO (PRD_ID, PRD_CODIGO, PRD_LARGURA, PRD_PROFUNDIDADE, PRD_PRECO) "
                f"VALUES ({prd_id}, '{prd_codigo}', {prd_largura}, {prd_profundidade}, {prd_preco});\n"
            )
            sql_file.write(sql)
