-- Truy vấn này phân tích thông tin khách hàng có từ 15-20 lần mua hàng dựa trên các tiêu chí:
-- 1. Mua trong những ngày 1-3 hoặc 25-28 của tháng
-- 2. Gia đình có tiềm năng mua sắm >10000 hoặc không xác định
-- 3. Có ít nhất 1 phương tiện đi lại, và tỉ lệ người phụ thuộc/phương tiện > 1.2
-- 4. Mua trong năm 1998-2000
-- 5. Tại các cửa hàng thuộc Quận Williamson
-- Kết quả trả về thông tin cá nhân của khách hàng và số vé mua hàng
select
	c_last_name,
	c_first_name,
	c_salutation,
	c_preferred_cust_flag,
	ss_ticket_number,
	cnt
from
	(
		select
			ss_ticket_number,
			ss_customer_sk,
			count(*) cnt
		from
			store_sales,
			date_dim,
			store,
			household_demographics
		where
			store_sales.ss_sold_date_sk = date_dim.d_date_sk
			and store_sales.ss_store_sk = store.s_store_sk
			and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
			and (
				date_dim.d_dom between 1 and 3
				or date_dim.d_dom between 25 and 28
			)
			and (
				household_demographics.hd_buy_potential = '>10000'
				or household_demographics.hd_buy_potential = 'Unknown'
			)
			and household_demographics.hd_vehicle_count > 0
			and (
				case
					when household_demographics.hd_vehicle_count > 0 then household_demographics.hd_dep_count / household_demographics.hd_vehicle_count
					else null
				end
			) > 1.2
			and date_dim.d_year in (1998, 1998 + 1, 1998 + 2)
			and store.s_county in (
				'Williamson County',
				'Williamson County',
				'Williamson County',
				'Williamson County',
				'Williamson County',
				'Williamson County',
				'Williamson County',
				'Williamson County'
			)
		group by
			ss_ticket_number,
			ss_customer_sk
	) dn,
	customer
where
	ss_customer_sk = c_customer_sk
	and cnt between 15 and 20
order by
	c_last_name,
	c_first_name,
	c_salutation,
	c_preferred_cust_flag desc,
	ss_ticket_number;