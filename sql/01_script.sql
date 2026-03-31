DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS utilisateur_role;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS categorie;
DROP TABLE IF EXISTS utilisateur;

CREATE TABLE utilisateur(
   id SERIAL,
   nom VARCHAR(100)  NOT NULL,
   login VARCHAR(50)  NOT NULL,
   mot_de_passe VARCHAR(255)  NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE categorie(
   id SERIAL,
   designation VARCHAR(50)  NOT NULL,
   couleur_texte VARCHAR(7)  NOT NULL,
   couleur_fond VARCHAR(7)  NOT NULL,
   PRIMARY KEY(id)
);


CREATE TABLE role(
   id SERIAL,
   designation VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE utilisateur_role(
   id SERIAL,
   id_role INTEGER NOT NULL,
   id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_role) REFERENCES role(id),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id)
);

CREATE TABLE article(
   id SERIAL,
   titre VARCHAR(1000)  NOT NULL,
   contenu TEXT NOT NULL,
   date_publication TIMESTAMP NOT NULL,
   slug VARCHAR(50) ,
   url TEXT,
   id_categorie INTEGER NOT NULL,
   id_utilisateur INTEGER NOT NULL,
   date_suppression TIMESTAMP,
   PRIMARY KEY(id),
   UNIQUE(slug),
   FOREIGN KEY(id_categorie) REFERENCES categorie(id),
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id)
);

CREATE TABLE image(
   id SERIAL,
   fichier VARCHAR(2000)  NOT NULL,
   alt VARCHAR(2000)  NOT NULL,
   id_article INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_article) REFERENCES article(id)
);
