# 🔥 Digital Burnout & Productivity Analytics Pipeline

An end-to-end data engineering pipeline that processes **5 million records** of employee productivity and digital wellness data — automating the full ETL workflow and delivering insights through an interactive Tableau dashboard.

---

## 📌 Problem Statement

Organizations generate large volumes of employee productivity and digital wellness data. Raw datasets often contain missing values, inconsistent records, and require transformation before meaningful insights can be generated.

This project automates the full ETL process and surfaces actionable insights through an interactive dashboard.

---

## 🏗️ Architecture

```
Raw Dataset (burnout_data.csv)
        ↓
Python ETL Pipeline
        ↓
Data Cleaning & Transformation
        ↓
Feature Engineering
        ↓
SQLite Database (5M records)
        ↓
Automated Scheduling (Cron — daily 2 AM)
        ↓
Tableau Dashboard
```

---

## 📂 Project Structure

```
digital-burnout-pipeline/
├── data/
│   ├── raw/                  # Raw input CSV (burnout_data.csv)
│   └── processed/            # Cleaned output CSV
├── scripts/
│   └── digital_burnout_etl_pipeline.py   # Main ETL script
├── sql/                      # SQL queries for analysis
├── dashboard/                # Tableau workbook (.twb)
├── docs/                     # Screenshots & documentation
├── burnout_pipeline.sqbpro   # DB Browser project file
├── requirements.txt
└── README.md
```

---

## 📊 Dataset

| Property | Detail |
|---|---|
| Size | ~5,000,000 records |
| Format | CSV |
| Features | Age, Occupation, Work Mode, Device Usage Type, Daily Screen Time, Social Media Hours, Doomscrolling Time, Sleep Hours, Deep Work Hours, Motivation Level, Productivity Score, Burnout Risk, Mental State |

---

## ⚙️ ETL Pipeline

### Extract
- Loads raw `burnout_data.csv` using Python and Pandas

### Transform
- Standardizes column names (lowercase + underscores)
- Identifies and fills missing values using **median imputation** for:
  - `social_media_hours`
  - `deep_work_hours`
  - `sleep_hours`
  - `motivation_level`
- Removes duplicate records
- Engineers new features:
  - `burnout_category` — Low / Moderate / High (based on burnout_risk score)
  - `screen_time_category` — Low / Medium / Heavy Usage (based on daily_screen_time)

### Load
- Saves cleaned data to `cleaned_burnout_data.csv`
- Loads ~5M records into SQLite database (`burnout_pipeline.db`)

---

## 🤖 Automation

A **Cron Job** runs the pipeline daily at 2:00 AM:

```bash
0 2 * * * cd /path/to/scripts && /usr/bin/python3 digital_burnout_etl_pipeline.py >> ~/etl.log 2>&1
```

Logs are written to `etl.log` for monitoring.

---

## 📈 Tableau Dashboard

Four interactive views:

| View | Description |
|---|---|
| Productivity by Work Mode | Avg. productivity score across Office, Remote, Hybrid |
| Average Burnout Risk by Occupation | Burnout risk ranked by job role |
| Mental State Distribution | Pie chart of Balanced / Burnout / Distracted / Focused |
| Burnout by Screen-Time Group | Avg. burnout risk across Low / Medium / Heavy usage |

---

## 💡 Key Insights

- 🏠 **Remote workers** showed the highest average productivity scores
- 📱 **Higher screen time** correlated directly with elevated burnout risk
- 💼 **Freelancers** had the highest average burnout risk (~30.57)
- 🧠 Mental state distribution revealed **4 distinct workforce wellbeing profiles**
- ⚠️ Heavy screen-time users had noticeably higher burnout risk vs. low users

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Python 3 | ETL scripting |
| Pandas | Data manipulation |
| SQLite | Database storage |
| SQL | Data querying |
| Cron Jobs | Pipeline automation |
| Tableau Public | Dashboard & visualization |
| Git / GitHub | Version control |

---

## 🚀 Getting Started

### Prerequisites
```bash
pip install -r requirements.txt
```

### Run the Pipeline
```bash
cd scripts
python3 digital_burnout_etl_pipeline.py
```

### Set Up Cron Automation
```bash
crontab -e
# Add this line:
0 2 * * * cd /path/to/scripts && /usr/bin/python3 digital_burnout_etl_pipeline.py >> ~/etl.log 2>&1
```

---

## 📄 License

MIT License — feel free to use and build on this project.

---

## 🙋 Author

**Hardeep Singh**  
Data Engineering | Analytics | Python  
[LinkedIn](https://www.linkedin.com/in/) • [GitHub](https://github.com/)
