CREATE DATABASE `BookstoreDB`;
   
   ```
   - Use Database: Write the SQL command to select the BookstoreDB database for use.
   ```SQL
   USE `BookstoreDB`;
   
   ```
   - Create Tables: For each entity (Books, Authors, BookAuthors, Customers, Orders, OrderDetails), write a CREATE TABLE statement. 
      - Define appropriate data types for each attribute.
      - Declare primary keys for each table. Use AUTO_INCREMENT for IDs where appropriate (Authors, Customers, Orders).
      - For the BookAuthors table, create a composite primary key using both ISBN and AuthorID.
      - Define foreign key constraints to enforce referential integrity. For example, in the Orders table, the CustomerID should be a foreign key referencing the Customers table's CustomerID. Do this for all appropriate relationships. The BookAuthors table will have two foreign keys.
   ```SQL
   -- Books Table [cite: 11]
   CREATE TABLE `Books` (
      `ISBN` VARCHAR(20) PRIMARY KEY,
      `Title` VARCHAR(255) NOT NULL,
      `Price` DECIMAL(10,2) NOT NULL
   );

   -- Authors Table [cite: 11]
   CREATE TABLE `Authors` (
      `AuthorID` INT PRIMARY KEY,
      `Name` VARCHAR(255) NOT NULL
   );

   -- BookAuthors Table (Associative Entity) [cite: 11]
   CREATE TABLE `BookAuthors` (
      `ISBN` VARCHAR(20),
      `AuthorID` INT,
      PRIMARY KEY (`ISBN`, `AuthorID`),
      FOREIGN KEY (`ISBN`) REFERENCES `Books`(`ISBN`),
      FOREIGN KEY (`AuthorID`) REFERENCES `Authors`(`AuthorID`)
   );

   -- Customers Table [cite: 11]
   CREATE TABLE `Customers` (
      `CustomerID` INT PRIMARY KEY,
      `Name` VARCHAR(255) NOT NULL,
      `Email` VARCHAR(255) NOT NULL
   );

   -- Orders Table [cite: 11]
   CREATE TABLE `Orders` (
      `OrderID` INT PRIMARY KEY,
      `CustomerID` INT,
      `OrderDate` DATE NOT NULL,
      FOREIGN KEY (`CustomerID`) REFERENCES `Customers`(`CustomerID`)
   );

   -- OrderDetails Table [cite: 11]
   CREATE TABLE `OrderDetails` (
      `OrderID` INT,
      `ISBN` VARCHAR(20),
      `Quantity` INT NOT NULL,
      PRIMARY KEY (`OrderID`, `ISBN`),
      FOREIGN KEY (`OrderID`) REFERENCES `Orders`(`OrderID`),
      FOREIGN KEY (`ISBN`) REFERENCES `Books`(`ISBN`)
   );