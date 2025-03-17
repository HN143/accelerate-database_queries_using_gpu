-- Truy vấn này phân tích doanh số bán hàng tại các cửa hàng cho những khách hàng có
-- quốc gia sinh khác với quốc gia họ đang sinh sống, với điều kiện mã bưu điện của
-- cửa hàng trùng với mã bưu điện của khách hàng và cửa hàng thuộc thị trường số 7.
-- Kết quả được lọc theo màu sắc sản phẩm (orchid và chiffon) và chỉ hiển thị những
-- khách hàng có tổng doanh số lớn hơn 5% mức trung bình.

with ssales as (
    select
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size,
        sum(ss_sales_price) netpaid
    from
        store_sales,
        store_returns,
        store,
        item,
        customer,
        customer_address
    where
        ss_ticket_number = sr_ticket_number
        and ss_item_sk = sr_item_sk
        and ss_customer_sk = c_customer_sk
        and ss_item_sk = i_item_sk
        and ss_store_sk = s_store_sk
        and c_current_addr_sk = ca_address_sk
        and c_birth_country <> upper(ca_country)
        and s_zip = ca_zip
        and s_market_id = 7
    group by
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size
)
select
    c_last_name,
    c_first_name,
    s_store_name,
    sum(netpaid) paid
from
    ssales
where
    i_color = 'orchid'
group by
    c_last_name,
    c_first_name,
    s_store_name
having
    sum(netpaid) > (
        select
            0.05 * avg(netpaid)
        from
            ssales
    )
order by
    c_last_name,
    c_first_name,
    s_store_name;

with ssales as (
    select
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size,
        sum(ss_sales_price) netpaid
    from
        store_sales,
        store_returns,
        store,
        item,
        customer,
        customer_address
    where
        ss_ticket_number = sr_ticket_number
        and ss_item_sk = sr_item_sk
        and ss_customer_sk = c_customer_sk
        and ss_item_sk = i_item_sk
        and ss_store_sk = s_store_sk
        and c_current_addr_sk = ca_address_sk
        and c_birth_country <> upper(ca_country)
        and s_zip = ca_zip
        and s_market_id = 7
    group by
        c_last_name,
        c_first_name,
        s_store_name,
        ca_state,
        s_state,
        i_color,
        i_current_price,
        i_manager_id,
        i_units,
        i_size
)
select
    c_last_name,
    c_first_name,
    s_store_name,
    sum(netpaid) paid
from
    ssales
where
    i_color = 'chiffon'
group by
    c_last_name,
    c_first_name,
    s_store_name
having
    sum(netpaid) > (
        select
            0.05 * avg(netpaid)
        from
            ssales
    )
order by
    c_last_name,
    c_first_name,
    s_store_name;