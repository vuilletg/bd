
DROP TABLE IF EXISTS avis;
DROP TABLE IF EXISTS bois;
DROP TABLE IF EXISTS vend;
DROP TABLE IF EXISTS Biere;
DROP TABLE IF EXISTS Bar;
DROP TABLE IF EXISTS Brasserie;
DROP TABLE IF EXISTS Personne;

CREATE TABLE Personne(
     id int PRIMARY KEY,
     nomB varchar(100), 
     PrenomB varchar(100), 
     adresse_domicile varchar(100),
     telephone varchar(10)
);

CREATE TABLE Bar(
     id int PRIMARY KEY,
     nomB varchar(100), 
     adresse varchar(100), 
     patron int,
     FOREIGN KEY (patron) REFERENCES Personne(id)
);

CREATE TABLE Brasserie(
     id int PRIMARY KEY,
     nom varchar(100),
     adresse varchar(100), 
     patron int,
     FOREIGN KEY (patron) REFERENCES Personne(id)
);

CREATE TABLE Biere(
     id int PRIMARY KEY,
     nom varchar(100),
     degré float,
     brasserie int,
     FOREIGN KEY (brasserie) REFERENCES Brasserie(id) ON DELETE CASCADE
);

CREATE TABLE vend(
    bar int,
    Biere int,
    prix float,
    CONSTRAINT PK_Vend PRIMARY KEY(bar, Biere),
    FOREIGN KEY (bar) REFERENCES Bar(id),
    FOREIGN KEY (Biere) REFERENCES Biere(id) ON DELETE CASCADE
);

CREATE TABLE bois(
    client int,
    bar int,
    Biere int,
    quantite int CHECK (quantite > 0),
    CONSTRAINT PK_Bois PRIMARY KEY(client, bar, Biere),
    FOREIGN KEY (client) REFERENCES Personne(id),
    FOREIGN KEY (bar) REFERENCES Bar(id),
    FOREIGN KEY (Biere) REFERENCES Biere(id) ON DELETE CASCADE
);

CREATE TABLE avis(
    personne int,
    bar int,
    note int CHECK (note >= 0 AND note <= 10),
    CONSTRAINT PK_Avis PRIMARY KEY(personne, bar),
    FOREIGN KEY (personne) REFERENCES Personne(id),
    FOREIGN KEY (bar) REFERENCES Bar(id) ON DELETE CASCADE
);

-- Insertion des données
INSERT INTO Personne VALUES
(1, 'Coic', 'Nouelig', '12 rue de la Soif', '0601020304'),
(2, 'Galand', 'Benedig', '5 avenue du Houblon', '0611223344'),
(3, 'Kerbellec', 'Nolwennig', '45 boulevard du cidre', '0788990011'),
(4, 'Broudic', 'Gaidig', '8 impasse du doliprane', '0655443322'),
(5, 'Queffelec', 'Gwennaig', '22 rue Michao', '0969394020'),
(6, 'Quenoualut', 'Rozenn', '1 Allée de la gallette', '117217'),
(7, 'Kermarrec', 'Kadec', '10 route à 3 gramme', '3630');

INSERT INTO Brasserie VALUES
(1, 'Brasserie du paumau', 'Painpol', 1),
(2, 'Brasserie celique', 'Ploubazlanec', 2),
(3, 'cuvée Saint-Michel', 'Quibron', 3),
(4, 'La cave de Nolwenn', 'Lorien', 6);

INSERT INTO Bar VALUES
(1, 'Le Tri yann', 'Place de la Pluie', 3),
(2, 'Le Bon Normand', 'Quartier du drapeau', 4),
(3, 'La Chope', 'Centre ville', 2),
(4, 'La maison Loïc', 'Rue des moulles frites', 6);

INSERT INTO Biere VALUES
(1, 'La Kenavo', 5.0, 3),
(2, 'Blanche et noire', 8.5, 3),
(3, 'Blanche d''Ouessant', 4.2, 1),
(4, 'La ciré jaune', 6.0, 2),
(5, 'La Bigoudaine', 12.0, 3),
(6, 'La blonde de Nantes', 9.0, 4),
(7, 'La Bro Gozh Ma Zadoù', 5.5, 4);

INSERT INTO vend VALUES
(1, 1, 5.50), (1, 2, 7.00), (1, 5, 8.50),
(2, 3, 6.00), (2, 5, 9.00),
(3, 4, 5.00), (3, 3, 6.50),
(4, 6, 11.0), (4, 7, 10.5), (4, 1, 9.5);

INSERT INTO bois VALUES
(4, 1, 1, 2), (5, 1, 5, 1), (1, 3, 4, 3), (4, 2, 5, 1),
(7, 4, 6, 4), (6, 4, 7, 2), (2, 3, 3, 5);

INSERT INTO avis VALUES
(4, 1, 9), (5, 1, 7), (1, 3, 8), (7, 4, 10), (2, 2, 4), (4, 3, 1);