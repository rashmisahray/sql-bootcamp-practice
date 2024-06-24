CREATE DATABASE books;
USE books;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100),
    BirthDate DATE,
    Nationality VARCHAR(50)
);

INSERT INTO Authors (AuthorID, AuthorName, BirthDate, Nationality)
VALUES
    (1, 'John Smith', '1970-01-01', 'American'),
    (2, 'Jane Doe', '1980-02-02', 'British'),
    (3, 'Bob Johnson', '1960-03-03', 'Canadian'),
    (4, 'Alice Brown', '1990-04-04', 'Australian');

CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

INSERT INTO Publishers (PublisherID, PublisherName, Address, Phone)
VALUES
    (1, 'Penguin Books', '123 Main St, New York', '212-123-4567'),
    (2, 'HarperCollins', '456 Broadway, New York', '212-789-0123'),
    (3, 'Random House', '789 Park Ave, New York', '212-345-6789'),
    (4, 'Simon & Schuster', '321 Lexington Ave, New York', '212-901-2345');

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublisherID INT,
    PublicationDate DATE,
    ISBN VARCHAR(20),
    Price DECIMAL(10, 2),
    Genre VARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

INSERT INTO Books (BookID, Title, AuthorID, PublisherID, PublicationDate, ISBN, Price, Genre)
VALUES
    (1, 'The Great Gatsby', 1, 1, '2010-01-01', '978-1234567890', 19.99, 'Fiction'),
    (2, 'To Kill a Mockingbird', 2, 2, '2012-02-02', '978-2345678901', 14.99, 'Fiction'),
    (3, 'The Catcher in the Rye', 3, 3, '2015-03-03', '978-3456789012', 12.99, 'Fiction'),
    (4, 'Pride and Prejudice', 4, 4, '2018-04-04', '978-4567890123', 16.99, 'Romance'),
    (5, 'The Hunger Games', 1, 1, '2019-05-05', '978-5678901234', 15.99, 'Science Fiction'),
    (6, 'The Da Vinci Code', 2, 2, '2020-06-06', '978-6789012345', 18.99, 'Mystery'),
    (7, 'The Lord of the Rings', 3, 3, '2021-07-07', '978-7890123456', 20.99, 'Fantasy'),
    (8, 'The Handmaid''s Tale', 4, 4, '2022-08-08', '978-8901234567', 17.99, 'Dystopian');

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY,
    BorrowerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

INSERT INTO Borrowers (BorrowerID, BorrowerName, Email, Phone)
VALUES
    (1, 'John Doe', 'johndoe@example.com', '212-123-4567'),
    (2, 'Jane Smith', 'janesmith@example.com', '212-789-0123'),
    (3, 'Bob Brown', 'bobbrown@example.com', '212-345-6789'),
    (4, 'Alice Johnson', 'alicejohnson@example.com', '212-901-2345');

CREATE TABLE BookCopies (
    BookCopyID INT PRIMARY KEY,
    BookID INT,
    CopyNumber INT,
    PurchaseDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

INSERT INTO BookCopies (BookCopyID, BookID, CopyNumber, PurchaseDate)
VALUES
    (1, 1, 1, '2010-01-01' ),
    (2, 1, 2, '2011-01-01'),
    (3, 2, 1, '2012-02-02' ),
    (4, 2, 2, '2013-02-02'),
    (5,3, 1, '2015-03-03'),
    (6, 3, 2, '2016-03-03' ),
    (7, 4, 1, '2018-04-04'),
    (8, 4, 2, '2019-04-04'),
    (9, 5, 1, '2019-05-05'),
    (10, 5, 2, '2020-05-05'),
    (11, 6, 1, '2020-06-06'),
    (12, 6, 2, '2021-06-06'),
    (13, 7, 1, '2021-07-07'),
    (14, 7, 2, '2022-07-07');

CREATE TABLE BookLoans (
    BookLoanID INT PRIMARY KEY,
    BookCopyID INT,
    BorrowerID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    LoanDuration INT,
    FOREIGN KEY (BookCopyID) REFERENCES BookCopies(BookCopyID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);

INSERT INTO BookLoans (BookLoanID, BookCopyID, BorrowerID, BorrowDate, ReturnDate, LoanDuration)
VALUES
    (1, 1, 1, '2022-01-01', '2022-01-31', 30),
    (2, 2, 2, '2022-02-01', '2022-02-28', 27),
    (3, 3, 3, '2022-03-01', '2022-03-31', 30),
    (4, 4, 4, '2022-04-01', '2022-04-30', 29),
    (5, 5, 1, '2022-05-01', '2022-05-31', 30),
    (6, 6, 2, '2022-06-01', '2022-06-30', 29),
    (7, 7, 3, '2022-07-01', '2022-07-31', 30),
    (8, 8, 4, '2022-08-01', '2022-08-31', 30);


-- TCL commands

START TRANSACTION;

-- Insert a new author
INSERT INTO Authors (AuthorID, AuthorName, BirthDate, Nationality)
VALUES (5, 'Mark Twain', '1835-11-30', 'American');

-- Commit the transaction
COMMIT;

START TRANSACTION;

-- Update the price of a book
UPDATE Books
SET Price = 22.99
WHERE BookID = 1;

-- Decide to rollback the changes
ROLLBACK;


-- Trigger
CREATE TABLE AuditLog (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    OperationType VARCHAR(20),
    TableName VARCHAR(50),
    RecordID INT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Details TEXT
);

-- before insert trigger
DELIMITER //
CREATE TRIGGER BeforeInsertBook
BEFORE INSERT ON Books
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (OperationType, TableName, RecordID, Details)
    VALUES ('INSERT', 'Books', NEW.BookID, CONCAT('About to insert a new book record with Title: ', NEW.Title));
END;
//
DELIMITER ;

-- after insert trigger
DELIMITER //
CREATE TRIGGER AfterInsertBook
AFTER INSERT ON Books
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (OperationType, TableName, RecordID, Details)
    VALUES ('INSERT', 'Books', NEW.BookID, CONCAT('Inserted a new book record with Title: ', NEW.Title));
END;
//
DELIMITER ;

-- before update trigger
DELIMITER //
CREATE TRIGGER BeforeUpdateBook
BEFORE UPDATE ON Books
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (OperationType, TableName, RecordID, Details)
    VALUES ('UPDATE', 'Books', OLD.BookID, CONCAT('About to update book record from Title: ', OLD.Title, ' to Title: ', NEW.Title));
END;
//
DELIMITER ;

-- after update trigger
DELIMITER //
CREATE TRIGGER AfterUpdateBook
AFTER UPDATE ON Books
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (OperationType, TableName, RecordID, Details)
    VALUES ('UPDATE', 'Books', NEW.BookID, CONCAT('Updated book record from Title: ', OLD.Title, ' to Title: ', NEW.Title));
END;
//
DELIMITER ;

-- before trigger
DELIMITER //
CREATE TRIGGER BeforeDeleteBook
BEFORE DELETE ON Books
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (OperationType, TableName, RecordID, Details)
    VALUES ('DELETE', 'Books', OLD.BookID, CONCAT('About to delete book record with Title: ', OLD.Title));
END;
//
DELIMITER ;

-- after trigger
DELIMITER //
CREATE TRIGGER AfterDeleteBook
AFTER DELETE ON Books
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (OperationType, TableName, RecordID, Details)
    VALUES ('DELETE', 'Books', OLD.BookID, CONCAT('Deleted book record with Title: ', OLD.Title));
END;
//
DELIMITER ;


