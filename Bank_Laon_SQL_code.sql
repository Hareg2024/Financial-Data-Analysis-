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


--2.3.Long term Anlaysis 

--2.4.Employee length anlaysis

--2.5.Loan Purpose breakdown

--2.6.Home Ownership analysis 