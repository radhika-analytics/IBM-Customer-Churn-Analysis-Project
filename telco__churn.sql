-- ================================================
-- TELCO CUSTOMER CHURN ANALYSIS
-- Analyst: Radhika Vishwakarma
-- Business Goal: Identify churn drivers and 
-- retention opportunities
-- ================================================


CREATE TABLE telco_churn (
    customerID        VARCHAR(20),
    gender            VARCHAR(10),
    SeniorCitizen     INT,
    Partner           VARCHAR(5),
    Dependents        VARCHAR(5),
    tenure            INT,
    PhoneService      VARCHAR(5),
    MultipleLines     VARCHAR(20),
    InternetService   VARCHAR(20),
    OnlineSecurity    VARCHAR(20),
    OnlineBackup      VARCHAR(20),
    DeviceProtection  VARCHAR(20),
    TechSupport       VARCHAR(20),
    StreamingTV       VARCHAR(20),
    StreamingMovies   VARCHAR(20),
    Contract          VARCHAR(20),
    PaperlessBilling  VARCHAR(5),
    PaymentMethod     VARCHAR(40),
    MonthlyCharges    DECIMAL(8,2),
    TotalCharges      VARCHAR(20),
    Churn             VARCHAR(5)
);
select * from telco_churn;



-- -----------------------------------------------
-- 1. OVERALL CHURN RATE
-- Business Q: What percentage of customers are we losing?
-- -----------------------------------------------
select round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate from telco_churn ;


-- -----------------------------------------------
-- 2. CHURN BY CONTRACT TYPE
-- Business Q: Do short-term customers churn more?
-- -----------------------------------------------
select contract,count(*) as total_customers,sum(case when churn='Yes' then 1 else 0 end) as churn_customers ,  round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate from telco_churn group by contract order by churn_rate desc;


-- -----------------------------------------------
-- 3. CHURN BY TENURE GROUP
-- Business Q: When in the customer lifecycle does churn peak?
-- -----------------------------------------------
select case 
	when tenure between 0 and 12 then '0-12 months'
	when tenure between 13 and 23 then '13-23 months' 
	when tenure between 24 and 48 then '24-48 months'
	else '48+ months'
end as tenure_catogery,
count(*) as total_customers,sum(case when churn='Yes' then 1 else 0 end) as churn_customers ,  round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate from telco_churn group by tenure_catogery order by churn_rate desc;



-- -----------------------------------------------
-- 4. CHURN BY INTERNET SERVICE TYPE
-- Business Q: Which service type has the highest churn risk?
-- -----------------------------------------------
select Internetservice,count(*) as total_customers,sum(case when churn='Yes' then 1 else 0 end) as churn_customers ,  round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate from telco_churn group by Internetservice order by churn_rate desc;


-- -----------------------------------------------
-- 5. CHURN BY PAYMENT METHOD
-- Business Q: Does how customers pay affect loyalty?
-- -----------------------------------------------
select paymentmethod,count(*) as total_customers,sum(case when churn='Yes' then 1 else 0 end) as churn_customers, round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2)as churn_rate from telco_churn group by paymentmethod order by churn_rate desc;


-- -----------------------------------------------
-- 6. AVERAGE MONTHLY CHARGES: CHURNED VS RETAINED
-- Business Q: Are high-paying customers leaving?
-- -----------------------------------------------
select churn, round(avg(monthlycharges),2) as monthly_charges, round(avg(tenure),2) from telco_churn group by churn;


-- -----------------------------------------------
-- 7. REVENUE AT RISK FROM CHURNED CUSTOMERS
-- Business Q: What is the financial impact of churn?
-- -----------------------------------------------
select
	sum(case when churn = 'Yes' then monthlycharges else 0 end) as momthly_revenue_lost,sum(case when churn = 'Yes' then monthlycharges else 0 end)*12 as annual_revenue_at_risk from telco_churn;



-- -----------------------------------------------
-- 8. CHURN BY SENIOR CITIZEN STATUS
-- Business Q: Are senior citizens a high-risk segment?
-- -----------------------------------------------
select case when seniorcitizen=1 then 'senior_citizen' else 'non-senior_citizen' end as segment,count(*) as total_customers,sum(case when churn='Yes' then 1 else 0 end) as churn_customers ,  round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate from telco_churn group by seniorcitizen order by churn_rate desc;



-- -----------------------------------------------
-- 9. HIGH RISK CUSTOMER PROFILE (CTE)
-- Business Q: Who are our most at-risk customers right now?
-- -----------------------------------------------
with high_risk as(
	select
		customerid,
		tenure,
		contract,
		paymentmethod,
		monthlycharges,
		churn
	from telco_churn
	where 
		contract = 'Month-to-month'
		and tenure < 12
		and monthlycharges>65
)
select 
	count(*) as total_customer,round(avg(monthlycharges),2) as monthly_charges , 
	sum(case when churn = 'Yes' then 1 else 0 end) as already_churned from high_risk;



-- -----------------------------------------------
-- 10. CHURN BY MULTIPLE SERVICES SUBSCRIBED
-- Business Q: Do customers with more services stay longer?
-- -----------------------------------------------
select 
	(case when phoneservice = 'Yes' then 1 else 0 end +
	case when internetservice != 'No' then 1 else 0 end +
	case when streamingtv = 'Yes' then 1 else 0 end +
	case when streamingmovies = 'Yes' then 1 else 0 end +
	case when onlinesecurity = 'Yes' then 1 else 0 end)
as services_count,
count(*) as total_customer , round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate from telco_churn group by services_count order by services_count;