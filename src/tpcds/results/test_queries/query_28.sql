/*
Mô tả:
- Phân tích thống kê giá bán lẻ của sản phẩm theo các khoảng số lượng bán
- Chia thành 6 nhóm (B1-B6) dựa trên số lượng bán:
+ B1: 0-5 sản phẩm
+ B2: 6-10 sản phẩm
+ B3: 11-15 sản phẩm
+ B4: 16-20 sản phẩm
+ B5: 21-25 sản phẩm
+ B6: 26-30 sản phẩm
- Mỗi nhóm tính:
+ Giá bán lẻ trung bình
+ Tổng số lượng giá
+ Số lượng giá khác nhau
- Điều kiện về giá bán lẻ, giảm giá và giá bán buôn khác nhau cho mỗi nhóm
- Giới hạn 100 bản ghi
*/
select
	*
from
	(
		select
			avg(ss_list_price) B1_LP,
			count(ss_list_price) B1_CNT,
			count(distinct ss_list_price) B1_CNTD
		from
			store_sales
		where
			ss_quantity between 0 and 5
			and (
				ss_list_price between 11 and 11  + 10
				or ss_coupon_amt between 460 and 460  + 1000
				or ss_wholesale_cost between 14 and 14  + 20
			)
	) B1,
	(
		select
			avg(ss_list_price) B2_LP,
			count(ss_list_price) B2_CNT,
			count(distinct ss_list_price) B2_CNTD
		from
			store_sales
		where
			ss_quantity between 6 and 10
			and (
				ss_list_price between 91 and 91  + 10
				or ss_coupon_amt between 1430 and 1430  + 1000
				or ss_wholesale_cost between 32 and 32  + 20
			)
	) B2,
	(
		select
			avg(ss_list_price) B3_LP,
			count(ss_list_price) B3_CNT,
			count(distinct ss_list_price) B3_CNTD
		from
			store_sales
		where
			ss_quantity between 11 and 15
			and (
				ss_list_price between 66 and 66  + 10
				or ss_coupon_amt between 920 and 920  + 1000
				or ss_wholesale_cost between 4 and 4  + 20
			)
	) B3,
	(
		select
			avg(ss_list_price) B4_LP,
			count(ss_list_price) B4_CNT,
			count(distinct ss_list_price) B4_CNTD
		from
			store_sales
		where
			ss_quantity between 16 and 20
			and (
				ss_list_price between 142 and 142  + 10
				or ss_coupon_amt between 3054 and 3054  + 1000
				or ss_wholesale_cost between 80 and 80  + 20
			)
	) B4,
	(
		select
			avg(ss_list_price) B5_LP,
			count(ss_list_price) B5_CNT,
			count(distinct ss_list_price) B5_CNTD
		from
			store_sales
		where
			ss_quantity between 21 and 25
			and (
				ss_list_price between 135 and 135  + 10
				or ss_coupon_amt between 14180 and 14180  + 1000
				or ss_wholesale_cost between 38 and 38  + 20
			)
	) B5,
	(
		select
			avg(ss_list_price) B6_LP,
			count(ss_list_price) B6_CNT,
			count(distinct ss_list_price) B6_CNTD
		from
			store_sales
		where
			ss_quantity between 26 and 30
			and (
				ss_list_price between 28 and 28  + 10
				or ss_coupon_amt between 2513 and 2513  + 1000
				or ss_wholesale_cost between 42 and 42  + 20
			)
	) B6
limit
	100;