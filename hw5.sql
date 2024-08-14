use `goit-rdb-hw-03`;

-- 1
select
    order_details.*,
    (select orders.customer_id
     from orders
     where orders.id = order_details.order_id) as customer_id
from order_details;

-- 2
select
    order_details.*
from
    order_details
where
    order_details.order_id in (
        select
            orders.id
        from
            orders
        where
            orders.shipper_id = 3
    );

-- 3
select
    subquery.order_id,
    avg(subquery.quantity) as avg_quantity
from
    (select
        *
     from
        order_details
     where
        quantity > 10) as subquery
group by
    subquery.order_id;

-- 4
with temp as (
    select
        *
    from
        order_details
    where
        quantity > 10
)
select
    temp.order_id,
    avg(temp.quantity) as avg_quantity
from
    temp
group by
    temp.order_id;

-- 5
DROP FUNCTION IF EXISTS divide_floats;

CREATE FUNCTION divide_floats(a FLOAT, b FLOAT)
    RETURNS FLOAT
    DETERMINISTIC
    NO SQL
BEGIN
    RETURN a / b;
END;

SELECT
    order_id,
    product_id,
    quantity,
    divide_floats(quantity, 2.5) AS divided_quantity
FROM
    order_details;