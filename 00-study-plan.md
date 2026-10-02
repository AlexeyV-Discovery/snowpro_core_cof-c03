# SnowPro Core COF-C03 -- Study Plan

## Exam Overview

| Detail | Value |
|---|---|
| **Exam Code** | COF-C03 |
| **Questions** | 100 multiple-choice / multi-select |
| **Duration** | 115 minutes |
| **Passing Score** | 750 / 1000 |
| **Cost** | $175 USD |
| **Delivery** | Online proctored or test center |

## Exam Domains & Weights

| # | Domain | Weight | Priority |
|---|--------|--------|----------|
| 1 | Snowflake AI Data Cloud Features & Architecture | 25% | HIGH |
| 2 | Account Access and Security | 20% | HIGH |
| 3 | Performance Concepts | 15% | MEDIUM |
| 4 | Data Loading and Unloading | 10% | MEDIUM |
| 5 | Data Transformations | 20% | HIGH |
| 6 | Data Protection and Data Sharing | 10% | MEDIUM |

---

## 4-Week Study Schedule (Hybrid Theory + Quiz-Driven)

### Week 1: Architecture + Security (45% of exam)

**Day 1-2: Snowflake Architecture Fundamentals**
- Cloud services layer, query processing layer, storage layer
- Virtual warehouses: types, sizing, scaling policies
- Micro-partitions and data clustering
- Metadata management
- Quiz: 15 questions

**Day 3-4: Snowflake Objects & Features**
- Databases, schemas, tables (permanent, transient, temporary, external)
- Views (standard, secure, materialized)
- Stages (internal, external, table stages)
- File formats, sequences, streams, tasks
- UDFs and stored procedures
- Quiz: 15 questions

**Day 5-6: Account Access & Security**
- Authentication (MFA, SSO, key-pair, OAuth)
- RBAC: system-defined roles (ACCOUNTADMIN, SYSADMIN, SECURITYADMIN, USERADMIN, PUBLIC)
- Role hierarchy and privilege inheritance
- Network policies, data encryption (end-to-end)
- Column-level and row-level security
- Quiz: 15 questions

**Day 7: Week 1 Checkpoint Quiz (30 questions across all Week 1 topics)**

---

### Week 2: Performance + Data Loading (25% of exam)

**Day 8-9: Performance Concepts**
- Query profiling and the query plan
- Warehouse sizing and concurrency
- Caching layers (metadata, result, local disk)
- Clustering keys and automatic clustering
- Search optimization service
- Materialized views for performance
- Quiz: 15 questions

**Day 10-11: Data Loading**
- COPY INTO (loading from stages)
- Snowpipe (auto-ingest)
- Bulk loading vs continuous loading
- File formats (CSV, JSON, Parquet, Avro, ORC)
- Data transformation during load (COPY transforms)
- Error handling during load
- Quiz: 15 questions

**Day 12-13: Data Unloading**
- COPY INTO <location> (unloading)
- Unloading to stages and cloud storage
- File format options for unloading
- Partitioning unloaded data
- Quiz: 10 questions

**Day 14: Week 2 Checkpoint Quiz (30 questions) + Week 1 Review (weak areas)**

---

### Week 3: Data Transformations + Data Protection (30% of exam)

**Day 15-16: SQL & Data Transformations**
- DML operations (INSERT, UPDATE, DELETE, MERGE)
- Joins, subqueries, CTEs
- Window functions (ROW_NUMBER, RANK, LEAD, LAG, etc.)
- FLATTEN and lateral joins for semi-structured data
- VARIANT, OBJECT, ARRAY data types
- QUALIFY clause
- Quiz: 15 questions

**Day 17-18: Semi-Structured Data**
- Loading and querying JSON, Parquet, Avro, XML
- Dot notation and bracket notation
- LATERAL FLATTEN
- PARSE_JSON, TRY_PARSE_JSON
- Type casting from VARIANT
- Quiz: 10 questions

**Day 19-20: Data Protection & Sharing**
- Time Travel (0-90 days, table types)
- Fail-safe (7 days, non-configurable)
- Data sharing (provider/consumer model)
- Secure views for sharing
- Reader accounts
- Data replication and failover
- Database and account replication
- Quiz: 15 questions

**Day 21: Week 3 Checkpoint Quiz (30 questions) + Weak Area Deep Dives**

---

### Week 4: Review, Mock Exams, Final Prep

**Day 22-23: Comprehensive Review**
- Re-study all weak areas identified in checkpoint quizzes
- Focus on highest-weight domains

**Day 24-25: Full Mock Exam #1 (100 questions) + Review**
- Take under timed conditions (115 min)
- Score and analyze results by domain
- Study gaps

**Day 26-27: Full Mock Exam #2 (100 questions) + Review**
- Second timed attempt
- Focus on remaining weak spots

**Day 28: Final Review**
- Quick-reference cheat sheet review
- Last pass on tricky topics
- REST before exam day

---

## Learning Resources

### Official (Free)
1. **Snowflake Documentation** -- docs.snowflake.com (primary reference)
2. **Snowflake University** -- learn.snowflake.com (free courses + hands-on badges)
   - "Hands-On Essentials: Data Warehousing" 
   - "Hands-On Essentials: Data Lake"
   - "Hands-On Essentials: Data Sharing"
3. **Snowflake COF-C03 Study Guide** -- official exam guide PDF

### Hands-On Practice
4. **Your Snowflake Account** -- MLA53836-UK_GENAI
   - Run all exercises directly in your account
   - Use SNOWFLAKE_SAMPLE_DATA for practice queries

### This Study Kit
- `00-STUDY-PLAN.md` -- This file (roadmap)
- `01-architecture-notes.md` -- Domain 1 study notes
- `02-security-notes.md` -- Domain 2 study notes
- `03-performance-notes.md` -- Domain 3 study notes
- `04-data-loading-notes.md` -- Domain 4 study notes
- `05-transformations-notes.md` -- Domain 5 study notes
- `06-protection-sharing-notes.md` -- Domain 6 study notes
- `exercises/` -- SQL exercises to run on your account
- `quizzes/` -- Practice questions by domain

---

## How We'll Work Together

1. **Study a domain** -- Read the notes, ask me to explain anything unclear
2. **Run exercises** -- Execute SQL on your Snowflake account
3. **Take quizzes** -- I'll quiz you and score your answers
4. **Checkpoint reviews** -- Weekly comprehensive quizzes to find weak spots
5. **Mock exams** -- Full 100-question timed practice tests
6. **Targeted review** -- I'll track your scores and focus on weak areas

**Ready? Tell me "Start Domain 1" to begin, or ask me any questions about the plan.**
