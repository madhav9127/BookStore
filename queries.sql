--Creare Database
CREATE DATABASE OnlineBookstore

--Use Database
USE OnlineBookStore

--Create Tables
DROP TABLE IF EXISTS Books 
CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
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

--Import data in books table
BULK INSERT Books
FROM 'C:\Users\ASUS\Desktop\30 Day - SQL Practice Files- SD50\Books.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);

--Import data in customer table
BULK INSERT Customers
FROM 'C:\Users\ASUS\Desktop\30 Day - SQL Practice Files- SD50\Customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);

--Import data in orders table
BULK INSERT Orders
FROM 'C:\Users\ASUS\Desktop\30 Day - SQL Practice Files- SD50\Orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);


--Basic queries


SELECT * FROM Books
SELECT * FROM Customers 
SELECT * FROM Orders



--q1 Retrieve all books in the "Fiction" genre:

SELECT * FROM Books WHERE Genre='Fiction'

--q2 Find books published after the year 1950:
SELECT * FROM Books WHERE Published_Year > 1950

--q3 List all customers from the Canada:
SELECT * FROM Customers WHERE Country='Canada'

--q4 Show orders placed in November 2023:
SELECT * FROM Orders WHERE Order_Date >= '2023-11-01' AND Order_Date < '2023-12-01'

--q5 Retrieve the total stock of books available:
SELECT SUM(Stock) AS Total_Stocks FROM Books

--q6 Find the details of the most expensive book:
SELECT * FROM Books WHERE Price = ( SELECT MAX(Price) FROM Books)

--q7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders WHERE quantity>1;




--q8 Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders WHERE Total_Amount>20

--q9 List all genres available in the Books table:
SELECT DISTINCT Genre AS Genres_available FROM Books

--q10 Find the book with the lowest stock:
SELECT * FROM BOOKS WHERE STOCK = (SELECT MIN(Stock) FROM Books)

--q11 Calculate the total revenue generated from all orders
SELECT SUM(Total_Amount) AS Total_Revenue  FROM Orders

--Advance queries

--q1 Retrieve the total number of books sold for each genre:
SELECT b.Genre,SUM(o.Quantity) AS Quantity_Sold FROM Books AS b INNER JOIN Orders AS o ON b.Book_ID=o.Book_ID GROUP BY b.Genre 

--q2 Find the average price of books in the "Fantasy" genre:
SELECT b.Genre,AVG(o.Total_Amount) AS Avg_Price FROM BOOKS AS b INNER JOIN Orders AS o ON b.Book_ID=o.Book_ID WHERE b.Genre='Fantasy' GROUP BY b.Genre  

--q3 List customers who have placed at least 2 orders:
SELECT * FROM Customers WHERE Customer_ID IN ( SELECT Customer_ID FROM Orders GROUP BY Customer_ID HAVING COUNT(*)>=2)

--q4 Find the most frequently ordered book:
WITH T AS(SELECT Book_ID,COUNT(*) AS Order_Freq FROM Orders GROUP BY Book_ID )


SELECT * FROM Books WHERE Book_Id IN(SELECT Book_ID FROM T WHERE Order_Freq=(select MAX(Order_Freq) FROM T))

--q5 Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT TOP(3) * FROM Books WHERE Genre='Fantasy' ORDER BY Price DESC

--q6 Retrieve the total quantity of books sold by each author:
SELECT b.Author,SUM(o.Quantity) AS Quantity_sold FROM Books AS b INNER JOIN Orders AS o ON b.Book_ID=o.Book_ID GROUP BY b.Author

--q7 List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city AS Cities_list FROM Customers AS c INNER JOIN Orders AS o ON c.Customer_ID=o.Customer_ID WHERE o.Total_Amount>30

--q8 Find the customer who spent the most on orders:
WITH T AS(
SELECT Customer_Id ,SUM(Total_Amount) AS Total_Spendings FROM Orders GROUP BY Customer_ID)

SELECT c.*,t.Total_Spendings FROM T as t INNER JOIN Customers AS c ON t.Customer_Id=c.Customer_ID WHERE t.Total_Spendings in (SELECT MAX(Total_Spendings) FROM T)

--q9 Calculate the stock remaining after fulfilling all orders:
WITH T AS (
SELECT Book_Id,SUM(Quantity) AS Stock_sold FROM Orders GROUP BY Book_ID)

SELECT b.*, COALESCE(t.Stock_sold,0) AS Stock_sold, b.Stock-COALESCE(t.Stock_sold,0) AS Stock_remaining FROM Books AS b LEFT JOIN T AS t ON b.Book_ID=t.Book_ID

