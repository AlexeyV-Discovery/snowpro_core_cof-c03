# Quiz: Domain 4 -- Data Loading and Unloading (15 Questions)

---

**Q1.** What is the default ON_ERROR behavior for the COPY INTO command?

A) CONTINUE  
B) SKIP_FILE  
C) ABORT_STATEMENT  
D) SKIP_FILE_1  

---

**Q2.** How long does Snowflake track file loading metadata to prevent duplicate loads?

A) 7 days  
B) 14 days  
C) 64 days  
D) 90 days  

---

**Q3.** Which COPY INTO option forces reloading of files that were already loaded?

A) PURGE = TRUE  
B) FORCE = TRUE  
C) RELOAD = TRUE  
D) DUPLICATE = ALLOW  

---

**Q4.** What is the recommended file size for optimal bulk loading?

A) 1-10 MB compressed  
B) 10-50 MB compressed  
C) 100-250 MB compressed  
D) 500 MB - 1 GB compressed  

---

**Q5.** The PUT command can be used from:

A) Snowsight only  
B) SnowSQL and programmatic drivers only  
C) Any Snowflake interface  
D) External tools only  

---

**Q6.** Which stage notation refers to the current user's stage?

A) `@%`  
B) `@~`  
C) `@*`  
D) `@$user`  

---

**Q7.** Snowpipe is triggered by:

A) A CRON schedule  
B) Cloud event notifications (SQS, Event Grid, Pub/Sub)  
C) Manual execution  
D) Warehouse resume events  

---

**Q8.** When using COPY INTO to load CSV data, what notation refers to the third column?

A) `$3`  
B) `col3`  
C) `[3]`  
D) `column(3)`  

---

**Q9.** Which VALIDATION_MODE option previews errors without loading any data?

A) RETURN_10_ROWS  
B) RETURN_ERRORS  
C) RETURN_ALL_ERRORS  
D) Both B and C  

---

**Q10.** Which file format is NOT supported by Snowflake for loading?

A) CSV  
B) JSON  
C) Parquet  
D) HDF5  

---

**Q11.** The PURGE option in COPY INTO:

A) Deletes the target table data before loading  
B) Deletes source files after successful load  
C) Removes duplicate records  
D) Clears the stage metadata  

---

**Q12.** What is the default MAX_FILE_SIZE for data unloading?

A) 1 MB  
B) 16 MB  
C) 64 MB  
D) 256 MB  

---

**Q13.** To transform data during loading, you must:

A) Use a stored procedure before COPY  
B) Use a COPY INTO with a SELECT subquery from the stage  
C) First load raw data, then transform with UPDATE  
D) Use an external ETL tool  

---

**Q14.** Which is TRUE about Snowpipe?

A) It uses a dedicated virtual warehouse  
B) It guarantees file loading order  
C) It uses serverless compute and loads in near real-time  
D) It can only load from internal stages  

---

**Q15.** The MATCH_BY_COLUMN_NAME option in COPY INTO:

A) Matches source columns to target by position  
B) Matches source columns to target by name  
C) Renames columns during loading  
D) Only works with CSV files  

---

## Answer Key

| Q | Answer | Explanation |
|---|--------|-------------|
| 1 | **C** | ABORT_STATEMENT is the default -- stops on first error |
| 2 | **C** | 64 days of load metadata tracking |
| 3 | **B** | FORCE=TRUE reloads already-loaded files |
| 4 | **C** | 100-250 MB compressed is the sweet spot for parallel loading |
| 5 | **B** | PUT is only available from SnowSQL and programmatic drivers |
| 6 | **B** | @~ is the user stage notation |
| 7 | **B** | Snowpipe is triggered by cloud event notifications |
| 8 | **A** | $1, $2, $3... are positional column references in CSV |
| 9 | **D** | Both RETURN_ERRORS and RETURN_ALL_ERRORS preview errors without loading |
| 10 | **D** | HDF5 is not a supported format; CSV, JSON, Parquet, Avro, ORC, XML are |
| 11 | **B** | PURGE deletes the source files from the stage after successful load |
| 12 | **B** | Default MAX_FILE_SIZE for unloading is 16 MB |
| 13 | **B** | Use a SELECT subquery within COPY INTO to transform during load |
| 14 | **C** | Snowpipe is serverless and provides near real-time loading |
| 15 | **B** | MATCH_BY_COLUMN_NAME matches by name, not position |
