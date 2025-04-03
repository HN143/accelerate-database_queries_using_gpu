# import matplotlib.pyplot as plt
# import pandas as pd

# # Load the CSV files
# low_end_df = pd.read_csv('compare_table/low_end_gpu.csv')
# mid_end_df = pd.read_csv('compare_table/mid_end_gpu.csv')
# high_end_df = pd.read_csv('compare_table/high_end_gpu.csv')

# # Add segment labels
# low_end_df['Phân Khúc'] = 'Thấp'
# mid_end_df['Phân Khúc'] = 'Trung Bình'
# high_end_df['Phân Khúc'] = 'Cao'

# # Combine all three dataframes for plotting
# all_df = pd.concat([low_end_df, mid_end_df, high_end_df], ignore_index=True)
# all_df['Cấu Hình'] = all_df['Phân Khúc'] + ' - ' + all_df['Cấu Hình'] + " (GPU)"

# # Create CPU data (assuming CPU consumption is 30% of GPU and DB query time is 1.5x slower)
# cpu_data = all_df.copy()
# cpu_data['Cấu Hình'] = cpu_data['Cấu Hình'].str.replace(" (GPU)", " (CPU)", regex=False)
# cpu_data['Tiêu Thụ Điện Năng (W)'] = cpu_data['Tiêu Thụ Điện Năng (W)'] * 0.3
# cpu_data['Thời Gian Chạy DB Query (giây)'] = cpu_data['Thời Gian Chạy DB Query (giây)'] * 1.5

# # Plot
# fig, ax1 = plt.subplots(figsize=(14, 7))

# # Bar plot for power consumption
# ax1.bar(all_df['Cấu Hình'], all_df['Tiêu Thụ Điện Năng (W)'], color='lightblue', label='GPU Power (W)', alpha=0.6)
# ax1.bar(cpu_data['Cấu Hình'], cpu_data['Tiêu Thụ Điện Năng (W)'], color='orange', label='CPU Power (W)', alpha=0.6)

# # Line plot for query time
# ax2 = ax1.twinx()
# ax2.plot(all_df['Cấu Hình'], all_df['Thời Gian Chạy DB Query (giây)'], color='green', marker='o', label='GPU Query Time (s)', linewidth=2)
# ax2.plot(cpu_data['Cấu Hình'], cpu_data['Thời Gian Chạy DB Query (giây)'], color='red', marker='o', label='CPU Query Time (s)', linewidth=2)

# # Labels and title
# ax1.set_xlabel("Cấu Hình (GPU vs CPU)")
# ax1.set_ylabel("Tiêu Thụ Điện Năng (W)", color='black')
# ax2.set_ylabel("Thời Gian Chạy DB Query (giây)", color='black')
# ax1.set_title("So sánh Mức Tiêu Thụ Điện Năng và Thời Gian Chạy Truy Vấn giữa GPU và CPU theo Phân Khúc")

# # Legends
# ax1.legend(loc='upper left')
# ax2.legend(loc='upper right')

# # Highlight different segments
# plt.xticks(rotation=45, ha='right', fontsize=5)
# plt.tight_layout()
# plt.show()

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# Load the CSV files
low_end_df = pd.read_csv('compare_table/low_end_gpu.csv')
mid_end_df = pd.read_csv('compare_table/mid_end_gpu.csv')
high_end_df = pd.read_csv('compare_table/high_end_gpu.csv')

# Add segment labels
low_end_df['Phân Khúc'] = 'Thấp'
mid_end_df['Phân Khúc'] = 'Trung Bình'
high_end_df['Phân Khúc'] = 'Cao'

# Combine all three dataframes for plotting
all_df = pd.concat([low_end_df, mid_end_df, high_end_df], ignore_index=True)

# Create CPU data (assuming CPU consumption is 30% of GPU and DB query time is 1.5x slower)
cpu_data = all_df.copy()
cpu_data['Tiêu Thụ Điện Năng (W)'] = cpu_data['Tiêu Thụ Điện Năng (W)'] * 0.3
cpu_data['Thời Gian Chạy DB Query (giây)'] = cpu_data['Thời Gian Chạy DB Query (giây)'] * 1.5

# Define colors for each segment
colors = {'Thấp': 'blue', 'Trung Bình': 'green', 'Cao': 'red'}

# Set positions for bars
x_positions = np.arange(len(all_df))
width = 0.4

# Plot
fig, ax1 = plt.subplots(figsize=(12, 6))

# Bar plot for power consumption
for idx, segment in enumerate(['Thấp', 'Trung Bình', 'Cao']):
    segment_data = all_df[all_df['Phân Khúc'] == segment]
    cpu_segment_data = cpu_data[cpu_data['Phân Khúc'] == segment]
    ax1.bar(x_positions[idx*4:idx*4+4] - width/2, segment_data['Tiêu Thụ Điện Năng (W)'], color=colors[segment], label=f'GPU {segment}' if idx == 0 else "", alpha=0.6)
    ax1.bar(x_positions[idx*4:idx*4+4] + width/2, cpu_segment_data['Tiêu Thụ Điện Năng (W)'], color=colors[segment], hatch='//', label=f'CPU {segment}' if idx == 0 else "", alpha=0.6)

# Line plot for query time
ax2 = ax1.twinx()
ax2.plot(x_positions, all_df['Thời Gian Chạy DB Query (giây)'], color='black', marker='o', linestyle='-', label='GPU Query Time (s)', linewidth=2)
ax2.plot(x_positions, cpu_data['Thời Gian Chạy DB Query (giây)'], color='gray', marker='o', linestyle='--', label='CPU Query Time (s)', linewidth=2)

# Labels and title
ax1.set_xlabel("Phân Khúc")
ax1.set_ylabel("Tiêu Thụ Điện Năng (W)", color='black')
ax2.set_ylabel("Thời Gian Chạy DB Query (giây)", color='black')
ax1.set_title("So sánh Mức Tiêu Thụ Điện Năng và Thời Gian Chạy Truy Vấn giữa GPU và CPU theo Phân Khúc")

# Legends
ax1.legend(loc='upper left')
ax2.legend(loc='upper right')

# Set x-ticks to only show segment labels
plt.xticks([2, 6, 10], ['Thấp', 'Trung Bình', 'Cao'], fontsize=12)
plt.tight_layout()
plt.show()