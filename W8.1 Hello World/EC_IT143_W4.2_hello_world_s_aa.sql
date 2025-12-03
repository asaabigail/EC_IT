/* 
    EC_IT143_W4.2_hello_world_s1_aa.sql
    Step 1 – Start with a Question
    Author: Alfred Somina Abigail
*/

-- Simple Question:
-- "Can SQL Server return the phrase 'Hello World'?"

SELECT 'Hello World' AS Message;
/* 
    EC_IT143_W4.2_hello_world_s2_aa.sql
    Step 2 – Begin Creating an Answer
    Author: Alfred Somina Abigail
*/

-- Step 1 of the answer:
-- SQL can return a text string using a SELECT statement.

SELECT 'Hello World' AS Message;

-- Step 2 of the answer:
-- The next logical step is to place this logic into a database object (a View).
/* 
    EC_IT143_W4.2_hello_world_s3_aa.sql
    Step 3 – Create Ad Hoc Query
    Author: Alfred Somina Abigail
*/

-- Ad hoc query for “Hello World”
SELECT 'Hello World' AS Message;/*
    EC_IT143_W4.2_hello_world_s4_aa.sql
    Step 4 – Create View
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;

IF OBJECT_ID('vw_hello_world', 'V') IS NOT NULL
    DROP VIEW vw_hello_world;

CREATE VIEW vw_hello_world AS
SELECT 
    'Hello World' AS Message;
    /*
    EC_IT143_W4.2_hello_world_s5.1_aa.sql
    Step 5.1 – Create Table using SELECT INTO
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;

-- Create table from view
SELECT *
INTO hello_world_table
FROM vw_hello_world;
/*
    EC_IT143_W4.2_hello_world_s5.2_aa.sql
    Step 5.2 – Refine Table Definition
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;

-- Drop the table to refine the structure
IF OBJECT_ID('hello_world_table', 'U') IS NOT NULL
    DROP TABLE hello_world_table;

-- Recreate table manually with better structure
CREATE TABLE hello_world_table (
    id INT IDENTITY(1,1) PRIMARY KEY,
    Message VARCHAR(50) NOT NULL DEFAULT('Hello World')
);
/*
    EC_IT143_W4.2_hello_world_s6_aa.sql
    Step 6 – Load Table From View
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;

TRUNCATE TABLE hello_world_table;

INSERT INTO hello_world_table (Message)
SELECT Message
FROM vw_hello_world;
/*
    EC_IT143_W4.2_hello_world_s7_aa.sql
    Step 7 – Stored Procedure
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;

IF OBJECT_ID('sp_load_hello_world', 'P') IS NOT NULL
    DROP PROCEDURE sp_load_hello_world;

CREATE PROCEDURE sp_load_hello_world
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE hello_world_table;

    INSERT INTO hello_world_table (Message)
    SELECT Message
    FROM vw_hello_world;

END;
/*
    EC_IT143_W4.2_hello_world_s8_aa.sql
    Step 8 – Call Stored Procedure
    Author: Alfred Somina Abigail
*/

USE EC_IT143_DA;
GO

EXEC sp_load_hello_world;

SELECT * FROM hello_world_table;