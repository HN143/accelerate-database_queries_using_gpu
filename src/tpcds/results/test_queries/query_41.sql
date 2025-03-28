-- Truy vấn này tìm kiếm tên các sản phẩm dựa trên nhiều tiêu chí phức tạp:
-- 1. Sản phẩm từ các nhà sản xuất có mã từ 742 đến 782
-- 2. Nhà sản xuất phải có ít nhất một sản phẩm thỏa mãn các tiêu chí sau:
--    - Danh mục "Women":
--      + (Màu orchid/papaya, đơn vị Pound/Lb, kích thước petite/medium) hoặc
--      + (Màu burlywood/navy, đơn vị Bundle/Each, kích thước N/A/extra large)
--    - Danh mục "Men":
--      + (Màu bisque/azure, đơn vị N/A/Tsp, kích thước small/large) hoặc
--      + (Màu chocolate/cornflower, đơn vị Bunch/Gross, kích thước petite/medium)
--    Hoặc thỏa mãn bộ tiêu chí tương tự với các giá trị khác
-- Kết quả trả về tên sản phẩm không trùng lặp
select distinct
	(i_product_name)
from
	item i1
where
	i_manufact_id between 742 and 742  + 40
	and (
		select
			count(*) as item_cnt
		from
			item
		where
			(
				i_manufact = i1.i_manufact
				and (
					(
						i_category = 'Women'
						and (
							i_color = 'orchid'
							or i_color = 'papaya'
						)
						and (
							i_units = 'Pound'
							or i_units = 'Lb'
						)
						and (
							i_size = 'petite'
							or i_size = 'medium'
						)
					)
					or (
						i_category = 'Women'
						and (
							i_color = 'burlywood'
							or i_color = 'navy'
						)
						and (
							i_units = 'Bundle'
							or i_units = 'Each'
						)
						and (
							i_size = 'N/A'
							or i_size = 'extra large'
						)
					)
					or (
						i_category = 'Men'
						and (
							i_color = 'bisque'
							or i_color = 'azure'
						)
						and (
							i_units = 'N/A'
							or i_units = 'Tsp'
						)
						and (
							i_size = 'small'
							or i_size = 'large'
						)
					)
					or (
						i_category = 'Men'
						and (
							i_color = 'chocolate'
							or i_color = 'cornflower'
						)
						and (
							i_units = 'Bunch'
							or i_units = 'Gross'
						)
						and (
							i_size = 'petite'
							or i_size = 'medium'
						)
					)
				)
			)
			or (
				i_manufact = i1.i_manufact
				and (
					(
						i_category = 'Women'
						and (
							i_color = 'salmon'
							or i_color = 'midnight'
						)
						and (
							i_units = 'Oz'
							or i_units = 'Box'
						)
						and (
							i_size = 'petite'
							or i_size = 'medium'
						)
					)
					or (
						i_category = 'Women'
						and (
							i_color = 'snow'
							or i_color = 'steel'
						)
						and (
							i_units = 'Carton'
							or i_units = 'Tbl'
						)
						and (
							i_size = 'N/A'
							or i_size = 'extra large'
						)
					)
					or (
						i_category = 'Men'
						and (
							i_color = 'purple'
							or i_color = 'gainsboro'
						)
						and (
							i_units = 'Dram'
							or i_units = 'Unknown'
						)
						and (
							i_size = 'small'
							or i_size = 'large'
						)
					)
					or (
						i_category = 'Men'
						and (
							i_color = 'metallic'
							or i_color = 'forest'
						)
						and (
							i_units = 'Gram'
							or i_units = 'Ounce'
						)
						and (
							i_size = 'petite'
							or i_size = 'medium'
						)
					)
				)
			)
	) > 0
order by
	i_product_name
limit
	100;