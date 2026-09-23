-- question-1  top 5 most selling products?
select top 5
    p.product_name,
    count(o.order_id) as total_orders,
    round(sum(try_cast(o.net_sales as float)), 2) as total_sales
from order_items o
inner join product_catalog p on o.product_id = p.product_id
group by p.product_name
order by total_sales desc;


--question-2  region-wise total sales & orders analysis
select
   c.region,
   count(distinct o.order_id) as total_orders,
   round(sum(try_cast(o.net_sales as float)), 2) as total_sales
from order_items o
inner join ecommerce_sales c on o.order_id = c.order_id
group by c.region
order by total_sales desc;


--question-3  payment method-wise total orders,sales & average order value
select
   payment_method,
   count(order_id) as total_orders,
   round(sum(try_cast(net_sales as float)), 2) as total_sales,
   round(avg(try_cast(net_sales as float)), 2) as avg_order_value
FROM ecommerce_sales
group by payment_method
order by total_sales desc;


-- question-4  shipping method analysis: orders, average shipping cost & delayed delivery count
select
   shipping_method,
   count(order_id) as total_orders,
   round(avg(try_cast(shipping_cost as float)), 2) as avg_shipping_cost,
   sum(case when delivery_status = 'delayed' then 1 else 0 end) as delayed_orders_count
from ecommerce_sales
group by shipping_method
order by total_orders desc;

-- question-5  return reason-wise lost sales & order count analysis
select
   return_reason,
   count(order_id) as total_returned_orders,
   round(sum(try_cast(net_sales as float)), 2) as total_lost_sales
from ecommerce_sales
where return_status ='returned'
group by return_reason
order by  total_lost_sales desc;
