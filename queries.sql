/*👉 Step 1: Customer Total Spending
For each customer:
		•	Show: 
		o	CustomerId 
		o	TotalSpent (sum of all invoices) */

WITH customer_spending 
		AS(
			SELECT 
				CustomerId,
				SUM(Total)  TotalSpent
			FROM Invoice
			GROUP BY CustomerId
			),

	/*👉 Step 2: Rank Customers
		•	Rank customers based on TotalSpent (highest first) 
	
	👉 Step 3: Revenue Contribution %
		For each customer:
		•	Calculate: 
		o	%Contribution = (Customer TotalSpent / Overall Total Revenue) * 100 
	*/
	
	 Customer_Analysis AS(
			SELECT 
				CustomerId,
				TotalSpent,
				RANK() OVER(ORDER BY TotalSpent DESC) AS CustomerRank,
				TotalSpent/SUM(TotalSpent) OVER() *100 AS ContributionPercent

			FROM customer_spending)
	
/*👉 Step 4: Running Contribution
•	Calculate cumulative contribution (running %)
Note: This helps identify top 20% customers (Pareto analysis) */

	
SELECT 
	CustomerId,
	TotalSpent,
	CustomerRank,
	ContributionPercent,
	SUM(ContributionPercent) OVER (ORDER BY TotalSpent DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)RunningTotal

FROM Customer_Analysis




