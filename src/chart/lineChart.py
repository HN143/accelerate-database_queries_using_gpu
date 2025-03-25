#Vẽ biểu đồ đường cho từng query, đọc dữ liệu từ các file benchmark và lấy danh sách các QueryID duy nhất từ file đầu tiên so sánh giữa duckdb và heavydb về thời gian thực thi của các query trên các bộ dữ liệu khác nhau. (kết quả sẽ trả về 99 biểu đồ , mỗi biểu đồ trên 1 hình)
# import pandas as pd
# import matplotlib.pyplot as plt
# import numpy as np

# # Đọc dữ liệu từ các file benchmark
# sizes = ["0.5G", "1G", "2G", "5G", "10G", "20G"]
# duckdb_files = [f"benchmark_duckdb_{size}.txt" for size in sizes]
# heavydb_files = [f"benchmark_heavydb_{size}.txt" for size in sizes]

# # Lấy danh sách các QueryID duy nhất từ file đầu tiên
# df_sample = pd.read_csv(duckdb_files[0])
# query_ids = df_sample["QueryID"].unique()

# # Vẽ biểu đồ đường cho từng query
# for query_id in query_ids:
#     duckdb_times = []
#     heavydb_times = []
    
#     for duckdb_file, heavydb_file in zip(duckdb_files, heavydb_files):
#         df_duckdb = pd.read_csv(duckdb_file)
#         df_heavydb = pd.read_csv(heavydb_file)
        
#         duckdb_time = df_duckdb[df_duckdb["QueryID"] == query_id]["Execution Time (ms)"].values[0]
#         heavydb_time = df_heavydb[df_heavydb["QueryID"] == query_id]["Execution Time (ms)"].values[0]
        
#         duckdb_times.append(duckdb_time)
#         heavydb_times.append(heavydb_time)
    
#     plt.figure(figsize=(10, 5))
#     plt.plot(sizes, duckdb_times, marker='o', linestyle='-', label="DuckDB", color='blue')
#     plt.plot(sizes, heavydb_times, marker='o', linestyle='-', label="HeavyDB", color='red')
    
#     plt.xlabel("Dataset Size")
#     plt.ylabel("Execution Time (ms)")
#     plt.title(f"Execution Time Comparison for Query {query_id}")
#     plt.legend()
#     plt.grid()
#     plt.show()


#Vẽ biểu đồ đường cho từng query, đọc dữ liệu từ các file benchmark và lấy danh sách các QueryID duy nhất từ file đầu tiên so sánh giữa duckdb và heavydb về thời gian thực thi của các query trên các bộ dữ liệu khác nhau. (kết quả sẽ trả về 99 biểu đồ trên 1 hình)
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Đọc dữ liệu từ các file benchmark
sizes = ["0.5G", "1G", "2G", "5G", "10G", "20G"]
duckdb_files = [f"./benchmark_result/benchmark_duckdb_{size}.txt" for size in sizes]
heavydb_files = [f"./benchmark_result/benchmark_heavydb_{size}.txt" for size in sizes]

# Lấy danh sách các QueryID duy nhất từ file đầu tiên
df_sample = pd.read_csv(duckdb_files[0])
query_ids = df_sample["QueryID"].unique()

# Xác định số hàng và cột cho biểu đồ
cols = 13  # Số cột
rows = 8   # Số hàng
fig, axes = plt.subplots(rows, cols, figsize=(cols * 20, rows * 20))  # Giảm kích thước mỗi subplot
axes = axes.flatten()

# Vẽ biểu đồ đường cho từng query
for i, query_id in enumerate(query_ids):
    duckdb_times = []
    heavydb_times = []
    
    for duckdb_file, heavydb_file in zip(duckdb_files, heavydb_files):
        df_duckdb = pd.read_csv(duckdb_file)
        df_heavydb = pd.read_csv(heavydb_file)
        
        duckdb_time = df_duckdb[df_duckdb["QueryID"] == query_id]["Execution Time (ms)"].values[0]
        heavydb_time = df_heavydb[df_heavydb["QueryID"] == query_id]["Execution Time (ms)"].values[0]
        
        duckdb_times.append(duckdb_time)
        heavydb_times.append(heavydb_time)
    
    ax = axes[i]
    ax.plot(sizes, duckdb_times, marker='o', markersize=2, linestyle='-', linewidth=0.8, label="DuckDB", color='blue')  # Giảm kích thước marker
    ax.plot(sizes, heavydb_times, marker='s', markersize=2, linestyle='-', linewidth=0.8, label="HeavyDB", color='red')  # Giảm kích thước marker
    
    ax.set_xlabel("Dataset", fontsize=6)
    ax.set_ylabel("Time (ms)", fontsize=6)
    ax.set_title(f"Q{query_id}", fontsize=6)  # Giảm kích thước tiêu đề
    ax.legend(fontsize=5, loc="upper left", frameon=False)  # Giảm kích thước chú thích
    ax.grid(True, linestyle="--", linewidth=0.5)
    ax.tick_params(axis='both', labelsize=5)  # Giảm kích thước nhãn trục
    ax.set_xticklabels(sizes, rotation=45, fontsize=5)  # Xoay nhãn trục x tránh chồng

# Ẩn các ô thừa nếu có
for j in range(i + 1, len(axes)):
    fig.delaxes(axes[j])

# plt.subplots_adjust(hspace=0.2, wspace=0.2)  # Tăng khoảng cách giữa các biểu đồ
plt.tight_layout()

plt.show()
