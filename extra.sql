
------------------------------------------MovieDetails----------------------------------------
CREATE TABLE MovieDetails
(
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(100),
    Director VARCHAR(100),
    ReleaseYear INT
);

INSERT INTO MovieDetails
(MovieID, Title, Genre, Director, ReleaseYear)
VALUES
(1, 'The Dark Knight', 'Action', 'Christopher Nolan', 2008),

(2, 'Inception', 'Sci-Fi', 'Christopher Nolan', 2010),

(3, 'Avengers:Endgame', 'Drama', 'Anthony Russo', 2019),

(4, 'The Avengers', 'Action', 'Joss Whedon', 2012),

(5, 'Titanic', 'Romance', 'James Cameron', 1997),

(6, 'Interstellar', 'Sci-Fi', 'Christopher Nolan', 2014),

(7, 'The Godfather', 'Crime', 'Francis Ford Coppola', 1972),

(8, 'Avengers:Infinity War', 'Action', 'Anthony Russo', 2018),

(9, 'The Batman', 'Crime', 'Matt Reeves', 2022),

(10, 'Jurassic Park', 'Adventure', 'Steven Spielberg', 1993);



------------------------------------------------MovieFinancials-----------------------------


CREATE TABLE MovieFinancials
(
    FinancialID INT PRIMARY KEY,
    BudgetUSD DECIMAL(12,2),
    BoxOfficeUSD DECIMAL(12,2),
    MovieID INT,
    
    FOREIGN KEY (MovieID)
        REFERENCES MovieDetails(MovieID)
);

INSERT INTO MovieFinancials
(FinancialID, BudgetUSD, BoxOfficeUSD, MovieID)
VALUES
(1, 185000000.00, 1005000000.00, 1),

(2, 160000000.00, 839000000.00, 2),

(3, 356000000.00, 2798000000.00, 3),

(4, 220000000.00, 1518000000.00, 4),

(5, 200000000.00, 2264000000.00, 5),

(6, 165000000.00, 731000000.00, 6),

(7, 6000000.00, 250000000.00, 7),

(8, 321000000.00, 2050000000.00, 8),

(9, 200000000.00, 772000000.00, 9),

(10, 63000000.00, 1046000000.00, 10);




------------------------------------------MovieRatingsDuration------------------------


CREATE TABLE MovieRatingsDuration
(
    RatingID INT PRIMARY KEY,
    DurationMin INT,
    Rating DECIMAL(12,2),
    Language VARCHAR(100),
    Country VARCHAR(100),
    MovieID INT,

    FOREIGN KEY (MovieID)
        REFERENCES MovieDetails(MovieID)
);




INSERT INTO MovieRatingsDuration
(RatingID, DurationMin, Rating, Language, Country, MovieID)
VALUES
(1, 152, 9.0, 'English', 'USA', 1),

(2, 148, 8.8, 'English', 'USA', 2),

(3, 181, 8.4, 'English', 'USA', 3),

(4, 143, 8.0, 'English', 'USA', 4),

(5, 195, 7.9, 'English', 'USA', 5),

(6, 169, 8.6, 'English', 'USA', 6),

(7, 175, 9.2, 'English', 'USA', 7),

(8, 149, 8.4, 'English', 'USA', 8),

(9, 176, 7.8, 'English', 'USA', 9),

(10, 127, 8.1, 'English', 'USA', 10);
