-- 2021 Data
SELECT *
FROM bike_share_yr_0;

-- 2022 Data
SELECT *
FROM bike_share_yr_1;

-- UNION the two tables to show 2021 & 2022 data
SELECT *
FROM bike_share_yr_0
UNION					-- Removes any duplicated rows
SELECT *
FROM bike_share_yr_1;

/*  
	CTE to union both bike share data
	Using a LEFT JOIN to join the CTE with the cost table
	matching the tables on the yr field

	This now shows all of the data from the two bike share tables, and the data
	from the cost table
*/

WITH bike_share_data AS (
SELECT *
FROM bike_share_yr_0
UNION
SELECT *
FROM bike_share_yr_1 )

SELECT *
FROM bike_share_data
LEFT JOIN cost_table
	ON bike_share_data.yr = cost_table.yr

/*
	SELECTING the columns that we need for our analysis
	Adding extra fields we need:
		Revenue
		Profits
*/

WITH bike_share_data AS (
	SELECT *
	FROM bike_share_yr_0
	UNION
	SELECT *
	FROM bike_share_yr_1
)

SELECT
	dteday,
	season,
	bike_share_data.yr,
	weekday,
	hr,
	rider_type,
	riders,
	price,
	COGS,
	riders * price AS revenue,
	riders * price - COGS * riders AS profit
FROM bike_share_data
LEFT JOIN cost_table
	ON bike_share_data.yr = cost_table.yr;