DROP TABLE IF EXISTS Conference;
DROP TABLE IF EXISTS Utilisateur;
DROP TABLE IF EXISTS ResponsabiliteConference;
DROP TABLE IF EXISTS Auteur;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS Article;
DROP TABLE IF EXISTS ResponsableTrack;
DROP TABLE IF EXISTS ComiteLecture;
DROP TABLE IF EXISTS Rapport;
DROP TABLE IF EXISTS Commentaire;
                           
                               
CREATE TABLE Conference(
	ID_conf INT NOT NULL,
	annee INT NOT NULL, 
	titre VARCHAR (50),
	date_soumission_abstract DATE NOT NULL,
	date_soumission_papier DATE NOT NULL,
	date_debut_conf DATE NOT NULL,
	date_fin_conf DATE NOT NULL,
	URLweb VARCHAR(60),
	resume VARCHAR,
	motscles VARCHAR(60),
	PRIMARY KEY(ID_conf,annee),fashion job
	CONSTRAINT Conference_date_article CHECK (date_soumission_abstract <= date_soumission_papier),
	CONSTRAINT Conference_date_conf CHECK (date_debut_conf) <= date_fin_conf)  	
);

CREATE TABLE Utilisateur(
	email VARCHAR, 
	prenom VARCHAR(25),
	nom VARCHAR(25),
	institution VARCHAR,
	PRIMARY KEY(email)
);



CREATE TABLE Auteur(
	email VARCHAR,
	login VARCHAR,
	motdepasse VARCHAR,
	pageweb VARCHAR,
	domainedexpertise VARCHAR,
	PRIMARY KEY(email),
	FOREIGN KEY (email) REFERENCES Utilisateur(email) 
);


CREATE TABLE ResponsabiliteConference(
	ID_conf INT,
	annee INT,
	email VARCHAR,
	PRIMARY KEY(ID_conf,annee),
  	FOREIGN KEY(email) REFERENCES Utilisateur(email),
  	FOREIGN KEY(ID_conf,annee) REFERENCES Conference(ID_conf,annee)
);

CREATE TABLE Track(
	ID_track INT,
	titre VARCHAR,
	ID_conf INT,
	annee INT,
	PRIMARY KEY(ID_track),
  	FOREIGN KEY(ID_conf,annee) REFERENCES Conference(ID_conf,annee)
);                                         

CREATE TABLE ResponsableTrack(
	ID_track INT,
	email VARCHAR,
	PRIMARY KEY(ID_track),
  	FOREIGN KEY(email) REFERENCES Utilisateur(email),
  	FOREIGN KEY(ID_track) REFERENCES Track(ID_track)
);

CREATE TABLE ComiteLecture(
 	ID_track INT,
	email VARCHAR,
  	PRIMARY KEY(ID_track,email),
  	FOREIGN KEY(email) REFERENCES Utilisateur(email),
  	FOREIGN KEY(ID_track) REFERENCES Track(ID_track)
);

CREATE TABLE Article(
	article_ID INT,
	ID_track INT,
	titre VARCHAR,
	resume VARCHAR,
	motscles VARCHAR,
	fichier_pdf VARCHAR,
	decision VARCHAR,
  	date_soumission_abstract DATE,
  	date_soumission_article DATE,
	PRIMARY KEY(article_ID),
  	FOREIGN KEY(ID_track) REFERENCES Track(ID_track),
  	CONSTRAINT date_article CHECK(date_soumission_abstract <= date_soumission_article),
  	CONSTRAINT decision CHECK (decision IN('refuse','accepte'))
);

CREATE TABLE Coauteurs_article(
	article_ID INT,
	email VARCHAR,
	principal BIT, #vaut 1 si auteur principal 0 sinon#
	PRIMARY KEY(article_ID,email),
	FOREIGN KEY(article_ID) REFERENCES Article(article_ID),
	FOREIGN KEY(email) REFERENCES Auteur(email),
	CONSTRAINT nb_principal CHECK (count(
);


CREATE TABLE Rapport(
	article_ID INT,
	ID_track INT,
	email VARCHAR,
	Evaluation VARCHAR,
	PRIMARY KEY(article_ID,ID_track,email),
  	FOREIGN KEY (article_ID) REFERENCES Article(article_ID),
	FOREIGN KEY (ID_track,email) REFERENCES ComiteLecture(ID_track,email),
	CONSTRAINT decision CHECK (decision IN('refuse','accepte'))
);


CREATE TABLE Commentaire(
	ID_commentaire INT,
	article_ID INT,
	ID_track INT,
	email VARCHAR,
	textecommentaire VARCHAR,
	PRIMARY KEY(ID_commentaire),
  	FOREIGN KEY(article_ID,ID_track,email) REFERENCES Rapport(article_ID,ID_track,email)
);

INSERT INTO Conference VALUES 
(1,2020,'Rethinking the value of technology in 2020','2020/02/01','2020/02/15','2020/03/03','2020/03/05','www.rethinktechno2020.com',
'The conference takes place in Stockholm. During theses three days, you will hear our speakers discuss about the impact of new technologies in our societies for the next decade.',
'data science' 'industrie4.0'),
(2,2020,'Popularisation of science','2020/03/01','2020/03/15','2020/04/04','2020/04/05','www.scienceforall.com',
'The goal of this conference is to show new ways of acquiring knowledge in science. We hope that everyone can have fun and be curious in their learning process.',
'learning' 'sciences' 'easy') ;


INSERT INTO Utilisateur VALUES 
('albertdupont@gmail.com', 'Albert','Dupont','Universite Paris Dauphine' ),
('jean.pascal@hotmail.fr', 'Jean', 'Pascal','UPMC'),
('lisa.campbell@gmail.com','Lisa','Campbell','London Investors'),
('michael.jordan@gmail.com','Michael','Jordan','Harvard'),
('emily.thompson@hotmail.com','Emily','Thompson','MIT'),
('marc-lucas@yahoo.com', 'Marc', 'Lucas','Centre de nanosciences et nanotechnologies'),
('nicolas.petit@gmail.com', 'Nicolas','Petit','Centre de nanosciences et nanotechnologies'),
('john.doe@gmail.com','John','Doe','Stanford'),
('jane-mendes@hotmail.com','Jane','Mendes','Harvard'),
('jimmy.wales@gmail.com', 'Jimmy', 'Wales', 'Stanford'),
('melanie.perkins@gmail.com','Melanie','Perkins','Stanford'),
('gary-norton@gmail.com','Gary','Norton','MIT'),
('bob.green@hotmail.com','Bob','Green','Oxford'),
('betty_thomas@gmail.com','Betty','Thomas','Cambridge')
('marie.leclerc@gmail.com','Marie','Leclerc','Universite Paris Dauphine')
('philip.wilson@gmail.com','Philip','Wilson','Cambridge')
('camille.martin@yahoo.fr','Camille','Martin','Universite Descartes'),
('lena.scott@gmail.com','Lena','Scott','UCLA'),
('max-cole@live.com','Max','Cole','Cambridge'),
('rachel.evans@gmail.com','Rachel','Evans','UCLA'),
('mike.specter@hotmail.com','Mike','Specter','Harvard'),
('jessica.landson@gmail.com','Jessica','Landson','MIT'),
('matthew.perry@gmail.com','Matthew','Perry','Stanford'),
('louis.armand@gmail.com', 'Louis','Armand','Universite Paris Dauphine'),
('michel.collins@hotmail.fr','Michel','Collins','MIT'),
('alex.clint@gmail.com','Alex','Clint','Oxford'),
('ana.nicols@gmail.com','Ana','Nicols','NYU'),
('leonard.stark@gmail.com','Leonard','Stark','NYU'),
('lindsay.watson@gmail.com','Lindsay','Watson','Stanford'),
('yann_cooper@gmail.com','Yann','Cooper','UCLA'),
('amanda.simons@gmail.com','Amanda','Simons','Stanford')
('lily.james@gmail.com','Lily','James','Harvard')
('julian.dean@gmail.com','Julian','Dean','Oxford')
;


INSERT INTO Auteur VALUES 
('lisa.campbell@gmail.com', 'lisacampbell', 'LisaC11039', 'www.lisa-campbell.com', 'Bitcoin and fintech'),
('michael.jordan@gmail.com', 'michaeljordan', 'MJActuary', 'www.mj-actuary.com', 'Actuarial Science, Data Science'),
('emily.thompson@hotmail.com', 'emilythompson', 'EMTHOMPSON34', 'www.em-thompson.com', ' AI '),
('marc-lucas@yahoo.com', 'marclucas', 'Lucas-MARC-9438', 'www.nanotech-lucas-marc.com', 'Nanotechnologies'),
('nicolas.petit@gmail.com', 'nicolaspetit', 'Petit-453-physics', 'https://www.nicolas.petit.fr/', 'Data Science, AI'),
('john.doe@gmail.com', 'johndoe', 'Password432', 'www.john.doe.com', 'Machine learning, AI'),
('jane-mendes@hotmail.com', 'janemendes', 'MendesJane24', 'www.janemendes.com', 'Cybersecurity'),
('jimmy.wales@gmail.com', 'jimmywales', 'WIKIwales', 'www.jimmy-wales.com', 'Internet technologies'),
('melanie.perkins@gmail.com', 'melanieperkins', 'MELperk345', 'www.melanieperkins.com', 'Energy research'),
('gary-norton@gmail.com', 'garynorton', 'NORTON334455', 'www.garynorton.com', 'Bioengineering'),
('bob.green@hotmail.com','bobgreen','123456','www.bobgreen.com','computer science'),
('betty_thomas@gmail.com','bettythomas','66486','www.betty_thomas.com','data science'),
('marie.leclerc@gmail.com','marieleclerc','Marieleclerc','www.marie-leclerc.com','new technologies'),
('philip.wilson@gmail.com','philipthomas','35435','www.philipthomas.com','Finance,data science')
;

INSERT INTO ResponsabiliteConference VALUES
(1,2020,'albertdupont@gmail.com'),
(2,2020,'jean.pascal@hotmail.fr')
;

INSERT INTO Track VALUES
(1,'5G Generation',1,2020),
(2, 'Automation et IA',1,2020),
(3, 'Impact de la science dans la vie courante',2,2020),
(4, 'Data sciences et applications',2,2020)
;

INSERT INTO ResponsableTrack VALUES
(1,'camille.martin@yahoo.fr'),
(2,'lena.scott@gmail.com'),
(3, 'max-cole@live.com'),
(4,'rachel.evans@gmail.com')
;

INSERT INTO ComiteLecture VALUES
(1,'mike.specter@hotmail.com'),
(1,'jessica.landson@gmail.com'),
(1,'michel.collins@hotmail.fr'),
(1,'amanda.simons@gmail.com'),
(2,'matthew.perry@gmail.com'),
(2,'louis.armand@gmail.com'),
(2,'lindsay.watson@gmail.com'),
(3,'michel.collins@hotmail.fr'),
(3,'alex.clint@gmail.com'),
(3,'yann_cooper@gmail.com'),
(3,'lily.james@gmail.com'),
(4,'ana.nicols@gmail.com'),
(4,'julian.dean@gmail.com'),
(4,'leonard.stark@gmail.com')
;

INSERT INTO Article VALUES
(1,1,'5G Generation et ses consequences','Larticle discute des conséquences de cette nouvelle technologie',
'telephonie,5G','5G_consequences.pdf','accepte',
'2020/01/31','2020/02/11'),
(2,1,'Reseaux de telecommunications dans le monde','Comparaison des différent réseaux exsitants',
'télecommunications,global','telecom.pdf','accepte',
'2020/01/23','2020/02/13'),
(3,2,'Automation dans lindustrie de services','Etude de cas chez les GAFA',
'robots,intelligence artificielle','automation_service.pdf','accepte',
'2020/01/25','2020/02/10'),
(4,2,'Machine learning et dérives','Problèmes éthiques du machine learning',
'robots,intelligence artificielle','machine_learning.pdf','accepte',
'2020/01/03','2020/02/14'),
(5,3,'La recherche énergétique','Présentations des innovations dans lénergie ',
'énergie,physique','energie.pdf','refuse',
'2020/01/23','2020/01/23'),
(6,3,'Comment enseigner les sciences','Description des methodes pédagogiques',
'enseignement,sciences','enseignement_science.pdf','accepte',
'2020/01/08','2020/02/12'),
(7,4,'Data Science au service de la médecine','Etude de cas des méthodes de machine learning dans le domaine médical',
'data science,intelligence artificielle','data_medecine.pdf','accepte',
'2020/01/16','2020/01/16'),
(8,4,'Data Science et marketing','Etude de cas en marketing',
'marketing,scoring','marketing.pdf','refuse',
'2020/01/15','2020/02/11'),
(9,4,'Data Science dans la finance','Etude des effets des méthodes de machine learning sur les marchés',
'marchés,séries temporelles, data science','data_finance.pdf','accepte',
'2020/01/15','2020/02/11')
;

INSERT INTO Coauteurs_article VALUES
(1,'emily.thompson@hotmail.com',1),
(1,'john.doe@gmail.com',0),
(2,'jimmy.wales@gmail.com',1),
(2,'nicolas.petit@gmail.com',0),
(3,'john.doe@gmail.com',1),
(3,'betty_thomas@gmail.com',0),
(3,'marie.leclerc@gmail.com',0),
(4,'bob.green@hotmail.com',1),
(4,'marc-lucas@yahoo.com',0),
(4,'john.doe@gmail.com',0),
(5,'melanie.perkins@gmail.com',1),
(5,'gary-norton@gmail.com',0),
(5,'emily.thompson@hotmail.com',0),
(6,'jimmy.wales@gmail.com',1),
(6,'john.doe@gmail.com',0),
(6,'michael.jordan@gmail.com',0),
(7,'emily.thompson@hotmail.com',1),
(7,'jane-mendes@hotmail.com',0),
(7,'bob.green@hotmail.com',0),
(8,'philip.wilson@gmail.com',1),
(8,'lisa.campbell@gmail.com',0),
(9,'lisa.campbell@gmail.com',1),
(9,'john.doe@gmail.com',0),
(9,'marie.leclerc@gmail.com',0)
;


INSERT VALUES INTO Rapport
(1,1,'mike.specter@hotmail.com','accepte'),
(1,1,'jessica.landson@gmail.com','accepte'),
(1,1,'michel.collins@hotmail.fr','accepte'),
(1,1,'amanda.simons@gmail.com','accepte'),
(2,1,'mike.specter@hotmail.com','accepte'),
(2,1,'michel.collins@hotmail.fr','accepte'),
(2,1,'jessica.landson@gmail.com','accepte'),
(3,2,'matthew.perry@gmail.com','accepte'),
(3,2,'louis.armand@gmail.com','accepte'),
(3,2,'lindsay.watson@gmail.com','accepte'),
(4,2,'matthew.perry@gmail.com','accepte'),
(4,2,'louis.armand@gmail.com','accepte'),
(4,2,'lindsay.watson@gmail.com','accepte'),
(5,3,'michel.collins@hotmail.fr','accepte'),
(5,3,'alex.clint@gmail.com','refuse'),
(5,3,'yann_cooper@gmail.com','accepte'),
(6,3,'michel.collins@hotmail.fr','accepte'),
(6,3,'lily.james@gmail.com','accepte'),
(6,3,'yann_cooper@gmail.com','accepte'),
(7,4,'ana.nicols@gmail.com','accepte'),
(7,4,'julian.dean@gmail.com','accepte'),
(7,4,'leonard.stark@gmail.com','accepte'),
(8,4,'ana.nicols@gmail.com','refuse'),
(8,4,'julian.dean@gmail.com','refuse'),
(8,4,'leonard.stark@gmail.com','refuse'),
(9,4,'ana.nicols@gmail.com','accepte'),
(9,4,'julian.dean@gmail.com','accepte'),
(9,4,'leonard.stark@gmail.com','refuse')
;

INSERT INTO Commentaire VALUES
(1,5,3,'michel.collins@hotmail.fr','article pertinent'),
(2,5,3,'alex.clint@gmail.com','article pas assez appronfondi'),
(3,5,3,'yann_cooper@gmail.com','RAS'),
(4,9,4,'ana.nicols@gmail.com','article pertinent'),
(5,9,4,'julian.dean@gmail.com','OK'),
(6,9,4,'leonard.stark@gmail.com','ressemble trop aux articles sur le même sujet')
;





#Requêtes
SELECT Utilisateur.prenom,Utilisateur.nom FROM Auteur,Conference,Article,Track
WHERE Article.email=Auteur.email
AND Utilisateur.email=Auteur.email
AND Conference.ID_conf=Track.ID_conf
AND Track.ID_track=Article.ID_track
AND Conference.titre='Popularisation of science';

