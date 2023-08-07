
-- Copyright  2023 Martin Baňacký

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
    nazev VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE interpret
(
    id_interpret INT IDENTITY(1,1) PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL UNIQUE,
    id_typ_narodnost INTEGER,
    FOREIGN KEY (id_typ_narodnost) REFERENCES typ_narodnost(id_typ_narodnost) ON DELETE SET NULL
);

CREATE TABLE album
(
    id_album INT IDENTITY(1,1) PRIMARY KEY ,
    id_typ_zanr INTEGER,
    nazev VARCHAR(100) NOT NULL UNIQUE,
    datum_vydani DATE NOT NULL,
    FOREIGN KEY (id_typ_zanr) REFERENCES typ_zanr(id_typ_zanr) ON DELETE SET NULL
);

CREATE TABLE album_interpret
(
    id_album_interpret INT IDENTITY(1,1) PRIMARY KEY ,
    id_album INTEGER,
    id_interpret INTEGER,
    FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE SET NULL,
    FOREIGN KEY (id_interpret) REFERENCES interpret(id_interpret) ON DELETE SET NULL,
    CONSTRAINT UC_AlbumInterpert UNIQUE (id_album, id_interpret)
);

CREATE TABLE skladba
(
    id_skladba INT IDENTITY(1,1) PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL UNIQUE,
    delka TIME
);

CREATE TABLE album_skladba
(
    id_album_skladba INT IDENTITY(1,1) PRIMARY KEY ,
    cislo_stopy INTEGER NOT NULL,
    id_album INTEGER,
    id_skladba INTEGER,
    FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE SET NULL,
    FOREIGN KEY (id_skladba) REFERENCES skladba(id_skladba) ON DELETE SET NULL,
    CONSTRAINT UC_StopaAlbum UNIQUE (cislo_stopy, id_album),
    CONSTRAINT AlbumSkladba UNIQUE (id_album,id_skladba)
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
    ('Swedish');

DECLARE @id_american INT, @id_australian INT, @id_swedish INT;
SET @id_american = (SELECT id_typ_narodnost
FROM typ_narodnost
WHERE nazev = 'American');
SET @id_australian = (SELECT id_typ_narodnost
FROM typ_narodnost
WHERE nazev = 'Australian');
SET @id_swedish = (SELECT id_typ_narodnost
FROM typ_narodnost
WHERE nazev = 'Swedish');

INSERT INTO skladba
    (nazev, delka)
VALUES
    ('Sweet Child O Mine', '00:05:03'),
    ('Back in Black', '00:04:14'),
    ('Livin on a Prayer', '00:04:09'),
    ('We are Not Gonna Take It', '00:04:32'),
    ('Rock the Night', '00:04:32'),
    ('The Flame', '00:04:41');

INSERT INTO album
    (id_typ_zanr, nazev, datum_vydani)
VALUES
    (@id_hard_rock, 'Appetite for Destruction', '1987-07-21'),
    (@id_hard_rock, 'Back in Black', '1980-07-25'),
    (@id_glam_metal, 'Slippery When Wet', '1986-08-18'),
    (@id_glam_metal, 'Stay Hungry', '1984-05-10'),
    (@id_glam_metal, 'On the Loose', '1985-04-1'),
    (@id_soft_rock, 'Lap of Luxury', '1988-04-12');

INSERT INTO album_skladba
    (cislo_stopy, id_album, id_skladba)
VALUES
    (9,
        (SELECT id_album
        FROM album
        WHERE nazev = 'Appetite for Destruction'),
        (SELECT id_skladba
        FROM skladba
        WHERE nazev = 'Sweet Child O Mine')),
    (1,
        (SELECT id_album
        FROM album
        WHERE nazev = 'Back in Black'),
        (SELECT id_skladba
        FROM skladba
        WHERE nazev = 'Back in Black')),
    (3,
        (SELECT id_album
        FROM album
        WHERE nazev = 'Slippery When Wet'),
        (SELECT id_skladba
        FROM skladba
        WHERE nazev = 'Livin on a Prayer')),
    (1,
        (SELECT id_album
        FROM album
        WHERE nazev = 'Stay Hungry'),
        (SELECT id_skladba
        FROM skladba
        WHERE nazev = 'We are Not Gonna Take It')),
    (1,
        (SELECT id_album
        FROM album
        WHERE nazev = 'On the Loose'),
        (SELECT id_skladba
        FROM skladba
        WHERE nazev = 'Rock the Night')),
    (3,
        (SELECT id_album
        FROM album
        WHERE nazev = 'Lap of Luxury'),
        (SELECT id_skladba
        FROM skladba
        WHERE nazev = 'The Flame'));

INSERT INTO interpret
    (nazev, id_typ_narodnost)
VALUES
    ('Guns N Roses', @id_american),
    ('AC/DC', @id_australian),
    ('Bon Jovi', @id_american),
    ('Twisted Sister', @id_american),
    ('Europe', @id_swedish),
    ('Cheap Trick', @id_american);

INSERT INTO album_interpret
    (id_album, id_interpret)
VALUES
    ((SELECT id_album
        FROM album
        WHERE nazev = 'Appetite for Destruction'),
        (SELECT id_interpret
        FROM interpret
        WHERE nazev = 'Guns N Roses')),
    ((SELECT id_album
        FROM album
        WHERE nazev = 'Back in Black'),
        (SELECT id_interpret
        FROM interpret
        WHERE nazev = 'AC/DC')),
    ((SELECT id_album
        FROM album
        WHERE nazev = 'Slippery When Wet'),
        (SELECT id_interpret
        FROM interpret
        WHERE nazev = 'Bon Jovi')),
    ((SELECT id_album
        FROM album
        WHERE nazev = 'Stay Hungry'),
        (SELECT id_interpret
        FROM interpret
        WHERE nazev = 'Twisted Sister')),
    ((SELECT id_album
        FROM album
        WHERE nazev ='On the Loose'),
        (SELECT id_interpret
        FROM interpret
        WHERE nazev = 'Europe')),
    ((SELECT id_album
        FROM album
        WHERE nazev = 'Lap of Luxury'),
        (SELECT id_interpret
        FROM interpret
        WHERE nazev = 'Cheap Trick'));

--TESTING QUERIES

-- DELETE FROM typ_zanr
-- WHERE nazev = 'horror';

-- INSERT INTO typ_zanr (nazev)
-- VALUES
--     ('horror');

-- INSERT INTO typ_zanr (nazev)
-- VALUES
--     ('documentary');

-- INSERT INTO album_skladba
--     (cislo_stopy, id_album, id_skladba)
-- VALUES
--     (9,
--         (SELECT id_album
--         FROM album
--         WHERE nazev = 'Appetite for Destruction'),
--         (SELECT id_skladba
--         FROM skladba
--         WHERE nazev = 'Sweet Child O Mine'));

-- INSERT INTO album_interpret
--     (id_album, id_interpret)
-- VALUES
--     ((SELECT id_album
--         FROM album
--         WHERE nazev = 'Appetite for Destruction'),
--     (SELECT id_interpret
--         FROM interpret
--         WHERE nazev = 'Guns N Roses'));

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