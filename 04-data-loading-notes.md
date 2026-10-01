# Domain 4: Data Loading and Unloading (10%)

## 4.1 Bulk Loading with COPY INTO

### Basic Syntax
```sql
COPY INTO my_table
FROM @my_stage/path/
FILE_FORMAT = (TYPE = CSV FIELD_DELIMITER = ',' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';
```

### Key Options

| Option | Values | Default |
|---|---|---|
| **ON_ERROR** | CONTINUE, SKIP_FILE, SKIP_FILE_n, ABORT_STATEMENT | ABORT_STATEMENT |
| **PURGE** | TRUE/FALSE -- delete files after successful load | FALSE |
| **FORCE** | TRUE/FALSE -- reload already-loaded files | FALSE |
| **VALIDATION_MODE** | RETURN_n_ROWS, RETURN_ERRORS, RETURN_ALL_ERRORS | (none) |
| **SIZE_LIMIT** | Max bytes to load (stops after threshold) | (none) |
| **MATCH_BY_COLUMN_NAME** | CASE_SENSITIVE, CASE_INSENSITIVE, NONE | NONE |

### Load Metadata
- Snowflake tracks which files have been loaded (64 days by default)
- Re-running COPY won't reload the same files (unless FORCE=TRUE)
- Use `LOAD_HISTORY` view to see load status

---

## 4.2 File Formats

| Format | Structured? | Notes |
|---|---|---|
| **CSV** | Yes | Most common; configurable delimiters |
| **JSON** | Semi-structured | Loaded into VARIANT column or flatten during load |
| **Parquet** | Semi-structured | Columnar; efficient for analytics |
| **Avro** | Semi-structured | Row-based; schema embedded |
| **ORC** | Semi-structured | Columnar; common in Hadoop |
| **XML** | Semi-structured | Hierarchical |

### Named File Format Objects
```sql
CREATE FILE FORMAT my_csv_format
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null', '');
```

---

## 4.3 Staging Data

### PUT Command (Internal Stages Only)
```sql
PUT file://C:/data/myfile.csv @my_stage AUTO_COMPRESS=TRUE;
```
- Uploads local files to internal stages
- Auto-compresses with gzip by default
- Only from SnowSQL or drivers (NOT Snowsight)

### GET Command (Internal Stages Only)
```sql
GET @my_stage/myfile.csv.gz file://C:/downloads/;
```
- Downloads files from internal stage to local filesystem

---

## 4.4 Snowpipe (Continuous Loading)

### How It Works
1. Files land in a stage (S3, Azure Blob, GCS)
2. Cloud event notification triggers Snowpipe
3. Snowpipe loads data using serverless compute
4. Near real-time latency (typically within minutes)

### Key Facts
- **Serverless** -- no virtual warehouse required
- Uses a PIPE object with a COPY INTO definition
- Cost: per-file compute charge (cheaper than warehouse for small frequent loads)
- Cannot use VALIDATION_MODE
- Files are loaded in **best-effort order** (not guaranteed order)
- Use `SYSTEM$PIPE_STATUS` to check pipe health

### REST API Alternative
- Call Snowpipe REST API `insertFiles` endpoint to trigger loading
- No cloud notifications needed (polling-based)

---

## 4.5 Data Transformation During Load

### COPY INTO with SELECT
```sql
COPY INTO my_table (col1, col2, col3)
FROM (
  SELECT $1, $2, TO_DATE($3, 'YYYY-MM-DD')
  FROM @my_stage/data.csv
)
FILE_FORMAT = (TYPE = CSV);
```

- Can select specific columns, reorder, cast, transform
- Column references: `$1, $2, $3...` for CSV (positional)
- For semi-structured: `$1:field_name` for JSON/Parquet

---

## 4.6 Data Unloading

### COPY INTO <location>
```sql
COPY INTO @my_stage/export/
FROM my_table
FILE_FORMAT = (TYPE = CSV COMPRESSION = GZIP)
HEADER = TRUE
OVERWRITE = TRUE
MAX_FILE_SIZE = 100000000;
```

### Key Unloading Options
- **SINGLE** = TRUE/FALSE -- output as single file or multiple
- **MAX_FILE_SIZE** -- max size per output file (default 16 MB)
- **HEADER** -- include column headers (CSV)
- **OVERWRITE** -- replace existing files
- **PARTITION BY** -- partition output files by expression

---

## 4.7 Data Loading Best Practices

1. **File sizing**: Aim for 100-250 MB compressed files
2. **Number of files**: Match to number of warehouse nodes for parallel loading
3. Use **dedicated loading warehouse** separate from query warehouse
4. Enable **PURGE=TRUE** for automated cleanup in production
5. Use **Snowpipe** for continuous, real-time-ish ingestion
6. Use **VALIDATION_MODE** to preview errors before full load
7. Prefer semi-structured native types (VARIANT) for JSON/Parquet
