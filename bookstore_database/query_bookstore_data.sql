USE `BookstoreDB`;
   
   ```
   - Data Retrieval: Write a SELECT statement that joins the Customers, Orders, OrderDetails, and Books tables to retrieve information about customer orders, including customer names, order dates, and book titles.
   ```SQL
   SELECT `c`.`Name` AS `CustomerName`, `o`.`OrderDate`, `b`.`Title` AS `BookTitle`, `od`.`Quantity`
   FROM `Customers` `c`
   JOIN `Orders` `o` ON `c`.`CustomerID` = `o`.`CustomerID`
   JOIN `OrderDetails` `od` ON `o`.`OrderID` = `od`.`OrderID`
   JOIN `Books` `b` ON `od`.`ISBN` = `b`.`ISBN`;
   
   ```
   - Data Update: Write an UPDATE statement to change the price of one of the books. Then, write a SELECT statement to verify that the price has been updated.
   ```SQL
   UPDATE `Books` SET `Price` = 8.99 WHERE `ISBN` = '9781234567890';
   
   SELECT * FROM `Books` WHERE `ISBN` = '9781234567890';
   
   ```
   - Data Deletion: Write a DELETE statement to remove one of the order details. Then, write a SELECT statement to verify that the order detail has been deleted.
   ```SQL
   DELETE FROM `OrderDetails` WHERE `OrderID` = 1 AND `ISBN` = '9780321765723';
   
   SELECT * FROM `OrderDetails` WHERE `OrderID` = 1;
   
   ```
   - Books by Author: Write a query that joins Authors, BookAuthors, and Books to display a list of books and their authors.
   ```SQL
   SELECT `a`.`Name` AS `AuthorName`, `b`.`Title` AS `BookTitle`
   FROM `Authors` `a`
   JOIN `BookAuthors` `ba` ON `a`.`AuthorID` = `ba`.`AuthorID`
   JOIN `Books` `b` ON `ba`.`ISBN` = `b`.`ISBN`;
   
   ```
   - Complex Query: Write a more complex query that retrieves information based on multiple criteria. For example, find customers who have ordered books by a specific author.
   ```SQL
   SELECT `c`.`Name` AS `CustomerName`
   FROM `Customers` `c`
   JOIN `Orders` `o` ON `c`.`CustomerID` = `o`.`CustomerID`
   JOIN `OrderDetails` `od` ON `o`.`OrderID` = `od`.`OrderID`
   JOIN `Books` `b` ON `od`.`ISBN` = `b`.`ISBN`
   JOIN `BookAuthors` `ba` ON `b`.`ISBN` = `ba`.`ISBN`
   JOIN `Authors` `a` ON `ba`.`AuthorID` = `a`.`AuthorID`
   WHERE `a`.`Name` = 'Douglas Adams'; -- Change author name as needed