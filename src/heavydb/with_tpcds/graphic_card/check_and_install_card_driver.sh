#!/bin/bash

# Nếu không chạy với quyền root, tự động chạy lại với sudo
if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

# Kiểm tra lại driver đã cài đặt
if command -v nvidia-smi &>/dev/null; then
    nvidia-smi
    echo "card đã cài đặt"
    exit 0
fi

# Kiểm tra card đồ họa NVIDIA hoặc AMD
gpu_info=$(lspci | grep -i -E "(nvidia|amd)")

if [ -z "$gpu_info" ]; then
  echo "Không tìm thấy card đồ họa NVIDIA hoặc AMD."
  exit 1
else
  echo "Tìm thấy card đồ họa:"
  echo "$gpu_info"
fi

# Tìm driver được recommended
recommended_driver=$(ubuntu-drivers devices | grep recommended | awk '{print $3}')

if [ -n "$recommended_driver" ]; then
    best_driver=$recommended_driver
    echo "Chọn driver được đề xuất: $best_driver"
else
    # Nếu không có driver recommended, chọn driver NVIDIA có số lớn nhất
    best_driver=$(ubuntu-drivers devices | grep -oP '(nvidia-driver-\d+)' | sort -V | tail -1)
    echo "Chọn driver tốt nhất theo phiên bản: $best_driver"
fi

# Cài đặt driver đã chọn
if [ -n "$best_driver" ]; then
    echo "Đang cài đặt $best_driver..."
    sudo apt install -y "$best_driver"
else
    echo "Không tìm thấy driver phù hợp."
    exit 1
fi

# Kiểm tra lại driver đã cài đặt
if command -v nvidia-smi &>/dev/null; then
    nvidia-smi
    echo "Cài đặt thành công! Hãy khởi động lại hệ thống."
else
    echo "Cài đặt có thể chưa thành công hoặc không tìm thấy GPU NVIDIA."
fi

# Yêu cầu khởi động lại hệ thống
echo "Cài đặt hoàn tất. cần khởi động lại hệ thống"
