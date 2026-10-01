# Domain 6: Data Protection and Data Sharing (10%)

## 6.1 Time Travel

### Overview
- Access historical data at any point within the retention period
- Available for tables, schemas, and databases

### Retention Periods
| Object Type | Standard Edition | Enterprise+ |
|---|---|---|
| Permanent table | 0-1 day | 0-90 days |
| Transient table | 0-1 day | 0-1 day |
| Temporary table | 0-1 day | 0-1 day |

### Time Travel Queries
```sql
-- By timestamp
SELECT * FROM my_table AT(TIMESTAMP => '2024-01-15 10:00:00'::TIMESTAMP);

-- By offset (seconds)
SELECT * FROM my_table AT(OFFSET => -60*5);  -- 5 minutes ago

-- By query ID
SELECT * FROM my_table BEFORE(STATEMENT => '<query_id>');
```

### UNDROP
```sql
UNDROP TABLE my_table;
UNDROP SCHEMA my_schema;
UNDROP DATABASE my_database;
```
- Restores the most recently dropped object with that name
- Only works within the Time Travel retention period

---

## 6.2 Fail-Safe

| Aspect | Detail |
|---|---|
| **Duration** | 7 days (starts after Time Travel expires) |
| **Access** | Snowflake support ONLY (not user-accessible) |
| **Object types** | Permanent tables only |
| **Cost** | Storage cost for the data during Fail-Safe period |
| **Configurable?** | No -- always 7 days, cannot be changed |

**Transient and temporary tables have NO Fail-Safe period.**

### Total Data Protection Timeline (Permanent Table, Enterprise+)
```
[Current Data] → [Time Travel: up to 90 days] → [Fail-Safe: 7 days]
Max total: 97 days of recovery window
```

---

## 6.3 Data Sharing

### Secure Data Sharing (Provider → Consumer)
- **Zero-copy** -- no data movement or copying
- Provider creates a **SHARE** object and grants access to databases/schemas/tables/views
- Consumer creates a database FROM the share
- Real-time -- consumer always sees current data
- **Cross-region/cross-cloud**: requires replication

### Share Objects
```sql
-- Provider side
CREATE SHARE my_share;
GRANT USAGE ON DATABASE mydb TO SHARE my_share;
GRANT USAGE ON SCHEMA mydb.public TO SHARE my_share;
GRANT SELECT ON TABLE mydb.public.my_table TO SHARE my_share;
ALTER SHARE my_share ADD ACCOUNTS = consumer_account;

-- Consumer side
CREATE DATABASE shared_db FROM SHARE provider_account.my_share;
```

### Secure Views for Sharing
- Use **secure views** to share controlled subsets of data
- Definition is hidden from consumers
- Prevents consumers from deducing underlying data through query profiling

### What Can Be Shared?
- Tables (permanent, dynamic, external, Iceberg -- not transient/temporary)
- Views (regular views, secure views, secure materialized views, semantic views)
- UDFs (both secure and non-secure)
- Cortex Search services
- Models (USER_MODEL, CORTEX_FINETUNED, DOC_AI)

**Note:** Snowflake strongly recommends sharing **secure** views and secure UDFs
to prevent exposing sensitive data or view definitions to consumers.
Regular views CAN be shared but their definition is visible to consumers.

### What CANNOT Be Shared?
- Transient/temporary tables
- Stages, pipes, streams, tasks
- Stored procedures

---

## 6.4 Reader Accounts

- Created by the provider for consumers who do NOT have a Snowflake account
- Provider creates and manages the reader account
- **Provider pays for compute** used by the reader account
- Reader accounts have limited functionality (read-only access to shared data)
- Reader accounts cannot create shares themselves

```sql
CREATE MANAGED ACCOUNT reader_acct
  ADMIN_NAME = 'admin'
  ADMIN_PASSWORD = 'P@ssword!'
  TYPE = READER;
```

---

## 6.5 Data Replication

### Database Replication
- Replicate databases across regions and cloud providers
- Uses **primary** and **secondary** database model
- Secondary databases are read-only replicas
- Refresh is manual or scheduled

### Account Replication (Business Critical+)
- Replicate account-level objects (users, roles, warehouses, resource monitors)
- Enables **Failover** and **Failback** for disaster recovery
- **Failover**: promote secondary to primary
- **Failback**: return to original primary after incident resolved

---

## 6.6 Data Encryption

### At Rest
- AES-256 bit encryption (always on)
- Snowflake manages keys by default
- **Periodic re-keying** (Enterprise+): automatic annual re-encryption
- **Tri-Secret Secure** (Business Critical+): composite key from Snowflake + customer

### In Transit
- TLS 1.2 (always on)
- All client connections are encrypted

---

## 6.7 Data Classification

- Automatic or manual classification of columns
- Identifies sensitive data (PII, PHI, financial)
- Tags columns with system tags:
  - `SNOWFLAKE.CORE.SEMANTIC_CATEGORY` -- what kind of data
  - `SNOWFLAKE.CORE.PRIVACY_CATEGORY` -- sensitivity level
- Integrates with masking policies

---

## 6.8 Cloning (Zero-Copy Clone)

```sql
CREATE TABLE clone_table CLONE source_table;
CREATE SCHEMA clone_schema CLONE source_schema;
CREATE DATABASE clone_db CLONE source_db;
```

### Key Facts
- **Zero-copy**: no data is physically copied initially
- Clone is independent -- changes to clone don't affect source (and vice versa)
- Only new/modified micro-partitions consume additional storage
- Cloning is instant regardless of data size
- **Database/schema clones**: child object grants are preserved automatically
- **Individual table clones**: use `COPY GRANTS` to preserve grants
  - `CREATE TABLE clone_t CLONE source_t COPY GRANTS;`
- Cloning a database clones all child objects

### Time Travel Cloning
```sql
CREATE TABLE restored CLONE my_table AT(TIMESTAMP => '2024-01-15 10:00:00');
```
- Create a clone from a historical point in time
