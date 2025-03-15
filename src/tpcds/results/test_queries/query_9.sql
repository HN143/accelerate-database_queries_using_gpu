-- Query Description:
-- Truy vấn này phân tích chiết khấu và lợi nhuận theo các khoảng số lượng bán ra.
-- Chi tiết:
-- 1. Chia số lượng bán ra thành 5 khoảng:
--    - 1-20 sản phẩm
--    - 21-40 sản phẩm
--    - 41-60 sản phẩm
--    - 61-80 sản phẩm
--    - 81-100 sản phẩm
-- 2. Cho mỗi khoảng:
--    - Nếu số lượng giao dịch vượt ngưỡng quy định: tính trung bình chiết khấu
--    - Ngược lại: tính trung bình lợi nhuận
-- 3. Chỉ xem xét lý do trả hàng có r_reason_sk = 1
-- Bảng sử dụng: store_sales, reason
select
	case
		when (
			select
				count(*)
			from
				store_sales
			where
				ss_quantity between 1 and 20
		) > 25437 then (
			select
				avg(ss_ext_discount_amt)
			from
				store_sales
			where
				ss_quantity between 1 and 20
		)
		else (
			select
				avg(ss_net_profit)
			from
				store_sales
			where
				ss_quantity between 1 and 20
		)
	end bucket1,
	case
		when (
			select
				count(*)
			from
				store_sales
			where
				ss_quantity between 21 and 40
		) > 22746 then (
			select
				avg(ss_ext_discount_amt)
			from
				store_sales
			where
				ss_quantity between 21 and 40
		)
		else (
			select
				avg(ss_net_profit)
			from
				store_sales
			where
				ss_quantity between 21 and 40
		)
	end bucket2,
	case
		when (
			select
				count(*)
			from
				store_sales
			where
				ss_quantity between 41 and 60
		) > 9387 then (
			select
				avg(ss_ext_discount_amt)
			from
				store_sales
			where
				ss_quantity between 41 and 60
		)
		else (
			select
				avg(ss_net_profit)
			from
				store_sales
			where
				ss_quantity between 41 and 60
		)
	end bucket3,
	case
		when (
			select
				count(*)
			from
				store_sales
			where
				ss_quantity between 61 and 80
		) > 10098 then (
			select
				avg(ss_ext_discount_amt)
			from
				store_sales
			where
				ss_quantity between 61 and 80
		)
		else (
			select
				avg(ss_net_profit)
			from
				store_sales
			where
				ss_quantity between 61 and 80
		)
	end bucket4,
	case
		when (
			select
				count(*)
			from
				store_sales
			where
				ss_quantity between 81 and 100
		) > 18213 then (
			select
				avg(ss_ext_discount_amt)
			from
				store_sales
			where
				ss_quantity between 81 and 100
		)
		else (
			select
				avg(ss_net_profit)
			from
				store_sales
			where
				ss_quantity between 81 and 100
		)
	end bucket5
from
	reason
where
	r_reason_sk = 1;