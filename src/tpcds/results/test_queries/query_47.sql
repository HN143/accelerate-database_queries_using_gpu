-- Truy vấn này phân tích biến động doanh số bán hàng theo tháng:
-- 1. So sánh doanh số của tháng hiện tại với trung bình hàng tháng
-- 2. Phân tích theo danh mục sản phẩm, thương hiệu, cửa hàng và công ty
-- 3. Xét dữ liệu của 3 tháng liên tiếp:
--    - Tháng 12 năm 1999
--    - Cả năm 2000
--    - Tháng 1 năm 2001
-- 4. Chỉ lấy những tháng có chênh lệch > 10% so với trung bình
-- Kết quả bao gồm thông tin doanh số hiện tại, trước đó và tiếp theo
with
	v1 as (
		select
			i_category,
			i_brand,
			s_store_name,
			s_company_name,
			d_year,
			d_moy,
			sum(ss_sales_price) sum_sales,
			avg(sum(ss_sales_price)) over (
				partition by
					i_category,
					i_brand,
					s_store_name,
					s_company_name,
					d_year
			) avg_monthly_sales,
			rank() over (
				partition by
					i_category,
					i_brand,
					s_store_name,
					s_company_name
				order by
					d_year,
					d_moy
			) rn
		from
			item,
			store_sales,
			date_dim,
			store
		where
			ss_item_sk = i_item_sk
			and ss_sold_date_sk = d_date_sk
			and ss_store_sk = s_store_sk
			and (
				d_year = 2000
				or (
					d_year = 2000 -1
					and d_moy = 12
				)
				or (
					d_year = 2000 + 1
					and d_moy = 1
				)
			)
		group by
			i_category,
			i_brand,
			s_store_name,
			s_company_name,
			d_year,
			d_moy
	),
	v2 as (
		select
			v1.i_category,
			v1.i_brand,
			v1.d_year,
			v1.d_moy,
			v1.avg_monthly_sales,
			v1.sum_sales,
			v1_lag.sum_sales psum,
			v1_lead.sum_sales nsum
		from
			v1,
			v1 v1_lag,
			v1 v1_lead
		where
			v1.i_category = v1_lag.i_category
			and v1.i_category = v1_lead.i_category
			and v1.i_brand = v1_lag.i_brand
			and v1.i_brand = v1_lead.i_brand
			and v1.s_store_name = v1_lag.s_store_name
			and v1.s_store_name = v1_lead.s_store_name
			and v1.s_company_name = v1_lag.s_company_name
			and v1.s_company_name = v1_lead.s_company_name
			and v1.rn = v1_lag.rn + 1
			and v1.rn = v1_lead.rn - 1
	)
select
	*
from
	v2
where
	d_year = 2000
	and avg_monthly_sales > 0
	and case
		when avg_monthly_sales > 0 then abs(sum_sales - avg_monthly_sales) / avg_monthly_sales
		else null
	end > 0.1
order by
	sum_sales - avg_monthly_sales,
	nsum
limit
	100;