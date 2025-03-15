-- Query Description:
-- Truy vấn này phân tích đặc điểm nhân khẩu học của khách hàng ở một số quận cụ thể.
-- Chi tiết:
-- 1. Chỉ xem xét khách hàng ở 5 quận:
--    - Walker County
--    - Richland County
--    - Gaines County
--    - Douglas County
--    - Dona Ana County
-- 2. Xét các giao dịch trong quý 2 năm 2002 (tháng 4-6)
-- 3. Chỉ chọn khách hàng có giao dịch qua:
--    - Cửa hàng VÀ
--    - (Web HOẶC Catalog)
-- 4. Thống kê theo các đặc điểm:
--    - Giới tính
--    - Tình trạng hôn nhân
--    - Trình độ học vấn
--    - Mức chi tiêu dự kiến
--    - Xếp hạng tín dụng
--    - Số người phụ thuộc
--    - Số người phụ thuộc có việc làm
--    - Số người phụ thuộc học đại học
-- 5. Giới hạn 100 kết quả
-- Bảng sử dụng: customer, customer_address, customer_demographics, store_sales, web_sales, catalog_sales, date_dim
select
	cd_gender,
	cd_marital_status,
	cd_education_status,
	count(*) cnt1,
	cd_purchase_estimate,
	count(*) cnt2,
	cd_credit_rating,
	count(*) cnt3,
	cd_dep_count,
	count(*) cnt4,
	cd_dep_employed_count,
	count(*) cnt5,
	cd_dep_college_count,
	count(*) cnt6
from
	customer c,
	customer_address ca,
	customer_demographics
where
	c.c_current_addr_sk = ca.ca_address_sk
	and ca_county in (
		'Walker County',
		'Richland County',
		'Gaines County',
		'Douglas County',
		'Dona Ana County'
	)
	and cd_demo_sk = c.c_current_cdemo_sk
	and exists (
		select
			*
		from
			store_sales,
			date_dim
		where
			c.c_customer_sk = ss_customer_sk
			and ss_sold_date_sk = d_date_sk
			and d_year = 2002
			and d_moy between 4 and 4  + 3
	)
	and (
		exists (
			select
				*
			from
				web_sales,
				date_dim
			where
				c.c_customer_sk = ws_bill_customer_sk
				and ws_sold_date_sk = d_date_sk
				and d_year = 2002
				and d_moy between 4 ANd 4  + 3
		)
		or exists (
			select
				*
			from
				catalog_sales,
				date_dim
			where
				c.c_customer_sk = cs_ship_customer_sk
				and cs_sold_date_sk = d_date_sk
				and d_year = 2002
				and d_moy between 4 and 4  + 3
		)
	)
group by
	cd_gender,
	cd_marital_status,
	cd_education_status,
	cd_purchase_estimate,
	cd_credit_rating,
	cd_dep_count,
	cd_dep_employed_count,
	cd_dep_college_count
order by
	cd_gender,
	cd_marital_status,
	cd_education_status,
	cd_purchase_estimate,
	cd_credit_rating,
	cd_dep_count,
	cd_dep_employed_count,
	cd_dep_college_count
limit
	100;