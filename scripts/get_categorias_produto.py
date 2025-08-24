import csv

categorias_produto_csv_file = "../extracoes/product_category_name_translation.csv"
sql_categorias_produto_file = "../database/dml/inserts_categorias_produto.sql"

categorias = set()

with open(categorias_produto_csv_file, newline="", encoding="utf-8-sig") as f:
    reader = csv.DictReader(f)
    reader.fieldnames = [name.strip() for name in reader.fieldnames]

    for row in reader:
        nome = (row.get("product_category_name") or "").strip().replace("'", "''")
        nome_ingles = (
            (row.get("product_category_name_english") or "").strip().replace("'", "''")
        )

        if nome and nome_ingles:
            categorias.add((nome, nome_ingles))

with open(sql_categorias_produto_file, "w", encoding="utf-8") as f:
    for i, (nome, nome_ingles) in enumerate(sorted(categorias), start=1):
        f.write(
            f"INSERT INTO CATEGORIA_PRODUTO (CTP_ID, CTP_NOME, CTP_NOME_INGLES) "
            f"VALUES ({i}, '{nome}', '{nome_ingles}');\n"
        )
