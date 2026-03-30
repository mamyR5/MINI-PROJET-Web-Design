INSERT INTO role (designation) VALUES ('Admin');
INSERT INTO role (designation) VALUES ('Consultant');


INSERT INTO utilisateur (nom, login, mot_de_passe) 
VALUES ('Jean Admin', 'admin@blog.com', 'pass123');

INSERT INTO utilisateur (nom, login, mot_de_passe) 
VALUES ('Alice Rédactrice', 'alice@blog.com', 'write456');

INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (1, 1);

INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (2, 2);
