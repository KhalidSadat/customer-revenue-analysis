
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




