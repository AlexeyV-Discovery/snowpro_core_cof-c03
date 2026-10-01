# Quiz: Domain 1 -- Architecture & Features (15 Questions)

Answer each question, then check your answers at the bottom.

---

**Q1.** Snowflake's architecture consists of three layers. Which layer handles authentication, metadata management, and query optimization?

A) Storage Layer  
B) Compute Layer  
C) Cloud Services Layer  
D) Network Layer  

---

**Q2.** How is data physically stored in Snowflake?

A) In row-based format in micro-partitions  
B) In columnar format in micro-partitions  
C) In columnar format in data blocks  
D) In row-based format across distributed nodes  

---

**Q3.** What is the approximate size range of a Snowflake micro-partition?

A) 1-10 MB compressed  
B) 50-500 MB compressed  
C) 500 MB - 1 GB compressed  
D) 1-5 GB compressed  

---

**Q4.** Which Snowflake edition is the MINIMUM required for multi-cluster warehouses?

A) Standard  
B) Enterprise  
C) Business Critical  
D) Virtual Private Snowflake  

---

**Q5.** A user runs `SELECT COUNT(*) FROM large_table;` and gets the result in under a second without using a warehouse. What made this possible?

A) Result cache  
B) Metadata cache  
C) Local disk cache  
D) Query acceleration service  

---

**Q6.** How long does the result cache persist for an unchanged query?

A) 1 hour  
B) 12 hours  
C) 24 hours  
D) 7 days  

---

**Q7.** Which table type has NO Fail-Safe period and is dropped at the end of the session?

A) Permanent  
B) Transient  
C) Temporary  
D) External  

---

**Q8.** What is the credit consumption for an X-Small warehouse per hour?

A) 0.5 credits  
B) 1 credit  
C) 2 credits  
D) 4 credits  

---

**Q9.** Which statement about Snowflake billing is TRUE?

A) Warehouses are billed per-minute with a 5-minute minimum  
B) Warehouses are billed per-second with a 60-second minimum  
C) Warehouses are billed per-hour  
D) Warehouses are billed per-query  

---

**Q10.** What is the purpose of a Snowflake STREAM object?

A) Load data from external sources  
B) Schedule SQL tasks  
C) Track DML changes (CDC) on a table  
D) Provide secure access to shared data  

---

**Q11.** Which stage type is automatically available for each user without creating any objects?

A) Named internal stage  
B) Named external stage  
C) User stage (@~)  
D) Table stage  

---

**Q12.** Snowpipe uses what type of compute for loading data?

A) Virtual warehouse specified in the PIPE definition  
B) Serverless compute managed by Snowflake  
C) Cloud services layer compute  
D) The user's default warehouse  

---

**Q13.** Which Snowflake feature is NOT available in Standard edition?

A) Time Travel (1 day)  
B) Virtual warehouses  
C) Materialized views  
D) Snowpipe  

---

**Q14.** A Snowpark-Optimized warehouse is best suited for:

A) Simple SELECT queries  
B) Memory-intensive operations like ML workloads  
C) Concurrent BI dashboard queries  
D) Bulk data loading  

---

**Q15.** When are Cloud Services charges billed to the customer?

A) Always -- for every query  
B) Only when cloud services usage exceeds 10% of the daily warehouse credit usage  
C) Only for metadata operations  
D) Cloud services are always free  

---

## Answer Key

| Q | Answer | Explanation |
|---|--------|-------------|
| 1 | **C** | Cloud Services handles auth, metadata, optimization, access control |
| 2 | **B** | Snowflake stores data in columnar format within micro-partitions |
| 3 | **B** | Micro-partitions are 50-500 MB compressed |
| 4 | **B** | Multi-cluster warehouses require Enterprise edition or higher |
| 5 | **B** | Metadata cache stores COUNT, MIN, MAX for tables; no warehouse needed |
| 6 | **C** | Result cache is valid for 24 hours if data hasn't changed |
| 7 | **C** | Temporary tables have no Fail-Safe and are session-scoped |
| 8 | **B** | X-Small = 1 credit/hour; each size up doubles |
| 9 | **B** | Per-second billing with 60-second minimum |
| 10 | **C** | Streams provide change data capture on tables |
| 11 | **C** | User stage (@~) is auto-created for each user |
| 12 | **B** | Snowpipe uses Snowflake-managed serverless compute |
| 13 | **C** | Materialized views require Enterprise edition |
| 14 | **B** | Snowpark-Optimized warehouses have more memory for ML/large data ops |
| 15 | **B** | Cloud services costs above 10% of daily warehouse usage are billed |
