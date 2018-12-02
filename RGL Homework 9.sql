use sakila;

-- 1a
select first_name,last_name from actor;
-- 1b
select concat(first_name," ",last_name) as 'Actor Name' from actor;
UPDATE actor SET `Actor Name` = UPPER( `Actor Name` );

-- 2a
Select actor_id, concat(first_name," ",last_name) as 'Actor Name' from actor
where first_name = "Joe";
-- 2b
Select concat(first_name," ",last_name) as 'Actor Name' from actor
where last_name like '%GEN%';
-- 2c
Select concat(first_name," ",last_name) as 'Actor Name' from actor
where last_name like '%LI%' order by last_name asc;
-- 2d
select country_id, country from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE `sakila`.`actor` 
ADD COLUMN `description` BLOB NULL AFTER `last_update`;
-- 3b
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;

-- 4a
Select last_name,count(*) as count from actor group by last_name order by count(*) desc;
-- 4b
Select last_name,count(*) as count from actor group by last_name having count >1 order by count desc;
-- 4c
Update actor SET first_name ='HARPO' WHERE first_name='GROUCHO' and last_name = 'WILLIAMS';
-- 4d
Update actor SET first_name ='GROUCHO' WHERE first_name='HARPO';

-- 5a
show create table address;

-- 6a
select first_name, last_name, address.address from staff
left join (address) using (address_id);
-- 6b
select first_name, last_name, sum(payment.amount) from staff
left join (payment) using (staff_id)
where year(payment.payment_date) = 2005 and month(payment.payment_date) = 8
group by staff.staff_id;
-- 6c
select film.title as 'Film Title', count(film_actor.film_id) as 'Number of Actors' from film_actor
inner join film using (film_id) group by film_actor.film_id;
-- 6d
select count(inventory.film_id) from inventory
inner join film using (film_id) where film.title = 'Hunchback Impossible';
-- 6e
select customer.first_name, customer.last_name, sum(payment.amount) from payment
join customer using (customer_id)
group by customer_id
order by customer.last_name asc;

-- 7a
select film.title from film join language using (language_id) where (title like "K%" or title like "Q%") and language.name = 'English';
-- 7b
select first_name, Last_name from actor where actor_id in
	(
	select actor_id from film_actor where film_id in
		(
		select film_id from film where title = 'Alone Trip'
		)
	);
-- 7c
select customer.first_name, customer.last_name, customer.email from customer 
	join address using (address_id)
    join city using (city_id)
    join country using (country_id)
    where country.country = 'Canada';
-- 7d
select title from film where film_id in
	(
    select film_id from film_category where category_id in 
		(
		select category_id from category where name = 'Family'
		)
	);
-- 7e
select film.title, count(inventory_id) from rental
	join inventory using (inventory_id)
    join film using (film_id)
    group by film.title
    order by count(inventory_id) desc;
-- 7f
select inventory.store_id, sum(payment.amount) from payment 
join rental using(rental_id)
join inventory using (inventory_id)
group by inventory.store_id;
-- 7g
select store.store_id, city.city, country.country from store
join address using(address_id)
join city using(city_id)
join country using(country_id)
group by store.store_id;
-- 7h
select category.name, sum(payment.amount) from payment
join rental using(rental_id)
join inventory using(inventory_id)
join film_category using (film_id)
join category using (category_id)
group by category.name
order by sum(payment.amount) desc;

-- 8a
create view TopGenres as
select category.name as 'Genre', sum(payment.amount) as 'Gross Revenue' from payment
join rental using(rental_id)
join inventory using(inventory_id)
join film_category using (film_id)
join category using (category_id)
group by category.name
order by sum(payment.amount) desc;
-- 8b
select * from TopGenres;
-- 8c
drop view TopGenres;

