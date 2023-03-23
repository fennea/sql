/*********************************************************
/                                                        /
/                  WEEKLY EXERCISE 03                    /
/                  ANTHONY FENNER                        /
/                  2020-16-02                            /
/                                                        /
/********************************************************/

/*
    1. Show me customers who have never ordered a helmet.
        a. Sales.Customers, sales.Orders, sales.Order_details, Sales.Products
*/

-- SELECT TOP 3 * FROM Sales.Customers;
-- SELECT TOP 3 * FROM sales.Orders;
-- SELECT TOP 3 * FROM sales.Order_details;
-- SELECT TOP 3 * FROM Sales.Products;

SELECT c.CustFirstName + ' ' + c.CustLastName AS NOT_HELMET_ORDER
FROM Sales.Customers AS c
    LEFT JOIN
        (SELECT DISTINCT o.OrderNumber, o.CustomerID, d.ProductNumber
        FROM sales.orders AS o
            INNER JOIN sales.Order_details AS d
                ON o.OrderNumber = d.OrderNumber) AS od
        INNER JOIN
            (SELECT d1.ProductNumber, p.ProductName
            FROM sales.Order_details AS d1
                INNER JOIN Sales.Products AS p
                    ON d1.ProductNumber = p.ProductNumber
            WHERE p.ProductName LIKE '%helmet%') AS dp
            ON od.ProductNumber = dp.ProductNumber
    ON c.CUstomerID = od.CustomerID
        WHERE od.CustomerID IS NULL
    ORDER BY NOT_HELMET_ORDER ASC;

/*
    2. Display matches with no game data
        a. Bowl.Turkey_matches, bowl.match_games
*/

-- SELECT TOP 3 * FROM Bowl.Tourney_matches;
-- SELECT TOP 3 * FROM bowl.match_games;

SELECT t.MatchID, t.TourneyID, m.GameNumber
FROM bowl.Tourney_Matches AS t
    LEFT JOIN bowl.Match_Games as m
        ON t.MatchID = m.MatchID
WHERE m.MatchID IS NULL;

/*
    3. Display bowlers who have never bowled a raw score greater than 150.
        a.) Bowl.Bowlers, bowl.Bowler_Scores
*/

-- SELECT TOP 3 * FROM Bowl.Bowlers;
-- SELECT TOP 3 * FROM bowl.Bowler_Scores;

SELECT DISTINCT b.BowlerFirstName + ' ' + b.BowlerLastName AS 'Bowler Name' 
FROM Bowl.Bowlers AS b
    INNER JOIN bowl.Bowler_Scores AS bs
        ON b.BowlerID = bs.BowlerID
WHERE bs.RawScore > 150;

/*
    4. Display all faculty and the classes they are scheduled to teach.
        a.) School.Staff, school.Faculty, school.Faculty_Classes
*/

-- SELECT TOP 3 * FROM School.Staff;
-- SELECT TOP 3 * FROM school.Faculty;
-- SELECT TOP 3 * FROM school.Faculty_Classes;

SELECT s.StfFirstName + ' ' + s.StfLastname AS 'Faculty Name', ffc.ClassID
FROM School.Staff AS s
    INNER JOIN
        (SELECT f.StaffID, fc.ClassID
        FROM School.Faculty AS f
            LEFT JOIN school.Faculty_Classes AS fc
            ON f.StaffID = fc.StaffID) AS ffc
        ON s.StaffID = ffc.StaffID;

