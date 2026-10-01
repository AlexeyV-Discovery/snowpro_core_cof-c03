# Quiz: Domain 5 -- Data Transformations (15 Questions)

---

**Q1.** What does the QUALIFY clause filter on?

A) Grouped aggregate results  
B) Window function results  
C) JOIN conditions  
D) Subquery results  

---

**Q2.** Which function returns a unique sequential number with no gaps or ties?

A) RANK()  
B) DENSE_RANK()  
C) ROW_NUMBER()  
D) NTILE()  

---

**Q3.** What is the correct way to access a field called "name" from a VARIANT column called `data`?

A) `data->name`  
B) `data.name`  
C) `data:name`  
D) `data['name']`  
E) Both C and D  

---

**Q4.** LATERAL FLATTEN is used to:

A) Join two tables on matching columns  
B) Expand semi-structured arrays/objects into rows  
C) Compress data into VARIANT format  
D) Create nested JSON structures  

---

**Q5.** Which FLATTEN output column contains the actual value of each element?

A) KEY  
B) INDEX  
C) VALUE  
D) THIS  

---

**Q6.** What is the difference between DELETE and TRUNCATE in Snowflake?

A) DELETE supports Time Travel; TRUNCATE does not  
B) TRUNCATE is DML; DELETE is DDL  
C) Both support Time Travel; TRUNCATE is DDL and faster  
D) They are identical  

---

**Q7.** In a MERGE statement, which clause handles rows that exist in the source but not the target?

A) WHEN MATCHED  
B) WHEN NOT MATCHED  
C) WHEN MATCHED AND NOT EXISTS  
D) ON clause  

---

**Q8.** Which function returns the value from the NEXT row in a window?

A) LAG()  
B) LEAD()  
C) FIRST_VALUE()  
D) NTH_VALUE()  

---

**Q9.** How do you cast a VARIANT field to a string?

A) `CAST(data:field AS STRING)`  
B) `data:field::STRING`  
C) `TO_VARCHAR(data:field)`  
D) All of the above  

---

**Q10.** What does NVL2(expr, value_if_not_null, value_if_null) return?

A) The expression if it's null  
B) value_if_not_null when expr IS NOT NULL; value_if_null when expr IS NULL  
C) Always the first non-null value  
D) The expression unchanged  

---

**Q11.** The PIVOT operation converts:

A) Columns to rows  
B) Rows to columns  
C) JSON to tabular  
D) Tabular to JSON  

---

**Q12.** Which sampling method is faster on very large tables?

A) ROW sampling  
B) BLOCK sampling  
C) Both are equally fast  
D) Sampling is not supported on large tables  

---

**Q13.** A sequence in Snowflake guarantees:

A) No gaps in values  
B) Unique, increasing values (gaps are possible)  
C) Sequential values across sessions  
D) Thread-safe gap-free numbering  

---

**Q14.** Which function converts a JSON string into a VARIANT value?

A) JSON_PARSE()  
B) PARSE_JSON()  
C) TO_JSON()  
D) CAST(str AS VARIANT)  

---

**Q15.** What does `SPLIT_PART('a-b-c', '-', 2)` return?

A) 'a'  
B) 'b'  
C) 'c'  
D) 'a-b'  

---

## Answer Key

| Q | Answer | Explanation |
|---|--------|-------------|
| 1 | **B** | QUALIFY filters on window function results (like HAVING for GROUP BY) |
| 2 | **C** | ROW_NUMBER() always gives unique sequential numbers |
| 3 | **E** | Both colon notation (data:name) and bracket notation (data['name']) work |
| 4 | **B** | FLATTEN expands arrays/objects in semi-structured data into rows |
| 5 | **C** | VALUE contains the actual element value from FLATTEN |
| 6 | **C** | Both support Time Travel; TRUNCATE is DDL and faster than DELETE |
| 7 | **B** | WHEN NOT MATCHED handles source rows not in target (INSERT) |
| 8 | **B** | LEAD() looks ahead; LAG() looks behind |
| 9 | **D** | All three methods work for casting VARIANT to string |
| 10 | **B** | NVL2 returns different values based on whether expr is null |
| 11 | **B** | PIVOT converts row values into columns |
| 12 | **B** | BLOCK sampling is faster because it samples entire micro-partitions |
| 13 | **B** | Sequences guarantee uniqueness but NOT gap-free values |
| 14 | **B** | PARSE_JSON() converts a JSON string to VARIANT |
| 15 | **B** | SPLIT_PART splits by delimiter and returns the 2nd part |
