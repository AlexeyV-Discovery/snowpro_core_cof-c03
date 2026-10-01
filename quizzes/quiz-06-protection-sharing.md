# Quiz: Domain 6 -- Data Protection & Sharing (15 Questions)

---

**Q1.** What is the maximum Time Travel retention period for a PERMANENT table on Enterprise edition?

A) 1 day  
B) 7 days  
C) 30 days  
D) 90 days  

---

**Q2.** The Fail-Safe period is:

A) 7 days, user-accessible via Time Travel  
B) 7 days, only recoverable by Snowflake support  
C) 90 days, only for permanent tables  
D) 14 days, configurable per table  

---

**Q3.** Which table types have a Fail-Safe period?

A) Permanent and transient  
B) Permanent only  
C) All table types  
D) Permanent and temporary  

---

**Q4.** The UNDROP command works within which time window?

A) Fail-Safe period  
B) Time Travel retention period  
C) 24 hours  
D) 7 days always  

---

**Q5.** Snowflake's Secure Data Sharing:

A) Copies data to the consumer's account  
B) Creates a read-only snapshot for consumers  
C) Provides zero-copy, real-time access to shared data  
D) Requires data to be in the same region  

---

**Q6.** Which object type can be shared via Secure Data Sharing?

A) Stored procedures  
B) Stages  
C) Secure views  
D) Transient tables  

---

**Q7.** A Reader Account is:

A) A full Snowflake account created by the consumer  
B) A managed account created by the provider for non-Snowflake consumers  
C) A special role for read-only access  
D) An account type for data engineering only  

---

**Q8.** Who pays for compute in a Reader Account?

A) The consumer  
B) The provider  
C) Shared equally  
D) Snowflake covers it  

---

**Q9.** Zero-Copy Cloning:

A) Creates a full physical copy of the data  
B) Creates an independent clone that initially shares storage with the source  
C) Creates a linked copy that reflects changes from the source  
D) Only works for small tables  

---

**Q10.** Which Time Travel query syntax uses a specific query ID?

A) `AT(TIMESTAMP => '...')`  
B) `AT(OFFSET => -300)`  
C) `BEFORE(STATEMENT => '<query_id>')`  
D) `AT(QUERY => '<query_id>')`  

---

**Q11.** Cross-region data sharing requires:

A) VPN connection  
B) Database replication  
C) Shared cloud storage  
D) It's not possible  

---

**Q12.** Which replication feature is available only in Business Critical edition and above?

A) Database replication  
B) Account replication (with failover/failback)  
C) Share replication  
D) Stage replication  

---

**Q13.** Periodic re-keying of encryption keys is available starting from:

A) Standard edition  
B) Enterprise edition  
C) Business Critical edition  
D) VPS only  

---

**Q14.** When you clone a database, what happens to the child objects?

A) Only tables are cloned  
B) All child objects (schemas, tables, views, etc.) are cloned  
C) Only the database metadata is cloned  
D) You must specify which objects to clone  

---

**Q15.** What is the total maximum data protection period for a permanent table on Enterprise edition?

A) 90 days  
B) 91 days  
C) 97 days  
D) 100 days  

---

## Answer Key

| Q | Answer | Explanation |
|---|--------|-------------|
| 1 | **D** | Enterprise+ supports up to 90 days Time Travel for permanent tables |
| 2 | **B** | Fail-Safe is 7 days, only Snowflake support can recover data |
| 3 | **B** | Only permanent tables have Fail-Safe (transient and temporary do not) |
| 4 | **B** | UNDROP works within the Time Travel retention period |
| 5 | **C** | Secure Data Sharing is zero-copy with real-time access |
| 6 | **C** | Secure views (and secure UDFs, secure MVs, permanent tables) can be shared |
| 7 | **B** | Reader accounts are managed by the provider for non-Snowflake consumers |
| 8 | **B** | The provider pays for reader account compute |
| 9 | **B** | Zero-copy clone shares storage initially; diverges on modifications |
| 10 | **C** | BEFORE(STATEMENT => 'id') uses a query ID for Time Travel |
| 11 | **B** | Cross-region sharing requires database replication |
| 12 | **B** | Account replication with failover/failback needs Business Critical+ |
| 13 | **B** | Periodic re-keying starts at Enterprise edition |
| 14 | **B** | Cloning a database clones all child objects |
| 15 | **C** | 90 days Time Travel + 7 days Fail-Safe = 97 days |
