DROP TABLE IF EXISTS Personne;
DROP TABLE IF EXISTS Bar;
DROP TABLE IF EXISTS Brasserie;
DROP TABLE IF EXISTS Biere;
DROP TABLE IF EXISTS vend;
DROP TABLE IF EXISTS bois;
CREATE TABLE Personne(
     id int UNIQUE,
     nomB varchar(100), 
     PrenomB varchar(100), 
     adresse_domicile varchar(100),
     telephone varchar(10)
     CONSTRAINT PK_Personne PRIMARY KEY(id),
);
CREATE TABLE Bar(
     id int UNIQUE,
     nomB varchar(100), 
     adresse varchar(100), 
     patron int,
     CONSTRAINT PK_Bar PRIMARY KEY(id),
     FOREIGN KEY ( patron ) REFERENCES Personne ( id )
);
CREATE TABLE Brasserie(
     id int UNIQUE,
     nom varchar(100),
     adresse varchar(100), 
     patron int,
     CONSTRAINT PK_Brasserie PRIMARY KEY(id),
     FOREIGN KEY ( patron ) REFERENCES Personne ( id )
);
CREATE TABLE Biere(
     id int UNIQUE,
     nom varchar(100),
     degré short,
     brasserie int,
     CONSTRAINT PK_Biere PRIMARY KEY(id),
     FOREIGN KEY ( brasserie ) REFERENCES Brasserie ( id )
     ON DELETE CASCADE
);

CREATE TABLE vend(
    bar int,
    Biere int,
    prix float,
    CONSTRAINT PK_Vend PRIMARY KEY(bar, client),
    FOREIGN KEY ( bar ) REFERENCES bar ( id ),
    FOREIGN KEY ( Biere ) REFERENCES Biere ( id ),
    ON DELETE CASCADE
);

CREATE TABLE bois(
    client int,
    bar int,
    Biere int,
    quantite int CHECK (quantite >0),
    CONSTRAINT PK_Bois PRIMARY KEY(bar, client),
    FOREIGN KEY ( client ) REFERENCES client ( id ),
    FOREIGN KEY ( bar ) REFERENCES bar ( id ),
    FOREIGN KEY ( Biere ) REFERENCES Biere ( id ),
    ON DELETE CASCADE
);

CREATE TABLE produis(
    brasserie int,
    Biere int,
    CONSTRAINT PK_Produit PRIMARY KEY(bar, client),
    FOREIGN KEY ( brasserie ) REFERENCES brasserie ( id ),
    FOREIGN KEY ( Biere ) REFERENCES Biere ( id ),
    ON DELETE CASCADE
);
INSERT INTO Personne (id, nomB, PrenomB, adresse_domicile, telephone) VALUES
(1, 'Dupont', 'Jean', '12 rue de la Soif, Paris', '0601020304'),
(2, 'Lefebvre', 'Marie', '5 avenue du Houblon, Lille', '0611223344'),
(3, 'Durand', 'Lucas', '45 boulevard Tech, Lyon', '0788990011'),
(4, 'Martin', 'Julie', '8 impasse du Code, Grenoble', '0655443322'),
(5, 'Petit', 'Thomas', '22 rue Java, Bordeaux', '0699887766');

INSERT INTO Brasserie (id, nom, adresse, patron) VALUES
(1, 'Brasserie du Mont Blanc', 'Chambéry', 1),
(2, 'Brasserie de la Paix', 'Lille', 2),
(3, 'Micro-brasserie du Geek', 'Grenoble', 3);

INSERT INTO Bar (id, nomB, adresse, patron) VALUES
(1, 'Le Terminal', 'Place de la Gare, Grenoble', 3),
(2, 'L''After Work', 'Quartier d''affaires, Lyon', 4),
(3, 'La Chope ', 'Centre ville, Lille', 2);

INSERT INTO Biere (id, nom, degré, brasserie) VALUES
(1, 'La Binaire', 5, 3),
(2, 'La 404 Not Found', 8, 3),
(3, 'Blanche des Cimes', 4, 1),
(4, 'L''Ambrée du Nord', 6, 2),
(5, 'La Kernel Panic', 10, 3);

INSERT INTO vend (bar, Biere, prix) VALUES
(1, 1, 5.50),
(1, 2, 7.00),
(1, 5, 8.50),
(2, 3, 6.00),
(2, 5, 9.00),
(3, 4, 5.00),
(3, 3, 6.50);

INSERT INTO bois (client, bar, Biere, quantite) VALUES
(4, 1, 1, 2),
(5, 1, 5, 1),
(1, 3, 4, 3),
(4, 2, 5, 1);