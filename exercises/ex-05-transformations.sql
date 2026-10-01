# Hands-On Exercises: Data Transformations & Semi-Structured Data

USE DATABASE EXAM_PREP;
USE SCHEMA EXERCISES;
USE WAREHOUSE exam_prep_wh;

------------------------------------------------------------
-- EXERCISE 1: Window Functions
------------------------------------------------------------

-- 1a. Create sample sales data
CREATE OR REPLACE TABLE sales (
  id INT,
  salesperson VARCHAR,
  region VARCHAR,
  sale_date DATE,
  amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 'Alice', 'East', '2024-01-15', 1500),
(2, 'Bob', 'East', '2024-01-20', 2300),
(3, 'Charlie', 'West', '2024-02-01', 1800),
(4, 'Alice', 'East', '2024-02-10', 2100),
(5, 'Bob', 'East', '2024-02-15', 1900),
(6, 'Diana', 'West', '2024-03-01', 2500),
(7, 'Charlie', 'West', '2024-03-10', 1200),
(8, 'Alice', 'East', '2024-03-15', 3000),
(9, 'Diana', 'West', '2024-04-01', 2800),
(10, 'Bob', 'East', '2024-04-10', 2200);

-- 1b. ROW_NUMBER: Rank salespeople by total sales
SELECT salesperson,
       SUM(amount) AS total_sales,
       ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM sales
GROUP BY salesperson;

-- 1c. RANK vs DENSE_RANK: Compare behavior with ties
SELECT salesperson, region,
       amount,
       RANK() OVER (ORDER BY amount DESC) AS rank_val,
       DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank_val,
       ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_num
FROM sales;

-- 1d. Running total with SUM() OVER
SELECT salesperson, sale_date, amount,
       SUM(amount) OVER (PARTITION BY salesperson ORDER BY sale_date) AS running_total
FROM sales
ORDER BY salesperson, sale_date;

-- 1e. LEAD/LAG: Compare each sale to the previous one
SELECT salesperson, sale_date, amount,
       LAG(amount) OVER (PARTITION BY salesperson ORDER BY sale_date) AS prev_sale,
       amount - LAG(amount) OVER (PARTITION BY salesperson ORDER BY sale_date) AS change
FROM sales
ORDER BY salesperson, sale_date;

-- 1f. QUALIFY: Get the top seller per region
SELECT salesperson, region, SUM(amount) AS total_sales,
       ROW_NUMBER() OVER (PARTITION BY region ORDER BY SUM(amount) DESC) AS rn
FROM sales
GROUP BY salesperson, region
QUALIFY rn = 1;

------------------------------------------------------------
-- EXERCISE 2: Semi-Structured Data (JSON)
------------------------------------------------------------

-- 2a. Create a table with VARIANT column
CREATE OR REPLACE TABLE events (
  event_id INT,
  event_data VARIANT
);

-- 2b. Insert JSON data
INSERT INTO events
SELECT 1, PARSE_JSON('{
  "event_type": "purchase",
  "customer": {
    "name": "John Smith",
    "email": "john@example.com",
    "age": 35
  },
  "items": [
    {"product": "Laptop", "price": 999.99, "qty": 1},
    {"product": "Mouse", "price": 29.99, "qty": 2}
  ],
  "timestamp": "2024-03-15T10:30:00Z"
}');

INSERT INTO events
SELECT 2, PARSE_JSON('{
  "event_type": "purchase",
  "customer": {
    "name": "Jane Doe",
    "email": "jane@example.com",
    "age": 28
  },
  "items": [
    {"product": "Keyboard", "price": 79.99, "qty": 1},
    {"product": "Monitor", "price": 599.99, "qty": 1},
    {"product": "USB Cable", "price": 9.99, "qty": 3}
  ],
  "timestamp": "2024-03-16T14:45:00Z"
}');

-- 2c. Query nested fields (dot and bracket notation)
SELECT 
  event_data:event_type::STRING AS event_type,
  event_data:customer.name::STRING AS customer_name,
  event_data:customer['email']::STRING AS email,
  event_data:customer.age::INT AS age,
  event_data:timestamp::TIMESTAMP AS event_time
FROM events;

-- 2d. FLATTEN: Expand the items array into rows
SELECT 
  e.event_id,
  e.event_data:customer.name::STRING AS customer,
  f.value:product::STRING AS product,
  f.value:price::DECIMAL(10,2) AS price,
  f.value:qty::INT AS quantity,
  f.value:price::DECIMAL(10,2) * f.value:qty::INT AS line_total
FROM events e,
LATERAL FLATTEN(input => e.event_data:items) f;

-- 2e. FLATTEN with aggregation: Total spend per customer
SELECT 
  e.event_data:customer.name::STRING AS customer,
  SUM(f.value:price::DECIMAL(10,2) * f.value:qty::INT) AS total_spend,
  COUNT(f.value) AS items_purchased
FROM events e,
LATERAL FLATTEN(input => e.event_data:items) f
GROUP BY 1;

------------------------------------------------------------
-- EXERCISE 3: MERGE (Upsert Pattern)
------------------------------------------------------------

-- 3a. Create target and source tables
CREATE OR REPLACE TABLE customers (
  id INT,
  name VARCHAR,
  email VARCHAR,
  status VARCHAR DEFAULT 'active',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO customers VALUES
(1, 'Alice', 'alice@old.com', 'active', CURRENT_TIMESTAMP()),
(2, 'Bob', 'bob@example.com', 'active', CURRENT_TIMESTAMP()),
(3, 'Charlie', 'charlie@example.com', 'active', CURRENT_TIMESTAMP());

CREATE OR REPLACE TABLE customer_updates (
  id INT,
  name VARCHAR,
  email VARCHAR
);

INSERT INTO customer_updates VALUES
(1, 'Alice', 'alice@new.com'),     -- UPDATE existing
(4, 'Diana', 'diana@example.com'), -- INSERT new
(5, 'Eve', 'eve@example.com');     -- INSERT new

-- 3b. Run MERGE
MERGE INTO customers c
USING customer_updates u ON c.id = u.id
WHEN MATCHED THEN UPDATE SET 
  c.email = u.email, 
  c.updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT (id, name, email) 
  VALUES (u.id, u.name, u.email);

-- 3c. Verify results
SELECT * FROM customers ORDER BY id;

------------------------------------------------------------
-- EXERCISE 4: PIVOT and UNPIVOT
------------------------------------------------------------

-- 4a. Create quarterly sales data
CREATE OR REPLACE TABLE quarterly_sales (
  salesperson VARCHAR,
  quarter VARCHAR,
  revenue DECIMAL(10,2)
);

INSERT INTO quarterly_sales VALUES
('Alice', 'Q1', 10000), ('Alice', 'Q2', 12000),
('Alice', 'Q3', 11000), ('Alice', 'Q4', 15000),
('Bob', 'Q1', 8000), ('Bob', 'Q2', 9500),
('Bob', 'Q3', 10500), ('Bob', 'Q4', 12000);

-- 4b. PIVOT: Convert quarters from rows to columns
SELECT * FROM quarterly_sales
  PIVOT(SUM(revenue) FOR quarter IN ('Q1', 'Q2', 'Q3', 'Q4'))
  AS p (salesperson, Q1, Q2, Q3, Q4)
ORDER BY salesperson;

-- 4c. UNPIVOT: Convert back from columns to rows
-- First create the pivoted version
CREATE OR REPLACE TABLE pivoted_sales AS
SELECT * FROM quarterly_sales
  PIVOT(SUM(revenue) FOR quarter IN ('Q1', 'Q2', 'Q3', 'Q4'))
  AS p (salesperson, Q1, Q2, Q3, Q4);

SELECT * FROM pivoted_sales
  UNPIVOT(revenue FOR quarter IN (Q1, Q2, Q3, Q4))
ORDER BY salesperson, quarter;

------------------------------------------------------------
-- EXERCISE 5: Conditional Expressions
------------------------------------------------------------

-- 5a. IFF vs CASE
SELECT id, amount,
  IFF(amount > 2000, 'High', 'Standard') AS iff_result,
  CASE 
    WHEN amount > 2500 THEN 'Premium'
    WHEN amount > 2000 THEN 'High'
    WHEN amount > 1500 THEN 'Medium'
    ELSE 'Standard'
  END AS case_result
FROM sales;

-- 5b. COALESCE, NVL, NVL2
SELECT 
  COALESCE(NULL, NULL, 'fallback') AS coalesce_result,
  NVL(NULL, 'default') AS nvl_result,
  NVL2(NULL, 'not null', 'is null') AS nvl2_null,
  NVL2('value', 'not null', 'is null') AS nvl2_not_null,
  NULLIF(10, 10) AS nullif_equal,
  NULLIF(10, 20) AS nullif_diff;

-- 5c. DECODE
SELECT salesperson, region,
  DECODE(region, 'East', 'Eastern Division', 'West', 'Western Division', 'Unknown') AS division
FROM sales;
