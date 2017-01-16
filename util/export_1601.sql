--------------------------------------------------------
--  File created - Monday-January-16-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View ARTIKAL_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "DB02"."ARTIKAL_VIEW" ("SIFRAARTIKLA", "NAZIVARTIKLA", "JEDMERE", "OPISARTIKLA", "TRENUTNA_CENA") AS 
  select
a.sifraartikla, a.nazivartikla, ad.jedmere, ad.opisartikla, ad.TRENUTNA_CENA
from ARTIKAL a, ARTIKAL_DETALJI ad
where ad.SIFRAARTIKLA = a.SIFRAARTIKLA;
--------------------------------------------------------
--  DDL for View KUPAC_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "DB02"."KUPAC_VIEW" ("SIFRAKUPCA", "IMEKUPCA", "ADRESA", "PIB", "BRTEL", "EMAIL") AS 
  SELECT
k.SIFRAKUPCA "SIFRAKUPCA",
k.IMEKUPCA "IMEKUPCA",
k.DETALJI.get_adresa() "ADRESA",
k.DETALJI.get_pib() "PIB",
k.DETALJI.get_brtel() "BRTEL",
k.DETALJI.get_email() "EMAIL"
FROM kupac k;
--------------------------------------------------------
--  DDL for View STAVKA_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "DB02"."STAVKA_VIEW" ("RBR", "BRPONUDE", "KOLICINA", "NAZIVARTIKLA") AS 
  select sp.rbr, sp.brponude, sp.kolicina, a.nazivartikla from stavkaponude sp join artikal a on sp.SIFRAARTIKLA = A.SIFRAARTIKLA;
--------------------------------------------------------
--  DDL for Type DETALJI_KUPCA
--------------------------------------------------------

  CREATE OR REPLACE TYPE "DB02"."DETALJI_KUPCA" 
AS
  OBJECT
  (
    adresa VARCHAR2(30),
    PIB    NUMBER(8),
    brtel  NUMBER(8),
    email  VARCHAR2(30),
    
    MEMBER FUNCTION get_adresa
    RETURN VARCHAR2,
    MEMBER FUNCTION get_PIB
    RETURN NUMBER,
    MEMBER FUNCTION get_brtel
    RETURN NUMBER,
    MEMBER FUNCTION get_email
    RETURN VARCHAR2
) 

INSTANTIABLE NOT FINAL;
/
CREATE OR REPLACE TYPE BODY "DB02"."DETALJI_KUPCA" 
AS
  MEMBER FUNCTION get_adresa
  RETURN VARCHAR2
IS
BEGIN
  RETURN SELF.adresa;
END;
MEMBER FUNCTION get_PIB
  RETURN NUMBER
IS
BEGIN
  RETURN SELF.PIB;
END;
MEMBER FUNCTION get_brtel
  RETURN NUMBER
IS
BEGIN
  RETURN SELF.brtel;
END;
MEMBER FUNCTION get_email
  RETURN VARCHAR2
IS
BEGIN
  RETURN SELF.email;
END;
END;

/
--------------------------------------------------------
--  DDL for Table ARTIKAL
--------------------------------------------------------

  CREATE TABLE "DB02"."ARTIKAL" 
   (	"SIFRAARTIKLA" NUMBER(5,0), 
	"NAZIVARTIKLA" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ARTIKAL_DETALJI
--------------------------------------------------------

  CREATE TABLE "DB02"."ARTIKAL_DETALJI" 
   (	"JEDMERE" VARCHAR2(30 BYTE), 
	"OPISARTIKLA" VARCHAR2(30 BYTE), 
	"SIFRAARTIKLA" NUMBER, 
	"TRENUTNA_CENA" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CENA
--------------------------------------------------------

  CREATE TABLE "DB02"."CENA" 
   (	"DATUM" TIMESTAMP (6) DEFAULT CURRENT_TIMESTAMP, 
	"SIFRAARTIKLA" NUMBER(5,0), 
	"CENA" NUMBER(5,0), 
	"STOPAPDV" NUMBER(5,0), 
	"NAZIVARTIKLA" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table KUPAC
--------------------------------------------------------

  CREATE TABLE "DB02"."KUPAC" 
   (	"SIFRAKUPCA" NUMBER(5,0), 
	"IMEKUPCA" VARCHAR2(30 BYTE), 
	"DETALJI" "DB02"."DETALJI_KUPCA" 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PONUDA
--------------------------------------------------------

  CREATE TABLE "DB02"."PONUDA" 
   (	"BRPONUDE" NUMBER(5,0), 
	"DATUM" TIMESTAMP (6) DEFAULT CURRENT_TIMESTAMP, 
	"SIFRAKUPCA" NUMBER(5,0), 
	"IMEKUPCA" VARCHAR2(30 BYTE), 
	"UKUPNI_IZNOS" NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table STAVKAPONUDE
--------------------------------------------------------

  CREATE TABLE "DB02"."STAVKAPONUDE" 
   (	"RBR" NUMBER(5,0) DEFAULT NULL, 
	"BRPONUDE" NUMBER(5,0), 
	"KOLICINA" NUMBER(5,0), 
	"SIFRAARTIKLA" NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Sequence ARTIKAL_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."ARTIKAL_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ARTIKAL_SEQ1
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."ARTIKAL_SEQ1"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence CENA_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."CENA_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence KUPAC1_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."KUPAC1_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence KUPAC_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."KUPAC_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence KUPAC_SEQ1
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."KUPAC_SEQ1"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PONUDA_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."PONUDA_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PONUDA_SEQ1
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."PONUDA_SEQ1"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STAVKAPONUDE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."STAVKAPONUDE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STAVKAPONUDE_SEQ1
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."STAVKAPONUDE_SEQ1"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STAVKAUPITA_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."STAVKAUPITA_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence UPIT_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."UPIT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
REM INSERTING into DB02.ARTIKAL
SET DEFINE OFF;
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (28,'Kamera');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (29,'Kuciste');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (26,'DVR');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (27,'Kabl');
REM INSERTING into DB02.ARTIKAL_DETALJI
SET DEFINE OFF;
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kom','Analogna kamera',28,360);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kom','Kuciste kamere okruglo',29,118);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kom','Analogni DVR',26,472);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('m','Opticki kabl',27,110);
REM INSERTING into DB02.CENA
SET DEFINE OFF;
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('15-JAN-17 12.02.56.330000000 AM','DD-MON-RR HH.MI.SSXFF AM'),26,400,18,'DVR');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('15-JAN-17 12.03.06.946000000 AM','DD-MON-RR HH.MI.SSXFF AM'),27,100,10,'Kabl');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('15-JAN-17 12.02.33.274000000 AM','DD-MON-RR HH.MI.SSXFF AM'),28,300,20,'Kamera');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('15-JAN-17 12.02.47.741000000 AM','DD-MON-RR HH.MI.SSXFF AM'),29,100,18,'Kuciste');
REM INSERTING into DB02.KUPAC
SET DEFINE OFF;
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (24,'Ana S.',DB02.DETALJI_KUPCA('Sombor',25654,254669,'qa@scripttic.com'));
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (21,'Voja R.',DB02.DETALJI_KUPCA('Beograd',25114,112544,'batica@gmail.com'));
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (23,'Nenad A.',DB02.DETALJI_KUPCA('Novi Sad',12557,884163,'qa@scripttic.com'));
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (22,'Mihailo S.',DB02.DETALJI_KUPCA('Zemun',112588,99854,'qa@scripttic.com'));
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (26,'Srdjan S.',DB02.DETALJI_KUPCA('munZe',112233,77554433,'mojemail@email.net'));
REM INSERTING into DB02.PONUDA
SET DEFINE OFF;
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA,UKUPNI_IZNOS) values (47,to_timestamp('15-JAN-17 12.01.15.673000000 AM','DD-MON-RR HH.MI.SSXFF AM'),24,'Ana S.',110);
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA,UKUPNI_IZNOS) values (57,to_timestamp('15-JAN-17 11.03.19.756000000 PM','DD-MON-RR HH.MI.SSXFF AM'),22,'Mihailo S.',720);
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA,UKUPNI_IZNOS) values (58,to_timestamp('15-JAN-17 11.03.34.093000000 PM','DD-MON-RR HH.MI.SSXFF AM'),23,'Nenad A.',472);
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA,UKUPNI_IZNOS) values (56,to_timestamp('15-JAN-17 11.00.09.090000000 PM','DD-MON-RR HH.MI.SSXFF AM'),26,'Srdjan S.',236);
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA,UKUPNI_IZNOS) values (59,to_timestamp('16-JAN-17 11.45.20.897000000 AM','DD-MON-RR HH.MI.SSXFF AM'),24,'Ana S.',1192);
REM INSERTING into DB02.STAVKAPONUDE
SET DEFINE OFF;
Insert into DB02.STAVKAPONUDE (RBR,BRPONUDE,KOLICINA,SIFRAARTIKLA) values (1,59,1,26);
Insert into DB02.STAVKAPONUDE (RBR,BRPONUDE,KOLICINA,SIFRAARTIKLA) values (1,56,2,29);
Insert into DB02.STAVKAPONUDE (RBR,BRPONUDE,KOLICINA,SIFRAARTIKLA) values (2,59,2,28);
Insert into DB02.STAVKAPONUDE (RBR,BRPONUDE,KOLICINA,SIFRAARTIKLA) values (1,47,1,27);
Insert into DB02.STAVKAPONUDE (RBR,BRPONUDE,KOLICINA,SIFRAARTIKLA) values (1,58,1,26);
Insert into DB02.STAVKAPONUDE (RBR,BRPONUDE,KOLICINA,SIFRAARTIKLA) values (1,57,2,28);
--------------------------------------------------------
--  DDL for Index ARTIKAL_DETALJI_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB02"."ARTIKAL_DETALJI_PK" ON "DB02"."ARTIKAL_DETALJI" ("SIFRAARTIKLA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ARTIKAL_INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB02"."ARTIKAL_INDEX1" ON "DB02"."ARTIKAL" ("NAZIVARTIKLA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index KUPAC_INDEX1
--------------------------------------------------------

  CREATE INDEX "DB02"."KUPAC_INDEX1" ON "DB02"."KUPAC" ("IMEKUPCA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PONUDA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB02"."PONUDA_PK" ON "DB02"."PONUDA" ("BRPONUDE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ARTIKAL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB02"."ARTIKAL_PK" ON "DB02"."ARTIKAL" ("SIFRAARTIKLA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index CENA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB02"."CENA_PK" ON "DB02"."CENA" ("DATUM", "SIFRAARTIKLA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index KUPAC_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB02"."KUPAC_PK" ON "DB02"."KUPAC" ("SIFRAKUPCA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index STAVKAPONUDE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DB02"."STAVKAPONUDE_PK" ON "DB02"."STAVKAPONUDE" ("RBR", "BRPONUDE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Trigger ARTIKAL_DELETE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ARTIKAL_DELETE" 
instead of delete ON artikal_view
for each row
begin

delete from artikal_detalji where sifraartikla = :old.sifraartikla;

delete from artikal where sifraartikla = :old.sifraartikla;

end ARTIKAL_DELETE;
/
ALTER TRIGGER "DB02"."ARTIKAL_DELETE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ARTIKAL_INSERT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ARTIKAL_INSERT" 
instead of insert ON artikal_view
for each row
declare x number;
begin

insert into artikal
(NAZIVARTIKLA) values (:NEW.NAZIVARTIKLA);

select sifraartikla
into x
from ARTIKAL
where NAZIVARTIKLA = :NEW.NAZIVARTIKLA;

insert into artikal_detalji
(jedmere, opisartikla, sifraartikla) values (:NEW.jedmere, :NEW.opisartikla, x);


end artikal_insert;
/
ALTER TRIGGER "DB02"."ARTIKAL_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ARTIKAL_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ARTIKAL_TRG" 
BEFORE INSERT ON ARTIKAL 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."ARTIKAL_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ARTIKAL_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ARTIKAL_TRG1" 
BEFORE INSERT ON ARTIKAL 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.SIFRAARTIKLA IS NULL THEN
      SELECT ARTIKAL_SEQ1.NEXTVAL INTO :NEW.SIFRAARTIKLA FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."ARTIKAL_TRG1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ARTIKAL_UPDATE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ARTIKAL_UPDATE" 
instead of update ON artikal_view
for each row
begin

update artikal set nazivartikla=:new.nazivartikla where  sifraartikla = :new.sifraartikla;

end ARTIKAL_UPDATE;
/
ALTER TRIGGER "DB02"."ARTIKAL_UPDATE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AZURIRAJ_IMEKUPCA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."AZURIRAJ_IMEKUPCA" 
AFTER UPDATE of imekupca ON kupac 
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azuriranje_imekupca DISABLE';
UPDATE PONUDA
set PONUDA.IMEKUPCA = :NEW.IMEKUPCA 
where ponuda.SIFRAKUPCA = :NEW.SIFRAKUPCA;
COMMIT;
BEGIN
EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azuriranje_imekupca ENABLE';
END;
END;
/
ALTER TRIGGER "DB02"."AZURIRAJ_IMEKUPCA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AZURIRAJ_IMEKUPCA_PO_SIFRI
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."AZURIRAJ_IMEKUPCA_PO_SIFRI" 
BEFORE UPDATE of sifrakupca ON ponuda 
FOR EACH ROW
DECLARE
n_imekupca VARCHAR2(30);
BEGIN
  SELECT IMEKUPCA
  INTO  n_imekupca
  FROM   KUPAC
  where SIFRAKUPCA =:NEW.SIFRAKUPCA;
  :new.imekupca := n_imekupca;
END;
/
ALTER TRIGGER "DB02"."AZURIRAJ_IMEKUPCA_PO_SIFRI" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AZURIRAJ_NAZIVARTIKLA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."AZURIRAJ_NAZIVARTIKLA" 
after UPDATE of nazivartikla ON artikal 
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azur_nazivartikla DISABLE';
UPDATE CENA
set cena.nazivartikla = :NEW.nazivartikla 
where SIFRAARTIKLA = :NEW.SIFRAARTIKLA;
COMMIT;
BEGIN
EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azur_nazivartikla ENABLE';
END;
END;
/
ALTER TRIGGER "DB02"."AZURIRAJ_NAZIVARTIKLA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger CENA_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."CENA_TRG" 
BEFORE INSERT ON CENA 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.SIFRAARTIKLA IS NULL THEN
      SELECT CENA_SEQ.NEXTVAL INTO :NEW.SIFRAARTIKLA FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."CENA_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DROP_TRIGGER_DB02
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."DROP_TRIGGER_DB02" 
   BEFORE DROP ON db02.SCHEMA
   BEGIN
     RAISE_APPLICATION_ERROR (
       num => -20000,
       msg => 'Cannot drop object on DB02 schema, there is a TRIGGER set up.');
   END;
/
ALTER TRIGGER "DB02"."DROP_TRIGGER_DB02" ENABLE;
--------------------------------------------------------
--  DDL for Trigger KUPAC_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."KUPAC_TRG" 
BEFORE INSERT ON KUPAC 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.SIFRAKUPCA IS NULL THEN
      SELECT KUPAC_SEQ1.NEXTVAL INTO :NEW.SIFRAKUPCA FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."KUPAC_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PONUDA_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."PONUDA_TRG" 
BEFORE INSERT ON PONUDA 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."PONUDA_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PONUDA_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."PONUDA_TRG1" 
BEFORE INSERT ON PONUDA 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.BRPONUDE IS NULL THEN
      SELECT PONUDA_SEQ1.NEXTVAL INTO :NEW.BRPONUDE FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."PONUDA_TRG1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PONUDA_UKUPNO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."PONUDA_UKUPNO" 
BEFORE INSERT OR UPDATE OR DELETE
ON stavkaponude
FOR EACH ROW
BEGIN
IF (INSERTING OR UPDATING) then
BEGIN
SIFRA_PACK.brponude := :NEW.brponude;
END;
ELSE
BEGIN
SIFRA_PACK.brponude:= :OLD.brponude;
END;
END IF;
END;
/
ALTER TRIGGER "DB02"."PONUDA_UKUPNO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PONUDA_UKUPNO_2
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."PONUDA_UKUPNO_2" 
AFTER INSERT OR UPDATE OR DELETE ON stavkaponude
DECLARE
br_pon NUMBER:=SIFRA_PACK.brponude;
--PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
--EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azur_ukupni_iznos DISABLE';

PONUDA_UKUPNO_PROC(br_pon);
  
--COMMIT;
--BEGIN
--EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azur_ukupni_iznos ENABLE';
--END;
END;
/
ALTER TRIGGER "DB02"."PONUDA_UKUPNO_2" ENABLE;
--------------------------------------------------------
--  DDL for Trigger STAVKAPONUDE_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."STAVKAPONUDE_TRG" 
BEFORE INSERT ON STAVKAPONUDE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."STAVKAPONUDE_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger STAVKAPONUDE_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."STAVKAPONUDE_TRG1" 
BEFORE INSERT ON STAVKAPONUDE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."STAVKAPONUDE_TRG1" DISABLE;
--------------------------------------------------------
--  DDL for Trigger STAVKAPONUDE_TRG3
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."STAVKAPONUDE_TRG3" 
BEFORE INSERT ON STAVKAPONUDE 
FOR EACH ROW 
declare tmp_rbr number;

  BEGIN
    IF INSERTING AND :NEW.RBR IS NULL THEN
      select COUNT(rbr) INTO tmp_rbr FROM stavkaponude where brponude = :new.brponude;
      tmp_rbr := tmp_rbr +1;
      :NEW.RBR := tmp_rbr;
    END IF;
  END;
/
ALTER TRIGGER "DB02"."STAVKAPONUDE_TRG3" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UNESI_AKTUELNU_CENU1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."UNESI_AKTUELNU_CENU1" 
BEFORE INSERT or UPDATE or DELETE of cena
on cena
FOR EACH row
BEGIN
IF (INSERTING OR UPDATING) then
BEGIN

SIFRA_PACK.sifra := :NEW.sifraartikla;

END;
ELSE
BEGIN
SIFRA_PACK.sifra := :OLD.sifraartikla;
END;
END IF;
END;
/
ALTER TRIGGER "DB02"."UNESI_AKTUELNU_CENU1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UNESI_AKTUELNU_CENU2
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."UNESI_AKTUELNU_CENU2" 
AFTER INSERT or UPDATE of cena on cena
DECLARE
SIFRA_ART NUMBER:= SIFRA_PACK.sifra;
--PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
--EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azur_trenutna_cena DISABLE';

CENA_ARTIKLA(SIFRA_ART);

--COMMIT;
--BEGIN
--EXECUTE IMMEDIATE 'ALTER TRIGGER zabrani_azur_trenutna_cena ENABLE';
--END;
END;
/
ALTER TRIGGER "DB02"."UNESI_AKTUELNU_CENU2" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UNESI_IMEKUPCA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."UNESI_IMEKUPCA" 
BEFORE INSERT ON ponuda 
FOR EACH ROW

DECLARE n_imekupca VARCHAR2(30);

BEGIN
  SELECT IMEKUPCA
  INTO  n_imekupca
  FROM   KUPAC
  where SIFRAKUPCA =:NEW.SIFRAKUPCA;
  :new.imekupca := n_imekupca;
END;
/
ALTER TRIGGER "DB02"."UNESI_IMEKUPCA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UNESI_NAZIVARTIKLA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."UNESI_NAZIVARTIKLA" 
before INSERT ON CENA 
FOR EACH ROW

DECLARE n_nazivartikla VARCHAR2(30);

BEGIN
  SELECT nazivartikla
  INTO  n_nazivartikla
  FROM   ARTIKAL
  where SIFRAARTIKLA =:NEW.SIFRAARTIKLA;
  :new.nazivartikla := n_nazivartikla;
END;
/
ALTER TRIGGER "DB02"."UNESI_NAZIVARTIKLA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ZABRANI_AZURIRANJE_IMEKUPCA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ZABRANI_AZURIRANJE_IMEKUPCA" 
AFTER UPDATE of imekupca ON ponuda 
FOR EACH ROW

BEGIN
RAISE_APPLICATION_ERROR (
NUM => -20000,
MSG => 'NE SMETE DA AZURIRATE IME KUPCA ODAVDE');
END;
/
ALTER TRIGGER "DB02"."ZABRANI_AZURIRANJE_IMEKUPCA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ZABRANI_AZUR_NAZIVARTIKLA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ZABRANI_AZUR_NAZIVARTIKLA" 
AFTER UPDATE of nazivartikla
ON cena 
FOR EACH ROW

BEGIN
RAISE_APPLICATION_ERROR (
NUM => -20000,
MSG => 'NE SMETE DA AZURIRATE NAZIV ARTIKLA ODAVDE');
END;
/
ALTER TRIGGER "DB02"."ZABRANI_AZUR_NAZIVARTIKLA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ZABRANI_AZUR_TRENUTNA_CENA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ZABRANI_AZUR_TRENUTNA_CENA" 
AFTER UPDATE of trenutna_cena
ON artikal_detalji 
FOR EACH ROW

BEGIN
RAISE_APPLICATION_ERROR (
NUM => -20000,
MSG => 'NE SMETE DA DIREKTNO AZURIRATE TRENUTNU CENU');
END;
/
ALTER TRIGGER "DB02"."ZABRANI_AZUR_TRENUTNA_CENA" DISABLE;
--------------------------------------------------------
--  DDL for Trigger ZABRANI_AZUR_UKUPNI_IZNOS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."ZABRANI_AZUR_UKUPNI_IZNOS" 
BEFORE UPDATE of ukupni_iznos
ON ponuda 
FOR EACH ROW

BEGIN
RAISE_APPLICATION_ERROR (
NUM => -20000,
MSG => 'NE SMETE DA DIREKTNO AZURIRATE UKUPNI IZNOS');
END;
/
ALTER TRIGGER "DB02"."ZABRANI_AZUR_UKUPNI_IZNOS" DISABLE;
--------------------------------------------------------
--  DDL for Procedure CENA_ARTIKLA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "DB02"."CENA_ARTIKLA" (sifra_art IN NUMBER)
as
cena_art ARTIKAL_DETALJI.TRENUTNA_CENA%type;

begin

cena_art:=0;
select (c.cena*(1 + c.STOPAPDV/100)) into cena_art from cena c
where c.sifraartikla = sifra_art and datum =
(select max(datum) from cena where sifraartikla = sifra_art);

update ARTIKAL_DETALJI
set TRENUTNA_CENA = cena_art
where sifraartikla = sifra_art;

end cena_artikla;

/
--------------------------------------------------------
--  DDL for Procedure PONUDA_UKUPNO_PROC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "DB02"."PONUDA_UKUPNO_PROC" (br_pon IN NUMBER) AS
suma NUMBER:=0;
BEGIN

SELECT SUM(a.trenutna_cena*sp.kolicina) INTO suma
FROM ARTIKAL_DETALJI a join stavkaponude sp on
(a.sifraartikla=sp.sifraartikla)
WHERE brponude=br_pon;

UPDATE ponuda
SET UKUPNI_IZNOS=suma
WHERE brponude=br_pon;

END ponuda_ukupno_proc;

/
--------------------------------------------------------
--  DDL for Package SIFRA_PACK
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "DB02"."SIFRA_PACK" AS 

sifra number;
brponude number;

END SIFRA_PACK;

/
--------------------------------------------------------
--  Constraints for Table ARTIKAL
--------------------------------------------------------

  ALTER TABLE "DB02"."ARTIKAL" ADD CONSTRAINT "ARTIKAL_PK" PRIMARY KEY ("SIFRAARTIKLA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB02"."ARTIKAL" MODIFY ("SIFRAARTIKLA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table STAVKAPONUDE
--------------------------------------------------------

  ALTER TABLE "DB02"."STAVKAPONUDE" ADD CONSTRAINT "STAVKAPONUDE_PK" PRIMARY KEY ("RBR", "BRPONUDE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB02"."STAVKAPONUDE" MODIFY ("BRPONUDE" NOT NULL ENABLE);
  ALTER TABLE "DB02"."STAVKAPONUDE" MODIFY ("RBR" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CENA
--------------------------------------------------------

  ALTER TABLE "DB02"."CENA" ADD CONSTRAINT "CENA_PK" PRIMARY KEY ("DATUM", "SIFRAARTIKLA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB02"."CENA" MODIFY ("SIFRAARTIKLA" NOT NULL ENABLE);
  ALTER TABLE "DB02"."CENA" MODIFY ("DATUM" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ARTIKAL_DETALJI
--------------------------------------------------------

  ALTER TABLE "DB02"."ARTIKAL_DETALJI" ADD CONSTRAINT "ARTIKAL_DETALJI_PK" PRIMARY KEY ("SIFRAARTIKLA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB02"."ARTIKAL_DETALJI" MODIFY ("SIFRAARTIKLA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PONUDA
--------------------------------------------------------

  ALTER TABLE "DB02"."PONUDA" ADD CONSTRAINT "PONUDA_PK" PRIMARY KEY ("BRPONUDE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB02"."PONUDA" MODIFY ("BRPONUDE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table KUPAC
--------------------------------------------------------

  ALTER TABLE "DB02"."KUPAC" MODIFY ("IMEKUPCA" NOT NULL ENABLE);
  ALTER TABLE "DB02"."KUPAC" ADD CONSTRAINT "KUPAC_PK" PRIMARY KEY ("SIFRAKUPCA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DB02"."KUPAC" MODIFY ("SIFRAKUPCA" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table ARTIKAL_DETALJI
--------------------------------------------------------

  ALTER TABLE "DB02"."ARTIKAL_DETALJI" ADD CONSTRAINT "ARTIKAL_DETALJI_FK1" FOREIGN KEY ("SIFRAARTIKLA")
	  REFERENCES "DB02"."ARTIKAL" ("SIFRAARTIKLA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CENA
--------------------------------------------------------

  ALTER TABLE "DB02"."CENA" ADD CONSTRAINT "CENA_FK1" FOREIGN KEY ("SIFRAARTIKLA")
	  REFERENCES "DB02"."ARTIKAL" ("SIFRAARTIKLA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PONUDA
--------------------------------------------------------

  ALTER TABLE "DB02"."PONUDA" ADD CONSTRAINT "PONUDA_FK1" FOREIGN KEY ("SIFRAKUPCA")
	  REFERENCES "DB02"."KUPAC" ("SIFRAKUPCA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table STAVKAPONUDE
--------------------------------------------------------

  ALTER TABLE "DB02"."STAVKAPONUDE" ADD CONSTRAINT "STAVKAPONUDE_FK1" FOREIGN KEY ("SIFRAARTIKLA")
	  REFERENCES "DB02"."ARTIKAL" ("SIFRAARTIKLA") ENABLE;
  ALTER TABLE "DB02"."STAVKAPONUDE" ADD CONSTRAINT "STAVKAPONUDE_FK2" FOREIGN KEY ("BRPONUDE")
	  REFERENCES "DB02"."PONUDA" ("BRPONUDE") ENABLE;
