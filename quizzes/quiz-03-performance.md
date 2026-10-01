# Quiz: Domain 3 -- Performance Concepts (15 Questions)

---

**Q1.** A query profile shows significant "bytes spilled to remote storage." What is the recommended fix?

A) Add a clustering key  
B) Use a larger warehouse  
C) Enable result caching  
D) Create a materialized view  

---

**Q2.** Which caching layer serves results for a repeated identical query without consuming warehouse credits?

A) Local disk cache  
B) Result cache  
C) Metadata cache  
D) CDN cache  

---

**Q3.** The result cache will be invalidated when:

A) A different user runs the same query  
B) The underlying table data changes  
C) 12 hours have passed  
D) The warehouse is suspended  

---

**Q4.** What is the ideal clustering depth for a well-clustered table?

A) 0  
B) 1-2  
C) 5-10  
D) 100+  

---

**Q5.** Which multi-cluster scaling policy prioritizes cost savings by waiting longer before adding clusters?

A) Standard  
B) Economy  
C) Auto-Scale  
D) Conservative  

---

**Q6.** Materialized views in Snowflake can be based on:

A) Multiple tables with joins  
B) A single table only  
C) Other views  
D) External tables and regular tables  

---

**Q7.** The Search Optimization Service is best suited for:

A) Full table scan queries  
B) Large aggregation queries  
C) Point-lookup queries with equality/IN predicates  
D) Complex join queries  

---

**Q8.** A BI tool runs the same 50 queries every morning at 8 AM. The data doesn't change overnight. On the second morning, queries run much faster. Why?

A) Clustering improved overnight  
B) The result cache returns previously computed results  
C) The warehouse was pre-warmed  
D) Snowflake precompiled the queries  

---

**Q9.** Which function shows clustering information for a table?

A) `SYSTEM$CLUSTERING_DEPTH`  
B) `SYSTEM$CLUSTERING_INFORMATION`  
C) `SHOW CLUSTERING KEYS`  
D) `GET_CLUSTERING_STATS`  

---

**Q10.** When should you NOT add a clustering key?

A) A very large table with frequent filters on specific columns  
B) A small table under 1 GB  
C) A table with high clustering depth  
D) A table frequently filtered by date column  

---

**Q11.** Query Acceleration Service is best for queries that:

A) Return all rows from a table  
B) Perform large scans but return few rows  
C) Only use metadata cache  
D) Join many tables  

---

**Q12.** What happens to the local disk cache when a warehouse is suspended?

A) It persists for 24 hours  
B) It is lost  
C) It is moved to cloud storage  
D) It becomes the result cache  

---

**Q13.** A warehouse has auto-suspend set to 5 minutes. A query arrives 3 minutes after the last query. Is the warehouse running?

A) Yes -- it hasn't hit the 5-minute idle threshold  
B) No -- it was suspended after the last query completed  
C) Depends on the warehouse size  
D) Depends on the multi-cluster setting  

---

**Q14.** Which is the correct order of cache layers checked when a query is submitted?

A) Local disk → Result → Metadata  
B) Metadata → Result → Local disk  
C) Result → Metadata → Local disk  
D) Metadata → Local disk → Result  

---

**Q15.** Automatic clustering is a:

A) User-managed background process  
B) Serverless, Snowflake-managed background process  
C) Manual operation requiring a warehouse  
D) Feature that runs only during data loading  

---

## Answer Key

| Q | Answer | Explanation |
|---|--------|-------------|
| 1 | **B** | Spilling to remote storage means insufficient memory; scale up the warehouse |
| 2 | **B** | Result cache serves identical queries without warehouse credits |
| 3 | **B** | Result cache is invalidated when underlying data changes |
| 4 | **B** | Clustering depth of 1-2 indicates well-clustered data |
| 5 | **B** | Economy scaling policy waits longer (~6 min queue) before scaling out |
| 6 | **B** | Materialized views must be based on a single table |
| 7 | **C** | Search optimization improves point lookups (equality, IN, LIKE) |
| 8 | **B** | Unchanged data + same queries = result cache hit (24-hour validity) |
| 9 | **B** | `SYSTEM$CLUSTERING_INFORMATION` provides clustering details |
| 10 | **B** | Small tables don't benefit from clustering keys |
| 11 | **B** | QAS helps queries that scan a lot but select a small subset |
| 12 | **B** | Local disk cache is lost when the warehouse suspends |
| 13 | **A** | Auto-suspend timer resets; 3 min < 5 min threshold, so still running |
| 14 | **B** | Metadata cache → Result cache → Local disk cache (then remote storage) |
| 15 | **B** | Automatic clustering is serverless and managed by Snowflake |
