
-- Copyright 2023 Martin Baňacký

-- All rights reserved.

--vymazanie tabuliek
DROP TABLE IF EXISTS album_interpret;
DROP TABLE IF EXISTS album_skladba;
DROP TABLE IF EXISTS interpret;
DROP TABLE IF EXISTS typ_narodnost;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS skladba;
DROP TABLE IF EXISTS typ_zanr;

--Vytvaranie tabuliek

CREATE TABLE typ_zanr
(
    id_typ_zanr INT IDENTITY(1,1) PRIMARY KEY ,
    nazev VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE typ_narodnost
(
    id_typ_narodnost INT IDENTITY(1,1) PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL
);

CREATE TABLE interpret
(
    id_interpret INT IDENTITY(1,1) PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL,
    id_typ_narodnost INTEGER,
    FOREIGN KEY (id_typ_narodnost) REFERENCES typ_narodnost(id_typ_narodnost) ON DELETE SET NULL
);

CREATE TABLE album
(
    id_album INT IDENTITY(1,1) PRIMARY KEY ,
    id_typ_zanr INTEGER,
    nazev VARCHAR(100) NOT NULL,
    datum_vydani DATE NOT NULL,
    FOREIGN KEY (id_typ_zanr) REFERENCES typ_zanr(id_typ_zanr) ON DELETE SET NULL
);

CREATE TABLE album_interpret
(
    id_album_interpret INT IDENTITY(1,1) PRIMARY KEY ,
    id_album INTEGER,
    id_interpret INTEGER,
    FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE SET NULL,
    FOREIGN KEY (id_interpret) REFERENCES interpret(id_interpret) ON DELETE SET NULL
);

CREATE TABLE skladba
(
    id_skladba INT IDENTITY(1,1) PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL,
    delka TIME
);

CREATE TABLE album_skladba
(
    id_album_skladba INT IDENTITY(1,1) PRIMARY KEY ,
    cislo_stopy INTEGER NOT NULL,
    id_album INTEGER,
    id_skladba INTEGER,
    FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE SET NULL,
    FOREIGN KEY (id_skladba) REFERENCES skladba(id_skladba) ON DELETE SET NULL
);

--TESTOVACIE DATA

INSERT INTO typ_zanr
    (nazev)
VALUES
    ('hard rock'),
    ('glam metal'),
    ('soft rock');

DECLARE @id_hard_rock INT, @id_glam_metal INT, @id_soft_rock INT;
SET @id_hard_rock = (SELECT id_typ_zanr
FROM typ_zanr
WHERE nazev = 'hard rock');
SET @id_glam_metal = (SELECT id_typ_zanr
FROM typ_zanr
WHERE nazev = 'glam metal');
SET @id_soft_rock = (SELECT id_typ_zanr
FROM typ_zanr
WHERE nazev = 'soft rock');

INSERT INTO typ_narodnost
    (nazev)
VALUES
    ('American'),
    ('Australian'),
    ('Sweden');

DECLARE @id_american INT, @id_australian INT, @id_sweden INT;
SET @id_american = (SELECT id_typ_narodnost
FROM typ_narodnost
WHERE nazev = 'American');
SET @id_australian = (SELECT id_typ_narodnost
FROM typ_narodnost
WHERE nazev = 'Australian');
SET @id_sweden = (SELECT id_typ_narodnost
FROM typ_narodnost
WHERE nazev = 'Sweden');


INSERT INTO skladba
    (nazev, delka)
VALUES
    ('Sweet Child O Mine', '00:05:03'),
    ('Back in Black', '00:04:14'),
    ('Livin on a Prayer', '00:04:09'),
    ('We are Not Gonna Take It', '00:04:32'),
    ('Rock the Night', '00:04:32'),
    ('The Flame', '00:04:41');

DECLARE @id_sweet_child_o_mine INT, @id_back_in_black INT, @id_livin_on_a_prayer INT,
@id_we_are_not_gonna_take_it INT, @id_rock_the_night INT, @id_the_flame INT;
SET @id_sweet_child_o_mine = (SELECT id_skladba
FROM skladba
WHERE nazev = 'Sweet Child O Mine');
SET @id_back_in_black = (SELECT id_skladba
FROM skladba
WHERE nazev = 'Back in Black');
SET @id_livin_on_a_prayer = (SELECT id_skladba
FROM skladba
WHERE nazev = 'Livin on a Prayer');
SET @id_we_are_not_gonna_take_it = (SELECT id_skladba
FROM skladba
WHERE nazev = 'We are Not Gonna Take It');
SET @id_rock_the_night = (SELECT id_skladba
FROM skladba
WHERE nazev = 'Rock the Night');
SET @id_the_flame = (SELECT id_skladba
FROM skladba
WHERE nazev = 'The Flame');

INSERT INTO album
    (id_typ_zanr, nazev, datum_vydani)
VALUES
    (@id_hard_rock, 'Appetite for Destruction', '1987-07-21'),
    (@id_hard_rock, 'Back in Black', '1980-07-25'),
    (@id_glam_metal, 'Slippery When Wet', '1986-08-18'),
    (@id_glam_metal, 'Stay Hungry', '1984-05-10'),
    (@id_glam_metal, 'On the Loose', '1985-04-1'),
    (@id_soft_rock, 'Lap of Luxury', '1988-04-12');

DECLARE @id_appetite_for_destruction INT, @id_back_in_black_album INT, @id_slippery_when_wet INT,
@id_stay_hungry INT, @id_on_the_loose INT, @id_lap_of_luxury INT;
SET @id_appetite_for_destruction = (SELECT id_album
FROM album
WHERE nazev = 'Appetite for Destruction');
SET @id_back_in_black_album = (SELECT id_album
FROM album
WHERE nazev = 'Back in Black');
SET @id_slippery_when_wet = (SELECT id_album
FROM album
WHERE nazev = 'Slippery When Wet');
SET @id_stay_hungry = (SELECT id_album
FROM album
WHERE nazev = 'Stay Hungry');
SET @id_on_the_loose = (SELECT id_album
FROM album
WHERE nazev = 'On the Loose');
SET @id_lap_of_luxury = (SELECT id_album
FROM album
WHERE nazev = 'Lap of Luxury');

INSERT INTO album_skladba
    (cislo_stopy, id_album, id_skladba)
VALUES
    (9, @id_appetite_for_destruction, @id_sweet_child_o_mine),
    (1, @id_back_in_black_album, @id_back_in_black),
    (3, @id_slippery_when_wet, @id_livin_on_a_prayer),
    (1, @id_stay_hungry, @id_we_are_not_gonna_take_it),
    (1, @id_on_the_loose, @id_rock_the_night),
    (3, @id_lap_of_luxury, @id_the_flame);

INSERT INTO interpret
    (nazev, id_typ_narodnost)
VALUES
    ('Guns N Roses', @id_american),
    ('AC/DC', @id_australian),
    ('Bon Jovi', @id_american),
    ('Twisted Sister', @id_american),
    ('Europe', @id_sweden),
    ('Cheap Trick', @id_american);

DECLARE @id_guns_n_roses INT, @id_acdc INT, @id_bon_jovi INT,
@id_twisted_sister INT, @id_europe INT, @id_cheap_trick INT;
SET @id_guns_n_roses = (SELECT id_interpret
FROM interpret
WHERE nazev = 'Guns N Roses');
SET @id_acdc = (SELECT id_interpret
FROM interpret
WHERE nazev = 'AC/DC');
SET @id_bon_jovi = (SELECT id_interpret
FROM interpret
WHERE nazev = 'Bon Jovi');
SET @id_twisted_sister = (SELECT id_interpret
FROM interpret
WHERE nazev = 'Twisted Sister');
SET @id_europe = (SELECT id_interpret
FROM interpret
WHERE nazev = 'Europe');
SET @id_cheap_trick = (SELECT id_interpret
FROM interpret
WHERE nazev = 'Cheap Trick');

INSERT INTO album_interpret
    (id_album, id_interpret)
VALUES
    (@id_appetite_for_destruction, @id_guns_n_roses),
    (@id_back_in_black_album, @id_acdc),
    (@id_slippery_when_wet, @id_bon_jovi),
    (@id_stay_hungry, @id_twisted_sister),
    (@id_on_the_loose, @id_europe),
    (@id_lap_of_luxury, @id_cheap_trick);

--TESTING QUERIES

-- DELETE FROM typ_zanr
-- WHERE nazev = 'horror';

-- INSERT INTO typ_zanr (nazev)
-- VALUES
--     ('horror');

-- INSERT INTO typ_zanr (nazev)
-- VALUES
--     ('documentary');

-- SELECT * FROM typ_zanr;
-- SELECT * FROM typ_narodnost;
-- SELECT * FROM skladba;
-- SELECT * FROM album;
-- SELECT * FROM album_skladba;
-- SELECT * FROM interpret;
-- SELECT * FROM album_interpret;

-- Seznam všech alb včetně interpreta, počtu skladeb na albu. Seřazeno dle názvu interpreta a
-- názvu alba

SELECT
    interpret.nazev AS interpret,
    album.nazev AS album,
    COUNT(album_skladba.id_skladba) AS pocet_songu
FROM album
    LEFT JOIN album_skladba ON album.id_album = album_skladba.id_album
    LEFT JOIN album_interpret ON album.id_album = album_interpret.id_album
    LEFT JOIN interpret ON album_interpret.id_interpret = interpret.id_interpret
GROUP BY interpret.nazev, album.nazev, album.id_album;

-- Najít album včetně interpreta, které obsahuje nejdelší písničku.

SELECT album.nazev AS album, interpret.nazev AS interpret
FROM album
    JOIN album_skladba ON album.id_album = album_skladba.id_album
    JOIN skladba ON album_skladba.id_skladba = skladba.id_skladba
    JOIN album_interpret ON album.id_album = album_interpret.id_album
    JOIN interpret ON album_interpret.id_interpret = interpret.id_interpret
WHERE skladba.delka = (SELECT MAX(delka)
FROM skladba);