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
       
-- select queries 
select * from games;

select platform from gamedetails;

-- group by queries
SELECT Genre, AVG(ReleaseYear) AS AvgReleaseYear
FROM Games
WHERE ReleaseYear > 2010
GROUP BY Genre;

-- order by queries
SELECT Title, ReleaseYear
FROM Games
ORDER BY ReleaseYear ASC;


-- group by and order by queries
SELECT Genre, COUNT(*) AS TotalGames
FROM Games
GROUP BY Genre
ORDER BY TotalGames DESC;

SELECT Platform, COUNT(*) AS PlatformCount
FROM GameDetails
GROUP BY Platform
ORDER BY PlatformCount DESC
LIMIT 1;


       

