-- Создание базы данных

CREATE DATABASE TestTask_ICS_IT ON
(NAME = MyCustomDatabase_dat,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TestTask_ICS_IT.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = Sales_log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TestTask_ICS_IT.ldf',
    SIZE = 5 MB,
    MAXSIZE = 25 MB,
    FILEGROWTH = 5 MB);
GO  

-- Переключаемся на нашу БД и создаём таблицы

USE TestTask_ICS_IT;

CREATE TABLE dbo.SKU (
	ID_SKU INTEGER IDENTITY(1,1) NOT NULL,
	Code AS ('s' + ID_SKU) UNIQUE,
	Name NVARCHAR(30),
	CONSTRAINT PK_SKU PRIMARY KEY(ID_SKU)
);


CREATE TABLE dbo.Family (
	ID_Family INTEGER IDENTITY(1,1) NOT NULL,
	SurName NVARCHAR(30),
	BudgetValue MONEY,
	CONSTRAINT PK_Family PRIMARY KEY(ID_Family)
);


CREATE TABLE dbo.Basket (
	ID_Basket INTEGER IDENTITY(1,1) NOT NULL,
	ID_SKU INTEGER NOT NULL,
	ID_Family INTEGER NOT NULL,
	Quantity SMALLINT DEFAULT 0,
	"Value" INTEGER DEFAULT 0,
	PurchaseDate DATETIME DEFAULT CURRENT_TIMESTAMP,
	DiscountValue INTEGER DEFAULT 0,
	CONSTRAINT PK_Basket PRIMARY KEY(ID_Basket),
	CONSTRAINT FK_Basket_SKU FOREIGN KEY(ID_SKU) REFERENCES dbo.SKU(ID_SKU),
	CONSTRAINT FK_Basket_Family FOREIGN KEY(ID_Family) REFERENCES dbo.Family(ID_Family),
	CONSTRAINT CHK_Basket_Quantity CHECK(Quantity >= 0),
	CONSTRAINT CHK_Basket_Value CHECK("Value" >= 0)
);