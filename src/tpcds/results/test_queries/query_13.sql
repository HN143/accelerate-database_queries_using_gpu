-- Mô tả: Câu query này tính trung bình số lượng bán hàng,
-- trung bình giá bán mở rộng, trung bình chi phí bán buôn mở rộng
-- và tổng chi phí bán buôn mở rộng từ bảng store_sales,
-- bảng store, bảng customer_demographics, bảng household_demographics,
-- bảng customer_address và bảng date_dim.
-- Điều kiện lọc bao gồm năm bán hàng là 2001,
-- các điều kiện về tình trạng hôn nhân, trình độ học vấn,
-- giá bán, số lượng người phụ thuộc, quốc gia, tiểu bang và lợi nhuận ròng.
select
	avg(ss_quantity),
	avg(ss_ext_sales_price),
	avg(ss_ext_wholesale_cost),
	sum(ss_ext_wholesale_cost)
from
	store_sales,
	store,
	customer_demographics,
	household_demographics,
	customer_address,
	date_dim
where
	s_store_sk = ss_store_sk
	and ss_sold_date_sk = d_date_sk
	and d_year = 2001
	and (
		(
			ss_hdemo_sk = hd_demo_sk
			and cd_demo_sk = ss_cdemo_sk
			and cd_marital_status = 'D'
			and cd_education_status = '2 yr Degree'
			and ss_sales_price between 100.00 and 150.00
			and hd_dep_count = 3
		)
		or (
			ss_hdemo_sk = hd_demo_sk
			and cd_demo_sk = ss_cdemo_sk
			and cd_marital_status = 'S'
			and cd_education_status = 'Secondary'
			and ss_sales_price between 50.00 and 100.00
			and hd_dep_count = 1
		)
		or (
			ss_hdemo_sk = hd_demo_sk
			and cd_demo_sk = ss_cdemo_sk
			and cd_marital_status = 'W'
			and cd_education_status = 'Advanced Degree'
			and ss_sales_price between 150.00 and 200.00
			and hd_dep_count = 1
		)
	)
	and (
		(
			ss_addr_sk = ca_address_sk
			and ca_country = 'United States'
			and ca_state in ('CO', 'IL', 'MN')
			and ss_net_profit between 100 and 200
		)
		or (
			ss_addr_sk = ca_address_sk
			and ca_country = 'United States'
			and ca_state in ('OH', 'MT', 'NM')
			and ss_net_profit between 150 and 300
		)
		or (
			ss_addr_sk = ca_address_sk
			and ca_country = 'United States'
			and ca_state in ('TX', 'MO', 'MI')
			and ss_net_profit between 50 and 250
		)
	);