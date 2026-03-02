-- Case Study: the music streaming app 
 
/* Task 1: Identify problems
a. Identify two anomalies that could occur in this design (such as update, insertion, or deletion).
1) Update anomaly: supposing that the user wants to add a new information to a specific song, such as the correct genre that
was miswritten, the user would have to edit every single playlist which song appears on the database, increasing the chance of anomaly;
2) Insertion anomaly: supposing that the user wants to add a song to a playlist that already have it, then
the database system would probably duplicate the existent song details, increasing the chance of anomaly. */

/* b. Give one concrete example of redundancy in the data.
Supposing that the user creates multiple playlists, the database system would store user's details such
as username and email address multiple times in each playlist's specified row. causing redundancy. */

/* c. Explain why this structure violates First Normal Form (1NF)
First Normal Form (1NF) means that each cell should contain a single value (atomic value), all values in a column should
be of the same type, and each column should be uniquely identified. This structure violates 1NF because the "Songs" column contains
multiple values from different data types, and that goes against the form.


/* Task 2: Transform to first normal form (1NF)
a. Identify which attribute(s) could serve as a primary key.
The attribute "PlaylistID" could serve as a primary key since each playlist has one, single, and unique ID.

b. Write SQL code to create a table that satisfies 1NF:
- every cell contains a single atomic value
- columns contain values of the same type
- the table has a defined primary key */
-- USERS TABLE
CREATE TABLE USERS (
  UserEmail VARCHAR PRIMARY KEY,
  UserName VARCHAR
);

-- SONGS TABLE
CREATE TABLE SONGS(
  SongID VARCHAR PRIMARY KEY, -- creating new attribute
  Title VARCHAR,
  Artist VARCHAR,
  Album VARCHAR,
  Year INT,
  Genre VARCHAR,
  Duration INT
);

-- PLAYLISTS TABLE
CREATE TABLE PLAYLISTS (
  PlaylistID VARCHAR PRIMARY KEY,
  PlaylistName VARCHAR,
  UserName VARCHAR REFERENCES Users(UserName)
);

-- PlaylistSongs TABLE
CREATE TABLE PlaylistSongs (
  PlaylistID VARCHAR,
  SongID INT,
  PRIMARY KEY (PlaylistID, SongID),
  FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
  FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

-- c. Insert the sample data provided
-- Users
INSERT INTO Users VALUES ('ana@gmail.com', 'Ana Lopez');
INSERT INTO Users VALUES ('ben@gmail.com', 'Ben Murphy');
INSERT INTO Users VALUES ('ciara@gmail.com', 'Ciara Ryan');

-- Songs
INSERT INTO Songs (Title, Artist, Album, Year, Genre, Duration) VALUES
('Yellow', 'Coldplay', 'Parachutes', 2000, 'Rock', 269),
('Vienna', 'Billy Joel', 'The Stranger', 1977, 'Soft Rock', 217),
('Blinding Lights', 'The Weeknd', 'After Hours', 2020, 'Pop', 200),
('Can''t Hold Us', 'Macklemore', 'The Heist', 2012, 'Hip-Hop', 280);

-- Playlists
INSERT INTO Playlists VALUES ('P001', 'Chill Vibes', 'ana@gmail.com');
INSERT INTO Playlists VALUES ('P002', 'Study Mix', 'ben@gmail.com');
INSERT INTO Playlists VALUES ('P003', 'Gym Pump', 'ciara@gmail.com');

-- PlaylistSongs
-- P001: Yellow, Vienna
INSERT INTO PlaylistSongs VALUES ('P001', 1);
INSERT INTO PlaylistSongs VALUES ('P001', 2);

-- P002: Blinding Lights, Yellow
INSERT INTO PlaylistSongs VALUES ('P002', 3);
INSERT INTO PlaylistSongs VALUES ('P002', 1);

-- P003: Can't Hold Us
INSERT INTO PlaylistSongs VALUES ('P003', 4);


/* Task 3: Transform to second normal form (2NF)
a. In your own words, define partial dependency.
Partial Dependency is a dependency or reliance of an attribute within a foreign key to an attribute within a primary key that contains
multiple column values.

b. Are there any partial dependencies on your 1NF version of the data? If yes, provide examples.
There are no partial dependencies on my 1NF data version.  In the PlaylistSongs table from 1NF update,
the primary key is (PlaylistID, SongID).

c. Write your own SQL code to divide your 1NF table into smaller tables, removing partial dependencies.
Insert the sample data provided into those tables. */
-- Users Table
CREATE TABLE Users (
    UserEmail VARCHAR(255) PRIMARY KEY,
    UserName VARCHAR(255)
);

-- Songs Table
CREATE TABLE Songs (
    SongID SERIAL PRIMARY KEY,
    Title VARCHAR(255),
    Artist VARCHAR(255),
    Album VARCHAR(255),
    Year INT,
    Genre VARCHAR(100),
    Duration INT
);

-- Playlists Table
CREATE TABLE Playlists (
    PlaylistID VARCHAR(10) PRIMARY KEY,
    PlaylistName VARCHAR(255),
    UserEmail VARCHAR(255) REFERENCES Users(UserEmail)
);

-- PlaylistSongs Table (junction, no partial dependencies)
CREATE TABLE PlaylistSongs (
    PlaylistID VARCHAR(10),
    SongID INT,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

-- Sample Inserts (same as before)
INSERT INTO Users VALUES ('ana@gmail.com', 'Ana Lopez');
INSERT INTO Users VALUES ('ben@gmail.com', 'Ben Murphy');
INSERT INTO Users VALUES ('ciara@gmail.com', 'Ciara Ryan');

INSERT INTO Songs (Title, Artist, Album, Year, Genre, Duration) VALUES
('Yellow', 'Coldplay', 'Parachutes', 2000, 'Rock', 269),
('Vienna', 'Billy Joel', 'The Stranger', 1977, 'Soft Rock', 217),
('Blinding Lights', 'The Weeknd', 'After Hours', 2020, 'Pop', 200),
('Can''t Hold Us', 'Macklemore', 'The Heist', 2012, 'Hip-Hop', 280);

INSERT INTO Playlists VALUES ('P001', 'Chill Vibes', 'ana@gmail.com');
INSERT INTO Playlists VALUES ('P002', 'Study Mix', 'ben@gmail.com');
INSERT INTO Playlists VALUES ('P003', 'Gym Pump', 'ciara@gmail.com');

INSERT INTO PlaylistSongs VALUES ('P001', 1); -- Yellow
INSERT INTO PlaylistSongs VALUES ('P001', 2); -- Vienna
INSERT INTO PlaylistSongs VALUES ('P002', 3); -- Blinding Lights
INSERT INTO PlaylistSongs VALUES ('P002', 1); -- Yellow
INSERT INTO PlaylistSongs VALUES ('P003', 4); -- Can't Hold Us


/* Task 4: Transform to third normal form (3NF)
a. In your own words, define transitive dependency.
Transitive dependency is when all the attributes should be only directly dependent of the primary key, not one of its attributes. It means that when a non‑key attribute depends on another non‑key attribute, which depends on the primary key, it creates an indirect dependency that we do not want to happen.

b. Are there any transitive dependencies on your 2NF version of the data? If yes, provide examples.
There are no partial dependencies on my 1NF data version.

c. Write your own SQL code to divide your 2NF tables into smaller tables, removing transitive dependencies.
Insert the sample data provided into those tables */
-- Users Table
CREATE TABLE Users (
    UserEmail VARCHAR(255) PRIMARY KEY,
    UserName VARCHAR(255)
);

-- Artists Table
CREATE TABLE Artists (
    Artist VARCHAR(255) PRIMARY KEY
    -- Add more artist details here if needed, e.g., ArtistEmail
);

-- Songs Table
CREATE TABLE Songs (
    SongID SERIAL PRIMARY KEY,
    Title VARCHAR(255),
    Artist VARCHAR(255) REFERENCES Artists(Artist),
    Album VARCHAR(255),
    Year INT,
    Genre VARCHAR(100),
    Duration INT
);

-- Playlists Table
CREATE TABLE Playlists (
    PlaylistID VARCHAR(10) PRIMARY KEY,
    PlaylistName VARCHAR(255),
    UserEmail VARCHAR(255) REFERENCES Users(UserEmail)
);

-- PlaylistSongs Table (junction)
CREATE TABLE PlaylistSongs (
    PlaylistID VARCHAR(10),
    SongID INT,
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

-- Sample Data
-- Users
INSERT INTO Users VALUES ('ana@gmail.com', 'Ana Lopez');
INSERT INTO Users VALUES ('ben@gmail.com', 'Ben Murphy');
INSERT INTO Users VALUES ('ciara@gmail.com', 'Ciara Ryan');

-- Artists
INSERT INTO Artists VALUES ('Coldplay');
INSERT INTO Artists VALUES ('Billy Joel');
INSERT INTO Artists VALUES ('The Weeknd');
INSERT INTO Artists VALUES ('Macklemore');

-- Songs
INSERT INTO Songs (Title, Artist, Album, Year, Genre, Duration) VALUES
('Yellow', 'Coldplay', 'Parachutes', 2000, 'Rock', 269),
('Vienna', 'Billy Joel', 'The Stranger', 1977, 'Soft Rock', 217),
('Blinding Lights', 'The Weeknd', 'After Hours', 2020, 'Pop', 200),
('Can''t Hold Us', 'Macklemore', 'The Heist', 2012, 'Hip-Hop', 280);

-- Playlists
INSERT INTO Playlists VALUES ('P001', 'Chill Vibes', 'ana@gmail.com');
INSERT INTO Playlists VALUES ('P002', 'Study Mix', 'ben@gmail.com');
INSERT INTO Playlists VALUES ('P003', 'Gym Pump', 'ciara@gmail.com');

-- PlaylistSongs
INSERT INTO PlaylistSongs VALUES ('P001', 1); -- Yellow
INSERT INTO PlaylistSongs VALUES ('P001', 2); -- Vienna
INSERT INTO PlaylistSongs VALUES ('P002', 3); -- Blinding Lights
INSERT INTO PlaylistSongs VALUES ('P002', 1); -- Yellow
INSERT INTO PlaylistSongs VALUES ('P003', 4); -- Can't Hold Us