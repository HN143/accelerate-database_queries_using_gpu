#!/bin/bash

# Định nghĩa đường dẫn file cấu hình
CONFIG_FILE="/var/lib/heavyai/heavy.conf"

# Nếu không chạy với quyền root, tự động chạy lại với sudo
if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

# Ghi đè nội dung file cấu hình
cat <<EOL | tee "$CONFIG_FILE" > /dev/null
port = 6274
http-port = 6278
calcite-port = 6279
data = "/var/lib/heavyai/storage"
null-div-by-zero = true
allowed-import-paths = ["/"]
allowed-export-paths = ["/"]

[web]
port = 6273
frontend = "/opt/heavyai/frontend"
EOL

sudo systemctl restart heavydb --now
#sudo systemctl enable heavydb --now

echo "Waiting for HeavyDB to start..."
sleep 5  # Chờ 5 giây

# Kiểm tra xem dịch vụ đã chạy chưa, nếu chưa thì chờ tiếp
while ! nc -z localhost 6274; do
  echo "HeavyDB chưa sẵn sàng, chờ thêm 2 giây..."
  sleep 2
done

echo "HeavyDB đã sẵn sàng!"
echo "File $CONFIG_FILE has been updated successfully!"

