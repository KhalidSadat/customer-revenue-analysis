/*
🧪 📊 Business Case 2: Top Customers & Revenue Contribution

You are working as a Data Analyst.
Management wants to identify high-value customers and understand how much they contribute to total revenue.

🎯 Objective

Analyze:

Who are the top customers
How much they contribute to overall revenue
📦 Dataset

Use the Invoice table.

🧠 Task Requirements
👉 Step 1: Customer Total Spending

For each customer:

Show:
CustomerId
TotalSpent (sum of all invoices)
👉 Step 2: Rank Customers
Rank customers based on TotalSpent (highest first)
👉 Step 3: Revenue Contribution %

For each customer:

Calculate:
%Contribution = (Customer TotalSpent / Overall Total Revenue) * 100
👉 Step 4: Running Contribution
Calculate cumulative contribution (running %)
👉 This helps identify top 20% customers (Pareto analysis)
⚠️ Rules
Use window functions
Avoid unnecessary subqueries if possible
Structure cleanly (CTE recommended)
🎯 Expected Skills
SUM() aggregation ✔
RANK() ✔
Window SUM() OVER() ✔
Division + percentage ✔
🧭 Your Task

Write a query (CTE allowed) that returns:

CustomerId
TotalSpent
CustomerRank
ContributionPercent
RunningContributionPercent
💬 What I’ll do

When you send your query:

I’ll review like an interviewer
Suggest improvements
Show a clean production-level version
*/

WITH customer_spending 
		AS(
			SELECT 
				CustomerId,
				SUM(Total)  TotalSpent
			FROM Invoice
			GROUP BY CustomerId
			),

	 Customer_Analysis AS(
			SELECT 
				CustomerId,
				TotalSpent,
				RANK() OVER(ORDER BY TotalSpent DESC) AS CustomerRank,
				TotalSpent/SUM(TotalSpent) OVER() *100 AS ContributionPercent

			FROM customer_spending)

SELECT 
	CustomerId,
	TotalSpent,
	CustomerRank,
	ContributionPercent,
	SUM(ContributionPercent) OVER (ORDER BY TotalSpent DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)RunningTotal

FROM Customer_Analysis




