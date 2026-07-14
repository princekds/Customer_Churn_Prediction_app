-- ============================================================ 
-- Customer Churn Analysis using PostgreSQL
-- Dataset: Telco Customer Churn Dataset 
-- ============================================================

-- 1. How many total customers are present in the dataset?
SELECT COUNT(DISTINCT "customerID") AS total_customers
FROM churn;

-- 2. What is the overall churn rate?
SELECT ROUND(COUNT(CASE WHEN "Churn" = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2)
AS churn_rate FROM churn;

-- 3. How many customers have churned vs stayed?
SELECT COUNT(*) FILTER (WHERE "Churn" = 'Yes') AS churned,
COUNT(*) FILTER (WHERE "Churn" = 'No') AS stayed
FROM churn;

-- 4. Which contract type has the highest churn rate?
SELECT "Contract", COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE "Churn" = 'Yes') AS churned,
ROUND(COUNT(*) FILTER (WHERE "Churn" = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM churn
GROUP BY "Contract" ORDER BY churn_rate DESC;

-- 5. Does customer tenure affect churn?
SELECT "Churn", ROUND(AVG("tenure"),2) AS avg_tenure,
MIN("tenure") as min_tenure,
MAX("tenure") as max_tenure
FROM churn
GROUP BY "Churn";

-- 6. Which internet service users churn the most?
SELECT "InternetService", COUNT (*) AS customers,
COUNT(*) FILTER (WHERE "Churn" = 'Yes') AS churned,
ROUND(COUNT(*) FILTER (WHERE "Churn" = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM churn
GROUP BY "InternetService" 
ORDER BY churn_rate DESC;

-- 7. Compare average monthly charges between churned and retained customers.
SELECT "Churn",
ROUND(AVG("MonthlyCharges")::numeric, 2) AS avg_monthly_charges
FROM churn
GROUP BY "Churn";

-- 8. Which payment method has the highest churn?
SELECT "PaymentMethod", 
COUNT(*) FILTER (WHERE "Churn" = 'Yes') AS churned
FROM churn
GROUP BY "PaymentMethod"
ORDER BY churned DESC;

-- 9. Find the top 10 customers with highest monthly charges who churned.
SELECT "customerID", "MonthlyCharges","Contract", "PaymentMethod", "InternetService"
FROM churn
WHERE "Churn" = 'Yes'
ORDER BY "MonthlyCharges" DESC
LIMIT 10;
