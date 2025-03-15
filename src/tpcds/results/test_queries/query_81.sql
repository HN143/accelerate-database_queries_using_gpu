-- Query 81: Tìm thông tin chi tiết của khách hàng có tổng giá trị hoàn trả hàng catalog cao hơn
-- mức trung bình của tiểu bang Illinois (IL).
-- Input:
--   - catalog_returns: thông tin hoàn trả hàng catalog
--   - customer_address: địa chỉ khách hàng
--   - customer: thông tin khách hàng
--   - date_dim: thời gian
-- Output: Thông tin chi tiết khách hàng và giá trị hoàn trả
-- Điều kiện:
--   - Năm 1998
--   - Tiểu bang IL
--   - Giá trị hoàn trả > 120% giá trị trung bình của tiểu bang
with
	customer_total_return as (
		select
			cr_returning_customer_sk as ctr_customer_sk,
			ca_state as ctr_state,
			sum(cr_return_amt_inc_tax) as ctr_total_return
		from
			catalog_returns,
			date_dim,
			customer_address
		where
			cr_returned_date_sk = d_date_sk
			and d_year = 1998
			and cr_returning_addr_sk = ca_address_sk
		group by
			cr_returning_customer_sk,
			ca_state
	)
select
	c_customer_id,
	c_salutation,
	c_first_name,
	c_last_name,
	ca_street_number,
	ca_street_name,
	ca_street_type,
	ca_suite_number,
	ca_city,
	ca_county,
	ca_state,
	ca_zip,
	ca_country,
	ca_gmt_offset,
	ca_location_type,
	ctr_total_return
from
	customer_total_return ctr1,
	customer_address,
	customer
where
	ctr1.ctr_total_return > (
		select
			avg(ctr_total_return) * 1.2
		from
			customer_total_return ctr2
		where
			ctr1.ctr_state = ctr2.ctr_state
	)
	and ca_address_sk = c_current_addr_sk
	and ca_state = 'IL'
	and ctr1.ctr_customer_sk = c_customer_sk
order by
	c_customer_id,
	c_salutation,
	c_first_name,
	c_last_name,
	ca_street_number,
	ca_street_name,
	ca_street_type,
	ca_suite_number,
	ca_city,
	ca_county,
	ca_state,
	ca_zip,
	ca_country,
	ca_gmt_offset,
	ca_location_type,
	ctr_total_return
limit
	100;