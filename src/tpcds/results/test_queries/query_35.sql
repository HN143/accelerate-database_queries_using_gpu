-- Truy vấn này phân tích thống kê về nhân khẩu học của khách hàng theo từng tiểu bang, bao gồm:
-- 1. Phân loại theo giới tính, tình trạng hôn nhân
-- 2. Thống kê về số người phụ thuộc: tổng số, số người đi làm, số người học đại học
-- 3. Chỉ xét những khách hàng đã mua hàng trong quý 1-3 năm 1999
-- 4. Khách hàng phải có ít nhất một trong các giao dịch:
--    - Mua tại cửa hàng
--    - Mua trực tuyến
--    - Mua qua danh mục
-- Kết quả được nhóm theo tiểu bang và các chỉ số nhân khẩu học
select
	ca_state,
	cd_gender,
	cd_marital_status,
	cd_dep_count,
	count(*) cnt1,
	avg(cd_dep_count) aggone1,
	max(cd_dep_count) aggtwo1,
	sum(cd_dep_count) aggthree1,
	cd_dep_employed_count,
	count(*) cnt2,
	avg(cd_dep_employed_count) aggone2,
	max(cd_dep_employed_count) aggtwo2,
	sum(cd_dep_employed_count) aggthree2,
	cd_dep_college_count,
	count(*) cnt3,
	avg(cd_dep_college_count) aggone3,
	max(cd_dep_college_count) aggtwo3,
	sum(cd_dep_college_count) aggthree3
from
	customer c,
	customer_address ca,
	customer_demographics
where
	c.c_current_addr_sk = ca.ca_address_sk
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
			and d_year = 1999
			and d_qoy < 4
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
				and d_year = 1999
				and d_qoy < 4
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
				and d_year = 1999
				and d_qoy < 4
		)
	)
group by
	ca_state,
	cd_gender,
	cd_marital_status,
	cd_dep_count,
	cd_dep_employed_count,
	cd_dep_college_count
order by
	ca_state,
	cd_gender,
	cd_marital_status,
	cd_dep_count,
	cd_dep_employed_count,
	cd_dep_college_count
limit
	100;