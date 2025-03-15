/*
Mô tả:
- Phân tích doanh số bán hàng qua catalog theo từng sản phẩm
- Thông tin bao gồm:
+ ID sản phẩm
+ Số lượng bán trung bình
+ Giá niêm yết trung bình
+ Giá trị giảm giá trung bình
+ Giá bán thực tế trung bình
- Điều kiện:
+ Năm 1998
+ Chỉ xét khách hàng nữ, đã kết hôn và có trình độ học vấn tiểu học
+ Không áp dụng khuyến mãi qua email hoặc sự kiện
- Kết quả được nhóm và sắp xếp theo ID sản phẩm
- Giới hạn 100 bản ghi
*/
select
	i_item_id,
	avg(cs_quantity) agg1,
	avg(cs_list_price) agg2,
	avg(cs_coupon_amt) agg3,
	avg(cs_sales_price) agg4
from
	catalog_sales,
	customer_demographics,
	date_dim,
	item,
	promotion
where
	cs_sold_date_sk = d_date_sk
	and cs_item_sk = i_item_sk
	and cs_bill_cdemo_sk = cd_demo_sk
	and cs_promo_sk = p_promo_sk
	and cd_gender = 'F'
	and cd_marital_status = 'W'
	and cd_education_status = 'Primary'
	and (
		p_channel_email = 'N'
		or p_channel_event = 'N'
	)
	and d_year = 1998
group by
	i_item_id
order by
	i_item_id
limit
	100;