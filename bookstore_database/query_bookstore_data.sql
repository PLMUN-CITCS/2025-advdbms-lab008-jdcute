USE BookstoreDB;

-- Data Retrieval: Join Customers, Orders, OrderDetails, and Books
SELECT c.`Name` AS CustomerName, o.`OrderDate`, b.`Title` AS BookTitle, od.`Quantity`
FROM Customers
c
JOIN Orders
o ON c.`CustomerID` = o.`CustomerID`
JOIN OrderDetails
od ON o.`OrderID` = od.`OrderID`
JOIN Books
b ON od.`ISBN` = b.`ISBN`;

-- Data Update: Change the price of a book
UPDATE Books SET Price = 8.99 WHERE ISBN = '9781234567890';

-- Verify the price update
SELECT * FROM Books WHERE ISBN = '9781234567890';

-- Data Deletion: Remove an order detail
DELETE FROM OrderDetails WHERE OrderID = 1 AND ISBN = '9780321765723';

-- Verify the deletion
SELECT * FROM OrderDetails WHERE OrderID = 1;

-- Books by Author: Join Authors, BookAuthors, and Books
SELECT a.`Name` AS AuthorName, b.`Title` AS BookTitle
FROM Authors
a
JOIN BookAuthors
ba ON a.`AuthorID` = ba.`AuthorID`
JOIN Books
b ON ba.`ISBN` = b.`ISBN`;

-- Complex Query: Customers who ordered books by a specific author
SELECT c.`Name` AS CustomerName
FROM Customers
c
JOIN Orders
o ON c.`CustomerID` = o.`CustomerID`
JOIN OrderDetails
od ON o.`OrderID` = od.`OrderID`
JOIN Books
b ON od.`ISBN` = b.`ISBN`
JOIN BookAuthors
ba ON b.`ISBN` = ba.`ISBN`
JOIN Authors
a ON ba.`AuthorID` = a.`AuthorID`
WHERE a.`Name` = 'Douglas Adams'; -- Change author name as needed