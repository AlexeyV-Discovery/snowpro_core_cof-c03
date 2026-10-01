# Hands-On Exercises: Data Loading & Unloading

USE DATABASE EXAM_PREP;
USE SCHEMA EXERCISES;
USE WAREHOUSE exam_prep_wh;

------------------------------------------------------------
-- EXERCISE 1: File Formats
------------------------------------------------------------

-- 1a. Create a CSV file format
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null', '')
  EMPTY_FIELD_AS_NULL = TRUE;

-- 1b. Create a JSON file format
CREATE OR REPLACE FILE FORMAT json_format
  TYPE = JSON
  STRIP_OUTER_ARRAY = TRUE;

-- 1c. Show all file formats
SHOW FILE FORMATS IN SCHEMA;

------------------------------------------------------------
-- EXERCISE 2: Internal Stage + COPY INTO
------------------------------------------------------------

-- 2a. Create a target table
CREATE OR REPLACE TABLE products (
  product_id INT,
  product_name VARCHAR,
  category VARCHAR,
  price DECIMAL(10,2)
);

-- 2b. Create an internal stage
CREATE OR REPLACE STAGE products_stage
  FILE_FORMAT = csv_format;

-- 2c. Generate sample data using a query and unload to stage
-- (This is how we simulate having files without using PUT)
CREATE OR REPLACE TABLE products_source AS
SELECT 
  SEQ4() AS product_id,
  'Product_' || SEQ4() AS product_name,
  CASE MOD(SEQ4(), 3) 
    WHEN 0 THEN 'Electronics'
    WHEN 1 THEN 'Clothing'
    ELSE 'Home'
  END AS category,
  ROUND(UNIFORM(10, 500, RANDOM())::DECIMAL(10,2), 2) AS price
FROM TABLE(GENERATOR(ROWCOUNT => 1000));

-- Unload to stage
COPY INTO @products_stage/products_
FROM products_source
FILE_FORMAT = (TYPE = CSV COMPRESSION = NONE)
HEADER = TRUE
MAX_FILE_SIZE = 50000;

-- 2d. List files in stage
LIST @products_stage;

-- 2e. Load from stage into target
COPY INTO products
FROM @products_stage/
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- 2f. Verify
SELECT COUNT(*) FROM products;
SELECT * FROM products LIMIT 10;

------------------------------------------------------------
-- EXERCISE 3: VALIDATION_MODE (Preview Errors)
------------------------------------------------------------

-- 3a. Create a table with strict types
CREATE OR REPLACE TABLE strict_data (
  id INT,
  amount DECIMAL(10,2),
  created_date DATE
);

-- 3b. Create a stage with intentionally bad data
CREATE OR REPLACE STAGE bad_data_stage;

-- Put some data with errors (using a CTE with bad values)
CREATE OR REPLACE TABLE bad_source AS
SELECT '1' AS col1, '100.50' AS col2, '2024-01-15' AS col3
UNION ALL SELECT '2', '200.00', '2024-02-20'
UNION ALL SELECT 'ABC', '300.00', '2024-03-01'  -- Bad: 'ABC' is not an INT
UNION ALL SELECT '4', 'NOT_NUM', '2024-04-01';  -- Bad: 'NOT_NUM' is not DECIMAL

COPY INTO @bad_data_stage/test_
FROM bad_source
FILE_FORMAT = (TYPE = CSV);

-- 3c. Validate before loading (preview errors)
COPY INTO strict_data
FROM @bad_data_stage/
FILE_FORMAT = (TYPE = CSV)
VALIDATION_MODE = 'RETURN_ERRORS';

------------------------------------------------------------
-- EXERCISE 4: Loading with Transformation
------------------------------------------------------------

-- 4a. Create a target with different column order/types
CREATE OR REPLACE TABLE transformed_products (
  category VARCHAR,
  product_upper VARCHAR,
  price_with_tax DECIMAL(10,2),
  load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- 4b. Load from stage with SELECT transformation
COPY INTO transformed_products (category, product_upper, price_with_tax)
FROM (
  SELECT $3,              -- category (3rd column)
         UPPER($2),       -- product_name uppercased
         $4 * 1.1         -- price + 10% tax
  FROM @products_stage/
)
FILE_FORMAT = csv_format;

-- 4c. Verify transformation
SELECT * FROM transformed_products LIMIT 10;

------------------------------------------------------------
-- EXERCISE 5: Data Unloading
------------------------------------------------------------

-- 5a. Create an export stage
CREATE OR REPLACE STAGE export_stage;

-- 5b. Unload with partitioning
COPY INTO @export_stage/by_category/
FROM (SELECT * FROM products)
PARTITION BY (category)
FILE_FORMAT = (TYPE = CSV COMPRESSION = GZIP)
HEADER = TRUE;

-- 5c. Check the exported files
LIST @export_stage;

-- 5d. Unload as JSON
COPY INTO @export_stage/json_export/
FROM (
  SELECT OBJECT_CONSTRUCT(
    'id', product_id,
    'name', product_name,
    'category', category,
    'price', price
  ) AS json_data
  FROM products
  WHERE category = 'Electronics'
  LIMIT 10
)
FILE_FORMAT = (TYPE = JSON);

LIST @export_stage/json_export/;

------------------------------------------------------------
-- EXERCISE 6: Load History
------------------------------------------------------------

-- 6a. Check load history for your table
SELECT *
FROM TABLE(INFORMATION_SCHEMA.COPY_HISTORY(
  TABLE_NAME => 'PRODUCTS',
  START_TIME => DATEADD(HOURS, -24, CURRENT_TIMESTAMP())
))
ORDER BY LAST_LOAD_TIME DESC;

-- 6b. Try to reload the same files (should skip -- already loaded)
COPY INTO products FROM @products_stage/ FILE_FORMAT = csv_format;
-- Notice: "Copy executed with 0 files processed"

-- 6c. Force reload
COPY INTO products FROM @products_stage/ FILE_FORMAT = csv_format FORCE = TRUE;
-- Now it reloads everything

------------------------------------------------------------
-- CLEANUP
------------------------------------------------------------
-- DROP STAGE products_stage;
-- DROP STAGE bad_data_stage;
-- DROP STAGE export_stage;
