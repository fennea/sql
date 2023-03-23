/*********************************************************
/                                                        /
/                  MIDTERM 2020                          /
/                  ANTHONY FENNER                        /
/                  2020-03-09                            /
/                                                        /
/********************************************************/

/*
1. How many products do our vendors located in Washington currently offer? 
What is the average retail price of available products for each vendor?
*/

SELECT 'There are ' + cast(COUNT(*) AS varchar(10)) + 
    ' products offered by vendors in WA.'
FROM sales.Product_Vendors AS pv
INNER JOIN sales.Vendors AS v
    ON pv.VendorID = v.VendorID
WHERE v.VendState = 'WA';

SELECT v.VendName, p.ProductName, '$' + CAST(p.RetailPrice AS VARCHAR(10))
    AS RetailPrice
FROM sales.Products AS p
    RIGHT JOIN
        (SELECT ve.VendorID, ve.VendName, pv.ProductNumber
        FROM sales.vendors AS ve
        INNER JOIN sales.Product_Vendors AS pv
        ON ve.VendorID = pv.VendorID
        WHERE VendState = 'WA') AS v
    ON p.ProductNumber = v.ProductNumber
ORDER BY v.VendName;

/*
2. How many orders did we process and what was the total quoted price 
per month in 2017?
*/

SELECT DATENAME(M, o.ShipDate) AS MONTHS, COUNT(o.OrderNumber) AS ORDERS_PROCESSED, 
    '$' + CAST(SUM(od.QuotedPrice) AS VARCHAR(10)) AS TOTAL_QP
FROM sales.Orders AS o
    INNER JOIN sales.Order_Details AS od
        ON o.OrderNumber = od.OrderNumber
WHERE o.ShipDate IS NOT NULL
    AND YEAR(o.ShipDate) = '2017'
GROUP BY DATENAME(M, o.ShipDate);

/*
3. How many bikes has each of our employees sold in 2017?
*/

SELECT odb2.EmployeeID AS 'Employee ID', SUM(odb.QuantityOrdered) AS 'Total Bikes Sold'
FROM
    (SELECT od.ProductNumber, od.OrderNumber, od.QuantityOrdered, p.ProductName
    FROM sales.Order_Details AS od
        INNER JOIN sales.Products as p
            ON od.ProductNumber = p.ProductNumber
    WHERE p.ProductName LIKE '%Bike') AS odb
    INNER JOIN
        (SELECT od2.OrderNumber, o.EmployeeID
        FROM sales.Order_Details As od2
            INNER JOIN sales.Orders AS o
                ON od2.OrderNumber = o.OrderNumber
        WHERE YEAR(o.ShipDate) = '2017') AS odb2
        ON odb.OrderNumber = odb2.OrderNumber
GROUP BY odb2.EmployeeID;

/*
4. Which three customers have spent the most money with our company?
*/

SELECT TOP 3 co.CustFirstName + ' ' + co.CustLastName AS 'Customer Name',
    '$' + CAST(SUM(odp.RetailPrice) AS VARCHAR(10)) AS 'Total Value'
FROM 
    (SELECT c.CustomerID, c.CustFirstName, c.CustLastName, o.OrderNumber
    FROM sales.Customers AS c
        INNER JOIN sales.Orders AS o
            ON c.CustomerID = o.CustomerID) AS co
    INNER JOIN
        (SELECT od.OrderNumber, od.ProductNumber, p.RetailPrice
        FROM sales.Order_Details AS od
            INNER JOIN sales.Products AS p
                ON od.ProductNumber = p.ProductNumber) AS odp
        ON co.OrderNumber = odp.OrderNumber
GROUP BY CustFirstName + ' ' + CustLastName
ORDER BY SUM(odp.RetailPrice) DESC;

/*
5. Which of our vendors do not sell tires?
*/

SELECT DISTINCT v.VendName AS NON_TIRE_SELLER
FROM sales.Vendors as v
    LEFT JOIN
        (SELECT pv.ProductNumber, pv.VendorID, vd.VendName
        FROM sales.Product_Vendors AS pv
            INNER JOIN sales.Vendors AS vd
                ON pv.VendorID = vd.VendorID) AS pvv
        INNER JOIN
            (SELECT p.ProductNumber, c.CategoryDescription
            FROM sales.Products AS p
                INNER JOIN sales.Categories AS c
                    ON p.CategoryID = c.CategoryID
            WHERE c.CategoryDescription = 'Tires') AS pc
            ON pvv.ProductNumber = pc.ProductNumber
        ON v.VendorID = pvv.VendorID
WHERE pvv.VendorID IS NULL;

/*
6. Which vendor offers the best average profit margin on their products?
   Product margin = (selling price – cost of product) / selling price
                     (p.RetailPrice - pv.WholesalePrice) / p.RetailPrice
*/

SELECT TOP 1 v.VendName, CAST(ppv.profit_margin * 100 AS VARCHAR(10)) + '%' 
    AS ProfitMargin
FROM sales.Vendors AS v
    INNER JOIN
        (SELECT pv.VendorID, (SUM(p.RetailPrice) - SUM(pv.WholesalePrice)) / 
            SUM(p.RetailPrice) AS profit_margin
        FROM sales.Products AS p
            INNER JOIN sales.Product_Vendors AS pv
                ON p.ProductNumber = pv.ProductNumber
        GROUP BY VendorID) AS ppv
        ON v.VendorID = ppv.VendorID
ORDER BY ppv.Profit_margin DESC;

/*
7. How many orders did each employee place in 2017? How many orders did each employee
    place in 2018?
*/

SELECT e.EmpFirstName, e.EmpLastName, o1.oc17 AS '2017 Order Count', 
    o2.oc18 AS '2018 Order Count'
FROM sales.Employees as e
INNER JOIN 
    (SELECT o.EmployeeID, COUNT(o.OrderNumber) AS oc17
    FROM sales.Orders AS o
        WHERE YEAR(o.OrderDate) = '2017'
    GROUP BY o.EmployeeID) AS o1
    INNER JOIN
        (SELECT ord.EmployeeID, COUNT(ord.OrderNumber) AS oc18
        FROM sales.Orders AS ord
            WHERE YEAR(ord.OrderDate) = '2018'
        GROUP BY ord.EmployeeID) AS o2
        ON o1.EmployeeID = o2.EmployeeID
    ON e.EmployeeID = o1.EmployeeID;

/*
8. How many items have been sold from each product category in 2017?
*/

SELECT c.CategoryDescription, COUNT(pod.QuantityOrdered) AS 'Items Sold 2017'
FROM sales.Categories AS c
    INNER JOIN
        (SELECT p.CategoryID, p.ProductNumber, od.OrderNumber, od.QuantityOrdered
        FROM sales.Products AS p
        INNER JOIN sales.Order_Details as od
            ON p.ProductNumber = od.ProductNumber)  AS pod
        INNER JOIN
            (SELECT od2.OrderNumber, o.OrderDate
            FROM sales.Order_Details AS od2
                INNER JOIN sales.Orders as o
                    ON od2.OrderNumber = o.OrderNumber
            WHERE YEAR(o.OrderDate) = '2017') AS odo
            ON pod.OrderNumber = odo.OrderNumber
        ON c.CategoryID = pod.CategoryID
GROUP BY c.CategoryDescription;