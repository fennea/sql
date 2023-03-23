/*********************************************************
/                                                        /
/                  WEEKLY EXERCISE 05                    /
/                  ANTHONY FENNER                        /
/                  2020-01-03                            /
/                                                        /
/********************************************************/

/*
1. What is the results of the following script:

CREATE TABLE DemoDB;

CREATE TABLE Students(
    student_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    street_address NVARCHAR,
    state varchar(255),
    zipcode VARCHAR(255),
    phone_number VARCHAR(255),
    major NVARCHAR
);

Database DemoDB will be created.

Table Students will be created.

Inside the students table, the following columns will be created:

student_id - Is an intiger and the primary key, which cannot be a NULL value
first_name - Is ASCII characters with a max length of 255 characters
last_name - Is ASCII characters with a max length of 255 characters
street_address - Stores unicode strings, length not specified, default 1 character.
state - Is ASCII characters with a max length of 255 characters
city - Is ASCII characters with a max length of 255 characters
zipcode - Is ASCII characters with a max length of 255 characters
phone_number - Is ASCII characters with a max length of 255 characters
major - Stores unicode strings, max length not specified, default 1 character.
*/

/*
2. What is the result of the folloing script?

CREATE DATABASE NHLData;

CREATE TABLE game_plays_players(
    game_id VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES game(game_id),
    play_id VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES game_plays(play_id),
    player_id VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES player_info(player_id),
    play_num INT,
    player_type VARCHAR(50),
    CONSTRAINT game_plays_players_id PRIMARY KEY (game_id, play_id, player_id)
);

Database NHLData will be created.

Table game_plays_players will be created.

Inside the game_plays_players table, the following columns will be created:

game_id - Is an ASCII character foreign key that is linked through reference
    back to the game table game_id column.The value cannot be a NULL value.
    max length of 50 characters.
play_id - Is an ASCII character foreign key that is linked through reference
    back to the game_plays table play_id column.The value cannot be a NULL value.
    max length of 50 characters
player_id - Is an ASCII character foreign key that is linked through reference
    back to the player_info table player_id column.The value cannot be a NULL 
    value. max length of 50 characters
play_num - Is an integer which has a range of -2^31 - 2^31
player_type - Is in ASCII charcters with a max length of 50 characters
game_plays_players_id - Is a composit primary key that uses the game_id, play_id,
    and player_id to create a unique row within this table.
*/

/*
3. Create a DDL Script which will create teh sales.Orders table.

SELECT TOP 3 * FROM sales.Orders;

SELECT
	COLUMN_NAME, DATA_TYPE
FROM
  	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'Orders';

CREATE DATABASE sales;

CREATE TABLE Orders(
    OrderNumber INT NOT NULL PRIMARY KEY
    OderDate DATETIME
    Shipdate DATETIME
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID)
)
*/

/*
4. Give me a list of all faculty in alphabetical order by 
    last name and the number of courses they have taught.
*/

-- SELECT TOP 3 * FROM school.Faculty;
-- SELECT TOP 3 * FROM school.Staff;
-- SELECT TOP 3 * FROM school.Faculty_Classes;

SELECT st.StfFirstName + ' ' + st.StfLastname AS 'faculty name',
    (SELECT COUNT(fc.ClassID)
        FROM school.Faculty_Classes AS fc
        WHERE st.StaffID = fc.StaffID) AS 'class count'
FROM school.Staff AS st
WHERE st.Position = 'Faculty'
ORDER BY st.stfLastname, 'class count';

/* Is that the correct way to reference the column header 'class count'?
    it worked, but it looks weird as it doesn't reference the table.
    Thanks Juli! :-)
*/