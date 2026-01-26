# Online Bookstore SQL Practice Project

## Overview
This project is a SQL practice project based on an Online Bookstore database.
I created the database structure, imported data from CSV files, and wrote SQL queries
to solve real-world business questions.

All queries in this project are written by me as part of my SQL learning and hands-on practice.

## Objectives
- Practice database design using SQL
- Write queries to analyze sales, customers, and books
- Improve understanding of joins, aggregation, and filtering
- Build a genuine SQL portfolio project

## Database Structure
The project uses three tables:

- Books  
  (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)

- Customers  
  (Customer_ID, Name, Email, Phone, City, Country)

- Orders  
  (Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)

## Data Loading
Data is imported into tables using BULK INSERT from CSV files:
- Books.csv
- Customers.csv
- Orders.csv

## SQL Topics Covered
- SELECT, WHERE, ORDER BY
- GROUP BY, HAVING
- Aggregate functions (SUM, AVG, COUNT)
- Joins (LEFT JOIN, RIGHT JOIN)
- Date filtering
- Common Table Expressions (CTE)
- Data analysis queries

## Queries Solved
- Genre-wise and year-wise book analysis
- Customer and country-based filtering
- Monthly order analysis
- Total revenue and stock calculations
- Most expensive and most ordered books
- Customers with multiple orders
- Remaining stock after fulfilling orders

## How to Use
1. Create the database using the SQL script
2. Import CSV files using BULK INSERT
3. Run queries in SQL Server Management Studio
4. Modify queries for additional practice

## Authenticity Note
All SQL queries in this repository are written by me during practice
and represent my own understanding of SQL concepts.

## Author
Rahul Pal    
Skills: SQL, Excel, Power BI

## Resume Line
Designed and queried an Online Bookstore database using SQL
to analyze sales, customers, and inventory data.
