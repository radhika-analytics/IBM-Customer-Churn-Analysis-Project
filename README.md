# IBM-Customer-Churn-Analysis-Project
This project analyzes customer churn behavior for a telecom company using real-world data of 7,043 customers. The goal is to identify why customers are leaving, which segments are at the highest risk, and what the business can do to improve retention. Churn is one of the most costly problems in subscription-based businesses.


# Customer Churn Analysis — Telecom Industry
### Analyst: Radhika Vishwakarma

##Presentation Link : https://gamma.app/docs/Untitled-dc74vnimkw6cdo1?mode=doc

---

## Business Problem
A telecom company is experiencing a ~26.5% customer churn rate, 
resulting in over $139,000 in monthly recurring revenue loss. 
This analysis identifies the key drivers of churn and provides 
actionable retention recommendations.

---

## Tools Used
| Tool | Purpose |
|------|---------|
| SQL | Business queries & churn segmentation |
| Python (Pandas, Matplotlib, Seaborn) | Data cleaning & EDA |
| Power BI | Interactive dashboard & KPI tracking |

---

## Dataset
- Source: IBM Telco Customer Churn (Kaggle)
- Rows: 7,043 customers | Columns: 21
- Link: https://www.kaggle.com/datasets/blastchar/telco-customer-churn

---

## Key Findings
1. Overall churn rate is **26.5%** — 1 in 4 customers is leaving
2. **Month-to-month contracts** drive the highest churn at 42%
3. **New customers (0–12 months)** are 3x more likely to churn
4. **Fiber optic customers** churn at 42% despite paying premium prices
5. **Electronic check users** churn at 45% vs 15% for auto-pay customers

---

## Business Recommendations
1. Convert month-to-month customers to annual plans with incentives
2. Launch a structured 90-day onboarding program
3. Audit fiber optic service quality and pricing strategy
4. Incentivize auto-pay enrollment across all customer segments

---

## Project Structure
customer-churn-analysis/
├── data/               # Raw dataset
├── sql/                # 10 business analysis queries
├── notebooks/          # Python EDA notebook
├── dashboard/          # Power BI .pbix file
├── report/             # PDF project report
└── visuals/            # Charts and dashboard screenshots
