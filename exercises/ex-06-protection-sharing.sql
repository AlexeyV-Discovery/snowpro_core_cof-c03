# Hands-On Exercises: Data Protection & Sharing

USE DATABASE EXAM_PREP;
USE SCHEMA EXERCISES;
USE WAREHOUSE exam_prep_wh;

------------------------------------------------------------
-- EXERCISE 1: Time Travel
------------------------------------------------------------

-- 1a. Create a table with Time Travel
CREATE OR REPLACE TABLE time_travel_demo (
  id INT,
  name VARCHAR,
  status VARCHAR
) DATA_RETENTION_TIME_IN_DAYS = 1;

INSERT INTO time_travel_demo VALUES
(1, 'Alice', 'active'),
(2, 'Bob', 'active'),
(3, 'Charlie', 'active');

-- 1b. Note the current timestamp
SELECT CURRENT_TIMESTAMP();
-- Record this timestamp: __________________

-- 1c. Make changes
UPDATE time_travel_demo SET status = 'inactive' WHERE id = 2;
DELETE FROM time_travel_demo WHERE id = 3;

-- 1d. See current state
SELECT * FROM time_travel_demo;

-- 1e. Time Travel using OFFSET (5 minutes ago)
SELECT * FROM time_travel_demo AT(OFFSET => -300);

-- 1f. Time Travel using TIMESTAMP (use the timestamp you noted)
-- SELECT * FROM time_travel_demo AT(TIMESTAMP => '<your_timestamp>'::TIMESTAMP);

-- 1g. Time Travel using query ID
-- First, find the UPDATE query ID from query history:
SELECT QUERY_ID, QUERY_TEXT 
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
WHERE QUERY_TEXT LIKE '%UPDATE time_travel_demo%'
ORDER BY START_TIME DESC
LIMIT 1;

-- Then use BEFORE to see the state before that query:
-- SELECT * FROM time_travel_demo BEFORE(STATEMENT => '<query_id>');

------------------------------------------------------------
-- EXERCISE 2: UNDROP
------------------------------------------------------------

-- 2a. Drop a table
DROP TABLE time_travel_demo;

-- 2b. Try to query it (should fail)
-- SELECT * FROM time_travel_demo;

-- 2c. Undrop it
UNDROP TABLE time_travel_demo;

-- 2d. Verify it's back
SELECT * FROM time_travel_demo;

------------------------------------------------------------
-- EXERCISE 3: Zero-Copy Cloning
------------------------------------------------------------

-- 3a. Clone a table
CREATE TABLE cloned_table CLONE time_travel_demo;

-- 3b. Verify the clone is independent
SELECT * FROM cloned_table;

-- 3c. Modify the clone (does NOT affect original)
UPDATE cloned_table SET name = 'MODIFIED' WHERE id = 1;

-- 3d. Compare
SELECT 'original' AS source, * FROM time_travel_demo
UNION ALL
SELECT 'clone' AS source, * FROM cloned_table
ORDER BY source, id;

-- 3e. Clone from a point in time
-- CREATE TABLE restored_table CLONE time_travel_demo 
--   AT(OFFSET => -600);

------------------------------------------------------------
-- EXERCISE 4: Table Type Comparison (Storage Costs)
------------------------------------------------------------

-- 4a. Check the retention time and fail-safe for different table types
SHOW TABLES IN SCHEMA;
-- Look at "retention_time" column:
--   - Permanent: shows your configured value
--   - Transient: 0 or 1
--   - Temporary: 0 or 1

-- 4b. Check storage usage
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS
WHERE TABLE_CATALOG = 'EXAM_PREP'
  AND TABLE_SCHEMA = 'EXERCISES'
  AND TABLE_DROPPED IS NULL
ORDER BY TABLE_NAME;

------------------------------------------------------------
-- EXERCISE 5: Data Encryption Verification
------------------------------------------------------------

-- 5a. Verify encryption type
SELECT SYSTEM$GET_SNOWFLAKE_PLATFORM_INFO();

-- 5b. Check encryption keys (if ACCOUNTADMIN)
-- SHOW ENCRYPTION KEYS IN ACCOUNT;

------------------------------------------------------------
-- EXERCISE 6: Data Sharing Concepts (Read-Only Demo)
------------------------------------------------------------

-- 6a. Show existing shares (if any)
SHOW SHARES;

-- 6b. Show available databases from shares
SHOW DATABASES;
-- Look for databases with "origin" or "kind" = IMPORTED_DATABASE

-- 6c. Understanding share syntax (don't execute unless you want to create a share)
-- CREATE SHARE IF NOT EXISTS demo_share;
-- GRANT USAGE ON DATABASE exam_prep TO SHARE demo_share;
-- GRANT USAGE ON SCHEMA exam_prep.exercises TO SHARE demo_share;
-- GRANT SELECT ON TABLE exam_prep.exercises.products TO SHARE demo_share;
-- ALTER SHARE demo_share ADD ACCOUNTS = <consumer_account>;

------------------------------------------------------------
-- EXERCISE 7: Secure View (Data Sharing Prerequisite)
------------------------------------------------------------

-- 7a. Create a regular view and a secure view
CREATE OR REPLACE VIEW v_products_regular AS
SELECT product_id, product_name, category FROM products;

CREATE OR REPLACE SECURE VIEW v_products_secure AS
SELECT product_id, product_name, category FROM products;

-- 7b. Compare DDL visibility
SELECT GET_DDL('VIEW', 'v_products_regular');
SELECT GET_DDL('VIEW', 'v_products_secure');
-- Both visible to you (owner). Non-owner cannot see secure view DDL.

-- 7c. Check which views are secure
SHOW VIEWS LIKE '%products%';
-- Look at "is_secure" column

------------------------------------------------------------
-- CLEANUP
------------------------------------------------------------
-- DROP TABLE time_travel_demo;
-- DROP TABLE cloned_table;
