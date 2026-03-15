-- Sales Analysis Project
-- By Vatsal Barot
-- Tools: MySQL
-- Description: Analysis of 6 months online store
--              sales data with business insights
-- ================================================
-- ================================================
-- STEP 1: CREATE DATABASE
-- ================================================
CREATE DATABASE analytics;
USE analytics;
-- ================================================
-- STEP 2: CREATE TABLES
-- ================================================

-- Customers table (stores customer info once)
CREATE TABLE Customers (
  CustomerID TEXT,
  Name       TEXT,
  City       TEXT
);

-- Orders table (stores each order)
CREATE TABLE Orders (
  OrderID    INT,
  CustomerID TEXT,
  Product    TEXT,
  Price      INT,
  Month      TEXT
);

-- ================================================
-- STEP 3: INSERT DATA
-- ================================================

-- Insert customers
INSERT INTO Customers VALUES ('C01', 'Ayesha', 'Mumbai');
INSERT INTO Customers VALUES ('C02', 'Rahul', 'Delhi');
INSERT INTO Customers VALUES ('C03', 'Priya', 'Chennai');

-- Insert orders
INSERT INTO Orders VALUES (1, 'C01', 'Shoes',   2000, 'March');
INSERT INTO Orders VALUES (2, 'C02', 'T-shirt',  500, 'March');
INSERT INTO Orders VALUES (3, 'C01', 'Bag',      1500, 'March');
INSERT INTO Orders VALUES (4, 'C03', 'Shoes',   2000, 'April');
INSERT INTO Orders VALUES (5, 'C02', 'Bag',      1500, 'April');
INSERT INTO Orders VALUES (6, 'C03', 'T-shirt',  500, 'April');

-- ================================================
-- STEP 4: VERIFY DATA
-- ================================================
SELECT * FROM Customers;
SELECT * FROM Orders;

-- ================================================
-- STEP 5: ANALYSIS QUERIES
-- ================================================

-- Q1: All orders with customer details (JOIN)
SELECT Orders.OrderID, Customers.Name,
       Customers.City, Orders.Product,
       Orders.Price, Orders.Month
FROM Orders
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

-- Q2: Filter orders by month
SELECT * FROM Orders
WHERE Month = 'March';

-- Q3: Orders above Rs.1000
SELECT * FROM Orders
WHERE Price > 1000;

-- Q4: Total revenue per customer
SELECT Customers.Name, SUM(Orders.Price) AS TotalSpent
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.Name
ORDER BY TotalSpent DESC;

-- Q5: Number of orders per customer
SELECT Customers.Name, COUNT(*) AS NumberOfOrders
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.Name;

-- Q6: Revenue per month
SELECT Month, SUM(Price) AS MonthlyRevenue
FROM Orders
GROUP BY Month;

-- Q7: Average price per product
SELECT Product, AVG(Price) AS AvgPrice
FROM Orders
GROUP BY Product;

-- Q8: Top 2 most expensive orders
SELECT Customers.Name, Orders.Product, Orders.Price
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
ORDER BY Orders.Price DESC
LIMIT 2;

-- Q9: Fix data error (UPDATE example)
UPDATE Customers
SET CustomerID = 'C02'
WHERE Name = 'Rahul';

-- ================================================
-- KEY BUSINESS INSIGHTS
-- ================================================
-- 1. Ayesha is the highest spender at Rs.3,500
-- 2. March and April have equal revenue at Rs.4,000
-- 3. Shoes is the most expensive product at Rs.2,000
-- 4. T-shirt is the cheapest product at Rs.500
-- 5. Mumbai has the highest order value overall
--
-- RECOMMENDATION:
-- Launch a Valentine's Day campaign in February
-- to boost sales during the slowest month


