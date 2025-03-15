-- Query 89: Phân tích biến động doanh số bán hàng theo danh mục sản phẩm và cửa hàng
--
-- Mô tả: Truy vấn này tìm kiếm những trường hợp có sự biến động lớn (>10%) trong doanh số bán hàng
-- so với mức trung bình hàng tháng. Phân tích được thực hiện trên:
-- - Các danh mục sản phẩm: Home, Books, Electronics, Shoes, Jewelry, Men
-- - Các lớp sản phẩm cụ thể: wallpaper, parenting, musical, womens, birdal, pants
-- - Theo từng cửa hàng và công ty
-- - Dữ liệu năm 2000
select
	*
from
	(
		select
			i_category,
			i_class,
			i_brand,
			s_store_name,
			s_company_name,
			d_moy,
			sum(ss_sales_price) sum_sales,
			avg(sum(ss_sales_price)) over (
				partition by
					i_category,
					i_brand,
					s_store_name,
					s_company_name
			) avg_monthly_sales
		from
			item,
			store_sales,
			date_dim,
			store
		where
			ss_item_sk = i_item_sk
			and ss_sold_date_sk = d_date_sk
			and ss_store_sk = s_store_sk
			and d_year in (2000)
			and (
				(
					i_category in ('Home', 'Books', 'Electronics')
					and i_class in ('wallpaper', 'parenting', 'musical')
				)
				or (
					i_category in ('Shoes', 'Jewelry', 'Men')
					and i_class in ('womens', 'birdal', 'pants')
				)
			)
		group by
			i_category,
			i_class,
			i_brand,
			s_store_name,
			s_company_name,
			d_moy
	) tmp1
where
	case
		when (avg_monthly_sales <> 0) then (
			abs(sum_sales - avg_monthly_sales) / avg_monthly_sales
		)
		else null
	end > 0.1
order by
	sum_sales - avg_monthly_sales,
	s_store_name
limit
	100;