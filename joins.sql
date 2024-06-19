-- reference to videogamelibrary database 
use videogameLibrary;

-- inner join
-- game with their developer and publisher 
SELECT g.Title, d.D_Name AS Developer, p.P_Name AS Publisher
FROM Games g
INNER JOIN GameDetails gd ON g.GameID = gd.GameID
INNER JOIN Developers d ON gd.DeveloperID = d.DeveloperID
INNER JOIN Publishers p ON gd.PublisherID = p.PublisherID;

-- game with their platfroms
SELECT g.Title, gd.Platform
FROM Games g
INNER JOIN GameDetails gd ON g.GameID = gd.GameID;


-- left join
SELECT g.Title, COALESCE(d.D_Name, 'No Developer') AS Developer
FROM Games g
LEFT JOIN GameDetails gd ON g.GameID = gd.GameID
LEFT JOIN Developers d ON gd.DeveloperID = d.DeveloperID;

-- getting developer with thier games
SELECT d.D_Name AS Developer, g.Title AS Game
FROM Developers d
LEFT JOIN GameDetails gd ON d.DeveloperID = gd.DeveloperID
LEFT JOIN Games g ON gd.GameID = g.GameID;

-- right join

-- publisher with their games
SELECT p.P_Name AS Publisher, g.Title AS Game
FROM Publishers p
RIGHT JOIN GameDetails gd ON p.PublisherID = gd.PublisherID
RIGHT JOIN Games g ON gd.GameID = g.GameID;

-- union
SELECT g.Title, d.D_Name AS Developer, p.P_Name AS Publisher
FROM Games g
LEFT JOIN GameDetails gd ON g.GameID = gd.GameID
LEFT JOIN Developers d ON gd.DeveloperID = d.DeveloperID
LEFT JOIN Publishers p ON gd.PublisherID = p.PublisherID
UNION
SELECT g.Title, d.D_Name AS Developer, p.P_Name AS Publisher
FROM GameDetails gd
RIGHT JOIN Games g ON gd.GameID = g.GameID
RIGHT JOIN Developers d ON gd.DeveloperID = d.DeveloperID
RIGHT JOIN Publishers p ON gd.PublisherID = p.PublisherID;

-- self join
SELECT g1.Title AS Game1, g2.Title AS Game2, g1.ReleaseYear
FROM Games g1
INNER JOIN Games g2 ON g1.ReleaseYear = g2.ReleaseYear AND g1.GameID <> g2.GameID;

-- cross join
-- to get the games and developers list
SELECT g.Title AS Game, d.D_Name AS Developer
FROM Games g
CROSS JOIN Developers d;

-- to get developers and publishers list
SELECT d.D_Name AS Developer, p.P_Name AS Publisher
FROM Developers d
CROSS JOIN Publishers p;








