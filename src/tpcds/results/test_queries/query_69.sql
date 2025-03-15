/*
Query này thực hiện:
- Phân tích khách hàng theo nhân khẩu học (demographics) và thói quen mua sắm
- Chỉ xét khách hàng ở 3 bang: CO, IL, MN
- Lọc ra những khách hàng đã mua hàng tại cửa hàng (store_sales) trong khoảng thời gian Q1/1999
- Loại trừ những khách hàng đã mua hàng qua web (web_sales) hoặc catalog (catalog_sales) trong cùng thời gian
- Nhóm kết quả theo các thuộc tính về nhân khẩu học:
+ Giới tính (cd_gender)
+ Tình trạng hôn nhân (cd_marital_status)
+ Trình độ học vấn (cd_education_status)
+ Mức chi tiêu dự kiến (cd_purchase_estimate)
+ Xếp hạng tín dụng (cd_credit_rating)
*/
select
	cd_gender,
	cd_marital_status,
	cd_education_status,
	count(*) cnt1,
	cd_purchase_estimate,
	count(*) cnt2,
	cd_credit_rating,
	count(*) cnt3
from
	customer c,
	customer_address ca,
	customer_demographics
where
	c.c_current_addr_sk = ca.ca_address_sk
	and ca_state in ('CO', 'IL', 'MN')
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
			and d_moy between 1 and 1  + 2
	)
	and (
		not exists (
			select
				*
			from
				web_sales,
				date_dim
			where
				c.c_customer_sk = ws_bill_customer_sk
				and ws_sold_date_sk = d_date_sk
				and d_year = 1999
				and d_moy between 1 and 1  + 2
		)
		and not exists (
			select
				*
			from
				catalog_sales,
				date_dim
			where
				c.c_customer_sk = cs_ship_customer_sk
				and cs_sold_date_sk = d_date_sk
				and d_year = 1999
				and d_moy between 1 and 1  + 2
		)
	)
group by
	cd_gender,
	cd_marital_status,
	cd_education_status,
	cd_purchase_estimate,
	cd_credit_rating
order by
	cd_gender,
	cd_marital_status,
	cd_education_status,
	cd_purchase_estimate,
	cd_credit_rating
limit
	100;