/*
Query này thực hiện:
- Tính tổng lợi nhuận (ss_net_profit) từ bảng store_sales theo từng state và county
- Chỉ xét các state nằm trong top 5 state có tổng lợi nhuận cao nhất
- Sử dụng ROLLUP để tổng hợp theo cấp độ state và county
- Dữ liệu được lọc trong khoảng thời gian 12 tháng (d_month_seq từ 1212 đến 1212+11)
- Kết quả được sắp xếp theo cấp bậc phân cấp (lochierarchy) và thứ hạng trong nhóm (rank_within_parent)
*/
select
	sum(ss_net_profit) as total_sum,
	s_state,
	s_county,
	grouping(s_state) + grouping(s_county) as lochierarchy,
	rank() over (
		partition by
			grouping(s_state) + grouping(s_county),
			case
				when grouping(s_county) = 0 then s_state
			end
		order by
			sum(ss_net_profit) desc
	) as rank_within_parent
from
	store_sales,
	date_dim d1,
	store
where
	d1.d_month_seq between 1212 and 1212  + 11
	and d1.d_date_sk = ss_sold_date_sk
	and s_store_sk = ss_store_sk
	and s_state in (
		select
			s_state
		from
			(
				select
					s_state as s_state,
					rank() over (
						partition by
							s_state
						order by
							sum(ss_net_profit) desc
					) as ranking
				from
					store_sales,
					store,
					date_dim
				where
					d_month_seq between 1212 and 1212  + 11
					and d_date_sk = ss_sold_date_sk
					and s_store_sk = ss_store_sk
				group by
					s_state
			) tmp1
		where
			ranking <= 5
	)
group by
	rollup (s_state, s_county)
order by
	lochierarchy desc,
	case
		when lochierarchy = 0 then s_state
	end,
	rank_within_parent
limit
	100;