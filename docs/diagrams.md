# ETL Planning Diagrams (Mermaid)

High-level system architecture.
<!-- ALT: high-level architecture -->
```mermaid
flowchart TD
    CRM["CRM Export"] --> Blob["Blob Storage (raw)\ndata/raw/"]
    Excel["Excel Files"] --> Blob
    Blob --> ADF["ADF Orchestration"]
    ADF --> MDF["Mapping Data Flow"]
    MDF --> StgDB["Staging DB"]
    StgDB --> Val["Validation"]
    Val --> ClnDB["Clean DB"]
    ClnDB --> PBI["Power BI"]
    KV["Azure Key Vault"] --- ADF
    ADF --- LA["Log Analytics"]

    subgraph Legend
        R1["Role 1 - Extraction: Amin,Ali"]
        R2["Role 2 - ETL: Ali"]
        R3["Role 3 - Modeling & BI: Mennatullah, Amin"]
        R4["Role 4 - Quality & Testing: Aseel,Habiba"]
        R5["Role 5 - Documentation: Ali, Amin, Mennat Allah, Aseel, Habiba"]
        R1 -.-> CRM & Excel & Blob
        R2 -.-> ADF & MDF & KV
        R3 -.-> ClnDB & PBI
        R4 -.-> StgDB & Val
        R5 -.-> LA
    end
```
Notes: Edit storage paths.

Role-linked pipeline flow with pipeline ownership.
<!-- ALT: role-linked pipeline flow -->
```mermaid
flowchart LR
    pl1["pl_ingest_crm\n(Role 1 - Extraction: Amin,Ali)"]
    pl2["pl_ingest_excel\n(Role 1 - Extraction: Amin,Ali)"]
    pl3["pl_transform_merge_publish\n(Role 2 - ETL: Ali)"]
    pl1 --> pl3
    pl2 --> pl3
    pl3 --> ctrl["control.pipeline_runs\nStaging DB"]

    subgraph Legend
        R1["Role 1 - Extraction: Amin,Ali"]
        R2["Role 2 - ETL: Ali"]
        R1 -.-> pl1 & pl2
        R2 -.-> pl3
    end
```
Notes: Set pipeline names.

In-depth transformation steps inside Mapping Data Flow.
<!-- ALT: mapping data flow steps -->
```mermaid
flowchart TD
    node1["normalize_email\n(lowercase, trim)"] --> node2["normalize_phone\n(digits only)"]
    node2 --> node3["normalize_name\n(unicode normalize)"]
    node3 --> node4["filter_invalid"]
    node4 --> node5["survivorship_rule\n(source precedence)"]
    node5 --> node6["dedupe"]
    node6 --> node7["generate_surrogate_key"]
    node7 --> node8["write_staging"]

    subgraph Legend
        R2["Role 2 - ETL: Ali"]
        R2 -.-> node1 & node2 & node3 & node4 & node5 & node6 & node7 & node8
    end
```
Notes: Edit normalization rules.

Final clean schema ERD, SCD2 indicated.
<!-- ALT: final clean schema ERD -->
```mermaid
classDiagram
    class customer_dim {
        +INT customer_id [PK]
        +VARCHAR full_name
        +VARCHAR email [UQ]
        +VARCHAR phone
        +DATETIME effective_from
        +DATETIME effective_to
        +BIT is_current
    }
    class customer_source_map {
        +INT mapping_id
        +INT customer_id
        +VARCHAR source_name
        +VARCHAR source_id
    }
    class customer_audit {
        +INT audit_id
        +VARCHAR action
        +DATETIME ts
        +VARCHAR details
    }
    customer_dim "1" -- "*" customer_source_map : has
    customer_dim "1" -- "*" customer_audit : logged

    class Legend {
        Role 3 - Modeling & BI: Mennatullah, Amin
    }
```
Notes: Set data types as needed.

Sequence of activities for one pipeline run with owners.
<!-- ALT: pipeline sequence diagram -->
```mermaid
sequenceDiagram
    participant Uploader
    participant ADF
    participant MDF as Mapping Data Flow
    participant StgDB as Staging DB
    participant Val as Validation SP
    participant ClnDB as Clean DB
    participant Monitor

    Uploader->>ADF: upload file -> trigger pipeline (Role 1 - Extraction: Amin,Ali)
    ADF->>ADF: ADF start pl_ingest -> copy to Blob Storage (Role 2 - ETL: Ali)
    ADF->>MDF: ADF invoke pl_transform
    MDF->>MDF: Mapping Data Flow runs steps
    MDF->>StgDB: write staging (Role 2 - ETL: Ali)
    StgDB->>Val: Validation SP runs (Role 4 - Quality & Testing: Aseel,Habiba)
    Val->>ClnDB: MERGE into Clean DB -> Publish (Role 3 - Modeling & BI: Mennatullah, Amin)
    ADF->>Monitor: Monitor logs metrics to Log Analytics (Role 5 - Documentation: Ali, Amin, Mennat Allah, Aseel, Habiba)

    Note over Uploader,Monitor: Legend:<br/>Uploader = Role 1 - Extraction: Amin,Ali<br/>ADF, Mapping Data Flow = Role 2 - ETL: Ali<br/>Staging DB, Validation SP = Role 4 - Quality & Testing: Aseel,Habiba<br/>Clean DB = Role 3 - Modeling & BI: Mennatullah, Amin<br/>Monitor = Role 5 - Documentation: Ali, Amin, Mennat Allah, Aseel, Habiba
```
Notes: Edit actor names.

Monitoring and alerting responsibilities and escalation.
<!-- ALT: monitoring and alerting flow -->
```mermaid
flowchart LR
    ADF["ADF Orchestration"] --> LA["Log Analytics"]
    LA --> AR["Alert Rules"]
    AR --> pf["pipeline_failure"]
    AR --> her["high_error_rate"]
    AR --> mf["missing_file"]

    pf --> r2["Role 2 - ETL: Ali"]
    pf --> r4["Role 4 - Quality & Testing: Aseel,Habiba"]
    her --> r4
    mf --> r1["Role 1 - Extraction: Amin,Ali"]

    subgraph Legend
        Crit["Critical: pipeline_failure"]
        Warn["Warning: high_error_rate"]
        Info["Info: missing_file"]
    end
```
Notes: Set alert recipients.

CI/CD pipeline for ADF and SQL artifacts.
<!-- ALT: CI/CD and deployment flow -->
```mermaid
flowchart LR
    dev["dev branch"] --> export["export ARM templates"]
    export --> cicd["CI/CD pipeline"]
    cicd --> testenv["test environment"]
    testenv --> prodenv["prod environment"]

    subgraph Approvals
        app1["deployment approvals by Role 2"]
        app2["deployment approvals by Role 3"]
        testenv -.-> app1
        testenv -.-> app2
        app1 & app2 -.-> prodenv
    end

    subgraph Notes
        KV["Placeholder replacement with Key Vault references for secrets"]
    end
    cicd -.-> KV

    subgraph Legend
        R5["Role 5 - Documentation: Ali, Amin, Mennat Allah, Aseel, Habiba"]
        R2["Role 2 - ETL: Ali"]
        R5 -.->|docs| cicd
        R2 -.->|deployments| cicd
    end
```
Notes: Replace placeholders with Key Vault secrets.

4-week project timeline starting 2026-04-01.
<!-- ALT: project timeline gantt -->
```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title 4-week project timeline starting 2026-04-01
    
    section Week 1
    MVP pipeline (Role 1, Role 2) - Amin,Ali; Ali :a1, 2026-04-01, 7d
    
    section Week 2-3
    Full load & automation (Role 2, Role 3, Role 4) - Ali; Mennatullah, Amin; Aseel,Habiba :a2, after a1, 14d
    
    section Week 4
    Validation & presentation (Role 4, Role 5) - Aseel,Habiba; Ali, Amin, Mennat Allah, Aseel, Habiba :a3, after a2, 7d
```
Notes: Edit start date.

Deliverables checklist with owners.
<!-- ALT: deliverables checklist -->
```mermaid
flowchart TD
    D1["docs/project_flow.md\n(Ali, Amin, Mennat Allah, Aseel, Habiba)"]
    D2["docs/architecture.md\n(Ali, Amin, Mennat Allah, Aseel, Habiba)"]
    D3["adf/pipelines/pl_transform_merge_publish.json\n(Ali)"]
    D4["sql/scripts/customer_schema.sql\n(Mennatullah, Amin)"]
    D5["data/raw/sample_crm.csv\n(Amin,Ali)"]
    D6["data/raw/sample_excel.xlsx\n(Amin,Ali)"]
    D7["data/clean/customers.csv\n(Amin,Ali)"]
    D8["presentation/final.pdf\n(Ali, Amin, Mennat Allah, Aseel, Habiba)"]

    subgraph Legend
        R1["Role 1 - Extraction: Amin,Ali"]
        R2["Role 2 - ETL: Ali"]
        R3["Role 3 - Modeling & BI: Mennatullah, Amin"]
        R4["Role 4 - Quality & Testing: Aseel,Habiba"]
        R5["Role 5 - Documentation: Ali, Amin, Mennat Allah, Aseel, Habiba"]
        
        R1 -.-> D5 & D6 & D7
        R2 -.-> D3
        R3 -.-> D4
        R5 -.-> D1 & D2 & D8
    end
```
Notes: Update file names if changed.
