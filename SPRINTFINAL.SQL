DROP DATABASE IF EXISTS sprintfinal;

CREATE DATABASE IF NOT EXISTS sprintfinal;
USE sprintfinal;
# -----------------------------------------------------------------------------
#       TABLE : DIRECTEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DIRECTEUR
 (
   IDDIRECTEUR INTEGER(3) NOT NULL AUTO_INCREMENT ,
   IDCATEGORIE VARCHAR(10) NOT NULL  
   , PRIMARY KEY (IDDIRECTEUR) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE DIRECTEUR
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_DIRECTEUR_CATEGORIE
     ON DIRECTEUR (IDCATEGORIE ASC);

# -----------------------------------------------------------------------------
#       TABLE : MEDECIN
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MEDECIN
 (
   IDMEDECIN INTEGER(3) NOT NULL AUTO_INCREMENT ,
   IDCATEGORIE VARCHAR(10) NOT NULL  ,
   NOM TEXT NULL  ,
   PRENOM TEXT NULL  ,
   SPECIALITE TEXT NULL  
   , PRIMARY KEY (IDMEDECIN) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE MEDECIN
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_MEDECIN_CATEGORIE
     ON MEDECIN (IDCATEGORIE ASC);

# -----------------------------------------------------------------------------
#       TABLE : RDV
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RDV
 (
   IDRDV INTEGER(3) NOT NULL AUTO_INCREMENT ,
   IDMEDECIN INTEGER(3) NOT NULL  ,
   NSS INTEGER(3) NOT NULL  ,
   IDCRENEAU INTEGER(3) NOT NULL  ,
   IDINTERVENTION INTEGER(3) NOT NULL  ,
   STATUT TEXT NULL  
   , PRIMARY KEY (IDRDV) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE RDV
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_RDV_MEDECIN
     ON RDV (IDMEDECIN ASC);

CREATE  INDEX I_FK_RDV_PATIENT
     ON RDV (NSS ASC);

CREATE  INDEX I_FK_RDV_CRENEAU
     ON RDV (IDCRENEAU ASC);

CREATE  INDEX I_FK_RDV_INTERVENTION
     ON RDV (IDINTERVENTION ASC);

# -----------------------------------------------------------------------------
#       TABLE : INTERVENTION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS INTERVENTION
 (
   IDINTERVENTION INTEGER(3) NOT NULL AUTO_INCREMENT ,
   IDDIRECTEUR INTEGER(3) NOT NULL  ,
   MOTIF TEXT NULL  ,
   PIECES TEXT NULL  ,
   CONSIGNES TEXT NULL  ,
   PRIX INTEGER(5) NULL  
   , PRIMARY KEY (IDINTERVENTION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE INTERVENTION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_INTERVENTION_DIRECTEUR
     ON INTERVENTION (IDDIRECTEUR ASC);

# -----------------------------------------------------------------------------
#       TABLE : PATIENT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PATIENT
 (
   NSS INTEGER(3) NOT NULL AUTO_INCREMENT ,
   NOM TEXT NULL  ,
   PRENOM TEXT NULL  ,
   ADRESSE TEXT NULL  ,
   NUM_TEL INTEGER(10) NULL  ,
   DATE_NAISSANCE DATE NULL  ,
   DEP_NAISSANCE INTEGER(2) NULL  ,
   PAYS TEXT NULL  ,
   SOLDE INTEGER(5) NULL  
   , PRIMARY KEY (NSS) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CRENEAU
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CRENEAU
 (
   IDCRENEAU INTEGER(3) NOT NULL AUTO_INCREMENT ,
   IDMEDECIN INTEGER(3) NOT NULL  ,
   LIBELLECRENEAU TEXT NULL  ,
   DATECRENEAU DATE NULL  ,
   HEURECRENEAU TIME NULL  
   , PRIMARY KEY (IDCRENEAU) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE CRENEAU
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_CRENEAU_MEDECIN
     ON CRENEAU (IDMEDECIN ASC);

# -----------------------------------------------------------------------------
#       TABLE : AGENT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS AGENT
 (
   IDAGENT INTEGER(3) NOT NULL AUTO_INCREMENT ,
   IDCATEGORIE VARCHAR(10) NOT NULL  
   , PRIMARY KEY (IDAGENT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE AGENT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_AGENT_CATEGORIE
     ON AGENT (IDCATEGORIE ASC);

# -----------------------------------------------------------------------------
#       TABLE : CATEGORIE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CATEGORIE
 (
   IDCATEGORIE VARCHAR(10) NOT NULL  
   , PRIMARY KEY (IDCATEGORIE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : EMPLOYE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EMPLOYE
 (
   LOGIN VARCHAR(10) NOT NULL  ,
   IDCATEGORIE VARCHAR(10) NOT NULL  ,
   MDP TEXT NULL  
   , PRIMARY KEY (LOGIN) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE EMPLOYE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_EMPLOYE_CATEGORIE
     ON EMPLOYE (IDCATEGORIE ASC);

# -----------------------------------------------------------------------------
#       TABLE : PREPARER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PREPARER
 (
   IDAGENT INTEGER(3) NOT NULL  ,
   IDRDV INTEGER(3) NOT NULL  
   , PRIMARY KEY (IDAGENT,IDRDV) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PREPARER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PREPARER_AGENT
     ON PREPARER (IDAGENT ASC);

CREATE  INDEX I_FK_PREPARER_RDV
     ON PREPARER (IDRDV ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE DIRECTEUR 
  ADD FOREIGN KEY FK_DIRECTEUR_CATEGORIE (IDCATEGORIE)
      REFERENCES CATEGORIE (IDCATEGORIE) ;


ALTER TABLE MEDECIN 
  ADD FOREIGN KEY FK_MEDECIN_CATEGORIE (IDCATEGORIE)
      REFERENCES CATEGORIE (IDCATEGORIE) ;


ALTER TABLE RDV 
  ADD FOREIGN KEY FK_RDV_MEDECIN (IDMEDECIN)
      REFERENCES MEDECIN (IDMEDECIN) ;


ALTER TABLE RDV 
  ADD FOREIGN KEY FK_RDV_PATIENT (NSS)
      REFERENCES PATIENT (NSS) ;


ALTER TABLE RDV 
  ADD FOREIGN KEY FK_RDV_CRENEAU (IDCRENEAU)
      REFERENCES CRENEAU (IDCRENEAU) ;


ALTER TABLE RDV 
  ADD FOREIGN KEY FK_RDV_INTERVENTION (IDINTERVENTION)
      REFERENCES INTERVENTION (IDINTERVENTION) ;


ALTER TABLE INTERVENTION 
  ADD FOREIGN KEY FK_INTERVENTION_DIRECTEUR (IDDIRECTEUR)
      REFERENCES DIRECTEUR (IDDIRECTEUR) ;


ALTER TABLE CRENEAU 
  ADD FOREIGN KEY FK_CRENEAU_MEDECIN (IDMEDECIN)
      REFERENCES MEDECIN (IDMEDECIN) ;


ALTER TABLE AGENT 
  ADD FOREIGN KEY FK_AGENT_CATEGORIE (IDCATEGORIE)
      REFERENCES CATEGORIE (IDCATEGORIE) ;


ALTER TABLE EMPLOYE 
  ADD FOREIGN KEY FK_EMPLOYE_CATEGORIE (IDCATEGORIE)
      REFERENCES CATEGORIE (IDCATEGORIE) ;


ALTER TABLE PREPARER 
  ADD FOREIGN KEY FK_PREPARER_AGENT (IDAGENT)
      REFERENCES AGENT (IDAGENT) ;


ALTER TABLE PREPARER 
  ADD FOREIGN KEY FK_PREPARER_RDV (IDRDV)
      REFERENCES RDV (IDRDV) ;

