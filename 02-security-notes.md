# Domain 2: Account Access and Security (20%)

## 2.1 Authentication Methods

| Method | Description |
|---|---|
| **Username/Password** | Default, basic authentication |
| **MFA** | Multi-factor via Duo Mobile; can be enforced per user |
| **SSO (SAML 2.0)** | Federated via Okta, Azure AD, ADFS, etc. |
| **Key-Pair Authentication** | RSA 2048-bit; for service accounts and programmatic access |
| **OAuth** | External OAuth or Snowflake OAuth for clients |

**Key exam point**: MFA is powered by Duo Security (built into Snowflake). Users must self-enroll or be enrolled by admin.

---

## 2.2 Role-Based Access Control (RBAC)

### System-Defined Roles (Hierarchy)

```
ACCOUNTADMIN
├── SYSADMIN
│   └── (all custom roles should be granted to SYSADMIN)
├── SECURITYADMIN
│   └── USERADMIN
└── PUBLIC (granted to every user automatically)
```

### Role Descriptions

| Role | Purpose |
|---|---|
| **ACCOUNTADMIN** | Top-level role. Combines SYSADMIN + SECURITYADMIN. Use sparingly. |
| **SYSADMIN** | Create/manage databases, schemas, warehouses, and all objects |
| **SECURITYADMIN** | Manage grants, create/manage roles. Has MANAGE GRANTS privilege. |
| **USERADMIN** | Create/manage users and roles (but not grant privileges on objects) |
| **PUBLIC** | Automatically granted to all users. Minimal privileges. |
| **ORGADMIN** | Manage accounts within a Snowflake organization |

### Best Practices
- Custom roles should be granted to SYSADMIN (so SYSADMIN can manage their objects)
- ACCOUNTADMIN should NOT be default role for any user
- Use ACCOUNTADMIN only when necessary
- Grant least privilege needed

---

## 2.3 Privileges

### Object Privilege Hierarchy
```
ACCOUNT → DATABASE → SCHEMA → Objects (TABLE, VIEW, STAGE, etc.)
```

### Key Privileges
- **USAGE** -- required on database/schema before accessing any object inside
- **SELECT** -- read data from table/view
- **INSERT/UPDATE/DELETE** -- modify data
- **CREATE <object>** -- create new objects in schema
- **OWNERSHIP** -- full control, can grant privileges to others
- **OPERATE** -- start/stop/resume warehouses
- **MONITOR** -- view usage/history on warehouses

### Future Grants
- Pre-grant privileges on objects that will be created in the future
- `GRANT SELECT ON FUTURE TABLES IN SCHEMA mydb.myschema TO ROLE analyst;`

---

## 2.4 Network Policies

- Restrict access by IP address (allow/deny lists)
- Can be applied at **account level** or **user level**
- User-level policies override account-level policies
- Use CIDR notation (e.g., 192.168.1.0/24)
- Only SECURITYADMIN or ACCOUNTADMIN can create network policies

---

## 2.5 Encryption

- **Always-on encryption** -- all data encrypted at rest and in transit
- AES-256 encryption for data at rest
- TLS 1.2 for data in transit
- **Automatic key rotation** every 30 days (Snowflake-managed keys)
- **Tri-Secret Secure** (Business Critical+): customer-managed key + Snowflake key = composite key
- **Periodic re-keying** (Enterprise+): re-encrypts data with new keys annually

---

## 2.6 Column-Level Security

### Dynamic Data Masking (Enterprise+)
- Apply masking policies to columns
- Different users see masked/unmasked data based on role
- Policy is a SQL function that returns masked or real value
- Can be applied to multiple columns across tables

### External Tokenization (Enterprise+)
- Replace sensitive data with tokens using external tokenization service

---

## 2.7 Row Access Policies (Enterprise+)
- Control which rows users can see
- Policy returns a boolean filter condition
- Applied to a table; evaluated at query time
- Can use mapping tables for complex access rules

---

## 2.8 Object Tagging
- Apply tags to objects for governance and classification
- Tag-based masking: attach masking policies to tags
- When a tagged column is queried, the masking policy fires automatically

---

## 2.9 Access History
- `SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY` view
- Records who accessed what data and when
- Includes direct and indirect access (through views, etc.)
- Retained for 365 days
