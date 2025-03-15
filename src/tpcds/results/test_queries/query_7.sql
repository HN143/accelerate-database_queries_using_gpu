-- Query Description:
-- Truy vấn này phân tích hành vi mua hàng của một nhóm khách hàng cụ thể.
-- Chi tiết:
-- 1. Chỉ xem xét khách hàng có đặc điểm:
--    - Giới tính: Nữ
--    - Tình trạng hôn nhân: Góa phụ
--    - Trình độ học vấn: Tiểu học
-- 2. Loại trừ các giao dịch từ chương trình khuyến mãi qua email hoặc sự kiện
-- 3. Tính trung bình cho mỗi mặt hàng:
--    - Số lượng bán
--    - Giá niêm yết
--    - Giá trị coupon
--    - Giá bán thực tế
-- 4. Chỉ xem xét các giao dịch trong năm 1998
-- 5. Sắp xếp theo ID sản phẩm
-- 6. Giới hạn 100 kết quả
-- Bảng sử dụng: store_sales, customer_demographics, date_dim, item, promotion
select
	i_item_id,
	avg(ss_quantity) agg1,
	avg(ss_list_price) agg2,
	avg(ss_coupon_amt) agg3,
	avg(ss_sales_price) agg4
from
	store_sales,
	customer_demographics,
	date_dim,
	item,
	promotion
where
	ss_sold_date_sk = d_date_sk
	and ss_item_sk = i_item_sk
	and ss_cdemo_sk = cd_demo_sk
	and ss_promo_sk = p_promo_sk
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