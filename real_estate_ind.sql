-- drop database real_estate;
CREATE DATABASE real_estate;
USE real_estate;

CREATE TABLE Buyer (
   buyer_id VARCHAR(8),
   name VARCHAR(30),
   phone NUMERIC(10,0),
   email VARCHAR(25),
   PRIMARY KEY (buyer_id)   
);

CREATE TABLE Seller (
   seller_id VARCHAR(8),
   name VARCHAR(30),
   phone NUMERIC(10,0),
   email VARCHAR(25),
   PRIMARY KEY (seller_id)   
);

CREATE TABLE Agent (
   agent_id VARCHAR(8),
   name VARCHAR(30),
   phone NUMERIC(10,0),
   email VARCHAR(25),
   PRIMARY KEY (agent_id)   
);

CREATE TABLE Property (
   property_id VARCHAR(8),
   seller_id VARCHAR(8),
   sell_price NUMERIC(7,0),
   upload_date Date,
   status varchar (20) check (status in ('Sold', 'On_Sale')),
   PRIMARY KEY (property_id),
   FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
);

CREATE TABLE Property_Details (
   property_id VARCHAR(8),
   area VARCHAR(10),
   bedrooms NUMERIC(3),
   swimming_pool NUMERIC(3),
   city VARCHAR(20),
   district VARCHAR(20),
   house_no NUMERIC(4,0),
   imge_link varchar(100),
   PRIMARY KEY (property_id),
   FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE
);

CREATE TABLE Transaction (
   transaction_id VARCHAR(8),
   Date date,
   Final_Price numeric(10,2),
   buyer_id VARCHAR(8),
   seller_id VARCHAR(8),
   agent_id VARCHAR(8),
   property_id VARCHAR(8),
   PRIMARY KEY (transaction_id),
   FOREIGN KEY (property_id) REFERENCES Property(property_id),
   FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id),
   FOREIGN KEY (seller_id) REFERENCES Seller(seller_id),
   FOREIGN KEY (Agent_id) REFERENCES Agent(agent_id)
);


-- Populate Buyer table
INSERT INTO Buyer (buyer_id, name, phone, email) VALUES
('B0001', 'Ramesh Kumar', 9876543210, 'ramesh@example.com'),
('B0002', 'Suresh Singh', 9876543210, 'suresh@example.com'),
('B0003', 'Rahul Sharma', 9876543210, 'rahul@example.com'),
('B0004', 'Amit Patel', 9876543210, 'amit@example.com'),
('B0005', 'Vivek Jain', 9876543210, 'vivek@example.com');

-- Populate Seller table
INSERT INTO Seller (seller_id, name, phone, email) VALUES
('S0001', 'Sandeep Verma', 5678901234, 'sandeep@example.com'),
('S0002', 'Vikram Singh', 8901234567, 'vikram@example.com'),
('S0003', 'Kunal Sharma', 9012345678, 'kunal@example.com'),
('S0004', 'Gaurav Gupta', 3456789012, 'gaurav@example.com'),
('S0005', 'Nitin Patel', 6789012345, 'nitin@example.com');

-- Populate Agent table
INSERT INTO Agent (agent_id, name, phone, email) VALUES
('A0001', 'Prakash Tiwari', 1231231234, 'prakash@example.com'),
('A0002', 'Amit Kumar', 4564564567, 'amitk@example.com'),
('A0003', 'Rajesh Singh', 7897897890, 'rajesh@example.com'),
('A0004', 'Deepak Mishra', 9879879876, 'deepak@example.com'),
('A0005', 'Vishal Gupta', 6546546543, 'vishal@example.com');

-- Populate Property table
INSERT INTO Property (property_id, seller_id, sell_price, upload_date, status) VALUES
('P0001', 'S0001', 250000, '2004-04-12', 'Sold'),
('P0002', 'S0002', 230000, '2004-04-14','Sold' ),
('P0003', 'S0003', 200000, '2004-04-13', 'Sold'),
('P0004', 'S0004', 240000, '2004-04-10', 'On_Sale'),
('P0005', 'S0004', 400000, '2004-04-11','On_Sale' ),
('P0006', 'S0003', 220000, '2004-04-10','On_Sale' ),
('P0007', 'S0005', 230000, '2004-04-08', 'On_Sale');

-- Populate Property_Details table
INSERT INTO Property_Details (property_id, area, bedrooms, swimming_pool, city, district, house_no, imge_link) VALUES
('P0001', '2000 sqft', 3, 1, 'Allahabad', 'Naini', 123, NULL),
('P0002', '1800 sqft', 4, 0, 'Varanasi', 'Shivpur', 456, NULL),
('P0003', '2200 sqft', 3, 1, 'Allahabad', 'Jhunsi', 789, "C:\Users\PRATAP\Pictures\DRAW\cp.png"),
('P0004', '2400 sqft', 5, 1, 'Varanasi', 'Rathyatra', 1020, NULL),
('P0005', '2800 sqft', 4, 1, 'Varanasi', 'Shivpur', 1213, "C:\Users\PRATAP\Pictures\DRAW\doraemon.png"),
('P0006', '2400 sqft', 5, 0, 'Varanasi', 'Shivpur', 1011, NULL),
('P0007', '2300 sqft', 6, 0, 'Varanasi', 'Shivpur', 1014, NULL);

-- Populate Transaction table
INSERT INTO Transaction (transaction_id, Date, Final_Price, buyer_id, seller_id, agent_id, property_id) VALUES
('T0001', '2004-04-15', 245000, 'B0001', 'S0001', 'A0001', 'P0001'),
('T0002', '2004-04-16', 295000, 'B0002', 'S0001', 'A0001', 'P0002'),
('T0003', '2004-04-17', 190000, 'B0003', 'S0003', 'A0003', 'P0003');


-- Queries

-- a) Find addresses of homes for sale in the city “Varanasi” costing between $200,000 and $250,000.
SELECT PD.city, PD.district, PD.house_no
FROM Property_Details PD
JOIN Property P ON PD.property_id = P.property_id
WHERE PD.city = 'Varanasi'
AND P.sell_price BETWEEN 200000 AND 250000
AND P.status = 'On_Sale';


-- b) Find addresses of homes for sale in the school district “Shivpur” with 4 or more bedrooms and no swimming pool.
SELECT PD.area, PD.city, PD.district, PD.house_no
FROM Property_Details PD
JOIN Property P ON PD.property_id = P.property_id
WHERE PD.district = 'Shivpur'
AND PD.bedrooms >= 4
AND PD.swimming_pool = 0
AND P.status = 'On_Sale';

-- c) Find the name of the agent who has sold the most property in the year 2004 by total dollar value.
SELECT A.name
FROM Agent A
JOIN Transaction T ON A.agent_id = T.agent_id
WHERE YEAR(T.Date) = 2004
GROUP BY A.name
ORDER BY SUM(T.Final_Price) DESC
LIMIT 1;

-- d) For each agent, compute the average selling price of properties sold in 2004, and the average time the property was on the market. Note that this suggests use of date attributes in your design.
SELECT A.name AS Agent_Name,
       AVG(P.sell_price) AS Avg_Selling_Price,
       AVG(DATEDIFF(T.Date, P.upload_date)) AS Avg_Days_On_Market
FROM Agent A
LEFT JOIN Transaction T ON A.agent_id = T.agent_id
LEFT JOIN Property P ON T.property_id = P.property_id
WHERE YEAR(T.Date) = 2004
GROUP BY A.name;

-- f) Record the sale of a property that had been listed as being available. This entails storing the sales price, the buyer, the selling agent, the buyer’s agent (if any), and the date.
INSERT INTO Transaction (transaction_id, Date, Final_Price, buyer_id, seller_id, agent_id, property_id)
VALUES ('T004', '2004-04-19', 2200000, 'B0004', 'S0004', 'A0003', 'P0004');

UPDATE Property
SET status = 'Sold'
where property_id='P0004';

-- g) Add a new agent to the database.
INSERT INTO Agent (agent_id, name, phone, email)
VALUES ('A0006', 'Kiran Sharma', 9999988888, 'kiran@example.com');
