-- Truy vấn này tính tổng số lượng hàng bán ra dựa trên các tiêu chí nhân khẩu học:
-- 1. Khách hàng được phân loại theo:
--    - Đã kết hôn, có bằng đại học, mua hàng giá 100-150
--    - Ly hôn, học tiểu học, mua hàng giá 50-100
--    - Độc thân, có bằng cao học, mua hàng giá 150-200
-- 2. Địa điểm mua hàng tại Mỹ, theo các nhóm tiểu bang:
--    - KY, GA, NM: lợi nhuận 0-2000
--    - MT, OR, IN: lợi nhuận 150-3000
--    - WI, MO, WV: lợi nhuận 50-25000
-- 3. Thời gian: năm 1998
select
	sum(ss_quantity)
from
	store_sales,
	store,
	customer_demographics,
	customer_address,
	date_dim
where
	s_store_sk = ss_store_sk
	and ss_sold_date_sk = d_date_sk
	and d_year = 1998
	and (
		(
			cd_demo_sk = ss_cdemo_sk
			and cd_marital_status = 'M'
			and cd_education_status = '4 yr Degree'
			and ss_sales_price between 100.00 and 150.00
		)
		or (
			cd_demo_sk = ss_cdemo_sk
			and cd_marital_status = 'D'
			and cd_education_status = 'Primary'
			and ss_sales_price between 50.00 and 100.00
		)
		or (
			cd_demo_sk = ss_cdemo_sk
			and cd_marital_status = 'U'
			and cd_education_status = 'Advanced Degree'
			and ss_sales_price between 150.00 and 200.00
		)
	)
	and (
		(
			ss_addr_sk = ca_address_sk
			and ca_country = 'United States'
			and ca_state in ('KY', 'GA', 'NM')
			and ss_net_profit between 0 and 2000
		)
		or (
			ss_addr_sk = ca_address_sk
			and ca_country = 'United States'
			and ca_state in ('MT', 'OR', 'IN')
			and ss_net_profit between 150 and 3000
		)
		or (
			ss_addr_sk = ca_address_sk
			and ca_country = 'United States'
			and ca_state in ('WI', 'MO', 'WV')
			and ss_net_profit between 50 and 25000
		)
	);