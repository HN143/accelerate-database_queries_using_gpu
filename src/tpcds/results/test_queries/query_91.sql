-- Query 91: Thống kê thiệt hại từ việc trả lại hàng theo từng trung tâm cuộc gọi với các điều kiện sau:
-- - Chỉ xét các đơn hàng bị trả lại trong tháng 11 năm 1999
-- - Lọc theo thông tin khách hàng:
--   + Đã kết hôn và trình độ học vấn không xác định, hoặc
--   + Góa bụa và có bằng cao học
-- - Khách hàng có khả năng mua sắm trong khoảng 0-500
-- - Khách hàng ở múi giờ GMT-7
-- - Kết quả được sắp xếp theo thiệt hại giảm dần
select
	cc_call_center_id Call_Center,
	cc_name Call_Center_Name,
	cc_manager Manager,
	sum(cr_net_loss) Returns_Loss
from
	call_center,
	catalog_returns,
	date_dim,
	customer,
	customer_address,
	customer_demographics,
	household_demographics
where
	cr_call_center_sk = cc_call_center_sk
	and cr_returned_date_sk = d_date_sk
	and cr_returning_customer_sk = c_customer_sk
	and cd_demo_sk = c_current_cdemo_sk
	and hd_demo_sk = c_current_hdemo_sk
	and ca_address_sk = c_current_addr_sk
	and d_year = 1999
	and d_moy = 11
	and (
		(
			cd_marital_status = 'M'
			and cd_education_status = 'Unknown'
		)
		or (
			cd_marital_status = 'W'
			and cd_education_status = 'Advanced Degree'
		)
	)
	and hd_buy_potential like '0-500%'
	and ca_gmt_offset = -7
group by
	cc_call_center_id,
	cc_name,
	cc_manager,
	cd_marital_status,
	cd_education_status
order by
	sum(cr_net_loss) desc;