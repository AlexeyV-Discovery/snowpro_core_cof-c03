# Domain 5: Data Transformations (20%)

## 5.1 DML Operations

### INSERT
```sql
INSERT INTO target_table (col1, col2) VALUES (1, 'abc');
INSERT INTO target_table SELECT * FROM source_table;
```

### UPDATE
```sql
UPDATE my_table SET status = 'active' WHERE created_date > '2024-01-01';
```

### DELETE
```sql
DELETE FROM my_table WHERE status = 'inactive';
```

### MERGE (Upsert)
```sql
MERGE INTO target t
USING source s ON t.id = s.id
WHEN MATCHED THEN UPDATE SET t.name = s.name
WHEN NOT MATCHED THEN INSERT (id, name) VALUES (s.id, s.name);
```

### TRUNCATE
```sql
TRUNCATE TABLE my_table;  -- Removes all rows, resets table
```

**Key difference**: DELETE is DML (logged, recoverable with Time Travel). TRUNCATE is DDL (faster, also supports Time Travel).

---

## 5.2 Common Table Expressions (CTEs)

```sql
WITH sales_cte AS (
  SELECT region, SUM(amount) AS total_sales
  FROM sales
  GROUP BY region
)
SELECT * FROM sales_cte WHERE total_sales > 100000;
```

- Temporary, named result sets within a single query
- Improve readability of complex queries
- Can be referenced multiple times in the same query

---

## 5.3 Window Functions

### Syntax
```sql
function_name() OVER (
  [PARTITION BY col1, col2]
  [ORDER BY col3 [ASC|DESC]]
  [ROWS|RANGE BETWEEN ... AND ...]
)
```

### Common Functions
| Function | Purpose |
|---|---|
| `ROW_NUMBER()` | Unique sequential number per partition |
| `RANK()` | Rank with gaps on ties |
| `DENSE_RANK()` | Rank without gaps on ties |
| `NTILE(n)` | Divide into n buckets |
| `LEAD(col, n)` | Value from n rows ahead |
| `LAG(col, n)` | Value from n rows behind |
| `FIRST_VALUE(col)` | First value in window |
| `LAST_VALUE(col)` | Last value in window |
| `SUM/AVG/COUNT()` | Running aggregates |

### QUALIFY Clause (Snowflake-specific)
```sql
SELECT id, name, region,
       ROW_NUMBER() OVER (PARTITION BY region ORDER BY sales DESC) AS rn
FROM employees
QUALIFY rn = 1;  -- Keep only top seller per region
```
- Filters results of window functions
- Like HAVING for GROUP BY, but for window functions
- Eliminates the need for subqueries

---

## 5.4 Semi-Structured Data

### VARIANT Data Type
```sql
CREATE TABLE events (
  id INT,
  data VARIANT
);

INSERT INTO events SELECT 1, PARSE_JSON('{"name":"John","age":30}');
```

### Querying Semi-Structured Data
```sql
-- Dot notation
SELECT data:name::STRING, data:age::INT FROM events;

-- Bracket notation
SELECT data['name']::STRING FROM events;

-- Nested
SELECT data:address.city::STRING FROM events;
```

### FLATTEN (Critical for Exam!)
```sql
-- Array flattening
SELECT f.value::STRING AS item
FROM orders,
LATERAL FLATTEN(input => order_items) f;

-- Nested flattening
SELECT f.value:name::STRING
FROM events,
LATERAL FLATTEN(input => data:employees) f;
```

### FLATTEN Output Columns
| Column | Description |
|---|---|
| `SEQ` | Sequence number |
| `KEY` | Key for maps, index for arrays |
| `PATH` | Path to the element |
| `INDEX` | Array index (null for objects) |
| `VALUE` | The flattened value |
| `THIS` | The element being flattened |

### Type Casting from VARIANT
```sql
data:field::STRING     -- Cast to string
data:field::NUMBER     -- Cast to number
data:field::BOOLEAN    -- Cast to boolean
data:field::TIMESTAMP  -- Cast to timestamp
```

Always cast VARIANT fields to specific types for proper comparison and aggregation.

---

## 5.5 String Functions

| Function | Example |
|---|---|
| `CONCAT` / `\|\|` | `CONCAT('a', 'b')` or `'a' \|\| 'b'` |
| `LENGTH` | `LENGTH('hello')` → 5 |
| `UPPER` / `LOWER` | Case conversion |
| `TRIM` / `LTRIM` / `RTRIM` | Remove whitespace |
| `SUBSTR` | `SUBSTR('hello', 1, 3)` → 'hel' |
| `REPLACE` | `REPLACE('hello', 'l', 'r')` |
| `SPLIT_PART` | `SPLIT_PART('a-b-c', '-', 2)` → 'b' |
| `REGEXP_LIKE` | Pattern matching |

---

## 5.6 Date/Time Functions

| Function | Description |
|---|---|
| `CURRENT_DATE()` | Today's date |
| `CURRENT_TIMESTAMP()` | Current timestamp |
| `DATEADD(part, n, date)` | Add interval to date |
| `DATEDIFF(part, d1, d2)` | Difference between dates |
| `DATE_TRUNC(part, date)` | Truncate to precision |
| `TO_DATE(str, fmt)` | String to date |
| `TO_TIMESTAMP(str, fmt)` | String to timestamp |
| `YEAR/MONTH/DAY(date)` | Extract component |

---

## 5.7 Conditional Expressions

```sql
-- CASE
SELECT CASE WHEN status = 'A' THEN 'Active' ELSE 'Inactive' END;

-- IFF (Snowflake shorthand for simple CASE)
SELECT IFF(status = 'A', 'Active', 'Inactive');

-- COALESCE
SELECT COALESCE(col1, col2, 'default');  -- First non-null

-- NVL / NVL2
SELECT NVL(col1, 'default');             -- If null, use default
SELECT NVL2(col1, 'has value', 'null');  -- If not null / if null

-- NULLIF
SELECT NULLIF(col1, col2);  -- Returns NULL if equal

-- DECODE
SELECT DECODE(status, 'A', 'Active', 'I', 'Inactive', 'Unknown');

-- ZEROIFNULL / NULLIFZERO
SELECT ZEROIFNULL(col1);  -- NULL → 0
SELECT NULLIFZERO(col1);  -- 0 → NULL
```

---

## 5.8 Sequences

```sql
CREATE SEQUENCE my_seq START = 1 INCREMENT = 1;

-- Use in INSERT
INSERT INTO my_table VALUES (my_seq.NEXTVAL, 'data');

-- Sequences are NOT gap-free (gaps are normal)
```

---

## 5.9 Sampling

```sql
-- Row-based sampling (approximate % of rows)
SELECT * FROM my_table SAMPLE (10);  -- ~10% of rows

-- Block-based sampling (faster for large tables)
SELECT * FROM my_table SAMPLE BLOCK (10);  -- ~10% of blocks

-- Fixed row count
SELECT * FROM my_table SAMPLE (100 ROWS);
```

---

## 5.10 PIVOT / UNPIVOT

```sql
-- PIVOT: rows to columns
SELECT * FROM sales
  PIVOT(SUM(amount) FOR quarter IN ('Q1','Q2','Q3','Q4'));

-- UNPIVOT: columns to rows
SELECT * FROM pivoted_sales
  UNPIVOT(amount FOR quarter IN (Q1, Q2, Q3, Q4));
```
