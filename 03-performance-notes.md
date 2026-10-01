# Domain 3: Performance Concepts (15%)

## 3.1 Query Performance Optimization

### Query Profile
- Visual tool in Snowsight showing query execution plan
- Shows operators, data flow, and performance statistics
- Key metrics: **bytes scanned**, **partitions scanned/total**, **bytes spilled**
- **Spilling** to local/remote storage = warehouse may be too small

### Query History
- Available in Snowsight and via QUERY_HISTORY views
- Filter by user, warehouse, status, duration
- Shows execution time breakdown

---

## 3.2 Warehouse Sizing Strategy

| Symptom | Action |
|---|---|
| Queries are slow (single large query) | **Scale Up** -- use larger warehouse |
| Too many concurrent queries queuing | **Scale Out** -- enable multi-cluster |
| Simple queries on small data are slow | Check caching; might be warehouse startup time |
| Queries spilling to disk | **Scale Up** -- more memory/compute needed |

### Key Sizing Facts
- Each size doubling = ~2x the compute power
- A query that takes 1 hour on X-Small might take ~30 min on Small
- Credit cost also doubles per size increase
- Bigger is NOT always better -- match warehouse to workload

---

## 3.3 Caching (Deep Dive)

### Metadata Cache
- Maintained in cloud services layer
- FREE (no warehouse needed)
- Answers: COUNT(*), MIN(col), MAX(col), COUNT(DISTINCT col) on unchanged tables
- Works because Snowflake stores metadata about every micro-partition

### Result Cache
- Exact same query + same role + data unchanged = cached result
- Valid for 24 hours
- FREE (no warehouse credits consumed)
- Resets if underlying data changes
- **Cannot be disabled** (always on)
- Works across warehouses (it's in cloud services)

### Warehouse Local Disk Cache
- SSD cache on compute nodes
- Caches raw data read from storage
- Only available while warehouse is running (lost on suspend)
- Same warehouse must be used

---

## 3.4 Clustering

### Micro-Partition Pruning
- Snowflake stores MIN/MAX values per column per micro-partition
- Filter predicates enable skipping irrelevant partitions
- Natural clustering: data loaded in order often clusters well on load-time columns

### Clustering Keys (Enterprise+)
- Define columns to organize data within micro-partitions
- **Automatic Clustering** maintains the clustering over time (serverless, background)
- Best for: large tables (multi-TB) with known, frequent filter columns
- Costs credits for ongoing maintenance
- `SYSTEM$CLUSTERING_INFORMATION` -- check clustering quality
- `SYSTEM$CLUSTERING_DEPTH` -- check depth (lower is better, 1-2 is ideal)

### When to Use Clustering Keys
- Table is very large (hundreds of GB+)
- Queries frequently filter on specific columns
- Clustering depth is high (data is poorly clustered)
- **Do NOT cluster** small tables or tables that are frequently fully scanned

---

## 3.5 Search Optimization Service (Enterprise+)

- Server-side feature for point-lookup queries (equality, IN, LIKE)
- Works on columns with high cardinality
- Serverless (Snowflake manages compute)
- Costs storage + compute credits
- Best for: selective lookups on columns NOT well-suited for clustering

---

## 3.6 Materialized Views (Enterprise+)

- Precomputed query results stored as a table
- Automatically refreshed when base table changes (serverless background)
- Best for: expensive queries on frequently-read, slowly-changing data
- Limitations:
  - Based on a single table only (can be a regular table OR an external table)
  - Limited SQL support (no joins, UDFs, HAVING, ORDER BY, LIMIT)
  - Cannot be based on other views
  - External table MVs require manual or auto-refresh of file metadata
  - Cost: storage + serverless maintenance credits

---

## 3.7 Query Acceleration Service (Enterprise+)

- Offloads portions of a query to shared compute resources
- **Requires Enterprise edition or higher**
- Best for: queries with large scans that return small results
- Controlled by `ENABLE_QUERY_ACCELERATION` warehouse parameter
- Scale factor controls maximum resources (0-10, default 8; 0 = no limit)

---

## 3.8 Performance Best Practices Summary

1. Right-size warehouses to workloads (dedicated WH per workload type)
2. Enable auto-suspend and auto-resume
3. Use clustering keys on large, frequently filtered tables
4. Leverage result cache (ensure consistent query text)
5. Use materialized views for expensive repeated computations
6. Monitor query profile for spilling and full table scans
7. Separate ETL and reporting warehouses
