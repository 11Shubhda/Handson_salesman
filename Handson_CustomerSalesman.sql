create database Handson
use Handson

create table salesman
(
salesman_id numeric(5) primary key,
Name varchar(30), 
City varchar(15),
Commission decimal(5,2)
)


insert into salesman values(5001,'James Hoog', 'New York', 0.15)
insert into salesman values( 5002, 'Nail Knite', 'Paris', 0.13)
insert into salesman values(5005, 'Pit Alex', 'London', 0.11)
insert into salesman values(5006, 'Mc Lyon', 'Paris', 0.14)
insert into salesman values(5007, 'Paul Adam', 'Rome', 0.13)
insert into salesman values(5003, 'Lauson Hen','San Jose', 0.12)

select * from salesman
drop table salesman

create table customer
(
customer_id numeric(5, 0) primary key,
cust_name varchar(30), 
city varchar(15),
grade numeric(3),
salesman_id numeric(5)
)


insert into customer values(3002, 'Nick Rimando', 'New York', 100, 5001)
insert into customer values(3001, 'Brad Guzan', 'London', 200, 5005)
insert into customer values(3005, 'Graham Zusi', 'California', 200, 5002)
insert into customer values(3008, 'Julian Green', 'London', 300, 5002)
insert into customer values(3004, 'Fabian Johnson', 'Paris', 300, 5006)
insert into customer values(3009, 'Geoff Cameron', 'Berlin', 100, 5003)
insert into customer values(3003, 'Jozy Altidor', 'Moscow', 200, 5007)
insert into customer values(3007, 'Brad Davis', 'New York', 200 , 5001)


select * from customer
drop table customer

create table orders
(
ord_no numeric(5) primary key,
purch_amt decimal(8,2), 
ord_date Date,
customer_id numeric(5) references customer(customer_id),
salesman_id numeric(5) references salesman(salesman_id)
)


insert into orders values (70008, 5760, '2012-09-10', '3002', '5001')
insert into orders values (70001, 150.5, '2012-10-05',  '3005', '5002')
insert into orders values (70009, 270.65, '2012-09-10', '3001', '5005')
insert into orders values (70002, 65.26, '2012-10-05', '3002', '5001')
insert into orders values (70004, 110.5, '2012-08-17', '3009', '5003')
insert into orders values (70007, 948.5, '2012-09-10', '3005', '5002')
insert into orders values (70005, 2400.6, '2012-07-27', '3007', '5001')
insert into orders values (70008, 5760, '2012-09-10', '3002', '5001')
insert into orders values (70010, 1983.43, '2012-10-10', '3004', '5006')
insert into orders values (70003, 2480.4, '2012-10-10',  '3009', '5003')
insert into orders values (70012, 250.45, '2012-06-27',  '3008', '5002')
insert into orders values (70011, 75.29, '2012-08-17', '3003', '5007')
insert into orders values (70013, 3045.6, '2012-04-25',  '3002', '5001')

select * from orders
drop table orders

--1 Write a query to display the columns in a specific order like order date, salesman id, order number and purchase amount from for all the orders
SELECT ord_date, salesman_id, ord_no, purch_amt
FROM orders;

--2 write a SQL query to find the unique salespeople ID. Return salesman_id.
SELECT DISTINCT salesman_id
FROM orders;

--3 write a SQL query to find the salespeople who lives in the City of 'Paris'. Return salesperson's name, city
SELECT name,city
FROM salesman
WHERE city='Paris';

--4 write a SQL query to find the orders, which are delivered by a salesperson of ID. 5001. Return ord_no, ord_date, purch_amt
SELECT ord_no, ord_date, purch_amt
FROM orders
WHERE salesman_id=5001;

--5 write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id.
SELECT * 
FROM customer 
WHERE city = 'New York' AND grade>100;

--6 write a SQL query to find the details of those salespeople whose commissions range from 0.10 to0.12. Return salesman_id, name, city, and commission
SELECT salesman_id,name,city,commission 
FROM salesman 
WHERE (commission > 0.10 
AND commission< 0.12);

--7 write a SQL query to calculate total purchase amount of all orders. Return total purchase amount.
SELECT SUM (purch_amt) 
FROM orders;

--8 write a SQL query to calculate average purchase amount of all orders. Return average purchase amount.
SELECT AVG (purch_amt) 
FROM orders;

--9 write a SQL query to count the number of unique salespeople. Return number of salespeople.
SELECT COUNT (DISTINCT salesman_id) 
FROM orders;

--10 write a SQL query to find the highest purchase amount ordered by each customer. Return customer ID, maximum purchase amount
SELECT customer_id,ord_date,MAX(purch_amt) 
FROM orders 
GROUP BY customer_id,ord_date;


--11 write a SQL query to find the highest purchase amount ordered by each customer on a particular date. Return, order date and highest purchase amoun
SELECT customer_id,ord_date,MAX(purch_amt) 
FROM orders 
GROUP BY customer_id,ord_date 
HAVING MAX(purch_amt)>2000.00;

--12 write a SQL query to find the highest purchase amount on '2012-08-17' by each salesperson. Return salesperson ID, purchase amount. 
SELECT salesman_id,MAX(purch_amt) 
FROM orders 
WHERE ord_date = '2012-08-17' 
GROUP BY salesman_id;

--13 write a SQL query to find the salesperson and customer who belongs to same city. Return Salesman, cust_name and city.
SELECT salesman.name AS "Salesman",
customer.cust_name, customer.city 
FROM salesman,customer 
WHERE salesman.city=customer.city;

--14 write a SQL query to find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city
SELECT  a.ord_no,a.purch_amt,
b.cust_name,b.city 
FROM orders a,customer b 
WHERE a.customer_id=b.customer_id 
AND a.purch_amt BETWEEN 500 AND 2000;

--15 write a SQL query to find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission
SELECT a.cust_name AS "Customer Name", 
a.city, b.name AS "Salesman", b.commission 
FROM customer a 
INNER JOIN salesman b 
ON a.salesman_id=b.salesman_id 
WHERE b.commission>.12;

--16 write a SQL query to display the cust_name, customer city, grade, Salesman, salesman city. The result should be ordered by ascending on customer_id.
SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman",b.city 
FROM customer a 
LEFT JOIN salesman b 
ON a.salesman_id=b.salesman_id 
order by a.customer_id;


SELECT *
FROM orders
WHERE salesman_id =
    (SELECT salesman_id 
     FROM salesman 
     WHERE name='Paul Adam');

SELECT *
FROM orders
WHERE salesman_id in
    (SELECT salesman_id 
     FROM salesman 
     WHERE city='London')

SELECT *
FROM orders
WHERE salesman_id =
    (SELECT DISTINCT salesman_id 
     FROM orders 
     WHERE customer_id =3007);

SELECT *
FROM orders
WHERE purch_amt >
    (SELECT  AVG(purch_amt) 
     FROM orders 
     WHERE ord_date ='10/10/2012');

SELECT *
FROM orders
WHERE salesman_id IN
    (SELECT salesman_id 
     FROM salesman 
     WHERE city ='New York');

SELECT salesman_id,name 
FROM salesman a 
WHERE 1 < 
    (SELECT COUNT(*) 
     FROM customer 
     WHERE salesman_id=a.salesman_id);

SELECT * 
FROM orders a
WHERE purch_amt >=
    (SELECT AVG(purch_amt) FROM orders b 
     WHERE b.customer_id = a.customer_id);

SELECT ord_date, SUM (purch_amt)
FROM orders a
GROUP BY ord_date
HAVING SUM (purch_amt) >
    (SELECT 1000.00 + MAX(purch_amt) 
     FROM orders b 
     WHERE a.ord_date = b.ord_date);

SELECT customer_id,cust_name, city
FROM customer
WHERE EXISTS
   (SELECT *
    FROM customer 
    WHERE city='London');

SELECT * 
FROM salesman 
WHERE salesman_id IN (
   SELECT DISTINCT salesman_id 
   FROM customer a 
   WHERE EXISTS (
      SELECT * 
      FROM customer b 
      WHERE b.salesman_id=a.salesman_id 
      AND b.cust_name<>a.cust_name));










