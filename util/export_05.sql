--------------------------------------------------------
--  File created - Monday-January-09-2017   
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
	"IMEKUPCA" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table STAVKAPONUDE
--------------------------------------------------------

  CREATE TABLE "DB02"."STAVKAPONUDE" 
   (	"RBR" NUMBER(5,0), 
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

   CREATE SEQUENCE  "DB02"."ARTIKAL_SEQ1"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
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

   CREATE SEQUENCE  "DB02"."KUPAC_SEQ1"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PONUDA_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."PONUDA_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PONUDA_SEQ1
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."PONUDA_SEQ1"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STAVKAPONUDE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DB02"."STAVKAPONUDE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
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
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (6,'DVR');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (7,'Novi1');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (4,'proba');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (5,'Kamera');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (8,'Proba2');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (9,'Kabl');
Insert into DB02.ARTIKAL (SIFRAARTIKLA,NAZIVARTIKLA) values (10,'Proba3');
REM INSERTING into DB02.ARTIKAL_DETALJI
SET DEFINE OFF;
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('proba','proba',4,650);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kom','Analogna kamera',5,222);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kom','Analogni DVR',6,1564);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kom','test',7,null);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kom','Analogni DVR',8,null);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('m','Opticki kabl',9,null);
Insert into DB02.ARTIKAL_DETALJI (JEDMERE,OPISARTIKLA,SIFRAARTIKLA,TRENUTNA_CENA) values ('kol','11',10,400);
REM INSERTING into DB02.CENA
SET DEFINE OFF;
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 03.44.18.411000000 PM','DD-MON-RR HH.MI.SSXFF AM'),4,650,18,'proba');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 03.44.42.230000000 PM','DD-MON-RR HH.MI.SSXFF AM'),6,650,10,'DVR');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 03.51.04.768000000 PM','DD-MON-RR HH.MI.SSXFF AM'),5,111,18,'Kamera');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 04.03.22.788000000 PM','DD-MON-RR HH.MI.SSXFF AM'),6,111,18,'DVR');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 04.42.26.779000000 PM','DD-MON-RR HH.MI.SSXFF AM'),10,400,18,'Proba3');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 04.15.36.579000000 PM','DD-MON-RR HH.MI.SSXFF AM'),7,400,18,'Novi1');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 04.19.53.498000000 PM','DD-MON-RR HH.MI.SSXFF AM'),8,650,18,'Proba2');
Insert into DB02.CENA (DATUM,SIFRAARTIKLA,CENA,STOPAPDV,NAZIVARTIKLA) values (to_timestamp('09-JAN-17 03.55.20.068000000 PM','DD-MON-RR HH.MI.SSXFF AM'),6,650,18,'DVR');
REM INSERTING into DB02.KUPAC
SET DEFINE OFF;
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (2,'Mile',DB02.DETALJI_KUPCA('Kalesija',233,444,'batica@gmail.com'));
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (3,'Milos',DB02.DETALJI_KUPCA(NULL,NULL,NULL,NULL));
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (5,'Mile',DB02.DETALJI_KUPCA('Negde',NULL,NULL,NULL));
Insert into DB02.KUPAC (SIFRAKUPCA,IMEKUPCA,DETALJI) values (1,'aca',DB02.DETALJI_KUPCA('Negde',233,444,'batica@gmail.com'));
REM INSERTING into DB02.PONUDA
SET DEFINE OFF;
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA) values (3,to_timestamp('09-JAN-17 11.29.29.502000000 AM','DD-MON-RR HH.MI.SSXFF AM'),2,'Mile');
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA) values (4,to_timestamp('09-JAN-17 11.38.52.677000000 AM','DD-MON-RR HH.MI.SSXFF AM'),3,'Milos');
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA) values (1,to_timestamp('09-JAN-17 11.28.48.880000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,'aca');
Insert into DB02.PONUDA (BRPONUDE,DATUM,SIFRAKUPCA,IMEKUPCA) values (2,to_timestamp('09-JAN-17 11.28.50.401000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,'aca');
REM INSERTING into DB02.STAVKAPONUDE
SET DEFINE OFF;
Insert into DB02.STAVKAPONUDE (RBR,BRPONUDE,KOLICINA,SIFRAARTIKLA) values (21,1,2,5);
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
ALTER TRIGGER "DB02"."DROP_TRIGGER_DB02" DISABLE;
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
--  DDL for Trigger STAVKAPONUDE_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."STAVKAPONUDE_TRG" 
BEFORE INSERT ON STAVKAPONUDE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.RBR IS NULL THEN
      SELECT STAVKAPONUDE_SEQ.NEXTVAL INTO :NEW.RBR FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "DB02"."STAVKAPONUDE_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UNESI_AKT_CENU1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."UNESI_AKT_CENU1" 
after INSERT on cena
FOR EACH row
begin

if (:NEW.sifraartikla is not null)  then

  "cena_artikla" (:NEW.sifraartikla);
end if;
END;
/
ALTER TRIGGER "DB02"."UNESI_AKT_CENU1" DISABLE;
--------------------------------------------------------
--  DDL for Trigger UNESI_AKT_CENU2
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "DB02"."UNESI_AKT_CENU2" 
AFTER INSERT OR UPDATE OR DELETE ON cena
DECLARE
x NUMBER;
cenap_sifraartikla number;
BEGIN
x :=cenap_sifraartikla;
"cena_artikla"(x);
END;
/
ALTER TRIGGER "DB02"."UNESI_AKT_CENU2" DISABLE;
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
AFTER UPDATE ON ponuda 
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
AFTER UPDATE ON cena 
FOR EACH ROW

BEGIN
RAISE_APPLICATION_ERROR (
NUM => -20000,
MSG => 'NE SMETE DA AZURIRATE IME NAZIV ARTIKLA ODAVDE');
END;
/
ALTER TRIGGER "DB02"."ZABRANI_AZUR_NAZIVARTIKLA" ENABLE;
--------------------------------------------------------
--  DDL for Procedure cena_artikla
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "DB02"."cena_artikla" 
(sifra_art IN NUMBER)
as
cena_art ARTIKAL_DETALJI.TRENUTNA_CENA%TYPE;
begin
cena_art:=0;
select cena into cena_art from cena
where sifraartikla = sifra_art and datum =
(select max(datum) from cena where sifraartikla = sifra_art);

update ARTIKAL_DETALJI
set TRENUTNA_CENA = cena_art
where sifraartikla = sifra_art;

end;

/
--------------------------------------------------------
--  DDL for Function CUSTOM_AUTH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "DB02"."CUSTOM_AUTH" (p_username in VARCHAR2, p_password in VARCHAR2)
return BOOLEAN
is
  l_password varchar2(4000);
  l_stored_password varchar2(4000);
  l_expires_on date;
  l_count number;
begin
-- First, check to see if the user is in the user table
select count(*) into l_count from demo_users where user_name = p_username;
if l_count > 0 then
  -- First, we fetch the stored hashed password & expire date
  select password, expires_on into l_stored_password, l_expires_on
   from demo_users where user_name = p_username;

  -- Next, we check to see if the user's account is expired
  -- If it is, return FALSE
  if l_expires_on > sysdate or l_expires_on is null then

    -- If the account is not expired, we have to apply the custom hash
    -- function to the password
    l_password := custom_hash(p_username, p_password);

    -- Finally, we compare them to see if they are the same and return
    -- either TRUE or FALSE
    if l_password = l_stored_password then
      return true;
    else
      return false;
    end if;
  else
    return false;
  end if;
else
  -- The username provided is not in the DEMO_USERS table
  return false;
end if;
end;

/
--------------------------------------------------------
--  DDL for Function CUSTOM_HASH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "DB02"."CUSTOM_HASH" (p_username in varchar2, p_password in varchar2)
return varchar2
is
  l_password varchar2(4000);
  l_salt varchar2(4000) := '8LJ2N9EPRR5VL6LBXHKBB57YJY24SC';
begin

-- This function should be wrapped, as the hash algorhythm is exposed here.
-- You can change the value of l_salt or the method of which to call the
-- DBMS_OBFUSCATOIN toolkit, but you much reset all of your passwords
-- if you choose to do this.

l_password := utl_raw.cast_to_raw(dbms_obfuscation_toolkit.md5
  (input_string => p_password || substr(l_salt,10,13) || p_username ||
    substr(l_salt, 4,10)));
return l_password;
end;

/
--------------------------------------------------------
--  DDL for Function GET_BAL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "DB02"."GET_BAL" (
    acc_no IN NUMBER)
  RETURN NUMBER
IS
  acc_bal NUMBER(11,2);
BEGIN
  SELECT demo_orders.order_total
  INTO acc_bal
  FROM DEMO_ORDERS
  WHERE customer_id = acc_no;
  RETURN(acc_bal);
END;

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
--  Ref Constraints for Table STAVKAPONUDE
--------------------------------------------------------

  ALTER TABLE "DB02"."STAVKAPONUDE" ADD CONSTRAINT "STAVKAPONUDE_FK1" FOREIGN KEY ("SIFRAARTIKLA")
	  REFERENCES "DB02"."ARTIKAL" ("SIFRAARTIKLA") ENABLE;
  ALTER TABLE "DB02"."STAVKAPONUDE" ADD CONSTRAINT "STAVKAPONUDE_FK2" FOREIGN KEY ("BRPONUDE")
	  REFERENCES "DB02"."PONUDA" ("BRPONUDE") ENABLE;
