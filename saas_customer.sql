-- Staging Table & Ingest Raw Data
CREATE TABLE raw_saas_churn (
    customer_id VARCHAR(20),
    signup_date VARCHAR(20),
    plan_tier VARCHAR(20),
    monthly_charge DECIMAL(5, 2),
    tenure_months INT,
    support_tickets_30d INT,
    monthly_login_hours DECIMAL(10, 2),
    payment_method VARCHAR(30),
    last_login_date VARCHAR(20),
    churned INT
);

-- Data Cleaning CTE & Transformation
CREATE TABLE clean_saas_churn AS
WITH cleaned_data AS (
    SELECT
        customer_id,
        -- Standardize signup_date and last_login_date to DATE format
        CASE
            WHEN signup_date LIKE '%/%/%' THEN STR_TO_DATE(signup_date, '%m/%d/%Y')
            ELSE signup_date LIKE '%-%-%' THEN STR_TO_DATE(signup_date, '%Y-%m-%d')
        END AS signup_date,

        -- Standardize dirty text strings
        TRIM(UPPER(plan_tier)) AS plan_tier,
        monthly_charge,
        tenure_months,
        support_tickets_30d,
        monthly_login_hours,
        payment_method,

        -- Handles Null Values
        COALESCE(payment_method, 'Unknown') AS payment_method,
        STR_TO_DATE(last_login_date, '%Y-%m-%d') AS last_login_date,
        churned
    FROM raw_saas_churn
)

SELECT
    customer_id,
    signup_date,
    plan_tier,
    monthly_charge,
    tenure_months,
    support_tickets_30d,
    monthly_login_hours,
    payment_method,
    last_login_date,
    churned,

    -- Calculate churn probability based on tenure and support tickets for business KPIs
    (monthly_charge * tenure_months) AS lifetime_value_to_date,
    CASE
        WHEN tenure_months <= 3 THEN '0-3 Months (Onboarding)'
        WHEN tenure_months BETWEEN 4 AND 12 THEN '4-12 Months (Growth)'
        WHEN tenure_months BETWEEN 13 AND 24 THEN '1-2 Years (Established)'
        ELSE '2+ Years (Mature)'
    END AS tenure_cohort,

    CASE
        WHEN monthly_login_hours < 10 THEN 'Low Engagement'
        WHEN monthly_login_hours BETWEEN 10 AND 30 THEN 'Moderate Engagement'
        ELSE 'High Engagement'
    END AS engagement_level,
FROM cleaned_data;

-- Summary Table for Business KPIs view
CREATE VIEW v_churn_summary_by_tier AS
SELECT
    plan_tier,
    COUNT(customer_id) AS total_customers,
    SUM(churned) AS total_churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_rate_pct,
    ROUND(AVG(monthly_charge), 2) AS avg_mrr,
    ROUND(AVG(support_tickets_30d), 1) AS avg_support_tickets,
    ROUND(AVG(monthly_login_hours), 1) AS avg_login_hours,
FROM clean_saas_churn
GROUP BY plan_tier;