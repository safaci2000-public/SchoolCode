1.

select cust.cust_fname, cust.cust_lname from musich.cust where cust.cust_credit_limit > 10000 order by cust.cust_lname;

2.

select item.item_description, item.item_quan_on_hand from musich.item order by item.item_quan_on_hand desc;

3.  

select musich.orders.order_number, musich.orders.order_date, musich.orders.cust_id, musich.cust.cust_lname, musich.cust.cust_fname from musich.cust, musich.orders order by musich.orders.order_number;

4.

select musich.ordlin.order_number, musich.ordlin.item_number, musich.item.item_description, musich.item.item_price, musich.ordlin.order_price from musich.item, musich.ordlin where musich.ordlin.order_price < musich.item.item_price;

5.  

select musich.orders.order_number, musich.cust.cust_lname, musich.cust.cust_fname from musich.orders, musich.cust where musich.orders.order_date = '05-JUL-02' OR musich.orders.order_date='10-JUL-02' OR musich.orders.order_date = '15-JUL-02'  order by musich.orders.order_number;

6.

select musich.ordlin.order_number, sum(musich.ordlin.order_price) from musich.ordlin group by musich.ordlin.order_number order by musich.ordlin.order_number desc
/

7.

select cust.cust_id, cust.cust_lname, cust.cust_fname from musich.cust where musich.cust.cust_balance > musich.cust.cust_credit_limit order by musich.cust.cust_id

8.

select distinct musich.cust.cust_fname, musich.cust.cust_lname, musich.ordlin.order_number from musich.cust, musich.orders, musich.ordlin, musich.item where lower(musich.item.item_description) = 'air conditioner'
AND musich.orders.cust_id = musich.cust.cust_id AND musich.orders.order_number = musich.ordlin.order_number AND musich.item.item_number = musich.ordlin.item_number order by  musich.cust.cust_fname


9.

select musich.ordlin.order_number, musich.cust.cust_fname, musich.cust.cust_lnam
e, musich.ordlin.order_price from musich.ordlin, musich.cust, musich.orders wher
e
( select sum (musich.ordlin.order_price * musich.ordlin.quantity_ordered) from m
usich.ordlin)  > 1000 AND musich.orders.cust_id = musich.cust.cust_id AND musich
.orders.order_number = musich.ordlin.order_number

10.

select musich.orders.order_number, musich.item.item_number, musich.item.item_description from musich.orders, musich.item where musich.orders.cust_id = '145' order by musich.item.item_number;

11.


select musich.cust.cust_city, count(musich.cust.cust_id) from musich.cust group by musich.cust.cust_city order by musich.cust.cust_city;

12.

select musich.cust.cust_id, musich.cust.cust_balance from musich.cust order by musich.cust.cust_balance desc, musich.cust.cust_id;


13. 


select musich.orders.order_number, musich.cust.cust_fname, musich.cust.cust_lname, musich.item.item_number, musich.item.item_quan_on_hand, musich.ordlin.quantity_ordered
 from musich.orders, musich.cust, musich.item, musich.ordlin
 where musich.ordlin.quantity_ordered > musich.item.item_quan_on_hand
 AND musich.orders.cust_id = musich.cust.cust_id AND musich.orders.order_number = musich.ordlin.order_number AND musich.item.item_number = musich.ordlin.item_number
 /

14.

select musich.cust.cust_id, musich.cust.cust_credit_limit from musich.cust where musich.cust.cust_credit_limit > (select avg (musich.cust.cust_credit_limit) from musich.cust);

15.  


select distinct musich.cust.cust_fname, musich.cust.cust_lname from musich.cust, musich.orders, musich.ordlin, musich.item where lower(musich.item.item_description) = 'puffy shirt' order by musich.cust.cust_fname6.  

16.

	 select musich.item.item_number, musich.item.item_description, musich.item.item_price from musich.item where musich.item.item_price between 100 and 350;

