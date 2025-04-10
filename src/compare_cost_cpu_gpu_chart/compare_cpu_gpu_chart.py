import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Đọc dữ liệu từ các file CSV
low_cpu = pd.read_csv("compare_table/cpu/low_cpu.csv")
mid_cpu = pd.read_csv("compare_table/cpu/mid_cpu.csv")
high_cpu = pd.read_csv("compare_table/cpu/high_cpu.csv")

low_gpu = pd.read_csv("compare_table/gpu/low_gpu.csv")
mid_gpu = pd.read_csv("compare_table/gpu/mid_gpu.csv")
high_gpu = pd.read_csv("compare_table/gpu/high_gpu.csv")

# Gộp dữ liệu CPU và GPU theo phân khúc
low_data = pd.concat([low_cpu.assign(Type="CPU"), low_gpu.assign(Type="GPU")])
mid_data = pd.concat([mid_cpu.assign(Type="CPU"), mid_gpu.assign(Type="GPU")])
high_data = pd.concat([high_cpu.assign(Type="CPU"), high_gpu.assign(Type="GPU")])

# Thêm cột phân khúc
low_data["Segment"] = "Low"
mid_data["Segment"] = "Mid"
high_data["Segment"] = "High"

# Gộp tất cả dữ liệu
all_data = pd.concat([low_data, mid_data, high_data])

# Xử lý giá trị không hợp lệ trong cột "Giá Mua (VND)" và "Thời Gian Chạy DB Query (giây)"
all_data["Giá Mua (VND)"] = pd.to_numeric(all_data["Giá Mua (VND)"], errors="coerce").fillna(0)
all_data["Thời Gian Chạy DB Query (giây)"] = pd.to_numeric(all_data["Thời Gian Chạy DB Query (giây)"], errors="coerce").fillna(0)

# Vẽ biểu đồ
fig, ax1 = plt.subplots(figsize=(14, 8))

# Trục OX: Các cấu hình (phân khúc + loại CPU/GPU)
x_labels = []
for segment in ["Low", "Mid", "High"]:
    for i in range(1, 5):
        x_labels.append(f"{segment} {i}")

x = np.arange(len(x_labels))  # Tạo vị trí cho các nhãn trên trục OX

# Offset để dịch chuyển các cột CPU và GPU
bar_width = 0.4  # Độ rộng của mỗi cột
x_cpu = x - bar_width / 2  # Dịch cột CPU sang trái
x_gpu = x + bar_width / 2  # Dịch cột GPU sang phải

# Dữ liệu cho cột (Giá mua)
cpu_prices = all_data[all_data["Type"] == "CPU"]["Giá Mua (VND)"].values
gpu_prices = all_data[all_data["Type"] == "GPU"]["Giá Mua (VND)"].values

# Dữ liệu cho đường (Thời gian chạy DB Query)
cpu_query_times = all_data[all_data["Type"] == "CPU"]["Thời Gian Chạy DB Query (giây)"].values
gpu_query_times = all_data[all_data["Type"] == "GPU"]["Thời Gian Chạy DB Query (giây)"].values

# Vẽ cột (Giá mua)
ax1.bar(x_cpu, cpu_prices, bar_width, color="blue", hatch="//", label="Giá Mua (CPU)")
ax1.bar(x_gpu, gpu_prices, bar_width, color="green", label="Giá Mua (GPU)")

# Trục OY thứ hai cho đường (Thời gian chạy DB Query)
ax2 = ax1.twinx()
ax2.plot(x, cpu_query_times, color="black", marker="o", label="Thời Gian Chạy DB Query (CPU)")
ax2.plot(x, gpu_query_times, color="red", marker="o", label="Thời Gian Chạy DB Query (GPU)")

# Cài đặt trục OX
ax1.set_xticks(x)
ax1.set_xticklabels(x_labels, rotation=90)
ax1.set_xlabel("Cấu Hình (Phân Khúc)")

# Cài đặt trục OY
ax1.set_ylabel("Giá Mua (VND)", color="blue")
ax2.set_ylabel("Thời Gian Chạy DB Query (giây)", color="red")

# Thêm tiêu đề và chú thích
plt.title("So sánh giữa CPU và GPU về Thời Gian Truy Vấn và Giá Mua")
ax1.legend(loc="upper left")
ax2.legend(loc="upper right")

# Hiển thị biểu đồ
plt.tight_layout()
plt.show()