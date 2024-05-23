USE MASTER
GO
DROP DATABASE IF EXISTS NGraph
GO
CREATE DATABASE NGraph
GO
USE NGraph
GO

-- Создание таблицы User
CREATE TABLE [User] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    birthdate DATE NULL
) AS NODE;

-- Создание таблицы Company
CREATE TABLE Company (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    industry VARCHAR(255) NOT NULL
) AS NODE;

-- Создание таблицы Project
CREATE TABLE Project (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    start_year INT NOT NULL
)  AS NODE;

CREATE TABLE Works AS EDGE;

CREATE TABLE Participates AS EDGE;

CREATE TABLE Communicates AS EDGE;

-- Вставка данных в таблицу User
INSERT INTO [User] (name, position, birthdate) VALUES
('John Doe', 'Software Engineer', '1985-06-15'),
('Jane Smith', 'Data Scientist', '1990-08-23'),
('Bob Johnson', 'Project Manager', '1978-02-10'),
('Alice Brown', 'Product Manager', '1983-11-05'),
('Charlie Green', 'Business Analyst', '1992-01-20'),
('Diana White', 'UX Designer', '1987-04-12'),
('Ethan Black', 'DevOps Engineer', '1989-09-30'),
('Fiona Red', 'QA Engineer', '1991-12-17'),
('George Blue', 'Systems Architect', '1975-07-25'),
('Hannah Yellow', 'Marketing Specialist', '1984-03-08');

-- Вставка данных в таблицу Company
INSERT INTO Company (name, industry) VALUES
('TechCorp', 'Technology'),
('DataSolutions', 'Data Analytics'),
('BuildIt', 'Construction'),
('HealthPlus', 'Healthcare'),
('EduWorld', 'Education'),
('GreenEnergy', 'Energy'),
('FinServe', 'Finance'),
('LogiTrans', 'Logistics'),
('MediaWorks', 'Media'),
('RetailHub', 'Retail');

-- Вставка данных в таблицу Project
INSERT INTO Project (name, start_year) VALUES
('Project A', 2022),
('Project B', 2021),
('Project C', 2023),
('Project D', 2020),
('Project E', 2022),
('Project F', 2021),
('Project G', 2023),
('Project H', 2020),
('Project I', 2022),
('Project J', 2021);

INSERT INTO Communicates ($from_id, $to_id)
VALUES ((SELECT $node_id FROM [User] WHERE id = 1),
 (SELECT $node_id FROM [User] WHERE id = 2)),
 ((SELECT $node_id FROM [User] WHERE id = 10),
 (SELECT $node_id FROM [User] WHERE id = 5)),
 ((SELECT $node_id FROM [User] WHERE id = 2),
 (SELECT $node_id FROM [User] WHERE id = 9)),
 ((SELECT $node_id FROM [User] WHERE id = 3),
 (SELECT $node_id FROM [User] WHERE id = 1)),
 ((SELECT $node_id FROM [User] WHERE id = 3),
 (SELECT $node_id FROM [User] WHERE id = 6)),
 ((SELECT $node_id FROM [User] WHERE id = 4),
 (SELECT $node_id FROM [User] WHERE id = 2)),
 ((SELECT $node_id FROM [User] WHERE id = 5),
 (SELECT $node_id FROM [User] WHERE id = 4)),
 ((SELECT $node_id FROM [User] WHERE id = 6),
 (SELECT $node_id FROM [User] WHERE id = 7)),
 ((SELECT $node_id FROM [User] WHERE id = 6),
 (SELECT $node_id FROM [User] WHERE id = 8)),
 ((SELECT $node_id FROM [User] WHERE id = 8),
 (SELECT $node_id FROM [User] WHERE id = 3));

INSERT INTO Participates ($from_id, $to_id)
VALUES ((SELECT $node_id FROM [User] WHERE ID = 1),
 (SELECT $node_id FROM Project WHERE ID = 1)),
 ((SELECT $node_id FROM [User] WHERE ID = 5),
 (SELECT $node_id FROM Project WHERE ID = 1)),
 ((SELECT $node_id FROM [User] WHERE ID = 8),
 (SELECT $node_id FROM Project WHERE ID = 1)),
 ((SELECT $node_id FROM [User] WHERE ID = 2),
 (SELECT $node_id FROM Project WHERE ID = 2)),
 ((SELECT $node_id FROM [User] WHERE ID = 3),
 (SELECT $node_id FROM Project WHERE ID = 3)),
 ((SELECT $node_id FROM [User] WHERE ID = 4),
 (SELECT $node_id FROM Project WHERE ID = 3)),
 ((SELECT $node_id FROM [User] WHERE ID = 6),
 (SELECT $node_id FROM Project WHERE ID = 4)),
 ((SELECT $node_id FROM [User] WHERE ID = 7),
 (SELECT $node_id FROM Project WHERE ID = 4)),
 ((SELECT $node_id FROM [User] WHERE ID = 1),
 (SELECT $node_id FROM Project WHERE ID = 9)),
 ((SELECT $node_id FROM [User] WHERE ID = 9),
 (SELECT $node_id FROM Project WHERE ID = 4)),
 ((SELECT $node_id FROM [User] WHERE ID = 10),
 (SELECT $node_id FROM Project WHERE ID = 9));

INSERT INTO Works ($from_id, $to_id)
VALUES ((SELECT $node_id FROM [User] WHERE ID = 1),
 (SELECT $node_id FROM Company WHERE ID = 6)),
 ((SELECT $node_id FROM [User] WHERE ID = 5),
 (SELECT $node_id FROM Company WHERE ID = 1)),
 ((SELECT $node_id FROM [User] WHERE ID = 8),
 (SELECT $node_id FROM Company WHERE ID = 7)),
 ((SELECT $node_id FROM [User] WHERE ID = 2),
 (SELECT $node_id FROM Company WHERE ID = 2)),
 ((SELECT $node_id FROM [User] WHERE ID = 3),
 (SELECT $node_id FROM Company WHERE ID = 5)),
 ((SELECT $node_id FROM [User] WHERE ID = 4),
 (SELECT $node_id FROM Company WHERE ID = 3)),
 ((SELECT $node_id FROM [User] WHERE ID = 6),
 (SELECT $node_id FROM Company WHERE ID = 4)),
 ((SELECT $node_id FROM [User] WHERE ID = 7),
 (SELECT $node_id FROM Company WHERE ID = 2)),
 ((SELECT $node_id FROM [User] WHERE ID = 1),
 (SELECT $node_id FROM Company WHERE ID = 9)),
 ((SELECT $node_id FROM [User] WHERE ID = 9),
 (SELECT $node_id FROM Company WHERE ID = 8)),
 ((SELECT $node_id FROM [User] WHERE ID = 10),
 (SELECT $node_id FROM Company WHERE ID = 9));


SELECT U.name, C.name
FROM [User] AS U
	, Works AS W
	, Company AS C
WHERE MATCH(U-(W)->C)
	AND U.name = 'John Doe';

SELECT U.name, C.name
FROM [User] AS U
	, Works AS W
	, Company AS C
WHERE MATCH(U-(W)->C)
	AND C.name = 'MediaWorks';

SELECT U.name, P.name
FROM [User] AS U
	, Participates AS Ps
	, Project AS P
WHERE MATCH(U-(Ps)->P)
	AND U.name = 'John Doe';

SELECT U.name, P.name
FROM [User] AS U
	, Participates AS Ps
	, Project AS P
WHERE MATCH(U-(Ps)->P)
	AND P.name = 'Project A';

SELECT u1.name, u2.name
FROM [User] AS u1
	, Communicates AS c
	, [User] AS u2
WHERE MATCH(u1-(c)->u2)
	AND u1.name = 'Bob Johnson';

SELECT u1.name AS PersonName
 , STRING_AGG(u2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Coopers
FROM [User] AS u1
 , Communicates FOR PATH AS c
 , [User] FOR PATH AS u2
WHERE MATCH(SHORTEST_PATH(u1(-(c)->u2)+))
 AND u1.name = 'John Doe';

SELECT u1.name AS PersonName
 , STRING_AGG(u2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Coopers
FROM [User] AS u1
 , Communicates FOR PATH AS c
 , [User] FOR PATH AS u2
WHERE MATCH(SHORTEST_PATH(u1(-(c)->u2){1,3}))
 AND u1.name = 'Diana White';

 SELECT u1.id AS IdFirst
	, u1.name AS First
	, CONCAT(N'user', u1.id) AS [First image name]
	, u2.id AS IdSecond
	, u2.name AS Second
	, CONCAT(N'user', u2.id) AS [Second image name]
FROM [User] AS u1
	, Communicates AS c
	, [User] AS u2
WHERE MATCH(u1-(c)->u2)

SELECT u.id AS IdFirst
	, u.name AS First
	, CONCAT(N'user', u.id) AS [First image name]
	, p.id AS IdSecond
	, p.name AS Second
	, CONCAT(N'project', p.id) AS [Second image name]
FROM [User] AS u
	, Participates AS ps
	, Project AS p
WHERE MATCH(u-(ps)->p);

SELECT u.id AS IdFirst
	, u.name AS First
	, CONCAT(N'user', u.id) AS [First image name]
	, c.id AS IdSecond
	, c.name AS Second
	, CONCAT(N'company', c.id) AS [Second image name]
FROM [User] AS U
	, Works AS W
	, Company AS C
WHERE MATCH(U-(W)->C)

select @@servername