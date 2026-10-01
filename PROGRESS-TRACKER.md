# SnowPro Core COF-C03 -- Learning Progress Tracker

## Student: Alexey Vitkalov
## Target: 75%+ across all domains
## Exam Date: TBD (within 1 month of 2024-09-10)

---

## Diagnostic Assessment -- 2024-09-10

**Overall Score: 11/20 (55%)**

| # | Domain | Weight | Score | % | Status |
|---|--------|--------|-------|---|--------|
| 1 | Architecture & Features | 25% | 2/4 | 50% | Needs work |
| 2 | Account Access & Security | 20% | 3/4 | 75% | Solid |
| 3 | Performance Concepts | 15% | 2/4 | 50% | Needs work |
| 4 | Data Loading & Unloading | 10% | 2/3 | 67% | Close |
| 5 | Data Transformations | 20% | 2/3 | 67% | Close |
| 6 | Data Protection & Sharing | 10% | 0/2 | 0% | Priority |

### Detailed Question Results

| Q# | Domain | Question Topic | Your Answer | Correct | Result |
|----|--------|---------------|-------------|---------|--------|
| 1 | Architecture | Cache for COUNT(*) without warehouse | D) Query acceleration | B) Metadata cache | WRONG |
| 2 | Architecture | Transient vs permanent tables | B) 0 Fail-Safe, 1d TT | B) 0 Fail-Safe, 1d TT | CORRECT |
| 3 | Architecture | Cloud services billing threshold | A) 5% | B) 10% | WRONG |
| 4 | Architecture | Warehouse credits (8 cr/hr) | B) Large | B) Large | CORRECT |
| 5 | Security | Role that cannot grant object privs | D) SYSADMIN | B) USERADMIN | WRONG |
| 6 | Security | ACCOUNTADMIN best practice | B) Use only when needed | B) Use only when needed | CORRECT |
| 7 | Security | Pre-assign privileges to future objects | C) FUTURE GRANTS | C) FUTURE GRANTS | CORRECT |
| 8 | Security | Row access policies edition | B) Enterprise | B) Enterprise | CORRECT |
| 9 | Performance | Result cache location | B) Storage layer | C) Cloud services | WRONG |
| 10 | Performance | Bytes spilled to remote storage | A) Network latency | B) Warehouse too small | WRONG |
| 11 | Performance | Feature NOT in Standard edition | B) Clustering keys | B) Clustering keys | CORRECT |
| 12 | Performance | Auto-clustering compute model | B) Serverless | B) Serverless | CORRECT |
| 13 | Data Loading | Default ON_ERROR for COPY INTO | C) ABORT_STATEMENT | C) ABORT_STATEMENT | CORRECT |
| 14 | Data Loading | Snowpipe compute type | C) Cloud services | B) Serverless | WRONG |
| 15 | Data Loading | Upload local files to stage | C) PUT | C) PUT | CORRECT |
| 16 | Transformations | QUALIFY clause filters on | B) Window functions | B) Window functions | CORRECT |
| 17 | Transformations | LATERAL FLATTEN purpose | B) Compress JSON | C) Expand arrays to rows | WRONG |
| 18 | Transformations | Function returns NULL if args equal | C) NULLIF | C) NULLIF | CORRECT |
| 19 | Protection | Fail-Safe for transient table | B) 1 day | C) 0 days | WRONG |
| 20 | Protection | Reader Account compute billing | A) Consumer | B) Provider | WRONG |

### Identified Weak Areas

1. **Caching layers** -- Confused metadata cache, result cache, and their locations (Q1, Q9)
2. **Data protection details** -- Fail-Safe periods per table type (Q19), Reader Account billing (Q20)
3. **Performance diagnostics** -- Interpreting query profile spilling (Q10)
4. **LATERAL FLATTEN** -- Purpose and usage (Q17)
5. **Serverless vs cloud services** -- Snowpipe compute model (Q14)
6. **Cloud services billing** -- 10% threshold (Q3)
7. **RBAC nuances** -- USERADMIN vs SYSADMIN privilege scope (Q5)

### Recommended Study Priority

1. Domain 6: Protection & Sharing (0% -- weakest)
2. Domain 1: Architecture (50% -- high exam weight)
3. Domain 3: Performance (50% -- caching concepts)
4. Domain 4: Data Loading (67% -- serverless concepts)
5. Domain 5: Transformations (67% -- FLATTEN)
6. Domain 2: Security (75% -- reinforce)

---

## Quiz History

| Date | Quiz | Score | % | Notes |
|------|------|-------|---|-------|
| 2024-09-10 | Diagnostic Assessment | 11/20 | 55% | Baseline established |
| 2024-09-10 | Domain 1: Architecture | 14/15 | 93% | Only missed XS credit rate (said 4, correct is 1) |
| 2024-09-10 | Domain 2: Security | 12/15 | 80% | Missed: role hierarchy, masking edition, key-pair auth |
| 2024-09-15 | Week 1 Checkpoint | 26/30 | 87% | Scale Up vs Out, stage formats, CALL-only procs, sharing billing |
| 2024-09-22 | Domain 3: Performance | 13/15 | 87% | Missed: clustering depth (said 0, correct 1-2), local disk vs result cache |
| 2024-09-22 | Domain 4: Data Loading | 10/15 | 67% | Snowpipe weak: compute type, ordering, VALIDATION_MODE, triggers |
| 2024-09-22 | Domain 4: RETAKE | 15/15 | 100% | All Snowpipe concepts now solid |
| 2024-09-22 | Domain 5: Transforms | 10/15 | 67% | LAG/LEAD, NULLIF, PIVOT, PARSE_JSON, IFF/DECODE |
| 2024-09-22 | Domain 5: RETAKE | 12/15 | 80% | Fixed all 5 prior misses. New gaps: OBJECT_CONSTRUCT, NVL2, MERGE DELETE |
| 2024-09-22 | Domain 6: Protection | 13/15 | 87% | Up from 0% diagnostic! Missed: cross-region sharing, re-keying edition |
| 2024-09-22 | Week 2 Checkpoint | 26/30 | 87% | PIVOT, PARSE_JSON, NVL2, clustering vs SOS persist as weak spots |
| 2024-09-22 | Full Mock Exam | 93/100 | 93% | PASS. Missed: spill=ScaleUp, share objects, re-key edition, block sampling, serverless task syntax, NVL precision, tag masking |
| **2026-09-30** | **OFFICIAL EXAM** | **823/1000** | **82.3%** | **PASSED -- SnowPro Core Certified!** |

---

## Weekly Checkpoint Scores

| Week | Date | Score | % | Improvement | Weak Areas Remaining |
|------|------|-------|---|-------------|---------------------|
| 0 | 2024-09-10 | 11/20 | 55% | Baseline | All above |
| 1 | 2024-09-15 | 26/30 | 87% | +32% from baseline | Scale Up/Out, CALL-only procs, sharing billing, stage formats |
| 2 | 2024-09-22 | 26/30 | 87% | +0% from W1 | PIVOT direction, PARSE_JSON, NVL2, clustering vs SOS |
| 3 | | | | | |
| 4 | | | | | |

---

## Domain Mastery Tracking

Track your score progression per domain across all quizzes:

### Domain 1: Architecture & Features (25%)
- Diagnostic: 50%
- Quiz 01: **93%** (14/15) -- missed XS warehouse credit rate
- Checkpoint 1: __%

### Domain 2: Account Access & Security (20%)
- Diagnostic: 75%
- Quiz 02: **80%** (12/15) -- missed role hierarchy, masking edition, key-pair auth purpose
- Checkpoint 1: __%

### Domain 3: Performance Concepts (15%)
- Diagnostic: 50%
- Quiz 03: **87%** (13/15) -- missed clustering depth ideal value, local disk cache vs result cache
- Checkpoint 1: __%

### Domain 4: Data Loading & Unloading (10%)
- Diagnostic: 67%
- Quiz 04: **67%** (10/15) then **100%** (15/15 retake) -- Snowpipe concepts fixed
- Checkpoint 1: __%

### Domain 5: Data Transformations (20%)
- Diagnostic: 67%
- Quiz 05: **67%** (10/15) then **80%** (12/15 retake) -- fixed prior gaps, new: OBJECT_CONSTRUCT, NVL2, MERGE DELETE
- Checkpoint 1: __%

### Domain 6: Data Protection & Sharing (10%)
- Diagnostic: 0%
- Quiz 06: **87%** (13/15) -- missed cross-region sharing requires replication, periodic re-keying=Enterprise
- Checkpoint 1: __%

---

## Key Concepts to Review Before Exam

- [ ] Three caching layers and their locations
- [ ] Fail-Safe periods for ALL table types
- [ ] Cloud services 10% billing threshold
- [ ] Warehouse credit scale (XS=1, doubling each size)
- [ ] RBAC role hierarchy and privileges
- [ ] Serverless features list
- [ ] LATERAL FLATTEN syntax and output columns
- [ ] Snowpipe vs COPY INTO compute models
- [ ] Reader Account vs regular sharing
- [ ] Query profile: spilling, pruning, scan metrics
- [ ] Edition-specific features (Standard vs Enterprise vs Business Critical)

---

## FINAL RESULT

**SnowPro Core COF-C03: PASSED (823/1000)**

Score progression: 55% (diagnostic) -> 87% (W1 checkpoint) -> 87% (W2 checkpoint) -> 93% (mock exam) -> **82.3% (official exam)**
