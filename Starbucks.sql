-- Chnages made while creating database: 
-- CREATE DATABASE Starbucks;
-- Alter Table Employee_T modify column Employeecity Varchar(20); 
-- Need a modify statement when I saw I could not fit san francisco
-- SET SQL_SAFE_UPDATES = 0; This is used to disable safe mode so we can delete data 
-- delete from customer_t deletes all data from table
-- Alter Table Drivethru_T modify column averagewait Time; 
-- Alter table driveThru_t rename column averagewait to waittime;
-- Alter Table Cafe_T modify column OrderName Varchar(25); 
-- CREATE DATABASE Starbucks;
USE Starbucks;
SHOW TABLES;
CREATE TABLE Starbucks_T (StoreNumber INT(5) NOT NULL,StoreType VARCHAR(1),State VARCHAR(2), CONSTRAINT Starbucks_PK PRIMARY KEY (StoreNumber));
CREATE TABLE Customer_T (CustomerNumber INT(4) NOT NULL,StoreNumber INT(5) NOT NULL, CustomerName VARCHAR(20), DOB DATE, Gender CHAR(1), CustomerCity VARCHAR(10), CustomerState CHAR(2), CustomerPostalCode INT(5),CONSTRAINT Customer_PK PRIMARY KEY (CustomerNumber), CONSTRAINT Customer_FK FOREIGN KEY (StoreNumber) REFERENCES Starbucks_T(StoreNumber));
CREATE TABLE Employee_T (EmployeeId INT(7) NOT NULL, StoreNumber INT(5) NOT NULL, EmployeeName VARCHAR(20), DateHired DATE, EmployeeCity VARCHAR(20), EmployeeState CHAR(2), EmployeePostalCode INT(5), CONSTRAINT Employee_PK PRIMARY KEY (EmployeeId), CONSTRAINT Employee_FK FOREIGN KEY (StoreNumber) REFERENCES Starbucks_T(StoreNumber));
CREATE TABLE Order_T (OrderNumber INT(5) NOT NULL,EmployeeId INT(7) NOT NULL,CustomerNumber INT(4) NOT NULL, OrderDate Date, TimePlaced TIME, OrderType CHAR(1), CONSTRAINT ORDER_T PRIMARY KEY (OrderNumber), CONSTRAINT Order_FK1 FOREIGN KEY (EmployeeId) REFERENCES Employee_T(EmployeeId), CONSTRAINT Order_FK2 FOREIGN KEY (CustomerNumber) REFERENCES Customer_T(CustomerNumber));
CREATE TABLE DriveThru_T (ArrivalTime TIME,OrderNumber INT(5) NOT NULL,DepartTime TIME, WaitTime TIME, CONSTRAINT DriveThru_FK FOREIGN KEY (OrderNumber) REFERENCES Order_T(OrderNumber));
CREATE TABLE Cafe_T (OrderName VARCHAR(12),OrderNumber INT(5) NOT NULL ,CONSTRAINT Cafe_FK FOREIGN KEY (OrderNumber) REFERENCES Order_T(OrderNumber));
CREATE TABLE Mobile_T(PickupTime TIME NOT NULL,OrderNumber INT(5) NOT NULL ,CONSTRAINT Mobile_FK FOREIGN KEY (Ordernumber) REFERENCES Order_T(OrderNumber));
CREATE TABLE Receipt_T (ReceiptNumber INT(7) NOT NULL,OrderNumber INT(5) NOT NULL,ItemId INT(5) NOT NULL,NumberOfItems INT(20),TotalCost DECIMAL(10,2), PaymentMethod VARCHAR(15), CONSTRAINT Receipt_PK PRIMARY KEY (ReceiptNumber), CONSTRAINT Receipt_FK1 FOREIGN KEY (OrderNumber) REFERENCES Order_T(OrderNumber), CONSTRAINT Receipt_FK2 FOREIGN KEY (ItemId) REFERENCES Item_T(ItemId));
CREATE TABLE Item_T (ItemId INT(5) NOT NULL,ItemDescription VARCHAR(50), ItemCost DECIMAL(3,2), CONSTRAINT Item_PK PRIMARY KEY (ItemId));
CREATE TABLE Shipment_T (ShipmentNumber INT(8) NOT NULL,ShipmentDate DATE, CONSTRAINT Shipment_PK PRIMARY KEY (ShipmentNumber));
CREATE TABLE Supplier_T (StoreNumber INT(6) NOT NULL,CompanyName VARCHAR(20), CONSTRAINT Supplier_PK PRIMARY KEY (StoreNumber));
-- Many to many tables:
CREATE TABLE Item_Shipment_T(ItemId INT(5) NOT NULL, ShipmentNumber INT(8) NOT NULL, CONSTRAINT Item_Shipment_PK PRIMARY KEY(ItemId,ShipmentNumber), CONSTRAINT Item_Shipment_FK1 FOREIGN KEY (ItemId) REFERENCES Item_T(ItemId), CONSTRAINT Item_Shipment_FK2 FOREIGN KEY (Shipmentnumber) REFERENCES Shipment_T(ShipmentNumber));
CREATE TABLE Shipment_Supplier_T(ShipmentNumber INT(8) NOT NULL, StoreNumber INT(6) NOT NULL, CONSTRAINT Shipment_Supplier_PK PRIMARY KEY (ShipmentNumber,StoreNumber), CONSTRAINT Shipment_Supplier_FK1 FOREIGN KEY (ShipmentNumber) REFERENCES Shipment_T(ShipmentNumber), CONSTRAINT Shipment_Supplier_FK2 FOREIGN KEY (StoreNumber) REFERENCES Supplier_T(StoreNumber));
-- Starbucks_T
INSERT INTO Starbucks_T VALUES(13454, 'C', 'NY');
INSERT INTO Starbucks_T VALUES(23459,'R','NY');
INSERT INTO Starbucks_T VALUES(34571,'C','FL');
INSERT INTO Starbucks_T VALUES(71710,'D','CA');
-- Customer_T 
INSERT INTO Customer_T VALUES(1010,13454,'Alex Parliman','1997-05-21','M','Middletown','NY','10940');
INSERT INTO Customer_T VALUES(1011,13454,'Cameron Allen','2000-02-22','M','Middletown','NY','10940');
INSERT INTO Customer_T VALUES(1012,13454,'Sean Mendes','1993-12-01','M','Middletown','NY','10940');
INSERT INTO Customer_T VALUES(1013,13454,'Allie Schadoff','200-04-30','F','Middletown','NY','10940');
INSERT INTO Customer_T VALUES(2010,23459,'Nick Daly','2004-09-29','M','New Paltz','NY','12561');
INSERT INTO Customer_T VALUES(2011,23459,'Erin Scott','2007-03-19','F','New Paltz','NY','12561');
INSERT INTO Customer_T VALUES(2012,23459,'Jazmine Reterina','1995-05-23','F','New Paltz','NY','12561');
INSERT INTO Customer_T VALUES(2013,23459,'Isabella Stoepel','2002-02-22','F','New Paltz','NY','12561');
INSERT INTO Customer_T VALUES(3010,34571,'Lori Schadoff','1980-01-17','M','Orlando','FL','32789');
INSERT INTO Customer_T VALUES(3011,34571,'Kristin Williams','1987-07-17','F','Orlando','FL','32789');
INSERT INTO Customer_T VALUES(3012,34571,'Brian Abbot','1990-04-11','M','Orlando','FL','32789');
INSERT INTO Customer_T VALUES(3013,34571,'Daniel Tosh','1993-01-12','M','Orlando','FL','32789');
INSERT INTO Customer_T VALUES(4010,71710,'John Nelson','1995-03-07','F','San Francisco','CA','94016');
INSERT INTO Customer_T VALUES(4011,71710,'Gaberial Valentine','2000-06-18','M','San Francisco','CA','94016');
INSERT INTO Customer_T VALUES(4012,71710,'Mike Henry','1993-02-11','M','San Francisco','CA','94016');
INSERT INTO Customer_T VALUES(4013,71710,'Abby Miller','1997-12-23','F','San Francisco','CA','94016');
-- Employee_T
INSERT INTO Employee_T VALUES(2806910,13454,'Erick Thompson','2019-09-21','Middletown','NY','10940');
INSERT INTO Employee_T VALUES(3206910,23459,'Sean Thompson','2017-04-01','New Paltz','NY','12561');
INSERT INTO Employee_T VALUES(2121789,34571,'Tom Smith','2010-01-30','Orlando','FL','32789');
INSERT INTO Employee_T VALUES(2572121,71710,'Sara Johnson','2015-11-11','San Francisco','CA','94016');
-- Order_T
INSERT INTO Order_T VALUES(10000,2806910,1010,'2021-11-01','11:31:33','D');
INSERT INTO Order_T VALUES(10001,2806910,1011,'2021-11-01','12:01:27','D');
INSERT INTO Order_T VALUES(10002,2806910,1012,'2021-11-01','14:59:03','D');
INSERT INTO Order_T VALUES(10003,2806910,1013,'2021-11-01','17:12:12','D');
-- Order_T
INSERT INTO Order_T VALUES(20000,3206910,2010,'2020-07-07','06:30:21','C');
INSERT INTO Order_T VALUES(20001,3206910,2011,'2020-07-07','07:35:09','C');
INSERT INTO Order_T VALUES(20002,3206910,2012,'2020-07-07','08:01:03','C');
INSERT INTO Order_T VALUES(20003,3206910,2013,'2020-07-07','09:03:58','C');
-- Order_T
INSERT INTO Order_T VALUES(30000,2121789,3010,'2019-03-07','11:11:37','M');
INSERT INTO Order_T VALUES(30001,2121789,3011,'2019-03-07','11:21:04','M');
INSERT INTO Order_T VALUES(30002,2572121,4010,'2019-03-07','11:59:11','M');
INSERT INTO Order_T VALUES(30003,2121789,4011,'2019-03-07','12:02:21','M');
-- Drive thru 
INSERT INTO Drivethru_T VALUES('11:27:33',10000,'11:31:33',Subtime('11:31:33','11:27:33'));
INSERT INTO Drivethru_T VALUES('11:27:33',10001,'12:01:27',Subtime('12:01:27','11:27:33'));
INSERT INTO Drivethru_T VALUES('11:27:33',10002,'12:01:27',subtime('12:01:27','11:27:33'));
INSERT INTO Drivethru_T VALUES('06:01:01',10003,'06:13:27',subtime('06:13:27','06:01:01'));
-- Cafe_T
INSERT INTO Cafe_T VALUES("Nick Daly",20000);
INSERT INTO Cafe_T VALUES("Erin Scott",20001);
INSERT INTO Cafe_T VALUES("Jazmine Reterina",20002);
INSERT INTO Cafe_T VALUES("Isabella Stoepel",20003);
-- Mobile_T
INSERT INTO Mobile_T VALUES('11:11:37',30000);
INSERT INTO Mobile_T VALUES('11:21:04',30001);
INSERT INTO Mobile_T VALUES('11:59:11',30002);
INSERT INTO Mobile_T VALUES('12:02:21',30003);
-- Receipt_T
INSERT INTO Receipt_T VALUES(5000000,10000,90000,3,12.72,'visa');
INSERT INTO Receipt_T VALUES(5000001,10001,90001,5,21.51,'mastercard');
INSERT INTO Receipt_T VALUES(5000002,20000,90002,1,5.27,'cash');
INSERT INTO Receipt_T VALUES(5000003,20001,90003,2,10.81,'cash');
-- Item_T
INSERT INTO Item_T VALUES(90000,'Tropical inspried pick me up',5.23);
INSERT INTO Item_T VALUES(90001,'Carmelized white chocolate with steamed milk',4.77);
INSERT INTO Item_T VALUES(90002,'Steamed apple juice with whip cream and carmel',3.11);
INSERT INTO Item_T VALUES(90003,'Smooth, frosty vanilla flavored luxury',2.23);
INSERT INTO Item_T VALUES(90004,null,7.12);
-- Shipment_T
INSERT INTO Shipment_T VALUES(70000000,'12-04-21');
INSERT INTO Shipment_T VALUES(70000001,'12-05-21');
INSERT INTO Shipment_T VALUES(70000002,'12-06-21');
INSERT INTO Shipment_T VALUES(70000003,'12-07-21');
-- Supplier_T
INSERT INTO Supplier_T VALUES(600000,'Bartlett');
INSERT INTO Supplier_T VALUES(600001,'Tuscon');
INSERT INTO Supplier_T VALUES(600002,'Bartlett');
INSERT INTO Supplier_T VALUES(600003,'Tuscon');
-- Item_Shipment_T
INSERT INTO Item_Shipment_T VALUES(90000,70000000);
INSERT INTO Item_Shipment_T VALUES(90001,70000001);
INSERT INTO Item_Shipment_T VALUES(90002,70000002);
INSERT INTO Item_Shipment_T VALUES(90003,70000003);
-- Shipment_Supplier_T
INSERT INTO Shipment_Supplier_T VALUES(70000000,600000);
INSERT INTO Shipment_Supplier_T VALUES(70000001,600001);
INSERT INTO Shipment_Supplier_T VALUES(70000002,600002);
INSERT INTO Shipment_Supplier_T VALUES(70000003,600003);
-- Inner Join
SELECT Starbucks_T.StoreNumber, CustomerNumber, customerName
FROM Starbucks_T INNER JOIN Customer_T ON
Starbucks_T.StoreNumber = Customer_T.StoreNumber
ORDER BY CustomerNumber;
-- Outer Join
SELECT Customer_T.CustomerNumber, CustomerName, OrderNumber
FROM Customer_T LEFT OUTER JOIN Order_T 
ON Customer_T.CustomerNumber = Order_T.CustomerNumber;
-- Outer Join #2
SELECT Item_T.ItemId, itemDescription, ReceiptNumber
FROM Item_T LEFT OUTER JOIN Receipt_T 
ON Item_T.ItemId = Receipt_T.ItemID;
-- Sub-query
SELECT CustomerName, CustomerCity, CustomerState, CustomerPostalCode
FROM Customer_T
WHERE Customer_T.CustomerNumber=
(SELECT Order_T.CustomerNumber
FROM Order_T 
WHERE OrderNumber= 10003);
-- Correlated sub-query Fixed
SELECT ReceiptNumber, PaymentMethod, TotalCost
FROM Receipt_T R
WHERE R.TotalCost > ALL
(SELECT TotalCost FROM Receipt_T RS 
WHERE RS.ReceiptNumber!=R.ReceiptNumber);
-- Join four tables
SELECT Customer_T.CustomerNumber, CustomerName, CustomerPostalCode, CustomerState, Order_T.OrderNumber, itemDescription, itemcost
FROM Customer_T, Order_T, Receipt_T,Item_T
WHERE (Order_T.CustomerNumber = Customer_T.CustomerNumber
AND Order_T.OrderNumber = Receipt_T.OrderNumber
AND Receipt_T.ItemID = Item_T.ItemID
AND ORDER_T.OrderNumber=10000);