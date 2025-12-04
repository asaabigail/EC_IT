/*
    EC_IT143_W4.2_simpsons_s1_aa.sql
    Step 1 – Start with a Question
    Author: Abigail Somina Alfred
*/
-- Simple Question for the Simpsons-1 dataset:
-- "How many characters are listed in the Simpsons-1 data?"
/*
    EC_IT143_W4.2_simpsons_s2_aa.sql
    Step 2 – Begin Creating an Answer
    Author: Abigail Somina Alfred
*/
-- Step 1 of the answer:
-- First, we need to select all rows from the Simpsons-1 dataset.
SELECT *
FROM Simpsons_1;
-- Step 2 of the answer:
-- Then, we need to count how many characters exist.
SELECT COUNT(*) AS TotalCharacters
FROM Simpsons_1;
-- These two steps form the basic foundation of the answer.
/*
    EC_IT143_W4.2_simpsons_s3_aa.sql
    Step 3 – Create Ad Hoc Query
    Author: Abigail Somina Alfred
*/
-- Ad hoc query answering the question:
SELECT COUNT(*) AS TotalCharacters
FROM Simpsons_1;
/*
    EC_IT143_W4.2_simpsons_s4_aa.sql
    Step 4 – Create View
    Author: Abigail Somina Alfred
*/
USE EC_IT143_DA;
IF OBJECT_ID('vw_simpsons_character_count', 'V') IS NOT NULL
    DROP VIEW vw_simpsons_character_count;
CREATE VIEW vw_simpsons_character_count AS
SELECT 
    COUNT(*) AS TotalCharacters
FROM Simpsons_1;
/*
    EC_IT143_W4.2_simpsons_s5.1_aa.sql
    Step 5.1 – Create Table from View
    Author: Abigail Somina Alfred
*/
USE EC_IT143_DA;
SELECT *
INTO simpsons_character_count
FROM vw_simpsons_character_count;
/*
    EC_IT143_W4.2_simpsons_s5.2_aa.sql
    Step 5.2 – Refine Table Definition
    Author: Abigail Somina Alfred
*/
USE EC_IT143_DA;
IF OBJECT_ID('simpsons_character_count', 'U') IS NOT NULL
    DROP TABLE simpsons_character_count;
-- Recreate table with proper structure
CREATE TABLE simpsons_character_count (
    id INT IDENTITY(1,1) PRIMARY KEY,
    TotalCharacters INT NOT NULL
);
/*
    EC_IT143_W4.2_simpsons_s6_aa.sql
    Step 6 – Load Table from View
    Author: Abigail Somina Alfred
*/
USE EC_IT143_DA;
TRUNCATE TABLE simpsons_character_count;
INSERT INTO simpsons_character_count (TotalCharacters)
SELECT TotalCharacters
FROM vw_simpsons_character_count;
/*
    EC_IT143_W4.2_simpsons_s7_aa.sql
    Step 7 – Stored Procedure
    Author: Abigail Somina Alfred
*/
USE EC_IT143_DA;
IF OBJECT_ID('sp_load_simpsons_character_count', 'P') IS NOT NULL
    DROP PROCEDURE sp_load_simpsons_character_count;
CREATE PROCEDURE sp_load_simpsons_character_count
AS
BEGIN
    SET NOCOUNT ON;
TRUNCATE TABLE simpsons_character_count;
INSERT INTO simpsons_character_count (TotalCharacters)
    SELECT TotalCharacters
    FROM vw_simpsons_character_count;
/*
    EC_IT143_W4.2_simpsons_s8_aa.sql
    Step 8 – Call Stored Procedure
    Author: Abigail Somina Alfred
*/
USE EC_IT143_DA;

EXEC sp_load_simpsons_character_count;

SELECT * FROM simpsons_character_count;
