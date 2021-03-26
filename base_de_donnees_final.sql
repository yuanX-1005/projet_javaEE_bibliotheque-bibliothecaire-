SET FEEDBACK OFF
SET LINESIZE 150
SET PAGESIZE 40

REM **************************************************************************
REM BASE MEDIATEK
REM Auteur : Lisa & Chels
REM ***************************************************************************

ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

PROMPT --> DEBUT DU SCRIPT@

REM SUPPRESSION des tables

DROP TABLE Document CASCADE CONSTRAINTS PURGE
/
DROP TABLE Abonne CASCADE CONSTRAINTS PURGE
/
DROP TABLE Bibliothecaire CASCADE CONSTRAINTS PURGE
/


DROP SEQUENCE IncremBibliothecaire;
DROP SEQUENCE IncremDocument;
DROP SEQUENCE IncremAbonne;

CREATE SEQUENCE IncremBibliothecaire; 
CREATE SEQUENCE IncremDocument; 
CREATE SEQUENCE IncremAbonne;


REM ** Requête SQL de création des tables **

PROMPT CREATION DES TABLES BIBLIOTHECAIRE

CREATE TABLE Bibliothecaire(
   IdBiblio INT,
   loginB VARCHAR(15) NOT NULL,
   passwordB VARCHAR(15) NOT NULL,
   PRIMARY KEY(IdBiblio)
);

PROMPT CREATION DES TABLES ABONNE

CREATE TABLE Abonne(
   IdAbonne INT,
   NomAbonne VARCHAR(50) NOT NULL,
   dateNaissance DATE NOT NULL,
   PRIMARY KEY(IdAbonne)
);

PROMPT CREATION DES TABLES DOCUMENT

CREATE TABLE Document(
   IdDocument INT,
   Title VARCHAR(50) NOT NULL,
   Auteur VARCHAR(20) NOT NULL,
   Type INTEGER NOT NULL,
   Adulte NUMBER(1),
   Disponible NUMBER(1) NOT NULL,
   IdBiblio INT NOT NULL,
   IdAbonne INT,
   PRIMARY KEY(IdDocument),
   FOREIGN KEY(IdBiblio) REFERENCES Bibliothecaire(IdBiblio),
   FOREIGN KEY(IdAbonne) REFERENCES Abonne(IdAbonne)
);


-- 1 = true | 0 = false --
alter table Document 
	add constraint CK_Adulte_Doc CHECK(adulte in (0,1))
	add constraint CK_Disp_Doc CHECK(Disponible in (0,1))
/

PROMPT INSERTION DE BIBLIOTHECAIRE

INSERT into Bibliothecaire (IdBiblio, loginB, passwordB)
VALUES(IncremBibliothecaire.nextval, 'francoismillet', 'monmdp');
INSERT into Bibliothecaire (IdBiblio,loginB, passwordB)
VALUES(IncremBibliothecaire.nextval, 'mathildebonnet', 'monmdp');
INSERT into Bibliothecaire (IdBiblio, loginB, passwordB)
VALUES(IncremBibliothecaire.nextval,'paulrochet', 'monmdp');
INSERT into Bibliothecaire (IdBiblio, loginB, passwordB)
VALUES(IncremBibliothecaire.nextval, 'tristanjouli', 'monmdp');

PROMPT INSERTION DE ABONNE

INSERT into Abonne (IdAbonne, NomAbonne, dateNaissance)
VALUES(IncremAbonne.nextval, 'Bernard', '09/03/2000');
INSERT into Abonne (IdAbonne,NomAbonne, dateNaissance)
VALUES(IncremAbonne.nextval, 'Thomas', '07/04/1976');
INSERT into Abonne (IdAbonne, NomAbonne, dateNaissance)
VALUES(IncremAbonne.nextval,'Robert', '21/03/1992');
INSERT into Abonne (IdAbonne, NomAbonne, dateNaissance)
VALUES(IncremAbonne.nextval, 'Durand', '27/10/1988');

PROMPT INSERTION DE DOCUMENT

-- TYPE 1=CD, 2=Livre 3=DVD
-- Disponible : 1 = disponible 0 = non disponible
-- Adulte : 1 = pour adulte | 0 = pour tous les abonnes --
INSERT into Document (IdDocument,Title,Auteur,Type,Adulte,Disponible,IdBiblio,IdAbonne)
VALUES(IncremDocument.nextval,'Petit roman','Pierre',2,null,1,1,null);
INSERT into Document (IdDocument,Title,Auteur,Type,Adulte,Disponible,IdBiblio,IdAbonne)
VALUES(IncremDocument.nextval,'Grand immeuble','Marc',2,null,1,3,null);
INSERT into Document (IdDocument,Title,Auteur,Type,Adulte,Disponible,IdBiblio,IdAbonne)
VALUES(IncremDocument.nextval,'Maman','Cindy',1,null,1,2,null);
INSERT into Document (IdDocument,Title,Auteur,Type,Adulte,Disponible,IdBiblio,IdAbonne)
VALUES(IncremDocument.nextval,'Géographique','Marc',1,null,1,3,null);
INSERT into Document (IdDocument,Title,Auteur,Type,Adulte,Disponible,IdBiblio,IdAbonne)
VALUES(IncremDocument.nextval,'Dance','Cindy',3,1,1,2,null);
INSERT into Document (IdDocument,Title,Auteur,Type,Adulte,Disponible,IdBiblio,IdAbonne)
VALUES(IncremDocument.nextval,'Mer','Anna',3,0,0,3,1);


PROMPT --> SCRIPT COMPLETEMENT TERMINE

commit;

SET FEEDBACK ON


