-- reference to videogamelibrary database 

-- string functions

-- length function
SELECT Title, LENGTH(Title) AS TitleLength
FROM Games
ORDER BY TitleLength DESC
LIMIT 1;

-- lowercase ,uppercase function
SELECT LOWER(Genre) AS LowercaseGenre
FROM Games;
SELECT UCASE(Genre) AS UppercaseGenre
FROM Games;


--  substr,instr 
SELECT SUBSTR(Title, 1, INSTR(Title, ' ') - 1) AS FirstWord
FROM Games
WHERE INSTR(Title, ' ') > 0;  -- Only titles with spaces

-- date and time functions

-- Get the current date
SELECT CURRENT_DATE AS TodaysDate;

-- Find the last day of the previous month
SELECT LAST_DAY(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)) AS LastDayPreviousMonth;

-- Add 30 days to a specific date (replace '2024-06-18' with your desired date)
SELECT ADDDATE('2024-06-18', INTERVAL 30 DAY) AS DatePlus30Days;

-- Get the ASCII value of the first character in each game title
SELECT Title, ASCII(SUBSTR(Title, 1, 1)) AS FirstCharASCII
FROM Games;

-- trim
SELECT TRIM(Genre) AS TrimmedGenre
FROM Games;


       

