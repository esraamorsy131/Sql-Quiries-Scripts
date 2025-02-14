/* Problem 1
For each customer, find their total orders amount and 
cumulative order amount over time, ordered by order_date.
*/

Select 
        C.customer_id ,
		C.customer_Name , 
		O.order_date ,
		SUM(O.total_amount) As 'Total Orders Amount',  
		SUM(O.total_amount)
		OVER (PARTITION BY C.customer_id 
		order by O.order_date
		) AS 'Cumulative Order Amount'

From customers C left outer join orders O    -- To include all customers even those without orders
On C.customer_id = O.customer_id
Group by C.customer_id , C.customer_name , O.order_date
order by O.order_date


------------------------------------------------------------------------------------------------
/* Problem 2
Return only customers who have made more than 1 order and 
they have to be among the top 3 in their region based on thier cumulative order amount.

*/

-- Create CTE To Improves Readability & Maintainability 

With Selected_Customers_CTE AS (
      Select 
	    C.region,
		C.customer_id,
		C.customer_Name ,
		COUNT(O.order_id) As TotalOrders,            -- Total Orders Per Customer 
		SUM(total_amount) As Total Orders Amount,    -- Total Orders Amount Per Customer 
		SUM(total_amount)
		OVER (PARTITION BY C.customer_id 
		order by O.order_date
		) AS CumulativeOrderAmount, -- Cumulative Order Amount Per Customer -- 
		Rank() over(partition BY C.region order by (SUM(total_amount) -- Rank Regions According to COA 
		OVER (PARTITION BY C.customer_id DESC) AS RankInRegion

		From customers C left outer join orders O    -- To include all customers even those without orders
		On C.customer_id = O.customer_id
		Group by C.region, C.customer_id, C.custmer_name 
)

Select *    
From Selected_Customers_CTE
Where  TotalOrders > 1           -- To Ensure Customers Have Made More Than 1 Order -- 
And RankInRegion <= 3            -- To Ensure Only Top 3 Customers In Region --
order by region, RankInRegio

-----------------------------------------------------------------------------------------------
/* Problem 3
Order the set of returned customer based on the customer_id and cumulative order amount 
*/


With Ranked_Customers_CTE AS (
      Select 
	    C.region,
		C.customer_id,
		C.customer_Name ,
		O.order_date,
		COUNT(O.order_id) As TotalOrders,            -- Total Orders Per Customer 
		SUM(total_amount) As Total Orders Amount,    -- Total Orders Amount Per Customer 
		SUM(total_amount)
		OVER (PARTITION BY C.customer_id 
		order by O.order_date
		) AS CumulativeOrderAmount, -- Cumulative Order Amount Per Customer -- 
		Rank() over(partition BY C.region order by (SUM(total_amount) -- Rank Regions According to COA 
		OVER (PARTITION BY C.customer_id DESC) AS RankInRegion

		From customers C left outer join orders O    -- To include all customers even those without orders
		On C.customer_id = O.customer_id
		Group by C.region, C.customer_id, C.custmer_name , O.order_date
)

Select * 
From Selected_Customers_CTE
Order by customer_id , CumulativeOrderAmount DESC

------------------------------------------------------------------------------------------------
/* Problem 4
Calculate the retention rate of customers who placed an order in their first month 
of registration and then placed at least one order in the following months.
*/

-- Create Function To Enhabce Reuseability 

Create Function GetRetentionRate()
RETURNS FLOAT
AS
BEGIN
     -- DECLARE VARIABLES 
   DECLARE @FirstMonthCustomers  INT
   DECLARE @FollowingMonthCustomers INT
   DECLARE @RETENTION_RATE  FLOAT

	 -- Count customers who made their first order in the same month as registration
   SELECT @FirstMonthCustomers = COUNT(DISTINCT C.customer_id)
   From Customers C inner join Orders O 
   ON C.customer_id = O.customer_id
   Where DATEPART(YEAR , C.register_date) = DATEPART(YEAR , O.order_date)
   And   DATEPART(MONTH , C.register_date) = DATEPART(MONTH , O.order_date)


   -- Count customers who made another order after the first month of registration 
   SELECT @FollowingMonthCustomers = COUNT(DISTINCT C.customer_id)
   From Customers C inner join Orders O 
   ON C.customer_id = O.customer_id
    WHERE 
       (DATEPART(YEAR, O.order_date) > DATEPART(YEAR, C.register_date))
       OR (DATEPART(YEAR, O.order_date) = DATEPART(YEAR, C.register_date)
           AND DATEPART(MONTH, O.order_date) > DATEPART(MONTH, C.register_date))


     -- Calculate retention rate (avoid division by zero)
   IF @FirstMonthCustomers = 0
       SET @RETENTION_RATE = 0;
   ELSE
       SET @RETENTION_RATE = CAST(@FollowingMonthCustomers AS FLOAT) / CAST(@FirstMonthCustomers AS FLOAT) * 100;

   
   

   RETURN @RETENTION_RATE
END

      -- TO CALL THE FUNCTION 
SELECT GetRetentionRate() AS @RETENTION_RATE

------------------------------------------------------------------------------------------------
/* Problem 5
Identify days in the last year where daily sales significantly deviated 
(±20%) from the 7-day moving average.
*/

WITH SalesWithMovingAvg AS (
    SELECT
        order_id,
        total_amount AS DailySales,
        order_date,
        DATEPART(YEAR, order_date) AS OrderYear,
        DATEPART(DAY, order_date) AS OrderDay,
        AVG(total_amount) OVER (
            ORDER BY order_date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS MovingAverage,
		((total_amount - AVG(total_amount) OVER (
            ORDER BY order_date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        )) / NULLIF(AVG(total_amount) OVER (
            ORDER BY order_date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 0)) * 100 AS DeviationPercent
    FROM Orders
	WHERE order_date >= DATEADD(YEAR, -1, GETDATE()) -- Last 1 year
)
SELECT 
    order_id, 
    DailySales, 
    OrderYear, 
    OrderDay, 
    MovingAverage,
    DeviationPercent
FROM SalesWithMovingAvg

WHERE ABS( DeviationPercent) > 20   -- ±20% deviation
ORDER BY order_date




