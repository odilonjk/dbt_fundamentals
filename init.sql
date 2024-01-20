-- Create Artists table
CREATE TABLE Artists (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(255) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(100)
);

-- Create Artworks table
CREATE TABLE Artworks (
    artwork_id SERIAL PRIMARY KEY,
    artwork_title VARCHAR(255) NOT NULL,
    creation_date DATE,
    artist_id INT,
    CONSTRAINT fk_artist
        FOREIGN KEY (artist_id)
        REFERENCES Artists(artist_id)
);

-- Insert example data into Artists table
INSERT INTO Artists (artist_name, birth_date, nationality) VALUES
    ('Leonardo da Vinci', '1452-04-15', 'Italian'),
    ('Vincent van Gogh', '1853-03-30', 'Dutch'),
    ('Pablo Picasso', '1881-10-25', 'Spanish'),
    ('Frida Kahlo', '1907-07-06', 'Mexican');

-- Insert example data into Artworks table
INSERT INTO Artworks (artwork_title, creation_date, artist_id) VALUES
    ('Mona Lisa', DATE '1506-01-01', 1),
    ('Starry Night', DATE '1889-01-01', 2),
    ('Guernica', DATE '1937-01-01', 3),
    ('The Two Fridas', DATE '1939-01-01', 4);