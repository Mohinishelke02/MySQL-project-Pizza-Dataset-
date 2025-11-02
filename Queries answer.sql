-- 1)Retrieve the total number of orders placed.
select count(order_details_id) from order_details;

-- 2)Calculate the total revenue generated from pizza sales.
select sum(quantity*price) as Total_Revenue from order_details inner join  pizzas on order_details.pizza_id=pizzas.pizza_id;

-- 3)Identify the highest-priced pizza.
select name,category,price from pizzas inner join pizza_types1 on pizzas.pizza_type_id=pizza_types1.pizza_type_id
order by price desc
limit 1;

-- 4)Identify the most common pizza size ordered.
select size,count(order_details_id) Number_of_time_order_place from pizzas inner join order_details on pizzas.pizza_id=order_details.pizza_id
group by size
order by count(order_details_id) desc
limit 1;

-- 5)List the top 5 most ordered pizza types along with their quantities.
select name,category,sum(quantity) from pizzas inner join order_details on pizzas.pizza_id=order_details.pizza_id 
					inner join pizza_types1 on pizza_types1.pizza_type_id=pizzas.pizza_type_id
group by name,category
order by sum(quantity) desc
limit 5 ;

-- 6)Join the necessary tables to find the total quantity of each pizza category ordered.
select category,sum(quantity) from pizzas inner join order_details on pizzas.pizza_id=order_details.pizza_id 
					inner join pizza_types1 on pizza_types1.pizza_type_id=pizzas.pizza_type_id
group by category
order by sum(quantity) desc ;

-- 7)Join relevant tables to find the category-wise distribution of pizzas.

-- 8)Group the orders by date and calculate the average number of pizzas ordered per day.
select  date,count(order_id) from orders
group by date ;

-- 9)Determine the top 3 most ordered pizza types based on revenue.
select name,category,sum(quantity*price) as revenue from pizzas inner join order_details on pizzas.pizza_id=order_details.pizza_id 
					inner join pizza_types1 on pizza_types1.pizza_type_id=pizzas.pizza_type_id
 group by name,category
 order by revenue desc
 limit 3;

 -- 10)Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select * from(
select category,name,revenue,dense_rank() over (partition by category order by revenue) as rnk from (
select name,category ,sum(quantity*price) as revenue from pizzas inner join order_details on pizzas.pizza_id=order_details.pizza_id 
					inner join pizza_types1 on pizza_types1.pizza_type_id=pizzas.pizza_type_id
                    group by name,category
                    order by revenue desc) as a) as b
where rnk<4;                    



