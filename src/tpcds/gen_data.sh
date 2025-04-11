rm -rf results/data
mkdir -p results/data
cd tools && ./dsdgen -sc $1 -dir ../results/data -TERMINATE N && cd ..
