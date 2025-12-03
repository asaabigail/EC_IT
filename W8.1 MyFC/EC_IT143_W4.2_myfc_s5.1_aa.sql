/* 
    EC_IT143_W4.2_myfc_s1_aa.sql
    Step 1 – Start with a Question
    Dataset: MyFC-1
    Author: Alfred Somina Abigail

    Simple Question:
    "How many players are on each team?"
*/

SELECT 'How many players are on each team?' AS Question;
/* 
    EC_IT143_W4.2_myfc_s2_aa.sql
    Step 2 – Begin Creating an Answer
    Dataset: MyFC-1
    Author: Alfred Somina Abigail
*/

-- Sub-answer Step 1:
-- Identify teams and count how many players each team has.

-- Sub-answer Step 2:
-- Group players by team to get the totals.

SELECT TeamName, COUNT(*) AS PlayerCount
FROM MyFC
GROUP BY TeamName;

-- Next step:
-- Convert the above logic into an ad hoc SQL query for Step 3.
/* 
    EC_IT143_W4.2_myfc_s3_aa.sql
    Step 3 – Ad Hoc Query
    Dataset: MyFC-1
    Author: Alfred Somina Abigail
*/

SELECT 
    TeamName,
    COUNT(*) AS PlayerCount
FROM MyFC
GROUP BY TeamName;
/* 
    EC_IT143_W4.2_myfc_s4_aa.sql
    Step 4 – Create View
    Dataset: MyFC-1
    Author: Alfred Abigail
*/

USE EC_IT143_DA;

IF OBJECT_ID('vw_myfc_player_count', 'V') IS NOT NULL
    DROP VIEW vw_myfc_player_count;

CREATE VIEW vw_myfc_player_count AS
SELECT 
    TeamName,
    COUNT(*) AS PlayerCount
FROM MyFC
GROUP BY TeamName;
/* 
    EC_IT143_W4.2_myfc_s5.1_aa.sql
    Step 5.1 – Create Table Using SELECT INTO
    Dataset: MyFC-1
    Author: Alfred Abigail
*/

USE EC_IT143_DA;

-- Create the initial table from the view
SELECT *
INTO myfc_player_count_table
FROM vw_myfc_player_count;
/* 
    EC_IT143_W4.2_myfc_s5.2_aa.sql
    Step 5.2 – Refine Table Definition
    Dataset: MyFC-1
    Author: Alfred Abigail
*/

USE EC_IT143_DA;

IF OBJECT_ID('myfc_player_count_table', 'U') IS NOT NULL
    DROP TABLE myfc_player_count_table;

CREATE TABLE myfc_player_count_table (
    id INT IDENTITY(1,1) PRIMARY KEY,
    TeamName VARCHAR(100) NOT NULL,
    PlayerCount INT NOT NULL
);
/* 
    EC_IT143_W4.2_myfc_s6_aa.sql
    Step 6 – Load Table from View
    Dataset: MyFC-1
    Author: Alfred Somina  Abigail
*/

USE EC_IT143_DA;

TRUNCATE TABLE myfc_player_count_table;

INSERT INTO myfc_player_count_table (TeamName, PlayerCount)
SELECT 
    TeamName,
    PlayerCount
FROM vw_myfc_player_count;
/* 
    EC_IT143_W4.2_myfc_s7_aa.sql
    Step 7 – Stored Procedure
    Dataset: MyFC-1
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;

IF OBJECT_ID('sp_load_myfc_player_count', 'P') IS NOT NULL
    DROP PROCEDURE sp_load_myfc_player_count;

CREATE PROCEDURE sp_load_myfc_player_count
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE myfc_player_count_table;

    INSERT INTO myfc_player_count_table (TeamName, PlayerCount)
    SELECT 
        TeamName,
        PlayerCount
    FROM vw_myfc_player_count;
END;
/* 
    EC_IT143_W4.2_myfc_s8_aa.sql
    Step 8 – Execute Stored Procedure
    Dataset: MyFC-1
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;

EXEC sp_load_myfc_player_count;

SELECT * FROM myfc_player_count_table;
