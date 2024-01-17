{{ config (
materialized='table'
)  }}

with customer_orders as (
  select
     customer_id
     , count(*) as n_orders
     , min(created_at) as first_order_at

  from `analytics-engineers-club.coffee_shop.orders` 
  group by 1
)

select 
  customers.id as customer_id
  , customers.name
  , customers.email
  , COUNT(customer_orders.n_orders) as n_orders
  , customer_orders.first_order_at
from `analytics-engineers-club.coffee_shop.customers` as customers
left join  customer_orders
  on  customers.id = customer_orders.customer_id 
group by 1,2,3,5