-- Step 1: Create Staging Table & Ingest Raw Data
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

