/*
Mô tả:
- Phân tích số lượng tồn kho trung bình theo phân cấp sản phẩm
- Thông tin hiển thị bao gồm:
+ Tên sản phẩm
+ Thương hiệu
+ Phân loại (class)
+ Danh mục
+ Số lượng tồn kho trung bình
- Dữ liệu được lấy trong 12 tháng liên tiếp (tháng 1212 và 11 tháng tiếp theo)
- Kết quả được nhóm theo rollup của các cấp phân loại sản phẩm
- Sắp xếp theo số lượng tồn kho và thông tin sản phẩm
- Giới hạn 100 bản ghi
*/
select
	i_product_name,
	i_brand,
	i_class,
	i_category,
	avg(inv_quantity_on_hand) qoh
from
	inventory,
	date_dim,
	item
where
	inv_date_sk = d_date_sk
	and inv_item_sk = i_item_sk
	and d_month_seq between 1212 and 1212  + 11
group by
	rollup (i_product_name, i_brand, i_class, i_category)
order by
	qoh,
	i_product_name,
	i_brand,
	i_class,
	i_category
limit
	100;