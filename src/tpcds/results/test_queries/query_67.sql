/*
Query này thực hiện:
- Phân tích doanh số bán hàng tại cửa hàng (store_sales) theo nhiều cấp độ:
+ Danh mục sản phẩm (i_category)
+ Nhóm sản phẩm (i_class)
+ Thương hiệu (i_brand)
+ Tên sản phẩm (i_product_name)
+ Theo thời gian: năm (d_year), quý (d_qoy), tháng (d_moy)
+ Theo cửa hàng (s_store_id)
- Sử dụng ROLLUP để tổng hợp theo tất cả các cấp độ trên
- Dữ liệu được lọc trong khoảng 12 tháng (d_month_seq từ 1212 đến 1212+11)
- Xếp hạng doanh số trong từng danh mục sản phẩm
- Chỉ lấy top 100 hàng đầu theo xếp hạng
*/
select
	*
from
	(
		select
			i_category,
			i_class,
			i_brand,
			i_product_name,
			d_year,
			d_qoy,
			d_moy,
			s_store_id,
			sumsales,
			rank() over (
				partition by
					i_category
				order by
					sumsales desc
			) rk
		from
			(
				select
					i_category,
					i_class,
					i_brand,
					i_product_name,
					d_year,
					d_qoy,
					d_moy,
					s_store_id,
					sum(coalesce(ss_sales_price * ss_quantity, 0)) sumsales
				from
					store_sales,
					date_dim,
					store,
					item
				where
					ss_sold_date_sk = d_date_sk
					and ss_item_sk = i_item_sk
					and ss_store_sk = s_store_sk
					and d_month_seq between 1212 and 1212  + 11
				group by
					rollup (
						i_category,
						i_class,
						i_brand,
						i_product_name,
						d_year,
						d_qoy,
						d_moy,
						s_store_id
					)
			) dw1
	) dw2
where
	rk <= 100
order by
	i_category,
	i_class,
	i_brand,
	i_product_name,
	d_year,
	d_qoy,
	d_moy,
	s_store_id,
	sumsales,
	rk
limit
	100;