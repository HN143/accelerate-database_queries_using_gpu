rm -rf /tmp/heavy_data/data
mkdir -p /tmp/heavy_data/data
cd tools && ./dsdgen -sc $1 -dir /tmp/heavy_data/data -TERMINATE N && cd ..
