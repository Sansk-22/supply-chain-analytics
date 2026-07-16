use supply_chain;
-- Step 1: Drop old table
DROP TABLE IF EXISTS supply_chain_data;

-- Step 2: Create table with EXACT column order matching CSV
CREATE TABLE supply_chain_data (
    Type VARCHAR(50),
    Days_for_shipping_real INT,
    Days_for_shipment_scheduled INT,
    Benefit_per_order FLOAT,
    Sales_per_customer FLOAT,
    Delivery_Status VARCHAR(50),
    Late_delivery_risk INT,
    Category_Id INT,
    Category_Name VARCHAR(100),
    Customer_City VARCHAR(100),
    Customer_Country VARCHAR(100),
    Customer_Fname VARCHAR(50),
    Customer_Id INT,
    Customer_Lname VARCHAR(50),
    Customer_Segment VARCHAR(50),
    Customer_State VARCHAR(100),
    Customer_Zipcode FLOAT,
    Department_Id INT,
    Department_Name VARCHAR(100),
    Latitude FLOAT,
    Longitude FLOAT,
    Market VARCHAR(50),
    Order_City VARCHAR(100),
    Order_Country VARCHAR(100),
    Order_Customer_Id INT,
    Order_Date VARCHAR(50),
    Order_Id INT,
    Order_Item_Cardprod_Id INT,
    Order_Item_Discount FLOAT,
    Order_Item_Discount_Rate FLOAT,
    Order_Item_Id INT,
    Order_Item_Product_Price FLOAT,
    Order_Item_Profit_Ratio FLOAT,
    Order_Item_Quantity INT,
    Sales FLOAT,
    Order_Item_Total FLOAT,
    Order_Profit_Per_Order FLOAT,
    Order_Region VARCHAR(100),
    Order_State VARCHAR(100),
    Order_Status VARCHAR(50),
    Order_Zipcode FLOAT,
    Product_Card_Id INT,
    Product_Category_Id INT,
    Product_Name VARCHAR(200),
    Product_Price FLOAT,
    Product_Status INT,
    Shipping_Date VARCHAR(50),
    Shipping_Mode VARCHAR(50),
    Shipping_Delay INT,
    Month VARCHAR(20),
    Discount_Category VARCHAR(20)
);

-- Step 3: Import
LOAD DATA LOCAL INFILE '/path/to/your/supply_chain_cleaned.csv'
INTO TABLE supply_chain_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Step 4: Verify
SELECT COUNT(*) FROM supply_chain_data;
SELECT Shipping_Mode, Delivery_Status, Market, Product_Name 
FROM supply_chain_data 
LIMIT 5;

-- Q1: Late delivery rate by shipping mode
SELECT 
    Shipping_Mode,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Delivery_Status = 'Late delivery' THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(SUM(CASE WHEN Delivery_Status = 'Late delivery' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Percentage
FROM supply_chain_data
GROUP BY Shipping_Mode
ORDER BY Late_Percentage DESC;

-- Q2: Profit by market
SELECT 
    Market,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    ROUND(AVG(Order_Profit_Per_Order), 2) AS Avg_Profit
FROM supply_chain_data
GROUP BY Market
ORDER BY Total_Profit DESC;

-- Q3: Top 10 most profitable products
SELECT 
    Product_Name,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Order_Profit_Per_Order), 2) AS Avg_Profit,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit
FROM supply_chain_data
GROUP BY Product_Name
ORDER BY Avg_Profit DESC
LIMIT 10;

-- Q4: Discount impact on profit
SELECT 
    Discount_Category,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Order_Profit_Per_Order), 2) AS Avg_Profit,
    ROUND(AVG(Order_Item_Discount_Rate) * 100, 2) AS Avg_Discount_Pct
FROM supply_chain_data
WHERE Discount_Category IS NOT NULL
GROUP BY Discount_Category
ORDER BY Avg_Discount_Pct ASC;

-- Q5: Suspected fraud by market
SELECT 
    Market,
    COUNT(*) AS Fraud_Orders
FROM supply_chain_data
WHERE Order_Status = 'SUSPECTED_FRAUD'
GROUP BY Market
ORDER BY Fraud_Orders DESC;

-- Q6: Customer segment performance
SELECT 
    Customer_Segment,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Order_Profit_Per_Order), 2) AS Avg_Profit
FROM supply_chain_data
GROUP BY Customer_Segment
ORDER BY Total_Sales DESC;