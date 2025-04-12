rm -rf /heavy_data/data
mkdir -p /heavy_data/data
cd tools && ./dsdgen -sc $1 -dir /heavy_data/data -TERMINATE N && cd ..
