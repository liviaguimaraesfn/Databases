-- Databases 1 Lab 3 - C24329646 - From ERD to SQL

-- Request 1: Provide the Data Definition Language (DDL) script to show the implementation of the database presented in the ERD.

DROP TABLE IF EXISTS player_contracts;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS clubs;

-- creating clubs table
CREATE TABLE clubs (
  club_id SERIAL PRIMARY KEY,
  club_name VARCHAR(120) NOT NULL
);

-- creating players table
CREATE TABLE players (
  player_id SERIAL PRIMARY KEY,
  player_name TEXT NOT NULL,
  age INTEGER,
  nationality TEXT,
  preferred_foot VARCHAR(5),
  height_cm INTEGER,
  weight_kg INTEGER
);

-- creating player_contracts table
CREATE TABLE player_contracts (
  player_contract_id SERIAL PRIMARY KEY,
  player_id INTEGER NOT NULL REFERENCES players(player_id),
  club_id INTEGER NOT NULL REFERENCES clubs(club_id),
  joined DATE,
  contract_valid_until DATE,
  jersey_number INTEGER,
  wage NUMERIC(12,2)
);

-- creating matches table
CREATE TABLE matches (
  match_id SERIAL PRIMARY KEY,
  match_date DATE,
  location TEXT,
  home_club_id INTEGER REFERENCES clubs(club_id),
  away_club_id INTEGER REFERENCES clubs(club_id)
);

-- Request 2: Add a bonus column to player_contracts with a default of 0 and a non-negative check.
ALTER TABLE player_contracts 
ADD COLUMN bonus DECIMAL(10, 2) DEFAULT 0 CHECK (bonus >= 0);

-- Request 3: List the name and age of players whose nationality is Irish OR English.
-- Make sure you rename the columns in the output as “Player’s name” and “Player’s age”.
SELECT player_name AS "Player's name", age AS "Player's age"
FROM players
WHERE nationality = 'Irish' OR nationality = 'English';