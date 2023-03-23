/*********************************************************
/                                                        /
/                  WEEKLY EXERCISE 05                    /
/                  ANTHONY FENNER                        /
/                  2020-01-03                            /
/                                                        /
/********************************************************/

/********************************************************
    1. Explain the effect of the following SQL statement:
    UPDATE sales.Order_Details
    SET QuotedPrice = QuotedPrice * 1.32
    WHERE OrderNumber IN (
        SELECT OrderNumber
        FROM sales.Orders
        WHERE DATEPART(year, OrderDate) = '2018')
*/

/*
    This looks like we are going back and udjusting our 
    quotes given back in 2018 by 32%. We are setting the
    new quote price, then selecting just the ones where 
    the OrderNumber is tied to the OrderDate year 2018. 
*/

/********************************************************
    2. Explain the effect of the following SQL statement:
    INSERT INTO sales.Customers (CustFirstName, CustLastName,
    CustStreetAddress, CustCity, CustState, CustZipCode, 
    CustAreaCode, CustPhoneNumber)
    VALUES('Juli', 'Lisser', '2300 E Kenwood Blvd', 
    'Milwaukee', 'WI', '53211', 414, '484-8592')
*/

/*
    We are adding a row into the sales.Customers table
    and specifying the exact columns to put the data
    into. Then we are using the values function to
    state the information for Juli Lisser that matches
    the specified columns above.
*/

/********************************************************
    3. Explain the effect of the following SQL statement:
    DELETE FROM school.Subjects
    WHERE SubjectID IN (
        SELECT s.SubjectID
        FROM school.Subjects AS s
            LEFT JOIN school.Faculty_Subjects AS fs
                ON s.SubjectID = fs.SubjectID
        WHERE fs.StaffID IS NULL)

*/

/*
    We are deleting rows from the school.Subjects 
    table that it looks like no faculty members
    are teaching. To do that we are using LEFT JOIN
    on the Faculty Subjects table and only taking
    NULL responses due to the faculty members not
    being associated to the subject. Once we have
    that list selected, we are then deleting those
    subjects from the subjects table.
*/

/********************************************************
    4. Write a SQL statement to resolve the following 
    question: ‘What products have never been ordered?’
        a. Tables: sales.Products, sales.Order_Details
*/

/* 
    SELECT ProductNumber FROM sales.Order_Details
    WHERE ProductNumber 
        IN('4', '23');

    SELECT ProductNumber, ProductName FROM sales.Products 
    WHERE ProductName 
        IN('Victoria Pro All Weather Tires', 
        'Ultra-Pro Rain Jacket');
    
    I wanted to check my work to ensure I was selecting 
    good data. Except now I know their is a cost with 
    every pull I feel bad. Eek. Talk about needing to be 
    right before taking action in a database.
*/

SELECT p.ProductName
FROM sales.Products AS p
    LEFT JOIN sales.Order_Details as od
        ON p.ProductNumber = od.ProductNumber
    WHERE OrderNumber IS NULL;