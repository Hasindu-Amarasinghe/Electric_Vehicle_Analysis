USE portfolio_projects;
SELECT * FROM electric_vehicle_data;

DESC electric_vehicle_data;

-- Changed column headings to new names avoiding using reserved words.
ALTER TABLE Electric_Vehicle_Data
RENAME COLUMN `VIN (1-10)` TO VIN1_10,
RENAME COLUMN `Postal Code` TO Postal_Code,
RENAME COLUMN `Model Year` TO Model_Year,
RENAME COLUMN `Electric Vehicle Type` TO Electric_Vehicle_Type,
RENAME COLUMN `Clean Alternative Fuel Vehicle (CAFV) Eligibility` TO Clean_Alternative_Fuel_Vehicle_Eligibility,
RENAME COLUMN `Electric Range` TO Electric_Range,
RENAME COLUMN `Base MSRP` TO Base_MSRP,
RENAME COLUMN `Legislative District` TO Legislative_District,
RENAME COLUMN `DOL Vehicle ID` TO DOL_Vehicle_ID,
RENAME COLUMN `Vehicle Location` TO Vehicle_Location_geographical_coordinates,
RENAME COLUMN `Electric Utility` TO Electric_Utility,
RENAME COLUMN `2020 Census Tract` TO _2020_Census_Tract;

-- Clean the Dataset
-- 1.	Remove rows with missing critical values
DELETE FROM Electric_Vehicle_Data
WHERE VIN1_10 IS NULL
OR Model_Year IS NULL
OR Make IS NULL
OR Model IS NULL;

-- 2.	Fill missing values in less critical columns with placeholders
UPDATE Electric_Vehicle_Data
SET County = COALESCE(County, 'Unknown'),
    City = COALESCE(City, 'Unknown'),
    Postal_Code = COALESCE(Postal_Code, 0),
    Legislative_District = COALESCE(Legislative_District, 0),
    Vehicle_Location_geographical_coordinates = COALESCE(Vehicle_Location_geographical_coordinates, 'Unknown'),
    Electric_Utility = COALESCE(Electric_Utility, 'Unknown'),
    _2020_Census_Tract = COALESCE(_2020_Census_Tract, 0);
    
-- Answer the Questions:

-- 1. Top 10 electric vehicle manufacturers:
SELECT Make, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Make
ORDER BY count DESC
LIMIT 10;

-- 2. Top 10 most common electric vehicle models:
SELECT Model, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Model
ORDER BY count DESC
LIMIT 10;

-- 3. Number of electric vehicles registered in each county:
SELECT County, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY County
ORDER BY count DESC;

-- 4. Distribution of electric vehicle types:
SELECT Electric_Vehicle_Type, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Electric_Vehicle_Type;

-- 5. Model year with the highest registration count:
SELECT Model_Year, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Model_Year
ORDER BY count DESC
LIMIT 1;

-- 6. Average electric range by make and model:
SELECT Make, Model, AVG(Electric_Range) as avg_range
FROM Electric_Vehicle_Data
GROUP BY Make, Model;

-- 7. Average base MSRP by county:
SELECT County, AVG(Base_MSRP) as avg_msrp
FROM Electric_Vehicle_Data
GROUP BY County;

-- 8. Percentage of electric vehicles eligible for CAFV:
SELECT Clean_Alternative_Fuel_Vehicle_Eligibility, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Clean_Alternative_Fuel_Vehicle_Eligibility;

-- 9. Distribution of electric vehicle registrations by postal code:
SELECT Postal_Code, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Postal_Code
ORDER BY count DESC;

-- 10. Electric utility serving the top 3 electric vehicles:
SELECT Electric_Utility, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Electric_Utility
ORDER BY count DESC
LIMIT 3;

-- 11. Legislative district with the highest number of electric vehicle registrations:
SELECT Legislative_District, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Legislative_District
ORDER BY count DESC
LIMIT 1;

-- 12. Distribution of electric vehicle registrations by city:
SELECT City, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY City
ORDER BY count DESC;

-- 13. Total number of electric vehicles registered each year:
SELECT Model_Year, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Model_Year
ORDER BY Model_Year DESC;

-- 14. Electric vehicle make with the highest average MSRP:
SELECT Make, AVG(Base_MSRP) as avg_msrp
FROM Electric_Vehicle_Data
GROUP BY Make
ORDER BY avg_msrp DESC
LIMIT 1;

-- 15. Correlation between electric range and base MSRP:
SELECT Electric_Range, Base_MSRP
FROM Electric_Vehicle_Data;

-- 16. Top 5 postal codes with the highest number of electric vehicle registrations:
SELECT Postal_Code, COUNT(*) as count
FROM Electric_Vehicle_Data
GROUP BY Postal_Code
ORDER BY count DESC
LIMIT 5;