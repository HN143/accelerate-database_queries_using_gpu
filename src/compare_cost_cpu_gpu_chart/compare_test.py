#Thực hiện việc so sánh mức tiêu thụ điện năng (W) và thời gian chạy truy vấn (giây) giữa GPU và CPU trong các phân khúc Thấp, Trung Bình, và Cao. Dữ liệu được lấy từ các file CSV, xử lý và hiển thị trên một biểu đồ kết hợp (biểu đồ cột và biểu đồ đường).

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Hàm tính chi phí điện năng
def calculate_energy_cost(power_watt, hours_per_month=720, electricity_price=2000):
    total_kwh = (power_watt * hours_per_month) / 1000
    return total_kwh * electricity_price

# Hàm tính tổng chi phí sau 1 năm
def calculate_total_cost(row, months=12):
    initial_cost = row["Giá Mua (VND)"]
    energy_cost = calculate_energy_cost(row["Mức Tiêu Thụ Điện Năng (W)"]) * months
    return initial_cost + energy_cost

# Đọc dữ liệu từ các file CSV
low_cpu = pd.read_csv("compare_table/cpu/low_cpu.csv")
mid_cpu = pd.read_csv("compare_table/cpu/mid_cpu.csv")
high_cpu = pd.read_csv("compare_table/cpu/high_cpu.csv")

low_gpu = pd.read_csv("compare_table/gpu/low_gpu.csv")
mid_gpu = pd.read_csv("compare_table/gpu/mid_gpu.csv")
high_gpu = pd.read_csv("compare_table/gpu/high_gpu.csv")

# Lấy Cấu Hình 1 làm đại diện cho mỗi phân khúc
low_cpu = low_cpu[low_cpu["Cấu Hình"] == "Cấu Hình 1"]
mid_cpu = mid_cpu[mid_cpu["Cấu Hình"] == "Cấu Hình 1"]
high_cpu = high_cpu[high_cpu["Cấu Hình"] == "Cấu Hình 1"]

low_gpu = low_gpu[low_gpu["Cấu Hình"] == "Cấu Hình 1"]
mid_gpu = mid_gpu[mid_gpu["Cấu Hình"] == "Cấu Hình 1"]
high_gpu = high_gpu[high_gpu["Cấu Hình"] == "Cấu Hình 1"]

# Tính chi phí điện năng và tổng chi phí sau 1 năm
for df in [low_cpu, mid_cpu, high_cpu, low_gpu, mid_gpu, high_gpu]:
    df["Chi Phí Điện Năng (VND/tháng)"] = df.apply(lambda row: calculate_energy_cost(row["Mức Tiêu Thụ Điện Năng (W)"]), axis=1)
    df["Tổng Chi Phí Sau 1 Năm (VND)"] = df.apply(lambda row: calculate_total_cost(row, months=12), axis=1)

# Gộp dữ liệu CPU và GPU
data = pd.concat([
    low_cpu.assign(Segment="Low", Type="CPU"),
    mid_cpu.assign(Segment="Mid", Type="CPU"),
    high_cpu.assign(Segment="High", Type="CPU"),
    low_gpu.assign(Segment="Low", Type="GPU"),
    mid_gpu.assign(Segment="Mid", Type="GPU"),
    high_gpu.assign(Segment="High", Type="GPU")
])

# Vẽ hai biểu đồ cột: Chi phí ban đầu và Chi phí sau 1 năm
def plot_separate_charts(data):
    segments = ["Low", "Mid", "High"]
    x = np.arange(len(segments))  # Vị trí trên trục OX
    bar_width = 0.35

    # Dữ liệu cho CPU và GPU
    cpu_data = data[data["Type"] == "CPU"]
    gpu_data = data[data["Type"] == "GPU"]

    # Chi phí ban đầu
    cpu_initial_cost = cpu_data["Giá Mua (VND)"].values
    gpu_initial_cost = gpu_data["Giá Mua (VND)"].values

    # Tổng chi phí sau 1 năm
    cpu_total_cost = cpu_data["Tổng Chi Phí Sau 1 Năm (VND)"].values
    gpu_total_cost = gpu_data["Tổng Chi Phí Sau 1 Năm (VND)"].values

    # Biểu đồ 1: Chi phí ban đầu
    fig1, ax1 = plt.subplots(figsize=(10, 6))
    ax1.bar(x - bar_width / 2, cpu_initial_cost, bar_width, label="Chi Phí Ban Đầu (CPU)", color="blue")
    ax1.bar(x + bar_width / 2, gpu_initial_cost, bar_width, label="Chi Phí Ban Đầu (GPU)", color="green")
    ax1.set_xticks(x)
    ax1.set_xticklabels(segments)
    ax1.set_ylabel("Chi Phí Ban Đầu (VND)")
    ax1.set_xlabel("Phân Khúc")
    ax1.set_title("Chi Phí Ban Đầu giữa CPU và GPU")
    ax1.legend()
    plt.tight_layout()
    plt.show()

    # Biểu đồ 2: Chi phí sau 1 năm
    fig2, ax2 = plt.subplots(figsize=(10, 6))
    ax2.bar(x - bar_width / 2, cpu_total_cost, bar_width, label="Chi Phí Sau 1 Năm (CPU)", color="cyan")
    ax2.bar(x + bar_width / 2, gpu_total_cost, bar_width, label="Chi Phí Sau 1 Năm (GPU)", color="lime")
    ax2.set_xticks(x)
    ax2.set_xticklabels(segments)
    ax2.set_ylabel("Chi Phí Sau 1 Năm (VND)")
    ax2.set_xlabel("Phân Khúc")
    ax2.set_title("Chi Phí Sau 1 Năm giữa CPU và GPU")
    ax2.legend()
    plt.tight_layout()
    plt.show()

# Gọi hàm vẽ hai biểu đồ
plot_separate_charts(data)