CREATE DATABASE AuctionStarSchema;
USE AuctionStarSchema;


-- "Item" TABLE
CREATE TABLE Item(
    ItemKey INT(3),
    ItemName VARCHAR(50),
    ItemNumber INT(5),
    Department VARCHAR(50),
    SoldFlag INT(1),
    PRIMARY KEY (ItemKey)
);

DESC Item;

INSERT INTO Item VALUES(001, "Raspberry Pi", 011, "Electronics", 0);
INSERT INTO Item VALUES(002, "Learn C++", 012, "Books", 1);
INSERT INTO Item VALUES(003, "T-Shirt", 013, "Clothing", 0);
INSERT INTO Item VALUES(004, "Watch", 014, "Accessories", 1);

SELECT * FROM Item;


-- "Time" TABLE
CREATE TABLE TimeTable(
    TimeKey INT(3),
    _Date VARCHAR(10),
    _Month VARCHAR(15),
    _Quarter VARCHAR(2),
    _Year INT(4),
    PRIMARY KEY (TimeKey)
);

DESC TimeTable;

INSERT INTO TimeTable VALUES(001, "10-10-2022", "October", "Q3", "2022");
INSERT INTO TimeTable VALUES(002, "15-10-2022", "October", "Q3", "2022");
INSERT INTO TimeTable VALUES(003, "20-10-2022", "October", "Q3", "2022");
INSERT INTO TimeTable VALUES(004, "25-10-2022", "October", "Q3", "2022");

SELECT * FROM TimeTable;


-- "Consignor" TABLE
CREATE TABLE Consignor(
    ConsignorKey INT(3),
    ConsignorName VARCHAR(50),
    ConsignorCode VARCHAR(5),
    ConsignorType VARCHAR(20),
    ConsignorCountry VARCHAR(20),
    PRIMARY KEY (ConsignorKey)
);

DESC Consignor;

INSERT INTO Consignor VALUES(001, "Atharva Auti", "AA021", "Business", "India");
INSERT INTO Consignor VALUES(002, "Mihir Doshi", "DD022", "Business", "India");
INSERT INTO Consignor VALUES(003, "Dhruvil Jain", "VP023", "Business", "India");
INSERT INTO Consignor VALUES(004, "Vivek Mishra", "SS024", "Business", "India");

SELECT * FROM Consignor;


-- "Buyer" TABLE
CREATE TABLE Buyer(
    BuyerKey INT(3),
    BuyerName VARCHAR(50),
    BuyerCode VARCHAR(5),
    BuyerType VARCHAR(20),
    BuyerCountry VARCHAR(20),
    PRIMARY KEY (BuyerKey)
);


DESC Buyer;

INSERT INTO Buyer VALUES(001, "Avi Patel", "MM031", "Business", "India");
INSERT INTO Buyer VALUES(002, "Avi Patel", "MM031", "Business", "India");
INSERT INTO Buyer VALUES(003, "Avi Patel", "MM031", "Business", "India");
INSERT INTO Buyer VALUES(004, "Avi Patel", "MM031", "Business", "India");

SELECT * FROM Buyer;


-- FACT TABLE "AuctionSales"
CREATE TABLE AuctionSales(
    ItemKey INT(3),
    TimeKey INT(3),
    ConsignorKey INT(3),
    BuyerKey INT(3),
    FOREIGN KEY (ItemKey) REFERENCES Item(ItemKey),
    FOREIGN KEY (TimeKey) REFERENCES TimeTable(TimeKey),
    FOREIGN KEY (ConsignorKey) REFERENCES Consignor(ConsignorKey),
    FOREIGN KEY (BuyerKey) REFERENCES Buyer(BuyerKey),
    
    LowEstimate INT(8),
    HighEstimate INT(8),
    ReservePrice INT(8),
    SoldPrice INT(8)
);

DESC AuctionSales;

INSERT INTO AuctionSales VALUES(001, 001, 001, 001, 2500, 5000, 3000, 4000);
INSERT INTO AuctionSales VALUES(002, 002, 002, 002, 5000, 10000, 6000, 8000);
INSERT INTO AuctionSales VALUES(003, 003, 003, 003, 1250, 2500, 1500, 2000);
INSERT INTO AuctionSales VALUES(004, 004, 004, 004, 7500, 12500, 10000, 11000);

SELECT * FROM AuctionSales;


-- SLICE
SELECT ItemName, SoldPrice
FROM AuctionSales
INNER JOIN Item ON AuctionSales.ItemKey=Item.ItemKey
WHERE ItemName = "Watch";

-- DICE
SELECT BuyerName, BuyerCode
FROM (Buyer INNER JOIN AuctionSales ON Buyer.BuyerKey=AuctionSales.BuyerKey) JOIN TimeTable
ON AuctionSales.TimeKey=TimeTable.TimeKey
WHERE BuyerName = "Avi Patel";

-- ROLLUP
SELECT _Date, _Quarter FROM (AuctionSales NATURAL JOIN Item) JOIN TimeTable ON
AuctionSales.TimeKey=TimeTable.TimeKey; 


-- DRILLDOWN
SELECT _Quarter, SUM(SoldPrice)
FROM (AuctionSales NATURAL JOIN Item) JOIN TimeTable
ON AuctionSales.TimeKey = TimeTable.TimeKey
WHERE ItemName = "Watch" GROUP BY _Quarter

-- PIVOT