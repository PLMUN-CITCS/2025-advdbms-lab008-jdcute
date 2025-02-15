USE BookstoreDB;

-- Retrieve Customer Orders with Book Details
SELECT 
    c.Name AS CustomerName, 
    o.OrderDate, 
    b.Title AS BookTitle, 
    od.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Books b ON od.ISBN = b.ISBN;

-- Update Book Price and Verify
UPDATE Books 
SET Price = 8.99 
WHERE ISBN = '9781234567890';

SELECT * FROM Books WHERE ISBN = '9781234567890';

-- Delete an Order Detail and Verify
DELETE FROM OrderDetails 
WHERE OrderID = 1 AND ISBN = '9780321765723';

SELECT * FROM OrderDetails WHERE OrderID = 1;

-- List Books and Their Authors
SELECT 
    a.Name AS AuthorName, 
    b.Title AS BookTitle
FROM Authors a
JOIN BookAuthors ba ON a.AuthorID = ba.AuthorID
JOIN Books b ON ba.ISBN = b.ISBN;

-- Find Customers Who Ordered Books by a Specific Author
SELECT 
    c.Name AS CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Books b ON od.ISBN = b.ISBN
JOIN BookAuthors ba ON b.ISBN = ba.ISBN
JOIN Authors a ON ba.AuthorID = a.AuthorID
WHERE a.Name = 'Douglas Adams';