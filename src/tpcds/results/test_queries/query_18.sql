-- Truy vấn này thực hiện phân tích tổng hợp dữ liệu bán hàng qua danh mục (catalog) 
-- theo các vùng địa lý (quốc gia, tiểu bang, hạt). Kết quả bao gồm các chỉ số trung bình như:
-- số lượng sản phẩm, giá niêm yết, số tiền giảm giá (coupon), giá bán, lợi nhuận ròng, 
-- năm sinh khách hàng và số người phụ thuộc. Chỉ xem xét khách hàng nam có trình độ đại học, 
-- sinh vào các tháng 1,4,5,9,10,12 và mua hàng trong năm 2001 tại 7 tiểu bang cụ thể.

select
    i_item_id,
    ca_country,
    ca_state,
    ca_county,
    avg(cast(cs_quantity as decimal(12, 2))) agg1,
    avg(cast(cs_list_price as decimal(12, 2))) agg2,
    avg(cast(cs_coupon_amt as decimal(12, 2))) agg3,
    avg(cast(cs_sales_price as decimal(12, 2))) agg4,
    avg(cast(cs_net_profit as decimal(12, 2))) agg5,
    avg(cast(c_birth_year as decimal(12, 2))) agg6,
    avg(cast(cd1.cd_dep_count as decimal(12, 2))) agg7
from
    catalog_sales,
    customer_demographics cd1,
    customer_demographics cd2,
    customer,
    customer_address,
    date_dim,
    item
where
    cs_sold_date_sk = d_date_sk
    and cs_item_sk = i_item_sk
    and cs_bill_cdemo_sk = cd1.cd_demo_sk
    and cs_bill_customer_sk = c_customer_sk
    and cd1.cd_gender = 'M'
    and cd1.cd_education_status = 'College'
    and c_current_cdemo_sk = cd2.cd_demo_sk
    and c_current_addr_sk = ca_address_sk
    and c_birth_month in (9, 5, 12, 4, 1, 10)
    and d_year = 2001
    and ca_state in ('ND', 'WI', 'AL', 'NC', 'OK', 'MS', 'TN')
group by
    rollup (i_item_id, ca_country, ca_state, ca_county)
order by
    ca_country,
    ca_state,
    ca_county,
    i_item_id
limit
     100;