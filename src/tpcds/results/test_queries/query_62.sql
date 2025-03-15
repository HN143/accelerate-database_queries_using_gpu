/*
Query này thực hiện:
- Phân tích thời gian xử lý và giao hàng của web_sales
- Phân loại đơn hàng theo thời gian xử lý:
+ 30 ngày hoặc ít hơn
+ 31-60 ngày
+ 61-90 ngày
+ 91-120 ngày
+ Trên 120 ngày
- Dữ liệu được nhóm theo:
+ Tên kho hàng (20 ký tự đầu)
+ Loại vận chuyển
+ Tên website
- Dữ liệu được lọc trong khoảng 12 tháng (d_month_seq từ 1212 đến 1212+11)
*/
select
	substr (w_warehouse_name, 1, 20),
	sm_type,
	web_name,
	sum(
		case
			when (ws_ship_date_sk - ws_sold_date_sk <= 30) then 1
			else 0
		end
	) as "30 days",
	sum(
		case
			when (ws_ship_date_sk - ws_sold_date_sk > 30)
			and (ws_ship_date_sk - ws_sold_date_sk <= 60) then 1
			else 0
		end
	) as "31-60 days",
	sum(
		case
			when (ws_ship_date_sk - ws_sold_date_sk > 60)
			and (ws_ship_date_sk - ws_sold_date_sk <= 90) then 1
			else 0
		end
	) as "61-90 days",
	sum(
		case
			when (ws_ship_date_sk - ws_sold_date_sk > 90)
			and (ws_ship_date_sk - ws_sold_date_sk <= 120) then 1
			else 0
		end
	) as "91-120 days",
	sum(
		case
			when (ws_ship_date_sk - ws_sold_date_sk > 120) then 1
			else 0
		end
	) as ">120 days"
from
	web_sales,
	warehouse,
	ship_mode,
	web_site,
	date_dim
where
	d_month_seq between 1212 and 1212  + 11
	and ws_ship_date_sk = d_date_sk
	and ws_warehouse_sk = w_warehouse_sk
	and ws_ship_mode_sk = sm_ship_mode_sk
	and ws_web_site_sk = web_site_sk
group by
	substr (w_warehouse_name, 1, 20),
	sm_type,
	web_name
order by
	substr (w_warehouse_name, 1, 20),
	sm_type,
	web_name
limit
	100;