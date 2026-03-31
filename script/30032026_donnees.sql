-- CATEGORIES
INSERT INTO categorie (designation) VALUES ('Diplomatie');
INSERT INTO categorie (designation) VALUES ('Conflits armés');
INSERT INTO categorie (designation) VALUES ('Humanitaire');
INSERT INTO categorie (designation) VALUES ('Sanctions économiques');
INSERT INTO categorie (designation) VALUES ('Nucléaire');

-- ROLES
INSERT INTO role (designation) VALUES ('administrateur');
INSERT INTO role (designation) VALUES ('editeur');

-- UTILISATEURS
INSERT INTO utilisateur (nom, login, mot_de_passe) VALUES ('Admin Principal', 'admin', 'admin123');
INSERT INTO utilisateur (nom, login, mot_de_passe) VALUES ('Jean Dupont', 'jean.dupont', 'pass123');
INSERT INTO utilisateur (nom, login, mot_de_passe) VALUES ('Marie Martin', 'marie.martin', 'pass123');

-- UTILISATEUR_ROLE
INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (1, 1);
INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (2, 2);
INSERT INTO utilisateur_role (id_role, id_utilisateur) VALUES (2, 3);

-- ARTICLES
INSERT INTO article (titre, contenu, date_publication, id_categorie, id_utilisateur)
VALUES (
    'Négociations à Genève : un cessez-le-feu fragile sous pression internationale',
    '<h2>Contexte des négociations</h2>
     <p>Les représentants de plusieurs nations se sont réunis à Genève pour tenter de trouver un accord durable sur le conflit iranien. La situation reste tendue malgré les avancées diplomatiques enregistrées ces derniers jours.</p>
     <h2>Les points de blocage</h2>
     <p>Plusieurs points restent en suspens, notamment la question des zones démilitarisées et le retrait des forces étrangères présentes sur le territoire. Les négociateurs ont exprimé leur volonté de parvenir à un accord avant la fin du mois.</p>
     <h2>Réactions internationales</h2>
     <p>La communauté internationale suit avec attention ces pourparlers. Les États-Unis et l Union européenne ont salué les efforts diplomatiques tout en appelant à la prudence.</p>',
    '2026-03-29 08:00:00',
    1, 1
);

INSERT INTO article (titre, contenu, date_publication, id_categorie, id_utilisateur)
VALUES (
    'Crise humanitaire : des milliers de déplacés dans le nord du pays',
    '<h2>Une situation alarmante</h2>
     <p>Les organisations humanitaires internationales tirent la sonnette d alarme face à l afflux massif de populations déplacées dans le nord de l Iran. Plus de 50 000 personnes auraient quitté leurs foyers depuis le début des hostilités.</p>
     <h2>Manque de ressources</h2>
     <p>Les camps de réfugiés installés à la hâte manquent cruellement de nourriture, d eau potable et de soins médicaux. Le HCR a lancé un appel urgent aux dons internationaux pour faire face à cette situation d urgence.</p>
     <h2>Témoignages</h2>
     <p>De nombreux civils témoignent de conditions de vie difficiles. Les familles sont souvent séparées et les enfants sont les premières victimes de cette crise sans précédent.</p>',
    '2026-03-28 10:30:00',
    3, 2
);

INSERT INTO article (titre, contenu, date_publication, id_categorie, id_utilisateur)
VALUES (
    'Nouvelles sanctions économiques : impact sur la population iranienne',
    '<h2>Un nouveau train de sanctions</h2>
     <p>Le Conseil de sécurité de l ONU a adopté un nouveau train de sanctions visant les secteurs clés de l économie iranienne. Ces mesures ciblent principalement le secteur pétrolier et le système bancaire.</p>
     <h2>Conséquences sur le quotidien</h2>
     <p>Les économistes alertent sur les conséquences directes de ces sanctions sur la population civile. L inflation a atteint des niveaux records et la monnaie nationale continue de se déprécier face au dollar.</p>
     <h2>Réponse du gouvernement iranien</h2>
     <p>Le gouvernement iranien a dénoncé ces sanctions comme une forme de guerre économique et a annoncé des mesures pour protéger les secteurs stratégiques de l économie nationale.</p>',
    '2026-03-27 14:00:00',
    4, 1
);

INSERT INTO article (titre, contenu, date_publication, id_categorie, id_utilisateur)
VALUES (
    'Rapport de l AIEA : situation nucléaire sous haute surveillance',
    '<h2>Dernières inspections</h2>
     <p>L Agence Internationale de l Énergie Atomique a publié son rapport trimestriel sur les installations nucléaires iraniennes. Les inspecteurs font état d une activité accrue dans plusieurs sites sensibles.</p>
     <h2>Enrichissement de l uranium</h2>
     <p>Selon le rapport, le taux d enrichissement de l uranium a atteint des niveaux préoccupants. Les experts estiment que l Iran dispose désormais de suffisamment de matière fissile pour produire plusieurs bombes atomiques.</p>
     <h2>Position des grandes puissances</h2>
     <p>Les membres permanents du Conseil de sécurité se sont réunis en urgence pour examiner les conclusions du rapport. Une réunion extraordinaire du Conseil de sécurité est prévue la semaine prochaine.</p>',
    '2026-03-26 09:00:00',
    5, 3
);

INSERT INTO article (titre, contenu, date_publication, id_categorie, id_utilisateur)
VALUES (
    'Offensive militaire dans la région de Téhéran : bilan et perspectives',
    '<h2>Déroulement des opérations</h2>
     <p>Une offensive militaire d envergure a été lancée dans la région de Téhéran. Les forces en présence s affrontent depuis plusieurs jours dans des combats intenses qui ont causé de nombreuses victimes civiles et militaires.</p>
     <h2>Bilan provisoire</h2>
     <p>Le bilan provisoire fait état de plusieurs centaines de morts et de milliers de blessés. Les infrastructures civiles ont été lourdement touchées, notamment les hôpitaux et les réseaux d eau et d électricité.</p>
     <h2>Appel au cessez-le-feu</h2>
     <p>Face à l escalade de la violence, plusieurs pays ont lancé un appel urgent au cessez-le-feu. Les Nations Unies ont dépêché un envoyé spécial pour tenter de stopper les combats.</p>',
    '2026-03-25 16:00:00',
    2, 2
);

-- ROLES
INSERT INTO role (designation) VALUES ('administrateur');
-- IMAGES (une par article)
INSERT INTO image (fichier, alt, id_article)
VALUES ('nego-gen1.jpeg', 'Négociations de paix à Genève entre diplomates internationaux', 1);
INSERT INTO image (fichier, alt, id_article)
VALUES ('nego-gen2.jpeg', 'Négociations de paix à Genève entre diplomates internationaux', 1);
INSERT INTO image (fichier, alt, id_article)
VALUES ('nego-gen3.jpeg', 'Négociations de paix à Genève entre diplomates internationaux', 1);

INSERT INTO image (fichier, alt, id_article)
VALUES ('crise-hum1.jpg', 'Camp de réfugiés iraniens dans le nord du pays', 2);
INSERT INTO image (fichier, alt, id_article)
VALUES ('crise-hum2.jpg', 'Camp de réfugiés iraniens dans le nord du pays', 2);

INSERT INTO image (fichier, alt, id_article)
VALUES ('sanction_economique1.jpg', 'Marché iranien touché par les sanctions économiques', 3);
INSERT INTO image (fichier, alt, id_article)
VALUES ('sanction_economique2.jpg', 'Marché iranien touché par les sanctions économiques', 3);
INSERT INTO image (fichier, alt, id_article)
VALUES ('sanction_economique3.jpg', 'Marché iranien touché par les sanctions économiques', 3);

INSERT INTO image (fichier, alt, id_article)
VALUES ('iaea-nucleaire1.jpeg', 'Installation nucléaire iranienne sous surveillance de l AIEA', 4);
INSERT INTO image (fichier, alt, id_article)
VALUES ('iaea-nucleaire2.jpg', 'Installation nucléaire iranienne sous surveillance de l AIEA', 4);

INSERT INTO image (fichier, alt, id_article)
VALUES ('conflit-arme1.jpg', 'Vue aérienne de la région de Téhéran durant le conflit', 5);

INSERT INTO image (fichier, alt, id_article)
VALUES ('conflit-arme2.jpg', 'Vue aérienne de la région de Téhéran durant le conflit', 5);

INSERT INTO image (fichier, alt, id_article)
VALUES ('conflit-arme3.jpg', 'Vue aérienne de la région de Téhéran durant le conflit', 5);