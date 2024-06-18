-- reference to videogamelibrary database 

-- numerical functions

-- average 
SELECT AVG(ReleaseYear) AS AverageReleaseYear
FROM Games;

-- Count 
SELECT P_Name, COUNT(*) AS PublishedGameCount
FROM Games
INNER JOIN GameDetails ON Games.GameID = GameDetails.GameID
INNER JOIN Publishers ON GameDetails.PublisherID = Publishers.PublisherID
GROUP BY P_Name;

-- square root (sqrt)
SELECT Title, ReleaseYear, SQRT(ReleaseYear) AS ReleaseYearSqrt
FROM Games;

-- min and max
SELECT MIN(releaseyear) 
FROM games;
SELECT MAX(releaseyear) 
FROM games;

-- power(pow)
SELECT D_Name, COUNT(*), POW(COUNT(*), 2) AS GamesPublishedSquared
FROM Games
INNER JOIN GameDetails ON Games.GameID = GameDetails.GameID
INNER JOIN Developers ON GameDetails.DeveloperID = Developers.DeveloperID
GROUP BY D_Name;

-- Round 
SELECT Genre, ROUND(AVG(ReleaseYear), 2) AS AvgReleaseYearRounded
FROM Games
GROUP BY Genre;

-- floor
SELECT Genre, FLOOR(AVG(ReleaseYear)) AS AvgReleaseYearFloor
FROM Games
GROUP BY Genre;

-- min a, max and pow function
SELECT POW(ABS(MAX(ReleaseYear) - MIN(ReleaseYear)), 2) AS ReleaseYearDiffSquared
FROM Games;


       

