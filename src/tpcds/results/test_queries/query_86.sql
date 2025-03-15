-- Query 86: Phân tích doanh thu bán hàng trực tuyến theo phân cấp danh mục sản phẩm
--
-- Mô tả: Truy vấn tổng hợp doanh thu thuần (ws_net_paid) từ bán hàng trực tuyến theo:
-- - Phân cấp danh mục sản phẩm (category và class)
-- - Sử dụng ROLLUP để tạo báo cáo tổng hợp theo cấp độ
-- - Xếp hạng trong từng nhóm phân cấp
-- Dữ liệu được lấy trong khoảng 12 tháng (từ tháng 1212 đến 1212+11)
-- Kết quả được sắp xếp theo cấp bậc phân cấp và xếp hạng
select
	sum(ws_net_paid) as total_sum,
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
			sum(ws_net_paid) desc
	) as rank_within_parent
from
	web_sales,
	date_dim d1,
	item
where
	d1.d_month_seq between 1212 and 1212  + 11
	and d1.d_date_sk = ws_sold_date_sk
	and i_item_sk = ws_item_sk
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