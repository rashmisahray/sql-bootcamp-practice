CREATE DATABASE VideoGameLibrary;

USE VideoGameLibrary;

CREATE TABLE Games (
  GameID INT PRIMARY KEY ,
  Title VARCHAR(255) NOT NULL,
  Genre VARCHAR(50),
  ReleaseYear INT
);

CREATE TABLE Developers (
  DeveloperID INT PRIMARY KEY ,
  D_Name VARCHAR(255) NOT NULL
);

CREATE TABLE Publishers (
  PublisherID INT PRIMARY KEY ,
  P_Name VARCHAR(255) NOT NULL
);

CREATE TABLE GameDetails (
  GameID INT PRIMARY KEY,
  DeveloperID INT NOT NULL,
  PublisherID INT NOT NULL,
  Platform VARCHAR(100),
  FOREIGN KEY (GameID) REFERENCES Games(GameID),
  FOREIGN KEY (DeveloperID) REFERENCES Developers(DeveloperID),
  FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

INSERT INTO Games 
VALUES (1,"The Witcher 3: Wild Hunt", 'RPG', 2015),
       (2,'Among Us', 'Social Deduction', 2015),
       (3,'Minecraft', 'Sandbox, Survival', 2011);

INSERT INTO Developers 
VALUES (101,'CD Projekt Red'),
       (102,' InnerSloth'),
       (103,'Mojang Studios');

INSERT INTO Publishers 
VALUES (1001,'Bethesda Softworks'),
       (1002,'InnerSloth'),
       (1003,'Mojang Studios');

INSERT INTO GameDetails (GameID, DeveloperID, PublisherID, Platform)
VALUES (1, 101, 1001, 'PC, PlayStation 3, Xbox 360'),
       (2, 102, 1002, 'PlayStation 3, Xbox , PC'),
       (3, 103, 1003, 'PC, Nintendo Switch, mobile');
       
-- queries for altering the table
-- add column
ALTER TABLE Games ADD Reviews INT;

-- modify columns
ALTER TABLE Games MODIFY Genre TEXT;

 -- rename column
ALTER TABLE GameDetails RENAME COLUMN Platform TO Platforms;

-- queries for updating the table
-- modifying the values
UPDATE Games
SET ReleaseYear = 2018
WHERE Title = 'Among Us';

-- adding the values
UPDATE Games
SET Reviews = 0
WHERE Reviews IS NULL;

-- deleting the table
drop table GameDetails;

-- turncating the table
TRUNCATE TABLE Games;

-- droping the database
drop database VideoGameLibrary;






