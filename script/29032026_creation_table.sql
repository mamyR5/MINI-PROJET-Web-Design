CREATE TABLE utilisateur(
   id SERIAL,
   nom VARCHAR(100)  NOT NULL,
   login VARCHAR(50)  NOT NULL,
   mot_de_passe VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE categorie(
   id SERIAL,
   designation VARCHAR(50)  NOT NULL,
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
   id_categorie INTEGER NOT NULL,
   id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(id),
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