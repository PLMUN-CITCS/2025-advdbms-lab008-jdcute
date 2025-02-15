-- Use the BookstoreDB Database
USE `BookstoreDB`;

-- Data Retrieval: Retrieve customer orders with book titles
SELECT `c`.`Name` AS `CustomerName`, `o`.`OrderDate`, `b`.`Title` AS `BookTitle`, `od`.`Quantity`
FROM `Customers` `c`
JOIN `Orders` `o` ON `c`.`CustomerID` = `o`.`CustomerID`
JOIN `OrderDetails` `od` ON `o`.`OrderID` = `od`.`OrderID`
JOIN `Books` `b` ON `od`.`ISBN` = `b`.`ISBN`;

-- Data Update: Update the price of a book and verify the update
UPDATE `Books` SET `Price` = 8.99 WHERE `ISBN` = '9781234567890';

-- Verify the update
SELECT * FROM `Books` WHERE `ISBN` = '9781234567890';

-- Data Deletion: Delete an order detail and verify
DELETE FROM `OrderDetails` WHERE `OrderID` = 1 AND `ISBN` = '9780321765723';

-- Verify deletion
SELECT * FROM `OrderDetails` WHERE `OrderID` = 1;

-- Books by Author: List books and their authors
SELECT `a`.`Name` AS `AuthorName`, `b`.`Title` AS `BookTitle`
FROM `Authors` `a`
JOIN `BookAuthors` `ba` ON `a`.`AuthorID` = `ba`.`AuthorID`
JOIN `Books` `b` ON `ba`.`ISBN` = `b`.`ISBN`;

-- Complex Query: Customers who ordered books by a specific author
SELECT `c`.`Name` AS `CustomerName`
FROM `Customers` `c`
JOIN `Orders` `o` ON `c`.`CustomerID` = `o`.`CustomerID`
JOIN `OrderDetails` `od` ON `o`.`OrderID` = `od`.`OrderID`
JOIN `Books` `b` ON `od`.`ISBN` = `b`.`ISBN`
JOIN `BookAuthors` `ba` ON `b`.`ISBN` = `ba`.`ISBN`
JOIN `Authors` `a` ON `ba`.`AuthorID` = `a`.`AuthorID`
WHERE `a`.`Name` = 'Douglas Adams'; -- Change author name as needed
