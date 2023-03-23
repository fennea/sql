/*********************************************************
/                                                        /
/                  WEEKLY EXERCISE 01                    /
/                  ANTHONY FENNER                        /
/                  2020-30-1                             /
/                                                        /
/********************************************************/

/* EXERCISE 1 */
/* 1. Select the first names, last names, and phone numbers 
from customer sales table 
where the state is California */
/* 2. SELECT the StudFirstName, StudLastName, and CustPhoneNumber 
FROM sales.Customers table 
WHERE the CustState = 'CA' */
/* 3. SELECT StudFirstName, StudLastName, CustPhoneNumber 
FROM sales.Customers 
WHERE CustState = 'CA' */
SELECT CustFirstName, CustLastName, CustPhoneNumber
FROM sales.Customers
WHERE CustState = 'CA';

/* EXERCISE 2 */
SELECT StudFirstName, StudLastName, StudState, 
    DATEDIFF(year, StudBirthDate, GETDATE()) AS StudAge
FROM school.Students 
ORDER BY StudLastName ASC;

/* EXERCISE 3 */
SELECT player_id, CAST(goals AS FLOAT) / shots 
    AS goals_per_shot_ratio
FROM nhl.game_skater_stats
WHERE time_on_ice / 60 > 10
    AND shots > 3;

/* EXERCISE 4 */
/* 1. Select the last names, salary, and date hired 
from school staff table 
where the date hired is between 1991 and 1996 */
/* 2. SELECT the StfLastname, Salary, and DateHired 
FROM school.Staff table 
WHERE DateHired is BETWEEN '1991' AND '1996' */
/* 3. SELECT StfLastname, Salary, DateHired 
FROM school.Staff
WHERE DateHired BETWEEN '1991' AND '1996' */
SELECT StfLastname, Salary, DateHired
FROM school.Staff
WHERE DateHired BETWEEN '1991' 
    AND '1996';

/* EXERCISE 5 */
SELECT TOP 3 * 
FROM school.Staff
ORDER BY DateHired ASC;

/* Test Data */
SELECT player_id, CAST(saves AS FLOAT) / shots 
    AS 'SavePercentage' 
FROM nhl.game_goalie_stats
WHERE shots > 0
ORDER BY SavePercentage DESC;

SELECT OrderNumber, DATEDIFF(day, OrderDate, ShipDate) AS ShipLength
FROM sales.Orders; 