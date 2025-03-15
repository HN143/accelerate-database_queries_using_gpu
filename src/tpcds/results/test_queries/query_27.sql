/*
Mô tả:
- Thống kê doanh số bán hàng theo sản phẩm và tiểu bang
- Thông tin bao gồm:
+ ID sản phẩm
+ Tiểu bang
+ Chỉ số phân nhóm theo tiểu bang
+ Số lượng bán trung bình
+ Giá niêm yết trung bình
+ Giá trị giảm giá trung bình
+ Giá bán thực tế trung bình
- Điều kiện:
+ Năm 1998
+ Chỉ xét khách hàng nữ, đã kết hôn và có trình độ học vấn tiểu học
+ Chỉ xét 6 cửa hàng ở bang Tennessee (TN)
- Kết quả được nhóm theo rollup của ID sản phẩm và tiểu bang
- Sắp xếp theo ID sản phẩm và tiểu bang
- Giới hạn 100 bản ghi
*/
select
	i_item_id,
	s_state,
	grouping(s_state) g_state,
	avg(ss_quantity) agg1,
	avg(ss_list_price) agg2,
	avg(ss_coupon_amt) agg3,
	avg(ss_sales_price) agg4
from
	store_sales,
	customer_demographics,
	date_dim,
	store,
	item
where
	ss_sold_date_sk = d_date_sk
	and ss_item_sk = i_item_sk
	and ss_store_sk = s_store_sk
	and ss_cdemo_sk = cd_demo_sk
	and cd_gender = 'F'
	and cd_marital_status = 'W'
	and cd_education_status = 'Primary'
	and d_year = 1998
	and s_state in ('TN', 'TN', 'TN', 'TN', 'TN', 'TN')
group by
	rollup (i_item_id, s_state)
order by
	i_item_id,
	s_state
limit
	100;