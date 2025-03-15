-- Query 84: Tìm thông tin khách hàng ở thành phố Hopewell có thu nhập trong khoảng xác định.
-- Input:
--   - customer: thông tin khách hàng
--   - customer_address: địa chỉ khách hàng
--   - customer_demographics: đặc điểm nhân khẩu học
--   - household_demographics: đặc điểm hộ gia đình
--   - income_band: phân khúc thu nhập
--   - store_returns: hoàn trả tại cửa hàng
-- Output: ID và tên đầy đủ của khách hàng
-- Điều kiện:
--   - Thành phố: Hopewell
--   - Thu nhập từ 32287 đến 82287
select
	c_customer_id as customer_id,
	coalesce(c_last_name, '') || ', ' || coalesce(c_first_name, '') as customername
from
	customer,
	customer_address,
	customer_demographics,
	household_demographics,
	income_band,
	store_returns
where
	ca_city = 'Hopewell'
	and c_current_addr_sk = ca_address_sk
	and ib_lower_bound >= 32287
	and ib_upper_bound <= 32287 + 50000
	and ib_income_band_sk = hd_income_band_sk
	and cd_demo_sk = c_current_cdemo_sk
	and hd_demo_sk = c_current_hdemo_sk
	and sr_cdemo_sk = cd_demo_sk
order by
	c_customer_id
limit
	100;