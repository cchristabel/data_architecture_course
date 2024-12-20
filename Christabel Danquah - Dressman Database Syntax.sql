CREATE DATABASE DRESSMAN
GO

USE DRESSMAN
GO

/*
Creating the table ContactDetails which will be the Parent Table
*/
CREATE TABLE ContactDetails
(
CustomerID INT IDENTITY(1000,1000) PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Gender NVARCHAR(7) NOT NULL,
DateOfBirth DATE NOT NULL,
PhoneCountryCode NVARCHAR(5) NOT NULL,
PhoneNumber NVARCHAR(20) NOT NULL,
Email NVARCHAR(100) NOT NULL
);
GO

/*
Creating CreateAccount table 
*/
CREATE TABLE CreateAccount
(
UserID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT NOT NULL,
	CONSTRAINT FK_CreateAccount_ContactDetails 
	FOREIGN KEY (CustomerID) 
	REFERENCES ContactDetails(CustomerID),
	CONSTRAINT UQ_CustomerID UNIQUE(CustomerID),
Passwords NVARCHAR(20) NOT NULL
);
GO

/*
Creating Address table 
*/
CREATE TABLE Addresses
(
AddressID INT IDENTITY(100,1) PRIMARY KEY,
CustomerID INT NOT NULL,
	CONSTRAINT FK_Addresses_ContactDetails 
	FOREIGN KEY (CustomerID) 
	REFERENCES ContactDetails(CustomerID),
StreetName NVARCHAR(50) NOT NULL,
City NVARCHAR(50) NOT NULL,
ZipCode NVARCHAR(10) NOT NULL,
Country NVARCHAR(50) NOT NULL,
IsDefaultAddress BIT NOT NULL
);
GO

/*
Creating Category table
*/
CREATE TABLE Category 
(
CategoryID INT IDENTITY(467,100) PRIMARY KEY,
CategoryName NVARCHAR(50) NOT NULL
);
GO

/*
Creating Product table 
*/
CREATE TABLE Product 
(
ProductID INT IDENTITY(136678,1076) PRIMARY KEY,
ProductName  NVARCHAR (50) NOT NULL,
ProductDescription NVARCHAR(100) NOT NULL,
ProductColour NVARCHAR(30) NOT NULL,
ProductPrice MONEY NOT NULL
);
GO

/*
Creating ProductCategory table
*/
CREATE TABLE ProductCategory 
(
ProductCategoryId INT  IDENTITY(10,1) PRIMARY KEY ,
CategoryID INT NOT NULL,
	CONSTRAINT FK_ProductCategory_Category 
	FOREIGN KEY (CategoryID) 
	REFERENCES Category(CategoryID),
ProductID INT NOT NULL
	CONSTRAINT FK_ProductCategory_Product 
	FOREIGN KEY (ProductID) 
	REFERENCES Product(ProductID),
);
GO

/*
Creating Picture table 
*/
CREATE TABLE Picture
(
PictureID INT IDENTITY(467,111) PRIMARY KEY,
ProductID  INT NOT NULL,
	CONSTRAINT FK_Picture_Product 
	FOREIGN KEY (ProductID) 
	REFERENCES Product(ProductID),
PictureURL NVARCHAR(100)  NOT NULL
);
GO

/*
Creating Orders table 
*/
CREATE TABLE Orders
(
OrderID INT IDENTITY(43567,2134) PRIMARY KEY,
CustomerID INT NOT NULL,
	CONSTRAINT FK_Orders_ContactDetails
	FOREIGN KEY (CustomerID)
	REFERENCES ContactDetails(CustomerID),
AddressID INT NOT NULL,
	CONSTRAINT FK_Orders_Addresses
	FOREIGN KEY (AddressID)
	REFERENCES Addresses(AddressID),
OrderAmount MONEY NOT NULL,
OrderDate DATE NOT NULL
);
GO

/*
Creating OrdersProduct table 
*/
CREATE TABLE OrdersProduct
(
OrderProductID INT IDENTITY(87,10) PRIMARY KEY,
ProductID INT NOT NULL,
	CONSTRAINT FK_OrdersProduct_Product
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID),
OrderID INT NOT NULL,
	CONSTRAINT FK_OrdersProduct_Orders
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID)
);
GO

/*
Creating OrderStatus table 
*/
CREATE TABLE OrderStatus
(
OrderStatusID INT IDENTITY(1234,500) PRIMARY KEY,
OrderID INT NOT NULL,
	CONSTRAINT FK_OrderStatus_Orders
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),
OStatus NVARCHAR(25) NOT NULL,
StatusDate DATE NOT NULL
);
GO

/*
Creating PaymentMethod table 
*/
CREATE TABLE PaymentMethod
(
PaymentMethodID INT IDENTITY(23456,333) PRIMARY KEY,
OrderID INT NOT NULL,
	CONSTRAINT FK_PaymentMethod_Orders
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),
PaymentType NVARCHAR(20) NOT NULL,
IsDefaultPaymentMethod BIT NOT NULL
);
GO

/*
Creating CardPayment table 
*/
CREATE TABLE CardPayment
(
CardID INT IDENTITY(163,111) PRIMARY KEY,
PaymentMethodID INT NOT NULL,
CONSTRAINT FK_CardPayment_PaymentMethod 
	FOREIGN KEY (PaymentMethodID) 
	REFERENCES PaymentMethod(PaymentMethodID),
CardHolderName NVARCHAR(100) NOT NULL,
CardType NVARCHAR(20) NOT NULL,
CardNumber NVARCHAR(20) NOT NULL,
ExpiryMonth TINYINT NOT NULL,
ExpiryYear SMALLINT NOT NULL,
CVCorCVV INT NOT NULL
);
GO

/*
Creating ShoppingCart table 
*/
CREATE TABLE ShoppingCart
(
CartID INT IDENTITY(226,100) PRIMARY KEY,
CustomerID INT NOT NULL,
	CONSTRAINT FK_ShoppingCart_ContactDetails
	FOREIGN KEY (CustomerID)
	REFERENCES ContactDetails(CustomerID),
	CONSTRAINT UQ_CustomerID2 UNIQUE(CustomerID),
Quantity INT NOT NULL
);
GO

/*
Creating ShoppingcartProduct table 
*/
CREATE TABLE ShoppingcartProduct
(
CartProductID INT IDENTITY(211,11) PRIMARY KEY,
ProductID INT NOT NULL,
	CONSTRAINT FK_ShoppingcartProduct_Product
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID),
CartID INT NOT NULL,
	CONSTRAINT FK_ShoppingcartProduct_ShoppingCart
	FOREIGN KEY (CartID)
	REFERENCES ShoppingCart(CartID)
);
GO

/*
Creating Quantity table 
*/
CREATE TABLE Quantity
(
QuantityID INT IDENTITY(43265,111) PRIMARY KEY,
ProductID INT NOT NULL,
	CONSTRAINT FK_Quantity_Product
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID),
	CONSTRAINT UQ_ProductID UNIQUE(ProductID),
XXSMALL INT,
XSmall INT,
Small INT,
Meduim INT,
Large INT,
XLarge INT,
XXLarge INT,
TotalStockQuantity INT NOT NULL
);
GO

/*
Creating Review table 
*/
CREATE TABLE Review
(
ReviewID INT IDENTITY(76343,345) PRIMARY KEY,
CustomerID INT NOT NULL,
	CONSTRAINT FK_Review_ContactDetails
	FOREIGN KEY (CustomerID)
	REFERENCES ContactDetails(CustomerID),
ProductID INT NOT NULL,
	CONSTRAINT FK_Review_Product
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID),
RatingStars INT NOT NULL,
ReviewMessage NVARCHAR(200),
ReviewDate DATE NOT NULL
);
GO

/*
Creating Promotions table 
*/
CREATE TABLE Promotions 
(
PromotionID INT IDENTITY(763,100) PRIMARY KEY,
PromotionCode NVARCHAR(10) NOT NULL UNIQUE,
PDescription VARCHAR(200),
DiscountType NVARCHAR(20) NOT NULL,
DiscountValue INT NOT NULL,
MinimumPurchaseAmount MONEY,
StartDate DATE,
EndDate DATE,
IsActive BIT NOT NULL
);
GO

/*
Creating ProductPromotion table 
*/
CREATE TABLE ProductPromotion
(
ProductPromotion INT IDENTITY(1111,1032) PRIMARY KEY,
PromotionID INT NOT NULL,
	CONSTRAINT FK_ProductPromotion_Promotions
	FOREIGN KEY (PromotionID)
	REFERENCES Promotions(PromotionID),
ProductID INT NOT NULL,
	CONSTRAINT FK_ProductPromotion_Product
	FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID)
);
GO

/*
Creating ReturnOrRefundRequest table 
*/
CREATE TABLE ReturnOrRefundRequest
(
RequestID INT IDENTITY(333,70) PRIMARY KEY,
OrderID INT NOT NULL,
	CONSTRAINT FK_ReturnOrRefundRequest_Orders
	FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),
RequestType NVARCHAR(15) NOT NULL,
RequestDate DATE NOT NULL,
RequestStatus NVARCHAR(25) NOT NULL
);
GO

--------------------------------------------------------------------------
/*INSERTING DATA INTO THE TABLES*/
--------------------------------------------------------------------------
/*INSERTING DATA INTO THE TABLES*/
--------------------------------------------------------------------------
/*INSERTING DATA INTO THE TABLES*/
--------------------------------------------------------------------------
/*INSERTING DATA INTO THE TABLES*/
--------------------------------------------------------------------------

-- Inserting data for ContactDetails table
INSERT INTO ContactDetails (FirstName, LastName, Gender, DateOfBirth, PhoneCountryCode, PhoneNumber, Email)
VALUES
    ('John', 'Kwakye', 'Male', '1990-05-15', '+46', '123456789', 'john.kwakye@email.com'),
    ('Mercy', 'Larsson', 'Female', '1985-09-20', '+47', '987654321', 'mercy.larsson@email.com'),
    ('Michael', 'Dapaa', 'Male', '1987-12-10', '+46', '444555666', 'michael.d@email.com'),
    ('Emma', 'Blomberg', 'Female', '1995-03-25', '+46', '777888999', 'emma.b@email.com'),
    ('David', 'Wilsson', 'Male', '1982-08-03', '+47', '111222333', 'david.w@email.com'),
    ('Sophia', 'Koskinen', 'Female', '1991-04-19', '+46', '333444555', 'sophia.koskinen@email.com'),
    ('Christopher', 'Leidstedt', 'Male', '1999-11-30', '+46', '222333444', 'christopher.l@email.com'),
    ('Olivia', 'Martinez', 'Female', '1993-07-27', '+47', '666777888', 'olivia.m@email.com'),
    ('Daniel', 'Atetekumbo', 'Male', '1988-02-14', '+46', '999000111', 'daniel.atetekumbo@email.com'),
    ('Eva', 'Bergkvist', 'Female', '1997-06-22', '+46', '555666777', 'evabergkvist@email.com'),
    ('Liam', 'Johansson', 'Male', '1993-09-10', '+47', '333444555', 'liam.j@email.com'),
    ('Olivia', 'Williamsson', 'Female', '1990-01-25', '+46', '123123123', 'olivia.w@email.com'),
    ('James', 'Dapaa', 'Male', '1985-11-05', '+46', '555555555', 'james.d@email.com'),
    ('Isabella', 'Andersson', 'Female', '1998-03-15', '+46', '987987987', 'isabella.a@email.com'),
    ('Ethan', 'Wilsson', 'Male', '1992-06-30', '+47', '111999888', 'ethan.w@email.com');
GO

-- Inserting data for CreateAccount table
INSERT INTO CreateAccount (CustomerID, Passwords)
VALUES
    (1000, 'bedvndhe1'),
    (2000, 'bjfbhjbf2'),
    (3000, 'nvfkgjrg3'),
    (4000, 'ifnfgdkf4'),
    (5000, 'ddfbjbmdf5'),
    (6000, 'password6'),
    (7000, 'vdgiwnng7'),
    (8000, 'dfvjggbv8'),
    (9000, 'befgebbd9'),
    (10000, '!,vnjgbggb10'),
    (11000, 'ydnvfckscndc11'),
    (12000, 'jhcatcb#12'),
    (13000, 'wordpass#13'),
    (14000, 'ssapdwor=14'),
    (15000, 'chccbhgss15');
GO

-- Inserting data for Addresses table
INSERT INTO Addresses (CustomerID, StreetName, City, ZipCode, Country, IsDefaultAddress)
VALUES
    (1000, 'Lovisgatan 5', 'Stockholm', '12345', 'Sweden', 1),
    (2000, 'Markens gate 5', 'Oslo', '67890', 'Norway', 0),
	(2000, 'Strandgaten 8', 'Oslo', '09864', 'Norway', 1),
    (3000, 'Mannerheimintie 43', 'Helsinki', '00123', 'Finland', 1),
	(3000, 'Peninsula 37', 'Helsinki', '13653', 'Finland', 0),
    (4000, 'Strandgatan 65', 'Stockholm', '12345', 'Sweden', 0),
    (5000, 'Strandpromenaden 7', 'Oslo', '67890', 'Norway', 1),
    (6000, 'Kanavakatu 87', 'Helsinki', '00123', 'Finland', 0),
    (7000, 'Huddingevägen 5', 'Stockholm', '12345', 'Sweden', 1),
	(7000, 'Fjärilstigen 27', 'Stockholm', '14753', 'Sweden', 0),
    (8000, 'Bergstein 10', 'Oslo', '67890', 'Norway', 0),
    (9000, 'Vyokatu 53', 'Helsinki', '00123', 'Finland', 1),
    (10000, 'Stockholmsgatan 9', 'Stockholm', '12345', 'Sweden', 0),
    (11000, 'Badeparken 66', 'Oslo', '67890', 'Norway', 1),
    (12000, 'Huvilakata 20', 'Helsinki', '00123', 'Finland', 0),
    (13000, 'Nygatan 90', 'Stockholm', '12345', 'Sweden', 1),
    (14000, 'Feyers gate 11', 'Oslo', '67890', 'Norway', 0),
    (15000, 'Tehtaankatu 99', 'Helsinki', '00123', 'Finland', 1);
GO

-- Inserting data for Category table
INSERT INTO Category (CategoryName)
VALUES
    ('Suits'),
    ('Shirts'),
    ('Blazers'),
    ('Trousers'),
    ('Accessories'),
    ('Outlet'),
    ('Underwear'),
    ('Casual Wear'),
    ('Sportswear'),
    ('Outerwear'),
    ('Shoes');
GO

-- Inserting data for Product table
INSERT INTO Product (ProductName, ProductDescription, ProductColour, ProductPrice)
VALUES
    ('Business Suit', 'Classic black suit', 'Black', 299.99),
    ('White Dress Shirt', 'Formal white shirt', 'White', 49.99),
    ('Navy Blue Blazer', 'Elegant blazer', 'Navy Blue', 139.99),
    ('Slim-Fit Trousers', 'Black dress pants', 'Black', 79.99),
    ('Leather Belt', 'Brown leather belt', 'Brown', 29.99),
    ('Clearance Shirt', 'Discounted shirt', 'Various', 19.99),
    ('Cotton Boxers', 'Pack of 3 boxer shorts', 'Multicolor', 29.99),
    ('Hooded Sweatshirt', 'Casual hoodie', 'Gray', 59.99),
    ('Running Shoes', 'Lightweight running shoes', 'Blue', 89.99),
    ('Waterproof Jacket', 'Outdoor rain jacket', 'Green', 119.99),
    ('Formal Shoes', 'Classic leather shoes', 'Black', 99.99),
    ('Silk Tie', 'Elegant silk tie', 'Navy Blue', 39.99),
    ('Fedora Hat', 'Stylish fedora hat', 'Black', 24.99),
    ('Leather Belt', 'Classic leather belt', 'Brown', 34.99),
    ('Cotton Socks', 'Pack of 5 cotton socks', 'White', 14.99);
GO


-- Inserting data for ProductCategory table
INSERT INTO ProductCategory (CategoryID, ProductID)
VALUES
    (467, 136678),
    (567, 137754),
    (667, 138830),
    (767, 139906),
    (867, 140982),
    (967, 142058),
    (1067, 143134),
    (1167, 144210),
    (1267, 145286),
    (1367, 146362),
    (1467, 147438),
    (867, 148514),
    (867, 149590),
    (867, 150666),
	(967, 151742),
	(1467, 145286),
    (867, 151742);
GO

-- Inserting data for Picture table
INSERT INTO Picture (ProductID, PictureURL)
VALUES
    (136678, 'images/suit1.jpg'),
    (137754, 'images/shirt1.jpg'),
    (138830, 'images/blazer1.jpg'),
    (139906, 'images/trousers1.jpg'),
    (140982, 'images/belt1.jpg'),
    (142058, 'images/shirt2.jpg'),
    (143134, 'images/boxers1.jpg'),
    (144210, 'images/sweatshirt1.jpg'),
    (145286, 'images/shoes1.jpg'),
    (146362, 'images/jacket1.jpg'),
    (147438, 'images/shoes2.jpg'),
    (148514, 'images/tie1.jpg'),
    (149590, 'images/hat1.jpg'),
    (150666, 'images/belt2.jpg'),
    (151742, 'images/socks1.jpg');
GO

-- Inserting data for Orders table
INSERT INTO Orders (CustomerID, AddressID, OrderAmount, OrderDate)
VALUES
    (1000, 100, 599.98, '2023-01-15'),
    (2000, 101, 49.99, '2023-02-20'),
    (3000, 102, 139.99, '2023-03-10'),
    (4000, 103, 79.99, '2023-04-25'),
    (5000, 104, 29.99, '2023-05-03'),
    (6000, 105, 19.99, '2023-06-01'),
    (7000, 106, 29.99, '2023-07-30'),
    (8000, 107, 59.99, '2023-08-05'),
    (9000, 108, 89.99, '2023-09-22'),
    (10000, 109, 119.99, '2023-10-30'),
    (11000, 110, 99.99, '2023-11-14'),
    (12000, 111, 39.99, '2023-12-15'),
    (13000, 112, 24.99, '2023-12-20'),
    (14000, 113, 34.99, '2023-11-05'),
    (15000, 114, 134.98, '2023-11-15');
GO

-- Inserting data for OrdersProduct table
INSERT INTO OrdersProduct (ProductID, OrderID)
VALUES
    (136678, 43567),
	(136678, 43567),
    (137754, 45701),
    (138830, 47835),
    (139906, 49969),
    (140982, 52103),
    (142058, 54237),
    (143134, 56371),
    (144210, 58505),
    (145286, 60639),
    (146362, 62773),
    (147438, 64907),
    (148514, 67041),
    (149590, 69175),
    (150666, 71309),
    (151742, 73443),
	(146362, 73443);
GO

-- Inserting data for OrderStatus table
INSERT INTO OrderStatus (OrderID, OStatus, StatusDate)
VALUES
    (43567, 'Processing', '2023-01-10'),
	(43567, 'Out for Delivery', '2023-01-16'),
	(43567, 'Delivered', '2023-01-18'),
    (45701, 'Out for Delivery', '2023-02-21'),
    (47835, 'Delivered', '2023-03-11'),
    (49969, 'Processing', '2023-04-26'),
    (52103, 'Out for Delivery', '2023-05-04'),
    (54237, 'Delivered', '2023-06-02'),
    (56371, 'Processing', '2023-07-31'),
    (58505, 'Out for Delivery', '2023-08-06'),
	(58505, 'Delivered', '2023-08-07'),
    (60639, 'Delivered', '2023-09-23'),
    (62773, 'Processing', '2023-10-31'),
    (64907, 'Out for Delivery', '2023-11-15'),
    (67041, 'Delivered', '2023-12-16'),
    (69175, 'Processing', '2023-12-21'),
    (71309, 'Out for Delivery', '2023-11-06'),
    (73443, 'Delivered', '2023-11-16');
GO

-- Inserting data for PaymentMethod table
INSERT INTO PaymentMethod (OrderID, PaymentType, IsDefaultPaymentMethod)
VALUES
    (43567, 'Card', 1),
    (45701, 'Klarna', 0),
    (47835, 'Paypal', 1),
    (49969, 'Card', 0),
    (52103, 'Klarna', 1),
    (54237, 'Paypal', 0),
    (56371, 'Card', 1),
    (58505, 'Klarna', 0),
    (60639, 'Card', 1),
    (62773, 'Klarna', 0),
    (64907, 'Card', 1),
    (67041, 'Card', 0),
    (69175, 'Paypal', 1),
    (71309, 'Paypal', 0),
    (73443, 'Klarna', 1);
GO

-- Inserting data for CardPayment table
INSERT INTO CardPayment (PaymentMethodID, CardHolderName, CardType, CardNumber, ExpiryMonth, ExpiryYear, CVCorCVV)
VALUES
    (23456, 'John Kwakye', 'Visa', '1234 5678 9012 3456', 12, 2025, 123),
    (24455, 'Emma Blomberg', 'MasterCard', '5678 1234 9876 5432', 10, 2024, 456),
    (25454, 'Christopher Leidstedt', 'Visa', '9012 3456 1234 5678', 6, 2026, 789),
    (26120, 'Daniel Atetekumbo', 'MasterCard', '9876 5432 5678 1234', 9, 2023, 234),
    (26786, 'Liam Johansson', 'Visa', '1234 5678 9012 3456', 8, 2027, 567),
    (27119, 'Olivia Williamsson', 'MasterCard', '5678 1234 9876 5432', 11, 2024, 890);
GO

-- Inserting data for ShoppingCart table
INSERT INTO ShoppingCart (CustomerID, Quantity)
VALUES
    (1000, 3),
    (2000, 2),
    (3000, 1),
    (4000, 4),
    (10000, 5),
    (15000, 2),
    (6000, 6),
    (7000, 3),
    (11000, 1),
    (5000, 4),
    (8000, 2),
    (13000, 5),
    (9000, 3),
    (12000, 1),
    (14000, 6);
GO

-- Inserting data for ShoppingcartProduct table
INSERT INTO ShoppingcartProduct (ProductID, CartID)
VALUES
    (136678, 226),
    (137754, 326),
	(137754, 1126),
    (138830, 426),
    (139906, 526),
	(136678, 526),
    (140982, 626),
	(146362, 626),
    (142058, 726),
    (143134, 826),
    (144210, 926),
    (145286, 1026),
    (146362, 1126),
	(146362, 1626),
    (147438, 1226),
    (148514, 1326),
    (149590, 1426),
    (150666, 1526),
    (151742, 1626);
GO

-- Inserting data for Quantity table
INSERT INTO Quantity (ProductID, XXSMALL, XSmall, Small, Meduim, Large, XLarge, XXLarge, TotalStockQuantity)
VALUES
    (136678, 10, 20, 30, 40, 50, 60, 70, 280),
    (137754, 12, 22, 32, 42, 52, 62, 72, 292),
    (138830, 15, 25, 35, 45, 55, 65, 75, 310),
    (139906, 18, 28, 38, 48, 58, 68, 78, 328),
    (140982, 11, 21, 31, 41, 51, 61, 71, 286),
    (142058, 13, 23, 33, 43, 53, 63, 73, 298),
    (143134, 16, 26, 36, 46, 56, 66, 76, 316),
    (144210, 14, 24, 34, 44, 54, 64, 74, 304),
    (145286, 20, 30, 40, 50, 60, 70, 80, 320),
    (146362, 8, 18, 28, 38, 48, 58, 68, 272),
    (147438, 9, 19, 29, 39, 49, 59, 69, 282),
    (148514, 17, 27, 37, 47, 57, 67, 77, 314),
    (149590, 19, 29, 39, 49, 59, 69, 79, 330),
    (150666, 7, 17, 27, 37, 47, 57, 67, 274),
    (151742, 10, 20, 30, 40, 50, 60, 70, 280);
GO

-- Inserting data for Review table
INSERT INTO Review (CustomerID, ProductID, RatingStars, ReviewMessage, ReviewDate)
VALUES
    (1000, 136678, 5, 'Bra produkt!', '2023-01-20'),
    (2000, 137754, 4, 'Good quality.', '2023-02-25'),
    (3000, 138830, 3, 'Keskimääräinen tuote.', '2023-03-15'),
    (4000, 139906, 4, 'Jag är nöjd med köpet.', '2023-04-30'),
    (5000, 140982, 5, 'Amazing!', '2023-05-08'),
    (6000, 142058, 3, 'Ei paha.', '2023-06-06'),
    (7000, 143134, 4, 'Would recommend.', '2023-07-05'),
    (8000, 144210, 2, 'Could be better.', '2023-08-10'),
    (9000, 145286, 5, 'Sopii täydellisesti.', '2023-09-27'),
    (10000, 146362, 4, 'Fast delivery.', '2023-10-31'),
    (11000, 147438, 3, 'Anstendig produkt.', '2023-11-16'),
    (12000, 148514, 5, 'Excellent!', '2023-12-20'),
    (13000, 149590, 4, 'Bra valuta för pengarna.', '2023-12-25'),
    (14000, 150666, 2, 'Veldig skuffet over beltet.', '2023-11-10'),
    (15000, 151742, 3, 'Could improve.', '2023-11-20');
GO

-- Inserting data for Promotions table
INSERT INTO Promotions (PromotionCode, PDescription, DiscountType, DiscountValue, MinimumPurchaseAmount, StartDate, EndDate, IsActive)
VALUES
    ('PROMO10', '10% off on all products', 'Percentage', 10, 50.00, '2023-01-01', '2023-01-31', 1),
    ('PROMO20', '20% off for new customers', 'Percentage', 20, 75.00, '2023-02-01', '2023-02-28', 1),
    ('FREEDEL', 'Free shipping on orders over 100', 'Fixed', 0, 100.00, '2023-03-01', '2023-03-31', 1),
    ('PROMO15', '15% off on selected items', 'Percentage', 15, 60.00, '2023-04-01', '2023-04-30', 1),
    ('PROMO25', '25% off clearance items', 'Percentage', 25, 30.00, '2023-05-01', '2023-05-31', 1),
    ('FALLSALE', 'Fall season sale', 'Percentage', 20, 50.00, '2023-09-01', '2023-09-30', 1),
    ('XMAS2023', 'Christmas 2023 sale', 'Percentage', 15, 75.00, '2023-12-01', '2023-12-25', 1);
GO
    
-- Inserting data for ProductPromotion table
INSERT INTO ProductPromotion (PromotionID, ProductID)
VALUES
    (763, 136678),
    (863, 137754),
    (963, 138830),
    (1063, 139906),
    (1163, 140982),
    (1263, 142058),
    (1363, 143134),
    (763, 144210),
    (863, 145286),
    (963, 146362),
    (1063, 147438),
    (1163, 148514),
    (1263, 149590),
    (1363, 150666),
    (763, 151742);
GO

-- Inserting data for ReturnOrRefundRequest table
INSERT INTO ReturnOrRefundRequest (OrderID, RequestType, RequestDate, RequestStatus)
VALUES
    (71309, 'Return', '2023-01-21', 'Pending'),
    (58505, 'Refund', '2023-02-26', 'Processed'),
    (73443, 'Return', '2023-03-16', 'Approved'),
    (47835, 'Return', '2023-04-01', 'Pending');
GO

