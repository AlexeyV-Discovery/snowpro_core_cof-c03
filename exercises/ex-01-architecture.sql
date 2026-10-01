# Hands-On Exercises: Architecture & Objects
-- Run these on your Snowflake account (MLA53836-UK_GENAI)

------------------------------------------------------------
-- EXERCISE 1: Explore the Three-Layer Architecture
------------------------------------------------------------

-- 1a. Check your account edition
SELECT CURRENT_ACCOUNT(), SYSTEM$GET_SNOWFLAKE_PLATFORM_INFO();

-- 1b. List all warehouses and observe their properties
SHOW WAREHOUSES;

-- 1c. Observe metadata cache in action (no warehouse needed if table is unchanged)
-- First, let's use sample data
USE DATABASE SNOWFLAKE_SAMPLE_DATA;
USE SCHEMA TPCH_SF1;

-- This uses metadata cache (observe the query profile!)
SELECT COUNT(*) FROM LINEITEM;
SELECT MIN(L_ORDERKEY), MAX(L_ORDERKEY) FROM LINEITEM;

------------------------------------------------------------
-- EXERCISE 2: Table Types Comparison
------------------------------------------------------------

-- Create a test database for exercises
CREATE DATABASE IF NOT EXISTS EXAM_PREP;
USE DATABASE EXAM_PREP;
CREATE SCHEMA IF NOT EXISTS EXERCISES;
USE SCHEMA EXERCISES;

-- 2a. Create each table type
CREATE OR REPLACE TABLE perm_table (id INT, name VARCHAR) DATA_RETENTION_TIME_IN_DAYS = 1;
CREATE OR REPLACE TRANSIENT TABLE trans_table (id INT, name VARCHAR);
CREATE OR REPLACE TEMPORARY TABLE temp_table (id INT, name VARCHAR);

-- 2b. Insert sample data
INSERT INTO perm_table VALUES (1, 'permanent');
INSERT INTO trans_table VALUES (1, 'transient');
INSERT INTO temp_table VALUES (1, 'temporary');

-- 2c. Check retention settings
SHOW TABLES LIKE '%_table';
-- Note: Check the "retention_time" column in the output

-- 2d. Try to set retention > 1 day on transient (this will fail on Enterprise)
-- ALTER TABLE trans_table SET DATA_RETENTION_TIME_IN_DAYS = 5;  -- Uncomment to test

------------------------------------------------------------
-- EXERCISE 3: Stages Exploration
------------------------------------------------------------

-- 3a. List your user stage contents
LIST @~;

-- 3b. Create a named internal stage
CREATE OR REPLACE STAGE my_test_stage;
LIST @my_test_stage;

-- 3c. Observe table stage (every table has one automatically)
LIST @%perm_table;

------------------------------------------------------------
-- EXERCISE 4: Caching Layers
------------------------------------------------------------

-- 4a. Result Cache Test
-- Run this query, then run it AGAIN immediately
-- Check the query profile for the second run -- it should show "QUERY RESULT REUSE"
CREATE OR REPLACE WAREHOUSE exam_prep_wh 
  WAREHOUSE_SIZE = 'XSMALL' 
  AUTO_SUSPEND = 60 
  AUTO_RESUME = TRUE;

USE WAREHOUSE exam_prep_wh;

SELECT L_RETURNFLAG, L_LINESTATUS, 
       SUM(L_QUANTITY) AS sum_qty,
       AVG(L_EXTENDEDPRICE) AS avg_price
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM
GROUP BY L_RETURNFLAG, L_LINESTATUS
ORDER BY L_RETURNFLAG, L_LINESTATUS;

-- Run the EXACT same query again and check query profile
-- You should see "QUERY RESULT REUSE" = true

------------------------------------------------------------
-- EXERCISE 5: Views Comparison
------------------------------------------------------------

USE DATABASE EXAM_PREP;
USE SCHEMA EXERCISES;

-- 5a. Standard view (definition visible)
CREATE OR REPLACE VIEW v_standard AS
  SELECT * FROM perm_table WHERE id > 0;

-- 5b. Secure view (definition hidden from non-owners)
CREATE OR REPLACE SECURE VIEW v_secure AS
  SELECT * FROM perm_table WHERE id > 0;

-- 5c. Check which views are secure
SHOW VIEWS;
-- Note the "is_secure" column

-- 5d. Try to see the view definition
SELECT GET_DDL('VIEW', 'v_standard');  -- Works
SELECT GET_DDL('VIEW', 'v_secure');    -- Works for owner, hidden for others

------------------------------------------------------------
-- EXERCISE 6: Streams and Tasks (CDC)
------------------------------------------------------------

-- 6a. Create a source table and stream
CREATE OR REPLACE TABLE source_data (id INT, value VARCHAR);
CREATE OR REPLACE STREAM source_stream ON TABLE source_data;

-- 6b. Insert data and observe the stream
INSERT INTO source_data VALUES (1, 'first'), (2, 'second');

-- 6c. Query the stream -- you'll see INSERT metadata
SELECT * FROM source_stream;

-- 6d. Update and delete, then check stream again
UPDATE source_data SET value = 'updated' WHERE id = 1;
DELETE FROM source_data WHERE id = 2;

SELECT * FROM source_stream;
-- Note: METADATA$ACTION (INSERT/DELETE), METADATA$ISUPDATE (TRUE/FALSE)

------------------------------------------------------------
-- EXERCISE 7: Resource Monitors
------------------------------------------------------------

-- Only ACCOUNTADMIN can do this:
-- USE ROLE ACCOUNTADMIN;
-- CREATE RESOURCE MONITOR exam_monitor
--   WITH CREDIT_QUOTA = 5
--   TRIGGERS
--     ON 75 PERCENT DO NOTIFY
--     ON 100 PERCENT DO SUSPEND;

------------------------------------------------------------
-- CLEANUP (optional)
------------------------------------------------------------
-- DROP DATABASE EXAM_PREP;
-- DROP WAREHOUSE exam_prep_wh;
