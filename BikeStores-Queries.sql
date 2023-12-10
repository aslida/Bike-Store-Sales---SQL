-- What is the highest priced products per category?

SELECT *
FROM Products;

-- What is the Minimum, Maximun and average prices of products per year?

SELECT ModelYear,
	   MIN(ListPrice) AS 'Min Price',
	   MAX(ListPrice) AS 'Max Price',
	   FORMAT(AVG(ListPrice),'N2') AS 'Average Price'
FROM Products
GROUP BY ModelYear;

-- What is the  Minimum, Maximun and average prices of product per Category?

SELECT Cat.CategoryName,
	   MIN(ListPrice) AS 'Min Price',
	   MAX(ListPrice) AS 'Max Price',
	   AVG(ListPrice) AS 'Average Price'
FROM Products AS Pro
LEFT OUTER JOIN Categories AS Cat
	ON Pro.CategoryID = Cat.CategoryID
GROUP BY Cat.CategoryName;



-- What is the  Minimum, Maximun and average prices of product per Year / Category ?
SELECT Pro.ModelYear,
	   Cat.CategoryName,
	   MIN(ListPrice) AS 'Min Price',
	   MAX(ListPrice) AS 'Max Price',
	   AVG(ListPrice) AS 'Avg Price'
FROM Products AS Pro
LEFT OUTER JOIN Categories AS Cat
	ON Pro.CategoryID = Cat.CategoryID
GROUP BY Pro.ModelYear, Cat.CategoryName
ORDER BY Pro.ModelYear, Cat.CategoryName;



-- How many cities do they get orders from per year?

SELECT YEAR(OrderDate) 'Order Year', COUNT(City) 'No of City'
FROM Orders Ord
LEFT OUTER JOIN Customers Cus
	ON Ord.CustomerID = Cus.CustomerID
GROUP BY YEAR(OrderDate)

-- What is the top 10 most ordered cities?


SELECT TOP 10 Cus.State, Cus.City, COUNT(OrderID) 'Orders by City'
FROM Orders Ord
LEFT OUTER JOIN Customers Cus
	ON Ord.CustomerID = Cus.CustomerID
GROUP BY Cus.State, Cus.City
ORDER BY 'Orders by City' DESC;



-- What is the order counts by State?

SELECT Cus.State, COUNT(OrderID) 'Orders by State'
FROM Orders Ord
LEFT OUTER JOIN Customers Cus
	ON Ord.CustomerID = Cus.CustomerID
GROUP BY Cus.State
ORDER BY 'Orders by State' DESC;


-- Who is the most selling staff in year 2018?

SELECT Sta.FirstName + ' ' + Sta.Lastname AS 'Staff Full Name',
	   COUNT(OrderID) AS 'Order no Per Staff'
FROM Orders Ord
JOIN Staffs Sta
	ON	Ord.StaffID = Sta.StaffID
WHERE YEAR(OrderDate) = 2018
GROUP BY Sta.FirstName + ' ' + Sta.Lastname
ORDER BY 'Order no Per Staff' DESC



-- Shipped Date - Required Date Difference per store

SELECT OrderID,
CASE
	WHEN DATEDIFF(DAY, RequiredDate, ShippedDate) <0 THEN 'Early Shipment'
	WHEN DATEDIFF(DAY, RequiredDate, ShippedDate) = 0 THEN 'On Time Shipment'
	WHEN DATEDIFF(DAY, RequiredDate, ShippedDate) > 0 THEN 'Late Shipment'
	ELSE 'Not Shipped'
END AS 'Shipment Performance'
FROM Orders
WHERE StoreID = '1'



-- Which brands are selling most?
SELECT *
FROM OrderItems
JOIN Brands
	ON 


-- Top 10 products selling most and their revenues-- discount var??? .
SELECT TOP 10 Oit.ProductID,
	Pro.ProductName,
	SUM(Oit.Quantity) AS 'Sales Number',
	SUM((Oit.ListPrice * (1 - Oit.Discount) ) * Oit.Quantity) AS 'Total Revenue'
FROM OrderItems Oit
JOIN Products Pro
	ON Pro.ProductID = Oit.ProductID
GROUP BY Oit.ProductID, Pro.ProductName
ORDER BY 'Sales Number' DESC;

-- Total revenue per product name and sales quantity 
SELECT Products.ProductID,
	   Products.ProductName,
	   SUM(Quantity) AS 'Total Sales Qty',
	   CAST(SUM(OrderItems.ListPrice * (1 - OrderItems.Discount) * OrderItems.Quantity) AS INT) AS 'Total Revenue'
FROM OrderItems
JOIN Products
	ON Products.ProductID = OrderItems.ProductID
GROUP BY Products.ProductID, Products.ProductName
ORDER BY 'Total Revenue' DESC;
-- Which Brand has higher margin?

SELECT * FROM Products;
SELECT * FROM OrderItems;




SELECT *
FROM Products
WHERE ProductName = 'Electra Townie Go! 8i - 2017/2018';

SELECT *
FROM Orders;

SELECT *
FROM Staffs;

SELECT DISTINCT ProductName
FROM Products
