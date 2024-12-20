/*
CHRISTABEL DANQUAH
17:e November, 2023
*/

--1. V�lj en anv�ndare via sitt namn och visa all hans kontaktinformation
SELECT  
	CONCAT(c.FirstName, ' ' ,c.LastName) AS Users,
	CONCAT(c.PhoneCountryCode, c.PhoneNumber) AS Phonenumber,
	c.Email,
	a.StreetName,
	a.City,
	a.ZipCode,
	a.Country
FROM Addresses AS a
INNER JOIN ContactDetails AS c ON c.CustomerID = a.CustomerID
WHERE c.FirstName = 'John' AND c.LastName = 'Kwakye'
GO

--ELLER----ELLER----ELLER--
--ELLER----ELLER----ELLER--

SELECT  
	CONCAT(c.FirstName, ' ' ,c.LastName) AS Users,
	CONCAT(c.PhoneCountryCode, c.PhoneNumber) AS Phonenumber,
	c.Email,
	a.StreetName,
	a.City,
	a.ZipCode,
	a.Country
FROM Addresses AS a
INNER JOIN ContactDetails AS c ON c.CustomerID = a.CustomerID
WHERE CONCAT(c.FirstName, ' ' ,c.LastName) = 'John Kwakye'
GO


--2. Vilken anv�ndare har spenderat mest pengar?
SELECT TOP 1
		CONCAT(c.FirstName, ' ' ,c.LastName) AS Users,
		o.OrderAmount
FROM Orders AS o
INNER JOIN ContactDetails AS c ON c.CustomerID = o.CustomerID
ORDER BY o.OrderAmount DESC
GO


--3. V�lj alla anv�ndare fr�n ett viss land och visa alla deras best�llningar
SELECT
	a.Country,
	CONCAT(c.FirstName, ' ' ,c.LastName) AS Users,
	o.OrderID,
	o.OrderDate,
	o.OrderAmount
FROM Orders AS o
INNER JOIN ContactDetails AS c ON c.CustomerID = o.CustomerID
INNER JOIN Addresses AS a ON a.AddressID = o.AddressID
WHERE a.Country = 'Norway'
GO

--ELLER----ELLER----ELLER--
--ELLER----ELLER----ELLER--

CREATE PROCEDURE AllOrdersByCountry
@Country NVARCHAR(50)
AS
BEGIN
	SELECT
		a.Country,
		CONCAT(c.FirstName, ' ' ,c.LastName) AS Users,
		o.OrderID,
		o.OrderDate,
		o.OrderAmount
	FROM Orders AS o
	INNER JOIN ContactDetails AS c ON c.CustomerID = o.CustomerID
	INNER JOIN Addresses AS a ON a.AddressID = o.AddressID
	WHERE a.Country = @Country
END

	EXEC AllOrdersByCountry @Country = 'Norway'
	EXEC AllOrdersByCountry 'Sweden'
	EXEC AllOrdersByCountry 'Finland'
GO

--4. Vilken �r den dyraste produkten i butiken?
SELECT TOP 1
	ProductName,
	ProductPrice
FROM Product
ORDER BY ProductPrice DESC
GO


--5. Hur m�nga produkter finns det totalt i butiken?

/*Jag vet ej om du menar att alla produkter butiken har
i stock eller hur m�nga specifika produkter vi har i butiken
Jag skapar syntaxer f�r b�da
*/

--Produkter butiken har i stock
SELECT 
	SUM(TotalStockQuantity) AS TotalStockQuantity
FROM Quantity
GO

--Specifika produkter butiken har
SELECT
	COUNT(ProductID) AS TotalProducts
FROM Product
GO

--6. Hur mycket �r det totala v�rdet (sek) av samtliga produkter?
SELECT
	CONCAT(SUM(p.ProductPrice), ' ' ,'sek') AS TotalPriceAmount
FROM Product AS p
GO


--7. Skapa en syntax som anv�nder GROUP BY
SELECT 
	a.Country,
	COUNT(c.CustomerID) AS Users
FROM ContactDetails AS c
INNER JOIN Addresses AS a ON a.CustomerID = c.CustomerID
GROUP BY a.Country
GO


--8. Skapa syntaxer som anv�nder MIN, MAX, SUM & AVG
--MIN
SELECT 
	MIN(OrderAmount) AS MinimumAmount
FROM Orders
GO

--MAX
SELECT 
	MAX(OrderAmount) AS MaximumAmount
FROM Orders
GO

--SUM
SELECT 
	SUM(OrderAmount) AS TotalAmount
FROM Orders
GO

--AVG
SELECT 
	AVG(ProductPrice) AS AverageAmount
FROM Product
GO


--9. Skapa syntaxer som sortera resultatet
SELECT 
	a.Country,
	a.CustomerID
FROM Addresses AS a
ORDER BY a.Country --- sorterade l�nderna alfabetisk ASC
GO

--ELLER----ELLER----ELLER--
--ELLER----ELLER----ELLER--

SELECT * 
FROM Product
ORDER BY ProductPrice DESC ---sorterade produkterna fr�n dyraste till billigaste
GO


--(VG)
--10. Skapa en syntax som anv�nder variabler
DECLARE @Country NVARCHAR(50)
SET @Country = 'Sweden'
SELECT 
	CONCAT(c.FirstName, ' ' ,c.LastName) AS Users,
	a.StreetName,
	a.City,
	a.Country,
	a.ZipCode
FROM Addresses AS a
INNER JOIN ContactDetails AS c ON c.CustomerID = a.CustomerID
WHERE Country = @Country
GO


--11. Skapa minst 1 stored procedure
CREATE PROCEDURE CurrencyPerCountry
@Country NVARCHAR(50),
@Currency NVARCHAR(5)
AS
BEGIN
	SELECT
		CONCAT(c.FirstName, ' ' ,c.LastName) AS Users,
		a.Country,
		o.OrderID,
		o.OrderDate,
		CONCAT(o.OrderAmount, ' ' , @Currency) AS OrderAmount
	FROM Orders AS o
	INNER JOIN ContactDetails AS c ON c.CustomerID = o.CustomerID
	INNER JOIN Addresses AS a ON a.AddressID = o.AddressID
	WHERE a.Country = @Country
END

	EXEC CurrencyPerCountry 'Sweden', SEK
	EXEC CurrencyPerCountry 'Norway', NOK
	EXEC CurrencyPerCountry 'Finland', EUR
GO

--12. Skapa en syntax som anv�nder IF
DECLARE @Rating INT;
	SELECT @Rating = RatingStars
	FROM Review 
	WHERE ReviewID = 78068;

IF @Rating >= 3
BEGIN
    PRINT 'A GOOD RATING.'
END
ELSE
BEGIN
    PRINT 'A BAD RATING.'
END
GO


--13. Skapa minst 2 SQL views
--1
CREATE VIEW USERS
AS
SELECT
	CONCAT(c.FirstName, ' ' ,c.LastName) AS Fullname,
	CONCAT(c.PhoneCountryCode, c.PhoneNumber) AS Phonenumber,
	c.Email,
	c.DateOfBirth
FROM ContactDetails AS c
GO

--2
CREATE VIEW PRODUCTS
AS
SELECT
	p.ProductID,
	p.ProductName,
	p.ProductPrice,
	q.TotalStockQuantity
FROM Product AS p
INNER JOIN Quantity AS q ON q.ProductID = p.ProductID
GO


--14. Skapa minst 1 syntax som inneh�ller en sub query
SELECT ProductName, ProductPrice
FROM Product 
WHERE ProductPrice < (
  SELECT AVG(ProductPrice) 
  FROM Product
);
GO


--15. Skapa minst 1 Index
CREATE INDEX USERS_idx
ON ContactDetails(FirstName);
GO