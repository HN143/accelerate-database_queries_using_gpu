#Biểu đồ cột so sánh các thông số hiệu suất của DuckDB

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Đọc dữ liệu từ file
file_path = "./benchmark_result/benchmark_results.txt"  # Thay đường dẫn file nếu cần
df = pd.read_csv(file_path)

# Lọc dữ liệu chỉ dành cho DuckDB
df_duckdb = df[df["Database"] == "DuckDB"].reset_index(drop=True)

# Xác định số lượng query
query_ids = df_duckdb["QueryID"]
x = np.arange(len(query_ids))  # Vị trí trên trục X

# Định nghĩa các tham số
metrics = ["Execution Time (ms)", "RAM Usage (GB)", "VRAM Usage (GB)", "CPU Usage (%)", "GPU Usage (%)"]
colors = ["blue", "green", "orange", "purple", "red"]
width = 0.15  # Độ rộng của từng cột

# Tạo biểu đồ
fig, ax = plt.subplots(figsize=(16, 6))

# Vẽ từng thông số
for i, metric in enumerate(metrics):
    ax.bar(x + i * width, df_duckdb[metric], width, label=metric, color=colors[i])

# Gắn nhãn
ax.set_xlabel("Query ID")
ax.set_ylabel("Value")
ax.set_title("Performance Metrics for DuckDB")
ax.set_xticks(x + width * 2)  # Dịch nhãn vào giữa nhóm cột
ax.set_xticklabels(query_ids, rotation=90)  # Hiển thị Query ID dọc để dễ nhìn
ax.legend()

# Hiển thị biểu đồ
plt.show()
