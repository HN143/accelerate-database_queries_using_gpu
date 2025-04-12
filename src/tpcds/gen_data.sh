sudo rm -rf /opt/heavy_data/data
sudo mkdir -p /opt/heavy_data/data
cd tools && ./dsdgen -sc $1 -dir /opt/heavy_data/data -TERMINATE N && cd ..
