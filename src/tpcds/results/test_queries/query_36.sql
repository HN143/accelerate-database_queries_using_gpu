-- Truy vấn này phân tích tỷ suất lợi nhuận gộp của cửa hàng theo phân cấp danh mục sản phẩm:
-- 1. Tính tỷ lệ lợi nhuận ròng trên doanh thu
-- 2. Phân theo danh mục và lớp sản phẩm
-- 3. Sử dụng ROLLUP để tạo báo cáo tổng hợp theo cấp bậc
-- 4. Chỉ xét các cửa hàng ở tiểu bang TN (Tennessee)
-- 5. Dữ liệu trong năm 2000
-- Kết quả được sắp xếp theo cấp bậc phân cấp và xếp hạng trong cùng nhóm
select
	sum(ss_net_profit) / sum(ss_ext_sales_price) as gross_margin,
	i_category,
	i_class,
	grouping(i_category) + grouping(i_class) as lochierarchy,
	rank() over (
		partition by
			grouping(i_category) + grouping(i_class),
			case
				when grouping(i_class) = 0 then i_category
			end
		order by
			sum(ss_net_profit) / sum(ss_ext_sales_price) asc
	) as rank_within_parent
from
	store_sales,
	date_dim d1,
	item,
	store
where
	d1.d_year = 2000
	and d1.d_date_sk = ss_sold_date_sk
	and i_item_sk = ss_item_sk
	and s_store_sk = ss_store_sk
	and s_state in ('TN', 'TN', 'TN', 'TN', 'TN', 'TN', 'TN', 'TN')
group by
	rollup (i_category, i_class)
order by
	lochierarchy desc,
	case
		when lochierarchy = 0 then i_category
	end,
	rank_within_parent
limit
	100;