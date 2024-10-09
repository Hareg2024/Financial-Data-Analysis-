use bank_loan;

-- ====================================================
        -- Problem Statement 1 
-- ===================================================
--1.1.  This query will return total loan application counts for each Month 
select monthname(Issue_Date) as Month , count(*) as MTD_Loan_Applications_count 
from bank_loan_data
where year(Issue_Date)= '2021'
group by monthname(Issue_Date) order by COUNT(*) DESC;
-- The results shows maximum number applications were submitted in December
-- and the least number of applications were in February for a given year. 


--  To monitor Month to date (MTD) loan applications 
-- and track changes Month over Month (MoM), we need month in where clause 
select count(*) as MTD_Loan_Applications ,monthname(Issue_Date) as Month 
from bank_loan_data
where year(Issue_Date)= '2021' and monthname(Issue_Date) = "December"
group by monthname(Issue_Date);
-- ------------------------------------------------------------------------

--1.2. The following query returns total funded amount for each month
SELECT  
    monthname(Issue_Date) as Month, 
    FORMAT(SUM( Loan_Amount),'N','en-US') AS Total_Funded_Amount
from bank_loan_data
GROUP BY monthname(Issue_Date), month(Issue_Date)
ORDER BY month(Issue_Date) ASC;

-- To monitor Month to date (MTD) funded amount 
-- and track changes Month over Month (MoM), we need month in where clause 
SELECT  
    monthname(Issue_Date) as Month, 
    FORMAT(SUM( Loan_Amount),'N','en-US') AS Total_Funded_Amount
from bank_loan_data where MONTH(Issue_Date) = 10
GROUP BY monthname(Issue_Date), month(Issue_Date)
-- ---------------------------------------------------------------------

-- 1.3. Total amount recieved
SELECT  
    monthname(Issue_Date) as Month, 
    FORMAT(SUM(Total_Payment),'N','en-US') AS Total_Amount_Recieved
from bank_loan_data
GROUP BY monthname(Issue_Date), month(Issue_Date)

-- MoM tracking 
SELECT  
    monthname(Issue_Date) as Month, 
    FORMAT(SUM(Total_Payment),'N','en-US') AS Total_Amount_Recieved
from bank_loan_data where MONTH(Issue_Date) = 10
GROUP BY monthname(Issue_Date), month(Issue_Date)

-- ---------------------------------------------------------------------

--1.4. Average interest rate

SELECT   monthname(Issue_Date) as Month,
    round(Avg(Int_Rate)*100,2) as Interst_Rate
FROM bank_loan_data
GROUP BY monthname(Issue_Date) 

--1.5. Average Debt-to-Income ratio(DTI) by loan Status

SELECT 
    Loan_Status,
    COUNT(*) AS   Total_Loan_Application,
    FORMAT(SUM(Total_Payment),'N','en-US') as Total_Amount_Recieved,
    FORMAT(SUM(Loan_Amount),'N','en-US') AS Total_Funded_Amount,
    Round(Avg(Dti)*100,2) as Avg_Interst_Rate
FROM bank_loan_data
GROUP BY Loan_Status

-- ====================================================
        -- Problem Statement 2 
-- ===================================================

--2.1.Monthly trends by issue date 
select monthname(Issue_Date) as Month , count(*) as MTD_Loan_Applications_count 
from bank_loan_data
where year(Issue_Date)= '2021'
group by monthname(Issue_Date) order by COUNT(*) DESC;


--2.2.Regional Analysis by State
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

--2.3.Long term Anlaysis 
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

--2.4.Employee length anlaysis

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

        --Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

        --Bad Loan Amount Received
SELECT FORMAT(SUM(total_payment),'N','en-US') AS Bad_Loan_amount_received 
FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--2.5.Loan Purpose breakdown
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

--2.6.Home Ownership analysis 
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership