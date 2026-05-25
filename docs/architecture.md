# Pipeline Architecture

## Overview

The Digital Burnout ETL Pipeline is a fully automated data engineering workflow designed to process millions of records and deliver analytical insights through a Tableau dashboard.

---

## Components

### 1. Data Source
- **File:** `burnout_data.csv`
- **Records:** ~5,000,000 rows
- **Columns:** user_id, age, occupation, work_mode, device_usage_type, daily_screen_time, social_media_hours, doomscrolling_hours, sleep_hours, motivation_level, burnout_risk, productivity_score, mental_health_status, ...

### 2. ETL Script (`digital_burnout_etl_pipeline.py`)

| Stage | Function | Description |
|-------|----------|-------------|
| Extract | `load_data()` | Reads raw CSV with Pandas |
| EDA | `quick_eda()` | Prints shape, nulls, duplicate count |
| Transform | `clean_columns()` | Normalizes column names |
| Transform | `fill_nulls()` | Median imputation for numeric cols |
| Engineer | `feature_engineering()` | Creates `burnout_category` and `screen_time_category` |
| Load | `save_data()` | Writes cleaned CSV and loads to SQLite |

### 3. Database
- **Engine:** SQLite
- **File:** `burnout_pipeline.db`
- **Table:** `cleaned_burnout_data`
- **Size:** ~876 MB (5M records)

### 4. Scheduler
- **Tool:** Linux Cron
- **Schedule:** Daily at 02:00 AM
- **Command:** `0 2 * * * cd /path/scripts && /usr/bin/python3 digital_burnout_etl_pipeline.py >> ~/etl.log 2>&1`
- **Log:** `etl.log` captures stdout and stderr for monitoring

### 5. Dashboard
- **Tool:** Tableau Public
- **File:** `digital_burnout_dashboard.twb`
- **Views:** 4 charts (Productivity by Work Mode, Burnout by Occupation, Mental State Distribution, Burnout by Screen Time)

---

## Data Flow Diagram

```
[Raw CSV]
    │
    ▼
[load_data()]          ← pandas.read_csv()
    │
    ▼
[quick_eda()]          ← prints nulls, shape, duplicates
    │
    ▼
[clean_columns()]      ← lowercase + underscore column names
    │
    ▼
[fill_nulls()]         ← median imputation on 4 numeric cols
    │
    ▼
[feature_engineering()]← adds burnout_category, screen_time_category
    │
    ▼
[save_data()]          ← writes cleaned CSV
    │
    ▼
[SQLite DB]            ← burnout_pipeline.db / cleaned_burnout_data
    │
    ▼
[Cron Job]             ← automates daily execution
    │
    ▼
[Tableau Dashboard]    ← connects to DB for visual analytics
```

---

## Feature Engineering Logic

### `burnout_category`
| Score Range | Category |
|-------------|----------|
| < 35 | Low |
| 35 – 59 | Moderate |
| ≥ 60 | High |

### `screen_time_category`
| Hours/Day | Category |
|-----------|----------|
| < 5 | Low Usage |
| 5 – 8.9 | Medium Usage |
| ≥ 9 | Heavy Usage |
