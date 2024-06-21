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

-- delimiter
DELIMITER //
CREATE PROCEDURE GetAuthorDetails(IN author_id INT)
BEGIN
    SELECT * FROM Authors WHERE AuthorID = author_id;
END//
DELIMITER ;

-- execute
CALL GetAuthorDetails(1);

-- creating a function
DELIMITER //
CREATE FUNCTION GetBookTitle(book_id INT) RETURNS VARCHAR(100) READS SQL DATA
BEGIN
    DECLARE title VARCHAR(100);
    SELECT Title INTO title FROM Books WHERE BookID = book_id;
    RETURN title;
END//
DELIMITER ;
-- executing the function
SELECT GetBookTitle(1);

-- creating a cursor
DELIMITER //
CREATE PROCEDURE GetBookLoans()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE book_loan_id INT;
    DECLARE book_copy_id INT;
    DECLARE borrower_id INT;
    DECLARE borrow_date DATE;
    DECLARE return_date DATE;
    DECLARE loan_duration INT;
    DECLARE cur1 CURSOR FOR SELECT * FROM BookLoans;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;

    read_loop: LOOP
        FETCH cur1 INTO book_loan_id, book_copy_id, borrower_id, borrow_date, return_date, loan_duration;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT book_loan_id, book_copy_id, borrower_id, borrow_date, return_date, loan_duration;
    END LOOP;

    CLOSE cur1;
END//
DELIMITER ;
-- executing the cursor
CALL GetBookLoans();