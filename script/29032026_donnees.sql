-- TABLE ROLE
INSERT INTO role (designation) VALUES ('administrateur');
INSERT INTO role (designation) VALUES ('editeur');

-- TABLE UTILISATEUR
-- Ici on met des valeurs simples pour le TP
INSERT INTO utilisateur (nom, login, mot_de_passe) VALUES ('Admin Principal', 'admin', 'admin123');
INSERT INTO utilisateur (nom, login, mot_de_passe) VALUES ('Jean Dupont', 'jean.dupont', 'pass123');
INSERT INTO utilisateur (nom, login, mot_de_passe) VALUES ('Marie Martin', 'marie.martin', 'pass123');

-- TABLE UTILISATEUR_ROLE
-- admin (id=1) → administrateur (id=1)
INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (1, 1);
-- jean.dupont (id=2) → editeur (id=2)
INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (2, 2);
-- marie.martin (id=3) → editeur (id=2)
INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (2, 3);
