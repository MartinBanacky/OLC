
-- Copyright 2023 Martin Baňacký

-- All rights reserved.


DROP TABLE IF EXISTS album_interpret;
DROP TABLE IF EXISTS album_skladba;
DROP TABLE IF EXISTS interpret;
DROP TABLE IF EXISTS typ_narodnost;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS skladba;
DROP TABLE IF EXISTS typ_zanr;


CREATE TABLE typ_zanr( 
    id_typ_zanr INTEGER PRIMARY KEY ,
    nazev VARCHAR(30) NOT NULL
);

CREATE TABLE typ_narodnost( 
    id_typ_narodnost INTEGER PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL
);

CREATE TABLE interpret( 
    id_interpret INTEGER PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL,
    id_typ_narodnost INTEGER,
    FOREIGN KEY (id_typ_narodnost) REFERENCES typ_narodnost(id_typ_narodnost)
);

CREATE TABLE album( 
    id_album INTEGER PRIMARY KEY ,
    id_typ_zanr INTEGER,
    nazev VARCHAR(100) NOT NULL,
    datum_vydani DATE NOT NULL,
    FOREIGN KEY (id_typ_zanr) REFERENCES typ_zanr(id_typ_zanr) ON DELETE SET NULL
);

CREATE TABLE album_interpret( 
    id_album_interpret INTEGER PRIMARY KEY ,
    id_album INTEGER,
    id_interpret INTEGER,
    FOREIGN KEY (id_album) REFERENCES album(id_album),
    FOREIGN KEY (id_interpret) REFERENCES interpret(id_interpret)
);

CREATE TABLE skladba( 
    id_skladba INTEGER PRIMARY KEY ,
    nazev VARCHAR(50) NOT NULL,
    delka TIME
);

CREATE TABLE album_skladba( 
    id_album_skladba INTEGER PRIMARY KEY ,
    cislo_stopy INTEGER NOT NULL,
    id_album INTEGER,
    id_skladba INTEGER,
    FOREIGN KEY (id_album) REFERENCES album(id_album),
    FOREIGN KEY (id_skladba) REFERENCES skladba(id_skladba)
);

