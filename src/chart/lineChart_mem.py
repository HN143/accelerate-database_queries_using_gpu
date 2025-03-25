#Biểu đồ đường so sánh thông số về memory của DuckDB và HeavyDB trên từng bộ dữ liệu (1G, 10G, 100G)
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Các bộ dữ liệu cần vẽ biểu đồ
sizes = ["1G", "10G", "100G"]

def plot_benchmark(size):
    # Đọc dữ liệu từ các file benchmark
    duckdb_file = f"./benchmark_result/benchmark_duckdb_{size}.txt"
    heavydb_file = f"./benchmark_result/benchmark_heavydb_{size}.txt"
    
    df_duckdb = pd.read_csv(duckdb_file)
    df_heavydb = pd.read_csv(heavydb_file)
    
    query_ids = df_duckdb["QueryID"].unique()
    
    duckdb_times = df_duckdb["RAM Usage (GB)"].values
    heavydb_times = df_heavydb["RAM Usage (GB)"].values
    
    # Vẽ biểu đồ
    plt.figure(figsize=(12, 8))
    plt.plot(query_ids, duckdb_times, marker='o', linestyle='-', label="DuckDB", color='blue', markersize=3)
    plt.plot(query_ids, heavydb_times, marker='s', linestyle='-', label="HeavyDB", color='red', markersize=3)
    
    plt.xlabel("Query ID", fontsize=5)
    plt.ylabel("RAM Usage (GB)", fontsize=10)
    plt.title(f"Benchmark Comparison for {size}", fontsize=12)
    plt.legend(fontsize=8)
    plt.grid()
    plt.tick_params(axis='both', labelsize=8)
    
    plt.xticks(rotation=90)  #xoay nhãn 90 độ
    plt.show()

# Vẽ 3 biểu đồ cho 3 bộ dữ liệu
for size in sizes:
    plot_benchmark(size)
