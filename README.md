# Customer-Churn-Analytics
B2B SaaS Customer Churn &amp; Revenue Retention Analytics

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-MySQL%20%7C%20PostgreSQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Data Analysis](https://img.shields.io/badge/Focus-Customer%20Retention-green?style=for-the-badge)

## 📌 Business Overview
Customer churn directly impacts Monthly Recurring Revenue (MRR) and Long-Term Value (LTV) in B2B Software-as-a-Service (SaaS) businesses. This project analyzes customer usage behaviors, support volume, subscription tiers, and billing profiles across a cohort of **1,000 SaaS accounts** to identify leading indicators of churn and deliver actionable retention strategies.

---

## 🔑 Key Findings & Business Insights
* **Product Engagement Drop-off:** Accounts logging fewer than **12.5 monthly hours** exhibit a **3.2x higher likelihood of churning** compared to highly active users.
* **Support Friction:** A rise in support tickets (>4 tickets in 30 days) serves as a primary churn driver, indicating product onboarding friction or unresolved technical errors.
* **Tier Risk Vulnerability:** **BASIC tier accounts** show the highest attrition rates (~38%), whereas **ENTERPRISE tier clients** maintain over 88% retention due to dedicated account management.

---

## 🛠️ Tech Stack & Workflow
1. **Data Generation:** Python (`pandas`, `numpy`) for generating complex synthetic usage signals and injecting controlled real-world data anomalies.
2. **Data Transformation & ETL:** SQL (`CTE`, `Window Functions`, `CASE` logic) to clean inconsistent data types, impute null values, and feature-engineer retention metrics.
3. **Exploratory Data Analysis (EDA):** Python (`matplotlib`, `seaborn`) to examine kernel densities, distribution variances, and categorical churn behavior.
