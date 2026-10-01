# Domain 1: Snowflake AI Data Cloud Features & Architecture (25%)

## 1.1 Cloud Architecture (Three-Layer Model)

### Storage Layer
- **Columnar storage** -- data stored in micro-partitions (50-500 MB compressed)
- Snowflake manages all storage; users cannot access underlying files directly
- Data is automatically compressed (no user action needed)
- Storage is billed separately from compute
- Data is stored in cloud provider's blob storage (S3, Azure Blob, GCS)

### Compute Layer (Query Processing)
- **Virtual Warehouses** execute queries
- Warehouses are independent MPP clusters
- Warehouses can be started/stopped/resized without affecting other warehouses
- Scaling: **Scale Up** (bigger size) for complex queries, **Scale Out** (multi-cluster) for concurrency
- Warehouse sizes: X-Small, Small, Medium, Large, X-Large, 2XL, 3XL, 4XL, 5XL, 6XL

### Cloud Services Layer
- Authentication and access control
- Infrastructure management
- Metadata management
- Query parsing and optimization
- **Billed only if usage exceeds 10% of total compute credit usage**

---

## 1.2 Snowflake Editions

| Feature | Standard | Enterprise | Business Critical | VPS |
|---|---|---|---|---|
| Time Travel | 1 day | 90 days | 90 days | 90 days |
| Multi-cluster warehouses | No | Yes | Yes | Yes |
| Materialized views | No | Yes | Yes | Yes |
| Column-level security | No | Yes | Yes | Yes |
| Search optimization | No | Yes | Yes | Yes |
| Failover/Failback | No | No | Yes | Yes |
| Tri-Secret Secure | No | No | Yes | Yes |
| HIPAA/PCI DSS | No | No | Yes | Yes |
| Customer-managed keys | No | No | Yes | Yes |
| Dedicated VPS | No | No | No | Yes |

---

## 1.3 Micro-Partitions

- Contiguous units of storage (50-500 MB compressed)
- Organized in a **columnar** format within each partition
- Snowflake automatically creates and maintains micro-partitions
- **Pruning**: Snowflake skips irrelevant partitions using min/max metadata
- You CANNOT manually control partitioning (Snowflake manages it)
- **Clustering keys** influence how data is organized within partitions

---

## 1.4 Data Types

### Structured
- NUMBER, INT, FLOAT, DECIMAL
- VARCHAR, CHAR, STRING, TEXT
- BOOLEAN
- DATE, TIME, TIMESTAMP (TIMESTAMP_LTZ, TIMESTAMP_NTZ, TIMESTAMP_TZ)
- BINARY, VARBINARY

### Semi-Structured
- **VARIANT** -- can store any JSON, Avro, ORC, Parquet, or XML value (up to 16 MB)
- **OBJECT** -- key-value pairs (like JSON object)
- **ARRAY** -- ordered list of values

---

## 1.5 Table Types

| Type | Time Travel | Fail-Safe | Persists After Session | CDL Cost |
|------|------------|-----------|----------------------|----------|
| **Permanent** | 0-90 days (Enterprise+) | 7 days | Yes | Full |
| **Transient** | 0-1 day | 0 days | Yes | Reduced |
| **Temporary** | 0-1 day | 0 days | No (session only) | Minimal |
| **External** | No | No | N/A (data external) | None |

---

## 1.6 Views

| Type | Definition Visible? | Uses Warehouse Credits? | Can Improve Performance? |
|------|-------------------|----------------------|------------------------|
| **Standard View** | Yes (via SHOW/GET_DDL) | Yes (runs query each time) | No |
| **Secure View** | No (hidden from consumers) | Yes | No |
| **Materialized View** | Yes | Yes (for refresh) | Yes (precomputed) |

---

## 1.7 Virtual Warehouses

### Key Concepts
- Each size doubling approximately doubles credits/hour and compute power
- X-Small = 1 credit/hour, Small = 2, Medium = 4, Large = 8...
- **Auto-suspend**: shuts down after period of inactivity (default 10 min, minimum 1 min for non-serverless)
- **Auto-resume**: starts when a query is submitted
- Credit billing is per-second (60-second minimum)

### Multi-Cluster Warehouses (Enterprise+)
- **Scaling Policy: Standard** (default) -- adds clusters aggressively, favors performance over cost (minimizes queuing)
- **Scaling Policy: Economy** -- adds clusters only when queuing is significant (~6 min estimated), favors cost over performance
- Min/Max cluster count controls

### Warehouse Types
- **Standard** -- general-purpose
- **Snowpark-Optimized** -- for memory-intensive operations (ML, large data processing)

---

## 1.8 Resource Monitors

- Track credit usage by warehouse or account
- Actions at thresholds: **Notify**, **Notify & Suspend**, **Notify & Suspend Immediately**
- Can be set at account or warehouse level
- Only ACCOUNTADMIN can create resource monitors

---

## 1.9 Caching

| Cache Type | Location | Duration | Reuse Condition |
|---|---|---|---|
| **Metadata Cache** | Cloud Services | Persistent | COUNT, MIN, MAX on same table |
| **Result Cache** | Cloud Services | 24 hours | Same query, same role, no underlying data change |
| **Local Disk Cache (Warehouse)** | Compute Nodes | While WH running | Same warehouse runs query touching same data |

**Key exam point**: Result cache does NOT consume warehouse credits. It is served from cloud services layer.

---

## 1.10 Stages

| Stage Type | Scope | Location |
|---|---|---|
| **User Stage** (`@~`) | Per user | Internal (Snowflake-managed) |
| **Table Stage** (`@%table_name`) | Per table | Internal (Snowflake-managed) |
| **Named Internal Stage** (`@stage_name`) | Explicit object | Internal (Snowflake-managed) |
| **Named External Stage** (`@stage_name`) | Explicit object | S3, Azure Blob, GCS |

---

## 1.11 Snowflake Features

### Streams (Change Data Capture)
- Track DML changes (INSERT, UPDATE, DELETE) on a table
- Types: **Standard**, **Append-only**, **Insert-only** (for external tables)
- Creates a "change table" that records before/after row states

### Tasks
- Schedule SQL execution (standalone or in DAGs)
- Can use cron or interval schedules
- Triggered by streams (WHEN SYSTEM$STREAM_HAS_DATA)
- Can use serverless compute (no warehouse needed)

### Snowpipe
- Continuous, serverless data loading
- Triggered by cloud event notifications (S3 SQS, Azure Event Grid, GCS Pub/Sub)
- Uses serverless compute (no virtual warehouse)
- Near real-time loading (within minutes)

### Stored Procedures
- Written in JavaScript, SQL, Python, Java, Scala
- Can run as **caller's rights** or **owner's rights**

### UDFs (User-Defined Functions)
- Written in SQL, JavaScript, Python, Java, Scala
- Can be scalar or tabular (UDTFs)
- Cannot perform DML (unlike stored procedures)
