mkdir -p results
cp tools/tpcds.sql results/tpcds.sql
sudo chmod +x remove_primary_keys.sh
./remove_primary_keys.sh # Remove primary key definition lines after copying
