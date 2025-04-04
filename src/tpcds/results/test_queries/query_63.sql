/*
Query này thực hiện:
- Phân tích doanh số bán hàng theo người quản lý (i_manager_id)
- Chỉ xét các sản phẩm thuộc các nhóm:
1. Danh mục: Books, Children, Electronics
Nhóm: personal, portable, reference, self-help
Thương hiệu: scholaramalgamalg #14, #7, #9, exportiunivamalg #9
2. Danh mục: Women, Music, Men
Nhóm: accessories, classical, fragrances, pants
Thương hiệu: amalgimporto #1, edu packscholar #1, exportiimporto #1, importoamalg #1
- Dữ liệu được lọc trong khoảng 12 tháng (d_month_seq từ 1212 đến 1212+11)
- So sánh doanh số với doanh số trung bình
- Chỉ lấy các trường hợp có độ lệch > 10% so với trung bình
*/
select
	*
from
	(
		select
			i_manager_id,
			sum(ss_sales_price) sum_sales,
			avg(sum(ss_sales_price)) over (
				partition by
					i_manager_id
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
			and d_month_seq in (
				1212,
				1212 + 1,
				1212 + 2,
				1212 + 3,
				1212 + 4,
				1212 + 5,
				1212 + 6,
				1212 + 7,
				1212 + 8,
				1212 + 9,
				1212 + 10,
				1212 + 11
			)
			and (
				(
					i_category in ('Books', 'Children', 'Electronics')
					and i_class in ('personal', 'portable', 'reference', 'self-help')
					and i_brand in (
						'scholaramalgamalg #14',
						'scholaramalgamalg #7',
						'exportiunivamalg #9',
						'scholaramalgamalg #9'
					)
				)
				or (
					i_category in ('Women', 'Music', 'Men')
					and i_class in ('accessories', 'classical', 'fragrances', 'pants')
					and i_brand in (
						'amalgimporto #1',
						'edu packscholar #1',
						'exportiimporto #1',
						'importoamalg #1'
					)
				)
			)
		group by
			i_manager_id,
			d_moy
	) tmp1
where
	case
		when avg_monthly_sales > 0 then abs(sum_sales - avg_monthly_sales) / avg_monthly_sales
		else null
	end > 0.1
order by
	i_manager_id,
	avg_monthly_sales,
	sum_sales
limit
	100;