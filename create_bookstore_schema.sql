-- Create Database
CREATE DATABASE IF NOT EXISTS BookstoreDB;
USE BookstoreDB;

-- Create Books Table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

-- Create Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

-- Create BookAuthors Table (Many-to-Many Relationship)
CREATE TABLE BookAuthors (
    ISBN VARCHAR(20),
    AuthorID INT,
    PRIMARY KEY (ISBN, AuthorID),
    FOREIGN KEY (ISBN) REFERENCES Books`(ISBN`) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors`(AuthorID`) ON DELETE CASCADE
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers`(CustomerID`) ON DELETE CASCADE
);

-- Create OrderDetails Table (Order Items)
CREATE TABLE OrderDetails (
    OrderID INT,
    ISBN VARCHAR(20),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PRIMARY KEY (OrderID, ISBN),
    FOREIGN KEY (OrderID) REFERENCES Orders`(OrderID`) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Books`(ISBN`) ON DELETE CASCADE
);