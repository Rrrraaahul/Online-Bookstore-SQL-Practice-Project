-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID int PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
BULK INSERT dbo.Books
FROM 'C:\Users\ABC\OneDrive\Practice Projects\SQL\30 Day - SQL Practice Files\Books.csv'
WITH (
    FORMAT = 'CSV',              -- SQL Server 2022+ supports FORMAT=CSV
    FIRSTROW = 2,                -- Skip header row if present
    FIELDTERMINATOR = ',',       -- Comma as delimiter
    ROWTERMINATOR = '0x0a',        -- New line as row terminator
    TABLOCK
);

-- Import Data into Customers Table
BULK INSERT dbo.Customers
FROM 'C:\Users\ABC\OneDrive\Practice Projects\SQL\30 Day - SQL Practice Files\Customers.csv'
WITH (
    FORMAT = 'CSV',              -- SQL Server 2022+ supports FORMAT=CSV
    FIRSTROW = 2,                -- Skip header row if present
    FIELDTERMINATOR = ',',       -- Comma as delimiter
    ROWTERMINATOR = '0x0a',        -- New line as row terminator
    TABLOCK
);

-- Import Data into Orders Table
BULK INSERT dbo.orders
FROM 'C:\Users\ABC\OneDrive\Practice Projects\SQL\30 Day - SQL Practice Files\orders.csv'
WITH (
    FORMAT = 'CSV',              -- SQL Server 2022+ supports FORMAT=CSV
    FIRSTROW = 2,                -- Skip header row if present
    FIELDTERMINATOR = ',',       -- Comma as delimiter
    ROWTERMINATOR = '0x0a',        -- New line as row terminator
    TABLOCK
);


-- 1) Retrieve all books in the "Fiction" genre:


select * from Books where Genre = 'Fiction'

-- 2) Find books published after the year 1950:

select * from Books where Published_Year = 1950

-- 3) List all customers from the Canada:
select * from customers where  Country like 'Can%'

-- 4) Show orders placed in November 2023:
select * from orders where Order_Date between '2023-11-01' and '2023-11-30'

select *, Format(Order_Date,'MMM_yyyy') from orders where Format(Order_Date,'MMM_yyyy') = 'Nov_2023'

-- 5) Retrieve the total stock of books available:
select Sum(stock) from Books 

-- 6) Find the details of the most expensive book:

select top 1 * from Books order by Price desc

-- 7) Show all customers who ordered more than 1 quantity of a book:
Select * from orders where Quantity>1

-- 8) Retrieve all orders where the total amount exceeds $20:
Select * from orders where Total_Amount>20

-- 9) List all genres available in the Books table:
Select distinct Genre  from Books 

-- 10) Find the book with the lowest stock:
Select top 1 * from Books order by Stock asc

-- 11) Calculate the total revenue generated from all orders:
Select Sum(Total_Amount) from orders 

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
Select b.Genre,sum(O.Quantity) as Quantity_sold from orders O left join Books B 
on O.Book_ID = B.Book_ID Group By b.Genre


-- 2) Find the average price of books in the "Fantasy" genre:
Select Genre,Avg(Price) as [Avg_Price] from Books where Genre = 'Fantasy' group by Genre


-- 3) List customers who have placed at least 2 orders:
Select C.Name,count(Order_ID) as [ID] from orders O left join
Customers C on o.customer_ID = c.customer_ID Group BY C.Name Having count(Order_ID)>=2 order by c.Name

-- 4) Find the most frequently ordered book:
Select top 1 B.Title, O.Book_ID,Count(O.Order_ID) as [times],sum(O.Quantity) as [qty],sum(o.Total_Amount) as [AMt] from
orders O
left join Books B on o.Book_ID = B.Book_ID Group BY B.Title, O.Book_ID order by qty Desc

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
Select top 3 * from Books where Genre in ('Fantasy') order by Price desc


-- 6) Retrieve the total quantity of books sold by each author:
Select Author,sum(O.Total_Amount) from Books B right join Orders O on O.Book_ID = B.Book_ID 
Group By Author

-- 7) List the cities where customers who spent over $30 are located:
select c.City,c.Customer_ID,o.Total_Amount from Orders O left join 
Customers c on o.Customer_ID = c.Customer_ID where Total_Amount > 30
order by Total_Amount asc

-- 8) Find the customer who spent the most on orders:
select  top 1 c.Customer_ID [ID],C.Name as [Name], sum(o.Total_Amount) as [AMT] from Orders O left join 
Customers c on o.Customer_ID = c.Customer_ID  where Total_Amount > 30
group by c.Customer_ID,[Name]
order by AMT Desc

--9) Calculate the stock remaining after fulfilling all orders:
with cte as (
Select B.Stock as [Stock], B.Book_ID, isnull(Sum(O.Quantity),0) [Sold_Qty]
from Books B left join Orders o on o.Book_ID = b.Book_ID
group by B.Stock, B.Book_ID
)
select *,Stock-Sold_Qty as [Curent_Stock] from cte order by Curent_Stock desc







