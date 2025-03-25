#Tạo các file benchmark giả lập cho HeavyDB
import pandas as pd
import numpy as np

# Danh sách kích thước dữ liệu
data_sizes = ["0.5G", "1G", "2G", "5G", "10G", "20G", "50G", "100G"]
num_queries = 99  # Số lượng câu query

# Tạo dữ liệu benchmark giả lập cho HeavyDB
for size in data_sizes:
    file_name = f"./benchmark_result/benchmark_heavydb_{size}.txt"
    data = {
        "QueryID": [f"Q{i+1}" for i in range(num_queries)],
        "Database": ["HeavyDB"] * num_queries,
        "Execution Time (ms)": np.random.uniform(50, 1200, num_queries).round(2),
        "RAM Usage (GB)": np.random.uniform(0.5, 8, num_queries).round(2),
        "VRAM Usage (GB)": np.random.uniform(1, 6, num_queries).round(2),
        "CPU Usage (%)": np.random.uniform(5, 50, num_queries).round(2),
        "GPU Usage (%)": np.random.uniform(30, 90, num_queries).round(2),
    }

    # Chuyển thành DataFrame
    df = pd.DataFrame(data)

    # Lưu vào file txt
    df.to_csv(file_name, index=False)
    print(f"Đã tạo file {file_name}")
