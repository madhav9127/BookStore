# 📚 Online Bookstore SQL Project

## 📌 Project Overview
This project demonstrates a complete SQL-based analysis of an **Online Bookstore database**. It focuses on extracting meaningful insights using both **basic and advanced SQL queries**.

The project highlights:
- Data retrieval & filtering
- Aggregations & grouping
- Joins across multiple tables
- Real-world business problem solving using SQL

---

## 🗂️ Dataset Description

The database consists of three CSV files:

### 📘 Books.csv
- Book_ID
- Title
- Author
- Genre
- Price
- Stock
- Published_Year

### 👤 Customers.csv
- Customer_ID
- Name
- City
- Country

### 🧾 Orders.csv
- Order_ID
- Customer_ID
- Book_ID
- Quantity
- Order_Date
- Total_Amount

> Tables are linked using common fields: `Book_ID` and `Customer_ID`.

---

## 🔧 Technologies Used
- SQL (MySQL / PostgreSQL)
- CSV Data Handling
- Relational Database Concepts

---

## 📊 SQL Queries Implemented

### 🔹 Basic Queries
- Retrieve all books in the "Fiction" genre  
- Find books published after 1950  
- List customers from Canada  
- Show orders placed in November 2023  
- Retrieve total stock of books  
- Find the most expensive book  
- Show customers who ordered more than 1 quantity  
- Retrieve orders with total amount > $20  
- List all available genres  
- Find book with lowest stock  
- Calculate total revenue  

---

### 🔹 Advanced Queries
- Total books sold per genre  
- Average price of Fantasy books  
- Customers with at least 2 orders  
- Most frequently ordered book  
- Top 3 most expensive Fantasy books  
- Total quantity sold per author  
- Cities with customers spending over $30  
- Customer with highest spending  
- Remaining stock after fulfilling orders  

---

## 🚀 Key Learnings
- Writing efficient SQL queries  
- Using GROUP BY, HAVING, and aggregate functions  
- Performing JOIN operations  
- Solving real-world business problems with data  

---

## 📁 Project Structure