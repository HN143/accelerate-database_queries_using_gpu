import duckdb
import os

# Connect to the DuckDB database
conn = duckdb.connect("db.duckdb")

# Install the TPCDS extension
conn.execute("INSTALL tpcds")
conn.execute("LOAD tpcds")

for i in [0, 1, 5, 10, 20]:
    # Drop all tables to ensure a clean slate
    tables = conn.execute(
        "SELECT table_name FROM information_schema.tables WHERE table_schema = 'main';"
    ).fetchall()

    for (table_name,) in tables:
        conn.execute(f"DROP TABLE IF EXISTS {table_name}")

    # Generate TPC-DS data at scale factor i
    conn.execute(f"CALL dsdgen(sf = {i})")

    if i == 0:
        # Export the entire database schema and data to a temporary directory
        temp_directory = os.path.join("temp_export")
        os.makedirs(temp_directory, exist_ok=True)
        conn.execute(f"EXPORT DATABASE '{temp_directory}';")
        print(f"Exported database to temporary folder: {temp_directory}")

        # Copy only the schema.sql file to the destination folder
        target_directory = os.path.join("results")
        os.makedirs(target_directory, exist_ok=True)
        schema_file = os.path.join(temp_directory, "schema.sql")
        if os.path.exists(schema_file):
            destination_file = os.path.join(target_directory, "schema.sql")
            with open(schema_file, "r") as src, open(destination_file, "w") as dst:
                dst.write(src.read())
            print(f"Copied schema.sql to {destination_file}")
        else:
            print("schema.sql not found in temporary folder")

        # Clean up the temporary directory
        for root, dirs, files in os.walk(temp_directory, topdown=False):
            for name in files:
                os.remove(os.path.join(root, name))
            for name in dirs:
                os.rmdir(os.path.join(root, name))
        os.rmdir(temp_directory)

        continue

    # Get the list of all tables
    tables = conn.execute(
        "SELECT table_name FROM information_schema.tables WHERE table_schema = 'main';"
    ).fetchall()

    # Create a subfolder for the current scale factor
    subfolder = f"results/data/sf_{i}"
    os.makedirs(subfolder, exist_ok=True)

    # Export each table to a CSV file in the subfolder
    for (table_name,) in tables:
        csv_file = os.path.join(subfolder, f"{table_name}.csv")
        query = f"COPY {table_name} TO '{csv_file}' (HEADER, DELIMITER ',');"
        conn.execute(query)
        print(f"Exported {table_name} to {csv_file}")

# Close the connection
conn.close()
