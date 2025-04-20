import matplotlib.pyplot as plt
import numpy as np

# Dữ liệu thời gian từ các phân tích
queries = [
    'Query 1 (2264ms)', 
    'Query 2 (2934ms)', 
    'Query 3 (1403ms)', 
    'Query 24 (397ms)', 
    'Query 54 (3162ms)', 
    'Query 78 (3890ms)'
]

# Dữ liệu thời gian
parse_to_ra = [942, 886, 796, 53, 910, 956]
compile_work_unit = [526, 756, 336, 46, 878, 1203]
launch_kernel = [263, 594, 142, 254, 297, 620]
fetch_chunks = [8, 283, 26, 0, 543, 281]
execute_sort = [10, 0, 0, 0, 0, 0]

# Tạo biểu đồ cột stacked
fig, ax = plt.subplots(figsize=(14, 6))
bar_width = 0.4  # tăng độ rộng cột
index = np.arange(len(queries))  # giữ nguyên khoảng cách chỉ số, có thể điều chỉnh nếu muốn cột sát hơn nữa

# Vẽ các cột stacked
ax.bar(index, parse_to_ra, bar_width, label='Parse to RA', color='b')
ax.bar(index, compile_work_unit, bar_width, bottom=parse_to_ra, label='Compile Work Unit', color='g')
ax.bar(index, launch_kernel, bar_width, bottom=np.array(parse_to_ra) + np.array(compile_work_unit), label='Launch Kernel', color='r')
ax.bar(index, fetch_chunks, bar_width, bottom=np.array(parse_to_ra) + np.array(compile_work_unit) + np.array(launch_kernel), label='Fetch Chunks', color='y')
ax.bar(index, execute_sort, bar_width, bottom=np.array(parse_to_ra) + np.array(compile_work_unit) + np.array(launch_kernel) + np.array(fetch_chunks), label='Execute Sort', color='purple')

# Cấu hình biểu đồ
ax.set_xlabel('Queries')
ax.set_ylabel('Time (ms)')
ax.set_title('Execution Time Breakdown for HeavyDB Queries')
ax.set_ylim(0, 4000)
ax.set_xticks(index)
ax.set_xticklabels(queries, rotation=45)
ax.legend(loc='upper left')

# Hiển thị giá trị tổng thời gian trên mỗi cột
total_times = [2264, 2934, 1403, 397, 3162, 3890]
for i, total in enumerate(total_times):
    ax.text(i, total + 50, f'{total} ms', ha='center', va='bottom')

plt.tight_layout()
plt.savefig('query_execution_time_chart_tighter.png')
plt.show()
