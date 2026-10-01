# Quiz: Domain 2 -- Security & Access Control (15 Questions)

---

**Q1.** Which system-defined role should be the parent of ALL custom roles?

A) ACCOUNTADMIN  
B) SYSADMIN  
C) SECURITYADMIN  
D) PUBLIC  

---

**Q2.** Which role has the MANAGE GRANTS global privilege?

A) ACCOUNTADMIN  
B) SYSADMIN  
C) SECURITYADMIN  
D) USERADMIN  

---

**Q3.** A user needs to create a resource monitor. Which role must they use?

A) SYSADMIN  
B) SECURITYADMIN  
C) ACCOUNTADMIN  
D) Any role with CREATE RESOURCE MONITOR privilege  

---

**Q4.** Which authentication mechanism does Snowflake use for MFA?

A) Google Authenticator  
B) Duo Security  
C) Microsoft Authenticator  
D) Custom TOTP  

---

**Q5.** What happens when both an account-level and user-level network policy exist for the same user?

A) Both policies are applied (AND logic)  
B) The account-level policy takes precedence  
C) The user-level policy takes precedence  
D) An error is thrown  

---

**Q6.** Which Snowflake edition supports dynamic data masking?

A) Standard  
B) Enterprise  
C) Business Critical only  
D) All editions  

---

**Q7.** What is the purpose of a row access policy?

A) Mask column values based on the user's role  
B) Filter which rows a user can see based on policy conditions  
C) Encrypt specific rows in a table  
D) Grant row-level INSERT privileges  

---

**Q8.** Which grant ensures that all FUTURE tables in a schema automatically get SELECT granted to a role?

A) `GRANT SELECT ON ALL TABLES IN SCHEMA TO ROLE r;`  
B) `GRANT SELECT ON FUTURE TABLES IN SCHEMA TO ROLE r;`  
C) `GRANT SELECT ON TABLES IN SCHEMA TO ROLE r;`  
D) `GRANT AUTO SELECT ON SCHEMA TO ROLE r;`  

---

**Q9.** What encryption standard does Snowflake use for data at rest?

A) AES-128  
B) AES-192  
C) AES-256  
D) RSA-2048  

---

**Q10.** Tri-Secret Secure is available starting from which edition?

A) Standard  
B) Enterprise  
C) Business Critical  
D) Virtual Private Snowflake only  

---

**Q11.** Which role is automatically granted to EVERY user in Snowflake?

A) USERADMIN  
B) SYSADMIN  
C) ACCOUNTADMIN  
D) PUBLIC  

---

**Q12.** A user needs to grant USAGE on a database to another role. Which privilege on the database must they already have?

A) SELECT  
B) OWNERSHIP  
C) CREATE  
D) MONITOR  

---

**Q13.** What is the key-pair authentication in Snowflake used for?

A) Encrypting data at rest  
B) MFA enrollment  
C) Programmatic/service account access without password  
D) SSO federation  

---

**Q14.** How long is access history data retained in ACCOUNT_USAGE.ACCESS_HISTORY?

A) 14 days  
B) 90 days  
C) 365 days  
D) Indefinitely  

---

**Q15.** Which of these CANNOT be done by USERADMIN?

A) Create a new user  
B) Create a new custom role  
C) Grant SELECT on a table to a role  
D) Drop a user  

---

## Answer Key

| Q | Answer | Explanation |
|---|--------|-------------|
| 1 | **B** | Best practice: all custom roles should be granted to SYSADMIN |
| 2 | **C** | SECURITYADMIN has MANAGE GRANTS, allowing it to manage all grants |
| 3 | **C** | Only ACCOUNTADMIN can create resource monitors |
| 4 | **B** | Snowflake MFA is powered by Duo Security |
| 5 | **C** | User-level network policy overrides account-level |
| 6 | **B** | Dynamic data masking requires Enterprise edition |
| 7 | **B** | Row access policies filter rows visible to users |
| 8 | **B** | FUTURE grants apply to objects not yet created |
| 9 | **C** | Snowflake uses AES-256 encryption at rest |
| 10 | **C** | Tri-Secret Secure requires Business Critical edition |
| 11 | **D** | PUBLIC is automatically granted to all users |
| 12 | **B** | Need OWNERSHIP (or a role with MANAGE GRANTS) to grant on an object |
| 13 | **C** | Key-pair auth enables passwordless programmatic access |
| 14 | **C** | Access history is retained for 365 days |
| 15 | **C** | USERADMIN manages users/roles but cannot grant object privileges |
