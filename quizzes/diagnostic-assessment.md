# Diagnostic Assessment -- SnowPro Core COF-C03
# 20 Questions Across All 6 Domains (Quick Baseline Test)

Answer each question to identify your starting strengths and weaknesses.

---

## Architecture (Q1-Q4)

**Q1.** Which cache layer answers `SELECT COUNT(*) FROM table` without a warehouse?  
A) Result cache  B) Metadata cache  C) Local disk cache  D) Query acceleration  

**Q2.** Transient tables differ from permanent tables because:  
A) They cannot store data longer than 24 hours  
B) They have 0 Fail-Safe days and max 1 day Time Travel  
C) They don't support DML operations  
D) They are stored in external storage  

**Q3.** Cloud services layer charges are billed when they exceed what threshold?  
A) 5% of compute credits  B) 10% of compute credits  C) 15% of compute credits  D) Always billed separately  

**Q4.** Which warehouse size consumes 8 credits per hour?  
A) Medium  B) Large  C) X-Large  D) 2X-Large  

---

## Security (Q5-Q8)

**Q5.** Which role CANNOT grant object privileges?  
A) SECURITYADMIN  B) USERADMIN  C) ACCOUNTADMIN  D) SYSADMIN  

**Q6.** What is the recommended practice for the ACCOUNTADMIN role?  
A) Set it as default role for DBAs  
B) Use it only when necessary; never as default role  
C) Grant it to all team leads  
D) Use it for all DDL operations  

**Q7.** Which grant type pre-assigns privileges to objects that don't yet exist?  
A) CURRENT GRANTS  B) ALL GRANTS  C) FUTURE GRANTS  D) DYNAMIC GRANTS  

**Q8.** Row access policies are available starting from which edition?  
A) Standard  B) Enterprise  C) Business Critical  D) VPS only  

---

## Performance (Q9-Q12)

**Q9.** The result cache is stored in which layer?  
A) Compute layer  B) Storage layer  C) Cloud services layer  D) Client layer  

**Q10.** A warehouse query profile shows "Bytes Spilled to Remote Storage." What does this indicate?  
A) Network latency issues  B) The warehouse is too small for the query  
C) Data corruption  D) Disk failure  

**Q11.** Which Snowflake feature is NOT available in Standard edition?  
A) Virtual warehouses  B) Clustering keys  C) Result caching  D) COPY INTO  

**Q12.** Auto-clustering is:  
A) A manual DBA task  B) A serverless background process  
C) A warehouse-dependent feature  D) Only for external tables  

---

## Data Loading (Q13-Q15)

**Q13.** The default ON_ERROR for COPY INTO is:  
A) CONTINUE  B) SKIP_FILE  C) ABORT_STATEMENT  D) SKIP_FILE_1  

**Q14.** Snowpipe uses what kind of compute?  
A) A user's virtual warehouse  B) Serverless compute  
C) Cloud services compute  D) External compute  

**Q15.** Which command uploads files from a local machine to an internal stage?  
A) COPY INTO  B) INSERT  C) PUT  D) LOAD  

---

## Transformations (Q16-Q18)

**Q16.** The QUALIFY clause filters on:  
A) Aggregate function results  B) Window function results  
C) JOIN conditions  D) WHERE clause conditions  

**Q17.** LATERAL FLATTEN is used to:  
A) Join two relational tables  B) Compress JSON data  
C) Expand arrays/objects into rows  D) Create nested structures  

**Q18.** Which function returns NULL if both arguments are equal?  
A) NVL  B) COALESCE  C) NULLIF  D) NVL2  

---

## Data Protection & Sharing (Q19-Q20)

**Q19.** The Fail-Safe period for a transient table is:  
A) 7 days  B) 1 day  C) 0 days  D) 90 days  

**Q20.** In Secure Data Sharing, who pays for compute on a Reader Account?  
A) Consumer  B) Provider  C) Snowflake  D) Shared cost  

---

## Answer Key

| Q | Domain | Answer |
|---|--------|--------|
| 1 | Architecture | **B** -- Metadata cache handles aggregate stats |
| 2 | Architecture | **B** -- Transient: 0 Fail-Safe, max 1 day TT |
| 3 | Architecture | **B** -- Cloud services charged above 10% of daily warehouse credits |
| 4 | Architecture | **B** -- XS=1, S=2, M=4, L=8, XL=16 |
| 5 | Security | **B** -- USERADMIN manages users/roles, not object privileges |
| 6 | Security | **B** -- ACCOUNTADMIN should only be used when necessary |
| 7 | Security | **C** -- FUTURE GRANTS apply to objects not yet created |
| 8 | Security | **B** -- Row access policies require Enterprise edition |
| 9 | Performance | **C** -- Result cache is in the cloud services layer |
| 10 | Performance | **B** -- Spilling means insufficient warehouse memory |
| 11 | Performance | **B** -- Clustering keys require Enterprise edition |
| 12 | Performance | **B** -- Auto-clustering is serverless |
| 13 | Data Loading | **C** -- ABORT_STATEMENT is the default |
| 14 | Data Loading | **B** -- Snowpipe uses serverless compute |
| 15 | Data Loading | **C** -- PUT uploads local files to internal stage |
| 16 | Transformations | **B** -- QUALIFY filters window function results |
| 17 | Transformations | **C** -- FLATTEN expands semi-structured to rows |
| 18 | Transformations | **C** -- NULLIF returns NULL if args are equal |
| 19 | Protection | **C** -- Transient tables have 0 Fail-Safe |
| 20 | Protection | **B** -- Provider pays for reader account compute |

---

## Scoring Guide

| Score | Assessment | Recommendation |
|-------|-----------|----------------|
| 18-20 | Strong foundation | Focus on mock exams and edge cases |
| 14-17 | Good, some gaps | Study weak domains, then practice quizzes |
| 10-13 | Moderate | Work through all domain notes systematically |
| <10 | Needs significant prep | Start from Domain 1, follow the full 4-week plan |

**Your score: __/20**
**Weak domains: ______________________**
