CREATE DATABASE company;
use company;

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductCode VARCHAR(10),
  Quantity INT,
  UnitPrice DECIMAL(5,2)
);

INSERT INTO Orders VALUES (1001, 123, 'ABC', 2, 10.50);
INSERT INTO Orders VALUES(1002, 345, 'DEF', 1, 15.75);
INSERT INTO Orders VALUES(1003, 123, 'GHI', 3, 8.25);
INSERT INTO Orders VALUES(1004, 256, 'JKL', 4, 10.50);

-- Airthmetic operations
-- sum 
SELECT OrderID, CustomerID, ProductCode, Quantity, UnitPrice, Quantity * UnitPrice AS TotalPrice
FROM Orders;
 -- avg
SELECT AVG(UnitPrice) AS AverageUnitPrice
FROM Orders;

-- comaprison operators
SELECT *
FROM Orders
WHERE Quantity * UnitPrice > 50;

SELECT *
FROM Orders
WHERE ProductCode LIKE '%AB%';

-- logical operators
-- AND
SELECT *
FROM Orders
WHERE CustomerID = 123 AND Quantity > 2;

-- OR
SELECT *
FROM Orders
WHERE ProductCode = 'ABC' OR ProductCode = 'DEF';




