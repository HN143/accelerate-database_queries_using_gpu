-- Query 85: Phân tích hoàn trả hàng trực tuyến theo các yếu tố nhân khẩu học
--
-- Mô tả: Truy vấn phân tích các trường hợp hoàn trả hàng mua trực tuyến năm 1998, tập trung vào:
-- - Lý do hoàn trả (20 ký tự đầu của mô tả)
-- - Số lượng hàng trung bình trong đơn hàng
-- - Số tiền hoàn trả trung bình
-- - Phí hoàn trả trung bình
-- Được lọc theo các điều kiện:
-- - Tình trạng hôn nhân và học vấn của khách hàng (M/4 yr Degree, D/Primary, U/Advanced Degree)
-- - Khoảng giá bán (50-100, 100-150, 150-200)
-- - Địa chỉ tại Mỹ với các bang cụ thể
-- - Lợi nhuận ròng trong các khoảng định trước
--
select
	substr (r_reason_desc, 1, 20),
	avg(ws_quantity),
	avg(wr_refunded_cash),
	avg(wr_fee)
from
	web_sales,
	web_returns,
	web_page,
	customer_demographics cd1,
	customer_demographics cd2,
	customer_address,
	date_dim,
	reason
where
	ws_web_page_sk = wp_web_page_sk
	and ws_item_sk = wr_item_sk
	and ws_order_number = wr_order_number
	and ws_sold_date_sk = d_date_sk
	and d_year = 1998
	and cd1.cd_demo_sk = wr_refunded_cdemo_sk
	and cd2.cd_demo_sk = wr_returning_cdemo_sk
	and ca_address_sk = wr_refunded_addr_sk
	and r_reason_sk = wr_reason_sk
	and (
		(
			cd1.cd_marital_status = 'M'
			and cd1.cd_marital_status = cd2.cd_marital_status
			and cd1.cd_education_status = '4 yr Degree'
			and cd1.cd_education_status = cd2.cd_education_status
			and ws_sales_price between 100.00 and 150.00
		)
		or (
			cd1.cd_marital_status = 'D'
			and cd1.cd_marital_status = cd2.cd_marital_status
			and cd1.cd_education_status = 'Primary'
			and cd1.cd_education_status = cd2.cd_education_status
			and ws_sales_price between 50.00 and 100.00
		)
		or (
			cd1.cd_marital_status = 'U'
			and cd1.cd_marital_status = cd2.cd_marital_status
			and cd1.cd_education_status = 'Advanced Degree'
			and cd1.cd_education_status = cd2.cd_education_status
			and ws_sales_price between 150.00 and 200.00
		)
	)
	and (
		(
			ca_country = 'United States'
			and ca_state in ('KY', 'GA', 'NM')
			and ws_net_profit between 100 and 200
		)
		or (
			ca_country = 'United States'
			and ca_state in ('MT', 'OR', 'IN')
			and ws_net_profit between 150 and 300
		)
		or (
			ca_country = 'United States'
			and ca_state in ('WI', 'MO', 'WV')
			and ws_net_profit between 50 and 250
		)
	)
group by
	r_reason_desc
order by
	substr (r_reason_desc, 1, 20),
	avg(ws_quantity),
	avg(wr_refunded_cash),
	avg(wr_fee)
limit
	100;