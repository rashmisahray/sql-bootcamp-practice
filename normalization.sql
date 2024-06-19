create database librarybookinfo;
use librarybookinfo;

/*
CREATE TABLE LibraryBooks (
    BookID INT,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Publisher VARCHAR(100),
    PublicationDate DATE,
    ISBN VARCHAR(20),
    BorrowerID INT,
    BorrowDate DATE,
    ReturnDate DATE
);

-- 1nf
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublisherID INT,
    PublicationDate DATE,
    ISBN VARCHAR(20),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
	FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY,
    BorrowerName VARCHAR(100)
);

CREATE TABLE BookLoans (
    BookLoanID INT PRIMARY KEY,
    BookID INT,
    BorrowerID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);

-- 2nf
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublisherID INT,
    PublicationDate DATE,
    ISBN VARCHAR(20),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY,
    BorrowerName VARCHAR(100)
);

CREATE TABLE BookLoans (
    BookLoanID INT PRIMARY KEY,
    BookID INT,
    BorrowerID INT,
    BorrowDate DATE,
    ReturnDate DATE,
	FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);

CREATE TABLE BookCopies (
    BookCopyID INT PRIMARY KEY,
    BookID INT,
    CopyNumber INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
*/
-- 3nf
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublisherID INT,
    PublicationDate DATE,
    ISBN VARCHAR(20),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY,
    BorrowerName VARCHAR(100)
);

CREATE TABLE BookCopies (
    BookCopyID INT PRIMARY KEY,
    BookID INT,
    CopyNumber INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

CREATE TABLE BookLoans (
    BookLoanID INT PRIMARY KEY,
    BookCopyID INT,
    BorrowerID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookCopyID) REFERENCES BookCopies(BookCopyID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);







