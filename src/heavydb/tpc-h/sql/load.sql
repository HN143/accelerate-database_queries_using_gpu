COPY customer FROM 'exported_data/customer.csv' WITH (quote = '"', delimiter = '|', header = 'true');
COPY lineitem FROM 'exported_data/lineitem.csv' WITH (quote = '"', delimiter = '|', header = 'true');
COPY nation FROM 'exported_data/nation.csv' WITH (quote = '"', delimiter = '|', header = 'true');
COPY orders FROM 'exported_data/orders.csv' WITH (quote = '"', delimiter = '|', header = 'true');
COPY part FROM 'exported_data/part.csv' WITH (quote = '"', delimiter = '|', header = 'true');
COPY partsupp FROM 'exported_data/partsupp.csv' WITH (quote = '"', delimiter = '|', header = 'true');
COPY region FROM 'exported_data/region.csv' WITH (quote = '"', delimiter = '|', header = 'true');
COPY supplier FROM 'exported_data/supplier.csv' WITH (quote = '"', delimiter = '|', header = 'true');

