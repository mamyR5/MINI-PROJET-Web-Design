INSERT INTO role (designation) VALUES ('Admin');
INSERT INTO role (designation) VALUES ('Consultant');


INSERT INTO utilisateur (nom, login, mot_de_passe) 
VALUES ('Jean Admin', 'admin@blog.com', 'pass123');

INSERT INTO utilisateur (nom, login, mot_de_passe) 
VALUES ('Alice Rédactrice', 'alice@blog.com', 'write456');

INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (1, 1);

INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (2, 2);

INSERT INTO categorie (designation, couleur_texte, couleur_fond) VALUES 
('Politique', '#FFFFFF', '#FF5733'),
('Technologie', '#000000', '#ECF0F1'),
('Armement', '#FFFFFF', '#C0392B');


SELECT a.id, titre, contenu, date_publication, 
                id_categorie, id_utilisateur,designation,couleur_fond,couleur_texte 
                FROM article a 
                JOIN  categorie c 
                ON c.id = a.id_categorie 
                where date_suppression is  null 
                ORDER BY date_publication DESC LIMIT 10