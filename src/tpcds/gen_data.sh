sudo rm -rf /opt/heavyai/data/data
sudo mkdir -p /opt/heavyai/data/data
cd tools && ./dsdgen -sc $1 -dir /opt/heavyai/data/data -TERMINATE N && cd ..
