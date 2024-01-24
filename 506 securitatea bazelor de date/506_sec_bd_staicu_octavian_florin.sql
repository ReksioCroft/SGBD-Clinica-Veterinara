--6
CREATE TABLE LOCATIE
(
    id_locatie NUMBER(10),
    oras       VARCHAR2(32)  NOT NULL,
    judet      VARCHAR2(32)  NOT NULL,
    adresa     VARCHAR2(256) NOT NULL,
    cod_postal NUMBER(10),
    CONSTRAINT pk_locatie PRIMARY KEY (id_locatie)
);

CREATE TABLE PROPRIETAR
(
    id_proprietar NUMBER(10),
    nume          VARCHAR2(32) NOT NULL,
    prenume       VARCHAR2(32) NOT NULL,
    telefon       NUMBER(10)   NOT NULL,
    email         VARCHAR2(64) NOT NULL,
    id_locatie    NUMBER(10)   NOT NULL,
    CONSTRAINT pk_proprietar PRIMARY KEY (id_proprietar),
    CONSTRAINT fk_proprietar_locatie FOREIGN KEY (id_locatie) REFERENCES LOCATIE (id_locatie),
    CONSTRAINT unique_tel_proprietar UNIQUE (telefon),
    CONSTRAINT unique_email_proprietar UNIQUE (email)
);

CREATE TABLE ANIMALUT
(
    id_animalut   NUMBER(10),
    nume          VARCHAR2(32) NOT NULL,
    rasa          Varchar2(32) NOT NULL,
    zi_nastere    DATE         NOT NULL,
    id_proprietar NUMBER(10),
    CONSTRAINT pk_animalut PRIMARY KEY (id_animalut),
    CONSTRAINT fk_animalut_proprietar FOREIGN KEY (id_proprietar) REFERENCES PROPRIETAR (id_proprietar)
);

CREATE TABLE DIAGNOSTIC
(
    id_diagnostic NUMBER(10),
    descriere     VARCHAR2(4000) NOT NULL,
    tratament     VARCHAR2(4000) NOT NULL,
    CONSTRAINT pk_diagnostic PRIMARY KEY (id_diagnostic)
);

CREATE TABLE ANGAJAT
(
    id_angajat       NUMBER(10),
    nume             VARCHAR2(32) NOT NULL,
    prenume          VARCHAR2(32) NOT NULL,
    telefon          NUMBER(10)   NOT NULL,
    email            VARCHAR2(64) NOT NULL,
    id_locatie       NUMBER(10)   NOT NULL,
    id_sef           NUMBER(10),
    trateaza_animale NUMBER(1)    NOT NULL,
    CONSTRAINT pk_angajat PRIMARY KEY (id_angajat),
    CONSTRAINT fk_angajat_locatie FOREIGN KEY (id_locatie) REFERENCES LOCATIE (id_locatie),
    CONSTRAINT fk_angajat FOREIGN KEY (id_sef) REFERENCES ANGAJAT (id_angajat),
    CONSTRAINT unique_tel_angajat UNIQUE (telefon),
    CONSTRAINT unique_email_angajat UNIQUE (email)
);

CREATE TABLE FISA_MEDICALA
(
    id_fisa       NUMBER(10),
    id_diagnostic NUMBER(10) NOT NULL,
    id_animalut   NUMBER(10) NOT NULL,
    id_doctor     NUMBER(10) NOT NULL,
    data_fisa     DATE       NOT NULL,
    observatii    VARCHAR2(4000),
    CONSTRAINT pk_fisa_medicala PRIMARY KEY (id_fisa),
    CONSTRAINT fk_fisa_diagnostic FOREIGN KEY (id_diagnostic) REFERENCES DIAGNOSTIC (id_diagnostic),
    CONSTRAINT fk_fisa_animalut FOREIGN KEY (id_animalut) REFERENCES ANIMALUT (id_animalut),
    CONSTRAINT fk_fisa_doctor FOREIGN KEY (id_doctor) REFERENCES ANGAJAT (id_angajat)
);

CREATE TABLE PRODUCATOR
(
    id_producator    NUMBER(10),
    telefon          NUMBER(10)   NOT NULL,
    email            VARCHAR2(64) NOT NULL,
    nume_firma       VARCHAR2(64) NOT NULL,
    id_locatie       NUMBER(10)   NOT NULL,
    persoana_contact VARCHAR2(64),
    CONSTRAINT pk_producator PRIMARY KEY (id_producator),
    CONSTRAINT fk_producator_locatie FOREIGN KEY (id_locatie) REFERENCES LOCATIE (id_locatie),
    CONSTRAINT producator_unique_location UNIQUE (id_locatie),
    CONSTRAINT unique_tel_producator UNIQUE (telefon),
    CONSTRAINT unique_email_producator UNIQUE (email)
);

CREATE TABLE CONTRACT
(
    id_contract           NUMBER(10),
    data_semnare          DATE NOT NULL,
    observatii            VARCHAR2(4000),
    id_contract_modificat NUMBER(10),
    CONSTRAINT pk_contract PRIMARY KEY (id_contract),
    CONSTRAINT fk_contract FOREIGN KEY (id_contract_modificat) REFERENCES CONTRACT (id_contract),
    CONSTRAINT unique_contract UNIQUE (id_contract_modificat)
);

CREATE TABLE CONTRACT_ANGAJAT
(
    id_contract NUMBER(10),
    id_angajat  NUMBER(10)   NOT NULL,
    rol         VARCHAR2(32) NOT NULL,
    salariu     NUMBER(5)    NOT NULL,
    CONSTRAINT pk_contract_angajat PRIMARY KEY (id_contract),
    CONSTRAINT fk_contract_angajat_contract FOREIGN KEY (id_contract) REFERENCES CONTRACT (id_contract),
    CONSTRAINT fk_contract_angajat FOREIGN KEY (id_angajat) REFERENCES ANGAJAT (id_angajat)
);

CREATE TABLE CONTRACT_PRODUCATOR
(
    id_contract   NUMBER(10),
    id_producator NUMBER(10) NOT NULL,
    CONSTRAINT pk_contract_producator PRIMARY KEY (id_contract),
    CONSTRAINT fk_contract_prod_contract FOREIGN KEY (id_contract) REFERENCES CONTRACT (id_contract),
    CONSTRAINT fk_contract_producator FOREIGN KEY (id_producator) REFERENCES PRODUCATOR (id_producator)
);

CREATE TABLE FACTURA
(
    id_factura    NUMBER(10),
    total_factura NUMBER(7, 2) NOT NULL,
    data_emitere  DATE         NOT NULL,
    CONSTRAINT pk_factura PRIMARY KEY (id_factura)
);

CREATE TABLE FACTURA_PROPRIETAR
(
    id_factura       NUMBER(10),
    id_proprietar    NUMBER(10) NOT NULL,
    id_fisa_medicala NUMBER(10),
    CONSTRAINT pk_factura_proprietar PRIMARY KEY (id_factura),
    CONSTRAINT fk_factura_proprietar FOREIGN KEY (id_proprietar) REFERENCES PROPRIETAR (id_proprietar),
    CONSTRAINT fk_factura_proprietar_fact FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura),
    CONSTRAINT fk_factura_proprietar_fisa_medicala FOREIGN KEY (id_fisa_medicala) REFERENCES FISA_MEDICALA (id_fisa)
);

CREATE TABLE FACTURA_PRODUCATOR
(
    id_factura    NUMBER(10),
    id_producator NUMBER(10) NOT NULL,
    CONSTRAINT pk_factura_producator PRIMARY KEY (id_factura),
    CONSTRAINT fk_factura_producator FOREIGN KEY (id_producator) REFERENCES PRODUCATOR (id_producator),
    CONSTRAINT fk_factura_producator_fact FOREIGN KEY (id_factura) REFERENCES FACTURA (id_factura)
);

CREATE TABLE CHITANTA
(
    id_chitanta  NUMBER(10),
    suma_platita NUMBER(7, 2) NOT NULL,
    data_plata   DATE         NOT NULL,
    id_factura   NUMBER(10)   NOT NULL,
    CONSTRAINT pk_chitanta PRIMARY KEY (id_chitanta),
    CONSTRAINT fk_chitanta_factura FOREIGN KEY (id_factura) references FACTURA (id_factura)
);


CREATE TABLE PRODUS
(
    id_produs      NUMBER(10),
    caracteristici VARCHAR2(256) NOT NULL,
    id_producator  NUMBER(10)    NOT NULL,
    CONSTRAINT pk_produs PRIMARY KEY (id_produs),
    CONSTRAINT fk_produs FOREIGN KEY (id_producator) REFERENCES PRODUCATOR (id_producator)
);

CREATE TABLE INVENTAR
(
    id_inventar   NUMBER(10),
    data_inventar DATE NOT NULL,
    CONSTRAINT pk_inventar PRIMARY KEY (id_inventar)
);

CREATE TABLE PRODUSE_DIN_INVENTAR
(
    id_produs     NUMBER(10) NOT NULL,
    id_inventar   NUMBER(10) NOT NULL,
    id_factura    NUMBER(10) NOT NULL,
    cantitate     NUMBER(5)  NOT NULL,
    data_expirare DATE,
    CONSTRAINT pk_produse_inventar PRIMARY KEY (id_produs, id_inventar, id_factura),
    CONSTRAINT fk_prod_inventar FOREIGN KEY (id_inventar) REFERENCES INVENTAR (id_inventar),
    CONSTRAINT fk_prod_produs FOREIGN KEY (id_produs) REFERENCES PRODUS (id_produs),
    CONSTRAINT fk_prod_factura FOREIGN KEY (id_factura) REFERENCES FACTURA_PRODUCATOR (id_factura)
);

commit;

--5
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (1, 'Bucuresti', 'Sector 2', 'soseaua colentina nr 2');
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa, cod_postal)
VALUES (2, 'Bucuresti', 'Sector 1', 'soseaua Aviatorilor nr 1', 12345);
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (3, 'Pantelimon', 'Ilfov', 'soseaua dn2');
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (4, 'Cluj-Napoca', 'Cluj', 'soseaua jmekera');
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (5, 'Iasi', 'Iasi', 'soseaua industriei');
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (6, 'Timisoara', 'Timis', 'soseaua intreprinderii');
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (7, 'Constanta', 'Constanta', 'soseaua antreprenorilor');
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (8, 'Giurgiu', 'Giurgiu', 'soseaua giurgiului');
INSERT INTO LOCATIE(id_locatie, oras, judet, adresa)
VALUES (9, 'Severin', 'Mehedinti', 'traian');

INSERT INTO PROPRIETAR(id_proprietar, nume, prenume, email, telefon, id_locatie)
VALUES (1, 'Staicu', 'Octavian-Florin', 'octavian.staicu@s.unibuc.ro', 0736659442, 1);
INSERT INTO PROPRIETAR(id_proprietar, nume, prenume, email, telefon, id_locatie)
VALUES (2, 'Bodea', 'George', 'george@yahoo.com', 0737392518, 2);
INSERT INTO PROPRIETAR(id_proprietar, nume, prenume, email, telefon, id_locatie)
VALUES (3, 'Staicu', 'Adrian', 'adi@gmail.com', 0736659441, 1);
INSERT INTO PROPRIETAR(id_proprietar, nume, prenume, email, telefon, id_locatie)
VALUES (4, 'Popescu', 'Ion', 'popescu.ion@gmail.com', 0771654789, 3);
INSERT INTO PROPRIETAR(id_proprietar, nume, prenume, email, telefon, id_locatie)
VALUES (5, 'Cineva', 'Interesant', 'jmekerie@my.fmi.unibuc.ro', 0777111999, 4);
INSERT INTO PROPRIETAR(id_proprietar, nume, prenume, email, telefon, id_locatie)
VALUES (6, 'Fara', 'Animalut', 'cumparator@my.fmi.unibuc.ro', 0729123123, 2);

INSERT INTO ANIMALUT(id_animalut, nume, rasa, zi_nastere, id_proprietar)
VALUES (1, 'Bit', 'Boxer', to_date('05/05/2017', 'DD/MM/YYYY'), 1);
INSERT INTO ANIMALUT(id_animalut, nume, rasa, zi_nastere, id_proprietar)
VALUES (2, 'Kid', 'Ciobanesc German', to_date('13/07/2010', 'DD/MM/YYYY'), 3);
INSERT INTO ANIMALUT(id_animalut, nume, rasa, zi_nastere, id_proprietar)
VALUES (3, 'Kitty', 'Birmaneza', to_date('25/12/2015', 'DD/MM/YYYY'), 2);
INSERT INTO ANIMALUT(id_animalut, nume, rasa, zi_nastere, id_proprietar)
VALUES (4, 'Angelina', 'Pisica Tigrata de Hymalaia', to_date('06/06/2016', 'DD/MM/YYYY'), 5);
INSERT INTO ANIMALUT(id_animalut, nume, rasa, zi_nastere, id_proprietar)
VALUES (5, 'John', 'Metis', to_date('05/12/2008', 'DD/MM/YYYY'), 4);
insert into ANIMALUT(id_animalut, nume, rasa, zi_nastere, id_proprietar)
VALUES (6, 'dog', 'Boxer', to_date('09.01.2021', 'dd.mm.yyyy'), 5);
insert into ANIMALUT(id_animalut, nume, rasa, zi_nastere, id_proprietar)
VALUES (13, 'Thor', 'Golden Retriever', to_date('13.07.2020', 'dd.mm.yyyy'), 1);
insert into ANIMALUT(id_animalut, nume, rasa, zi_nastere)
VALUES (11, 'Idk', 'Comuna', to_date('13.01.2023', 'dd.mm.yyyy'));
insert into ANIMALUT(id_animalut, nume, rasa, zi_nastere)
VALUES (14, 'Idk2', 'Comuna', to_date('01.02.2023', 'dd.mm.yyyy'));

INSERT INTO DIAGNOSTIC(id_diagnostic, descriere, tratament)
VALUES (1, 'Vaccinare Leptospiroza', 'Vaccin Leptospiroza');
INSERT INTO DIAGNOSTIC(id_diagnostic, descriere, tratament)
VALUES (2, 'Enterocolita', 'Enteroguarg');
INSERT INTO DIAGNOSTIC(id_diagnostic, descriere, tratament)
VALUES (3, 'Rana deschisa', 'Spray Cicatrizant');
INSERT INTO DIAGNOSTIC(id_diagnostic, descriere, tratament)
VALUES (4, 'durere abdominala', 'ecografie');
INSERT INTO DIAGNOSTIC(id_diagnostic, descriere, tratament)
VALUES (5, 'capusa', 'eliminare capusa');

INSERT INTO ANGAJAT(id_angajat, nume, prenume, telefon, email, id_locatie, trateaza_animale)
VALUES (1, 'Staicu', 'Clara', 0722012983, 'dr.staicu-clara@clinicatareanimale.ro', 1, 1);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, telefon, email, id_sef, id_locatie, trateaza_animale)
VALUES (2, 'Popa', 'Adi', 0723145867, 'asistent.popa-adi@clinicatareanimale.ro', 1, 2, 1);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, telefon, email, id_locatie, trateaza_animale)
VALUES (3, 'Spalatorul', 'Pop', 0711012070, 'spalatorul.pop@gmail.com', 3, 0);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, telefon, email, id_locatie, trateaza_animale)
VALUES (4, 'Ana', 'Maria', 0723012982, 'dr.ana-maria@clinicatareanimale.ro', 1, 1);
INSERT INTO ANGAJAT(id_angajat, nume, prenume, telefon, email, id_sef, id_locatie, trateaza_animale)
VALUES (5, 'Numinescu', 'George', 0723145868, 'asistent.numinescu-george@clinicatareanimale.ro', 4, 2, 1);

INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (1, 2, 1, 1, to_date('13.07.2020', 'dd.mm.yyyy'), 'Stapanul a dat caineul sa manance tort');
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa)
VALUES (2, 1, 2, 1, to_date('13.07.2011', 'dd.mm.yyyy'));
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa)
VALUES (3, 1, 3, 2, to_date('13.07.2016', 'dd.mm.yyyy'));
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (4, 3, 1, 2, to_date('13.09.2020', 'dd.mm.yyyy'), 'Rana deschisa in zona botului');
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (5, 1, 4, 1, to_date('13.07.2017', 'dd.mm.yyyy'), 'Una din cele mai frumoase specimene');
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa)
VALUES (6, 2, 5, 1, to_date('04.05.2009', 'dd.mm.yyyy'));
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (7, 1, 5, 2, to_date('14.06.2010', 'dd.mm.yyyy'), 'Vaccinare anuala');
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa)
VALUES (8, 1, 4, 2, to_date('13.07.2020', 'dd.mm.yyyy'));
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (9, 3, 3, 1, to_date('13.12.2016', 'dd.mm.yyyy'), 'S-a taiat intr-o conserva de peste');
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (10, 2, 1, 1, to_date('25.12.2020', 'dd.mm.yyyy'), 'Cainele a mancat din pregaritile de Craciun');
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa)
VALUES (11, 3, 5, 1, to_date('14.08.2015', 'dd.mm.yyyy'));
insert into FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa)
VALUES (13, 1, 13, 1, to_date('13.09.2020', 'dd.mm.yyyy'));
insert into FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa)
VALUES (12, 1, 13, 1, to_date('13.07.2021', 'dd.mm.yyyy'));
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (14, 3, 11, 1, to_date('05.02.2023', 'dd.mm.yyyy'), 'catelus fara stapan');
INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (15, 3, 14, 1, to_date('05.02.2023', 'dd.mm.yyyy'), 'catelus fara stapan');

INSERT INTO PRODUCATOR(id_producator, nume_firma, telefon, email, id_locatie)
VALUES (1, 'Mancare Catei SA', 0767582563, 'comenzi@mancarecatei.ro', 5);
INSERT INTO PRODUCATOR(id_producator, nume_firma, telefon, email, persoana_contact, id_locatie)
VALUES (2, 'Aparatura Animale SRL', 0798712365, 'aparatus.ion@aparaturaanimale.ro', 'Aparatus Ion', 6);
INSERT INTO PRODUCATOR(id_producator, nume_firma, telefon, email, persoana_contact, id_locatie)
VALUES (3, 'Vaccinam cu Iubire', 0712345678, 'bussines@vacciniubire.ro', 'Ana Vacix', 7);
INSERT INTO PRODUCATOR(id_producator, nume_firma, telefon, email, persoana_contact, id_locatie)
VALUES (4, 'Producator 4', 0700000000, 'producator4@bussines.ro', 'Producator 4 contact', 8);
INSERT INTO PRODUCATOR(id_producator, nume_firma, telefon, email, persoana_contact, id_locatie)
VALUES (5, 'Producator 5', 0711111111, 'bussines@producator5.ro', 'contact prod 5', 9);

INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (1, to_date('02.01.2005', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (2, to_date('13.07.2004', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (3, to_date('09.09.2005', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (4, to_date('01.05.2007', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (5, to_date('02.06.2008', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (6, to_date('02.01.2005', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare, observatii, id_contract_modificat)
VALUES (7, to_date('28.12.2020', 'dd.mm.yyyy'), 'Promovare', 2);
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (8, to_date('02.01.2020', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (9, to_date('02.01.2021', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (10, to_date('02.07.2022', 'dd.mm.yyyy'));
INSERT INTO CONTRACT(id_contract, data_semnare)
VALUES (11, to_date('13.01.2023', 'dd.mm.yyyy'));

INSERT INTO CONTRACT_ANGAJAT(id_contract, id_angajat, rol, salariu)
VALUES (1, 1, 'doctor veterinar', 6000);
INSERT INTO CONTRACT_ANGAJAT(id_contract, id_angajat, rol, salariu)
VALUES (2, 2, 'asistent veterinar', 3000);
INSERT INTO CONTRACT_ANGAJAT(id_contract, id_angajat, rol, salariu)
VALUES (3, 3, 'paznic', 1500);
INSERT INTO CONTRACT_ANGAJAT(id_contract, id_angajat, rol, salariu)
VALUES (7, 2, 'doctor veterinar', 6000);
INSERT INTO CONTRACT_ANGAJAT(id_contract, id_angajat, rol, salariu)
VALUES (8, 4, 'doctor veterinar', 6000);
INSERT INTO CONTRACT_ANGAJAT(id_contract, id_angajat, rol, salariu)
VALUES (9, 5, 'asistent veterinar', 3000);

INSERT INTO CONTRACT_PRODUCATOR(id_contract, id_producator)
VALUES (4, 1);
INSERT INTO CONTRACT_PRODUCATOR(id_contract, id_producator)
VALUES (5, 2);
INSERT INTO CONTRACT_PRODUCATOR(id_contract, id_producator)
VALUES (6, 3);
INSERT INTO CONTRACT_PRODUCATOR(id_contract, id_producator)
VALUES (10, 4);
INSERT INTO CONTRACT_PRODUCATOR(id_contract, id_producator)
VALUES (11, 5);

INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (1, 300, to_date('13.07.2020', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (2, 300, to_date('13.07.2011', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (3, 300, to_date('13.07.2015', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (4, 300, to_date('13.09.2020', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (5, 300, to_date('13.07.2017', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (6, 300, to_date('04.05.2009', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (7, 300, to_date('14.06.2010', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (8, 300, to_date('13.07.2020', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (9, 300, to_date('13.12.2016', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (10, 300, to_date('25.12.2020', 'dd.mm.yyyy'));
insert into FACTURA(id_factura, total_factura, data_emitere)
VALUES (104, 300, to_date('13.07.2021', 'dd.mm.yyyy'));
insert into FACTURA(id_factura, total_factura, data_emitere)
VALUES (105, 3000, to_date('13.07.2021', 'dd.mm.yyyy'));
insert into FACTURA(id_factura, total_factura, data_emitere)
VALUES (106, 3000, to_date('12.05.2021', 'dd.mm.yyyy'));
insert into FACTURA(id_factura, total_factura, data_emitere)
VALUES (107, 3000, to_date('12.05.2021', 'dd.mm.yyyy'));
Insert into FACTURA(id_factura, total_factura, data_emitere)
VALUES (1000, 100, sysdate);
Insert into FACTURA(id_factura, total_factura, data_emitere)
VALUES (1001, 100, sysdate);
Insert into FACTURA(id_factura, total_factura, data_emitere)
VALUES (1002, 499, to_date('06.02.2023', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (11, 1500, to_date('25.10.2009', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (12, 4325, to_date('13.11.2009', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (13, 6000, to_date('25.07.2009', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (14, 1400, to_date('25.10.2014', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (15, 4725, to_date('13.04.2013', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (16, 6025, to_date('25.09.2014', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (17, 5000, to_date('13.11.2019', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (18, 7500, to_date('25.09.2019', 'dd.mm.yyyy'));
INSERT INTO FACTURA(ID_FACTURA, TOTAL_FACTURA, DATA_EMITERE)
VALUES (19, 9256.35, to_date('12.04.2019', 'dd.mm.yyyy'));

INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (1, 1, 1);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (2, 3, 2);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (3, 2, 3);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (4, 1, 4);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (5, 5, 5);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (6, 4, 6);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (7, 4, 7);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (8, 5, 8);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (9, 2, 9);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (10, 1, 10);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (104, 1, 11);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (105, 1, 12);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (106, 2, 13);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (107, 2, 13);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar)
VALUES (1000, 5);
INSERT INTO FACTURA_PROPRIETAR(id_factura, id_proprietar, id_fisa_medicala)
VALUES (1002, 5, 15);

INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (11, 1);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (12, 2);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (13, 3);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (14, 1);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (15, 2);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (16, 3);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (17, 1);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (18, 2);
INSERT INTO FACTURA_PRODUCATOR(id_factura, id_producator)
VALUES (19, 3);

INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (1, 150, to_date('13.07.2020', 'dd.mm.yyyy'), 1);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (2, 300, to_date('13.07.2011', 'dd.mm.yyyy'), 2);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (3, 300, to_date('13.08.2015', 'dd.mm.yyyy'), 3);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (4, 300, to_date('03.01.2021', 'dd.mm.yyyy'), 4);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (5, 150, to_date('13.07.2017', 'dd.mm.yyyy'), 5);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (6, 75.25, to_date('13.08.2017', 'dd.mm.yyyy'), 5);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (7, 75.75, to_date('13.09.2017', 'dd.mm.yyyy'), 5);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (8, 100, to_date('13.07.2009', 'dd.mm.yyyy'), 6);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (9, 200, to_date('17.08.2009', 'dd.mm.yyyy'), 6);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (10, 300, to_date('13.07.2010', 'dd.mm.yyyy'), 7);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (11, 300, to_date('13.09.2020', 'dd.mm.yyyy'), 8);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (12, 300, to_date('13.12.2016', 'dd.mm.yyyy'), 9);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (13, 300, to_date('15.01.2021', 'dd.mm.yyyy'), 10);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (14, 1500, to_date('25.10.2009', 'dd.mm.yyyy'), 11);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (15, 4325, to_date('25.10.2009', 'dd.mm.yyyy'), 12);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (16, 3000, to_date('25.07.2009', 'dd.mm.yyyy'), 13);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (17, 3000, to_date('25.09.2009', 'dd.mm.yyyy'), 13);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (18, 1400, to_date('25.10.2014', 'dd.mm.yyyy'), 14);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (19, 4725, to_date('13.05.2013', 'dd.mm.yyyy'), 15);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (20, 3025, to_date('25.09.2014', 'dd.mm.yyyy'), 16);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (21, 3000, to_date('01.11.2014', 'dd.mm.yyyy'), 16);
INSERT INTO CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (22, 4500, to_date('25.10.2019', 'dd.mm.yyyy'), 18);
insert into CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (104, 300, to_date('13.07.2021', 'dd.mm.yyyy'), 104);
insert into CHITANTA(id_chitanta, suma_platita, data_plata, id_factura)
VALUES (106, 600, to_date('13.07.2021', 'dd.mm.yyyy'), 106);


INSERT INTO PRODUS(id_produs, caracteristici, id_producator)
VALUES (1, 'boabe de caini cu carne de vita si somon', 1);
INSERT INTO PRODUS(id_produs, caracteristici, id_producator)
VALUES (2, 'boabe de pisici cu ulei de peste', 1);
INSERT INTO PRODUS(id_produs, caracteristici, id_producator)
VALUES (3, 'aparat radiografie', 2);
INSERT INTO PRODUS(id_produs, caracteristici, id_producator)
VALUES (4, 'stetoscop', 2);
INSERT INTO PRODUS(id_produs, caracteristici, id_producator)
VALUES (5, 'masa operatii', 2);
INSERT INTO PRODUS(id_produs, caracteristici, id_producator)
VALUES (6, 'vaccin leptospiroza', 3);
INSERT INTO PRODUS(id_produs, caracteristici, id_producator)
VALUES (7, 'vaccin hexavalent', 3);

INSERT INTO INVENTAR(id_inventar, data_inventar)
VALUES (1, to_date('05.01.2010', 'dd.mm.yyyy'));
INSERT INTO INVENTAR(id_inventar, data_inventar)
VALUES (2, to_date('05.01.2015', 'dd.mm.yyyy'));
INSERT INTO INVENTAR(id_inventar, data_inventar)
VALUES (3, to_date('05.01.2020', 'dd.mm.yyyy'));
INSERT INTO INVENTAR(id_inventar, data_inventar)
VALUES (4, to_date('05.01.2021', 'dd.mm.yyyy'));
INSERT INTO INVENTAR(id_inventar, data_inventar)
VALUES (5, to_date('05.01.2022', 'dd.mm.yyyy'));

INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (1, 1, 11, 10, to_date('05.01.2011', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (2, 1, 12, 15, to_date('05.01.2011', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (1, 2, 13, 20, to_date('05.01.2016', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (2, 2, 14, 25, to_date('05.01.2016', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (1, 3, 15, 35, to_date('05.03.2023', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (2, 3, 16, 30, to_date('05.01.2021', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (3, 1, 17, 1);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (3, 2, 18, 1);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (3, 3, 19, 2);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (4, 1, 11, 5);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (4, 2, 12, 10);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (4, 3, 13, 15);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (5, 1, 14, 1);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (5, 2, 15, 1);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate)
VALUES (5, 3, 16, 2);
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (6, 1, 17, 100, to_date('13.07.2011', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (7, 1, 18, 150, to_date('13.07.2011', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (6, 2, 19, 100, to_date('13.07.2011', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (7, 2, 11, 150, to_date('13.07.2011', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (6, 3, 12, 234, to_date('13.07.2011', 'dd.mm.yyyy'));
INSERT INTO PRODUSE_DIN_INVENTAR(id_produs, id_inventar, id_factura, cantitate, data_expirare)
VALUES (7, 3, 13, 512, to_date('13.07.2011', 'dd.mm.yyyy'));


commit;

-- 2. criptarea datelor
drop table ENCKEYS cascade constraints;
drop table PROPRIETAR_DECRYPTED cascade constraints;
drop table PROPRIETAR_ENCRYPTED cascade constraints;


CREATE TABLE ENCKeys
(
    id_key  NUMBER(7),
    enc_key RAW(16),
    CONSTRAINT pk_ENCKeys PRIMARY KEY (id_key)
);

CREATE TABLE Proprietar_Encrypted
(
    id_proprietar NUMBER(10),
    nume          RAW(100) NOT NULL,
    prenume       RAW(100) NOT NULL,
    telefon       RAW(100) NOT NULL,
    email         RAW(100) NOT NULL,
    id_locatie    RAW(100) NOT NULL,
    CONSTRAINT pk_proprietar_enc PRIMARY KEY (id_proprietar)
);

CREATE TABLE Proprietar_Decrypted
(
    id_proprietar NUMBER(10),
    nume          VARCHAR2(32) NOT NULL,
    prenume       VARCHAR2(32) NOT NULL,
    telefon       NUMBER(10)   NOT NULL,
    email         VARCHAR2(64) NOT NULL,
    id_locatie    NUMBER(10)   NOT NULL,
    CONSTRAINT pk_proprietar_dec PRIMARY KEY (id_proprietar)
);

CREATE OR REPLACE PROCEDURE Encrypt_Proprietar AS
    encryption_key               RAW(16);
    encryption_binary_location   RAW(100);
    encryption_binary_last_name  RAW(100);
    encryption_binary_first_name RAW(100);
    encryption_binary_email      RAW(100);
    encryption_binary_phone      RAW(100);
    encryption_type              PLS_INTEGER;
BEGIN
    FOR c IN (SELECT * FROM PROPRIETAR)
        LOOP
            encryption_key := DBMS_CRYPTO.randombytes(16);

            INSERT INTO ENCKeys (id_key, enc_key) VALUES (c.id_proprietar, encryption_key);

            encryption_type := DBMS_CRYPTO.ENCRYPT_AES128 + DBMS_CRYPTO.PAD_PKCS5 + DBMS_CRYPTO.CHAIN_CBC;

            encryption_binary_location :=
                    DBMS_CRYPTO.encrypt(UTL_I18N.STRING_TO_RAW(c.id_locatie, 'AL32UTF8'), encryption_type,
                                        encryption_key);
            encryption_binary_last_name :=
                    DBMS_CRYPTO.encrypt(UTL_I18N.STRING_TO_RAW(c.prenume, 'AL32UTF8'), encryption_type, encryption_key);
            encryption_binary_first_name :=
                    DBMS_CRYPTO.encrypt(UTL_I18N.STRING_TO_RAW(c.nume, 'AL32UTF8'), encryption_type, encryption_key);
            encryption_binary_email :=
                    DBMS_CRYPTO.encrypt(UTL_I18N.STRING_TO_RAW(c.email, 'AL32UTF8'), encryption_type, encryption_key);
            encryption_binary_phone :=
                    DBMS_CRYPTO.encrypt(UTL_I18N.STRING_TO_RAW(c.telefon, 'AL32UTF8'), encryption_type, encryption_key);

            INSERT INTO PROPRIETAR_Encrypted (id_proprietar,
                                              nume, prenume, telefon,
                                              email, id_locatie)
            VALUES (c.id_proprietar, encryption_binary_last_name, encryption_binary_first_name, encryption_binary_phone,
                    encryption_binary_email, encryption_binary_location);
        END LOOP;
    COMMIT;
END ;

BEGIN
    Encrypt_Proprietar();
end;

SELECT *
FROM ENCKeys;

SELECT *
FROM PROPRIETAR_ENCRYPTED;

CREATE OR REPLACE PROCEDURE Decrypt_Proprietar AS
    encryption_type      PLS_INTEGER;
    decryption_key       RAW(16);
    decrypted_location   VARCHAR2(100);
    decrypted_last_name  VARCHAR2(100);
    decrypted_first_name VARCHAR2(100);
    decrypted_email      VARCHAR2(100);
    decrypted_phone      VARCHAR2(100);
BEGIN
    FOR c_enc IN (SELECT * FROM PROPRIETAR_ENCRYPTED)
        LOOP

            SELECT enc_key
            INTO decryption_key
            FROM ENCKeys
            WHERE id_key = TO_NUMBER(c_enc.id_proprietar);

            encryption_type := DBMS_CRYPTO.ENCRYPT_AES128 + DBMS_CRYPTO.PAD_PKCS5 + DBMS_CRYPTO.CHAIN_CBC;

            decrypted_location :=
                    UTL_I18N.RAW_TO_CHAR(DBMS_CRYPTO.DECRYPT(c_enc.id_locatie, encryption_type, decryption_key));
            decrypted_last_name :=
                    UTL_I18N.RAW_TO_CHAR(DBMS_CRYPTO.DECRYPT(c_enc.nume, encryption_type, decryption_key));
            decrypted_first_name :=
                    UTL_I18N.RAW_TO_CHAR(DBMS_CRYPTO.DECRYPT(c_enc.prenume, encryption_type, decryption_key));
            decrypted_email := UTL_I18N.RAW_TO_CHAR(DBMS_CRYPTO.DECRYPT(c_enc.email, encryption_type, decryption_key));
            decrypted_phone :=
                    UTL_I18N.RAW_TO_CHAR(DBMS_CRYPTO.DECRYPT(c_enc.telefon, encryption_type, decryption_key));

            INSERT INTO PROPRIETAR_DECRYPTED (id_proprietar, nume, prenume, telefon, email, id_locatie)
            VALUES (c_enc.id_proprietar,
                    decrypted_first_name,
                    decrypted_last_name,
                    decrypted_phone, decrypted_email,
                    decrypted_location);
        END LOOP;
    COMMIT;
END;

BEGIN
    DECRYPT_PROPRIETAR();
end;

SELECT *
FROM PROPRIETAR_DECRYPTED;

-- 3. Auditarea

ALTER SYSTEM SET audit_trail = db, extended SCOPE = spfile;

AUDIT SELECT, UPDATE, INSERT, DELETE ON FISA_MEDICALA;

CREATE SYNONYM AUD$ FOR SYS.AUD$;

SELECT *
FROM FISA_MEDICALA;

INSERT INTO FISA_MEDICALA(id_fisa, id_diagnostic, id_animalut, id_doctor, data_fisa, observatii)
VALUES (1113, 1, 1, 1, sysdate, 'obs audit');

SELECT obj$name, sqltext, userid
from AUD$
ORDER BY ntimestamp# DESC;

-- b)

CREATE SEQUENCE secv_audit START WITH 1 INCREMENT BY 1;

CREATE TABLE audit_fisa_medicala
(
    sec_id           NUMBER(4) PRIMARY KEY,
    user_name        VARCHAR2(20)   NOT NULL,
    session_name     VARCHAR2(20)   NOT NULL,
    data_modificare  DATE           NOT NULL,
    observatii_vechi VARCHAR2(4000) NOT NULL,
    observatii_noi   VARCHAR2(4000) NOT NULL
);

CREATE OR REPLACE TRIGGER trigger_audit_fisa_medicala
    AFTER INSERT OR UPDATE OF observatii
    ON FISA_MEDICALA
    FOR EACH ROW
    WHEN (NEW.observatii IS NOT NULL and OLD.observatii IS NOT NULL )
BEGIN
    DECLARE
        v_old_observatii FISA_MEDICALA.observatii%TYPE := :OLD.observatii;
        v_new_observatii FISA_MEDICALA.observatii%TYPE := :NEW.observatii;
    BEGIN
        INSERT INTO audit_fisa_medicala(sec_id, user_name, session_name, data_modificare, observatii_vechi,
                                        observatii_noi)
        VALUES (secv_audit.NEXTVAL, sys_context('userenv', 'session_user'), sys_context('userenv', 'host'), sysdate,
                v_old_observatii, v_new_observatii);
    END;
END;
/

UPDATE FISA_MEDICALA
set observatii = 'obs audit 2'
where id_fisa = 1113;

SELECT *
FROM audit_fisa_medicala;
-- c)
-- GRANT EXECUTE ON DBMS_FGA TO C##REKSIO;


CREATE OR REPLACE PROCEDURE POLICY_HANDLER_FISA_MEDICALA(object_schema VARCHAR2, object_name VARCHAR2, policy_name VARCHAR2)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Audit Policy: [object_schema = ' || object_schema || ']; [object_name = ' || object_name ||
                         ']; [policy_name = ' || policy_name || ']');
END;
/

--  GRANT SELECT ON DBA_FGA_AUDIT_TRAIL TO c##reksio;
CREATE OR REPLACE PROCEDURE CREATE_AUDIT_POLICY_FOR_FISA_MEDICALA as
BEGIN

    BEGIN
        dbms_fga.drop_policy(
                object_schema => 'C##REKSIO',
                object_name => 'FISA_MEDICALA',
                policy_name => 'POLICY_FISA_MEDICALA'
            );
    EXCEPTION
        WHEN OTHERS then
            NULL;
    END;
     dbms_fga.add_policy(
             object_schema => 'C##REKSIO',
             object_name => 'FISA_MEDICALA',
             policy_name => 'POLICY_FISA_MEDICALA',
             enable => false,
             statement_types => 'UPDATE',
             handler_module => 'POLICY_HANDLER_FISA_MEDICALA');
END;
/


BEGIN
    CREATE_AUDIT_POLICY_FOR_FISA_MEDICALA();
    dbms_fga.enable_policy(object_schema => 'C##REKSIO',
                           object_name => 'FISA_MEDICALA',
                           policy_name => 'POLICY_FISA_MEDICALA');
END;

UPDATE FISA_MEDICALA
set observatii = 'obs audit 3'
where id_fisa = 1113;

SELECT *
FROM dba_fga_audit_trail
ORDER BY TIMESTAMP DESC;

DELETE
FROM FISA_MEDICALA
where id_fisa = 1113;
commit;

-- 4. gestionarea utilizatorilor unei baze de date si a resurseloc computationale
CREATE USER C##ADMINISTRATOR IDENTIFIED BY PASSWORD PASSWORD EXPIRE;
GRANT CREATE SESSION TO C##ADMINISTRATOR;

CREATE USER C##DOCTOR IDENTIFIED BY PASSWORD PASSWORD EXPIRE;
GRANT CREATE SESSION TO C##DOCTOR;

CREATE USER C##CONTABIL IDENTIFIED BY PASSWORD PASSWORD EXPIRE;
GRANT CREATE SESSION TO C##CONTABIL;

CREATE USER C##GUEST_DOCTOR  IDENTIFIED BY PASSWORD PASSWORD EXPIRE;
GRANT CREATE SESSION TO C##GUEST_DOCTOR;

CREATE USER C##GUEST_FINANTE  IDENTIFIED BY PASSWORD PASSWORD EXPIRE;
GRANT CREATE SESSION TO C##GUEST_FINANTE;

ALTER USER C##ADMINISTRATOR QUOTA UNLIMITED ON USERS;
ALTER USER C##DOCTOR QUOTA UNLIMITED ON USERS;
ALTER USER C##CONTABIL QUOTA UNLIMITED ON USERS;
ALTER USER C##GUEST_DOCTOR QUOTA 1M ON USERS;
ALTER USER C##GUEST_FINANTE QUOTA 1M ON USERS;

-- GRANT SELECT ON DBA_TS_QUOTAS to c##reksio;
SELECT *
FROM DBA_TS_QUOTAS
where TABLESPACE_NAME='USERS';

CREATE PROFILE C##FULL_PROFILE LIMIT
    SESSIONS_PER_USER 5
    IDLE_TIME 20
    FAILED_LOGIN_ATTEMPTS 4
    CONNECT_TIME 120;

CREATE PROFILE C##GUEST_PROFILE LIMIT
    SESSIONS_PER_USER 20
    IDLE_TIME 5
    FAILED_LOGIN_ATTEMPTS 10
    CONNECT_TIME 10;

ALTER USER C##ADMINISTRATOR PROFILE C##FULL_PROFILE;
ALTER USER C##DOCTOR PROFILE C##FULL_PROFILE;
ALTER USER C##CONTABIL PROFILE C##FULL_PROFILE;
ALTER USER C##GUEST_DOCTOR PROFILE C##GUEST_PROFILE;
ALTER USER C##GUEST_FINANTE PROFILE C##GUEST_PROFILE;

SELECT *
FROM DBA_USERS
WHERE UPPER(USERNAME) LIKE 'C##%';

-- 5. Privilegii si roluri
CREATE ROLE C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON PROPRIETAR TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON ANIMALUT TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON DIAGNOSTIC TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON FACTURA TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON CHITANTA TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON FACTURA_PROPRIETAR TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON FACTURA_PRODUCATOR TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON INVENTAR TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON PRODUSE_DIN_INVENTAR TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON PRODUS TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON FISA_MEDICALA TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON PRODUCATOR TO C##ADMIN_ROLE;
GRANT SELECT, UPDATE, DELETE ON LOCATIE TO C##ADMIN_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON ANGAJAT TO C##ADMIN_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON CONTRACT TO C##ADMIN_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON CONTRACT_ANGAJAT TO C##ADMIN_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON CONTRACT_PRODUCATOR TO C##ADMIN_ROLE;

CREATE ROLE C##DOCTOR_ROLE;
GRANT SELECT, INSERT, UPDATE on PROPRIETAR to C##DOCTOR_ROLE;
GRANT SELECT, INSERT, UPDATE on ANIMALUT to C##DOCTOR_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE on DIAGNOSTIC to C##DOCTOR_ROLE;
GRANT SELECT on INVENTAR to C##DOCTOR_ROLE;
GRANT SELECT on PRODUSE_DIN_INVENTAR to C##DOCTOR_ROLE;
GRANT SELECT on PRODUS to C##DOCTOR_ROLE;
GRANT SELECT, INSERT, UPDATE on FISA_MEDICALA to C##DOCTOR_ROLE;
GRANT SELECT on ANGAJAT to C##DOCTOR_ROLE;
GRANT SELECT on PRODUCATOR to C##DOCTOR_ROLE;
GRANT SELECT, INSERT, UPDATE on LOCATIE to C##DOCTOR_ROLE;
GRANT SELECT on FACTURA to C##DOCTOR_ROLE;
GRANT SELECT on FACTURA_PROPRIETAR to C##DOCTOR_ROLE;

CREATE ROLE C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on PROPRIETAR to C##FINANCE_ROLE;
GRANT SELECT on ANIMALUT to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on FACTURA to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on CHITANTA to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on FACTURA_PROPRIETAR to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on FACTURA_PRODUCATOR to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on INVENTAR to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on PRODUSE_DIN_INVENTAR to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on PRODUS to C##FINANCE_ROLE;
GRANT SELECT on FISA_MEDICALA to C##FINANCE_ROLE;
GRANT SELECT on ANGAJAT to C##FINANCE_ROLE;
GRANT SELECT on CONTRACT to C##FINANCE_ROLE;
GRANT SELECT on CONTRACT_PRODUCATOR to C##FINANCE_ROLE;
GRANT SELECT on CONTRACT_ANGAJAT to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE,DELETE on PRODUCATOR to C##FINANCE_ROLE;
GRANT SELECT, INSERT, UPDATE on LOCATIE to C##FINANCE_ROLE;

CREATE ROLE C##GUEST_DOCTOR_ROLE;
GRANT SELECT on PROPRIETAR to C##GUEST_DOCTOR_ROLE;
GRANT SELECT on ANIMALUT to C##GUEST_DOCTOR_ROLE;
GRANT SELECT on DIAGNOSTIC to C##GUEST_DOCTOR_ROLE;
GRANT SELECT on FACTURA to C##GUEST_DOCTOR_ROLE;
GRANT SELECT on FACTURA_PROPRIETAR to C##GUEST_DOCTOR_ROLE;
GRANT SELECT on FISA_MEDICALA to C##GUEST_DOCTOR_ROLE;
GRANT SELECT on ANGAJAT to C##GUEST_DOCTOR_ROLE;
GRANT SELECT on LOCATIE to C##GUEST_DOCTOR_ROLE;

CREATE ROLE C##GUEST_FINANCE_ROLE;
GRANT SELECT on FACTURA to C##GUEST_FINANCE_ROLE;
GRANT SELECT on CHITANTA to C##GUEST_FINANCE_ROLE;
GRANT SELECT on FACTURA_PROPRIETAR to C##GUEST_FINANCE_ROLE;
GRANT SELECT on FACTURA_PRODUCATOR to C##GUEST_FINANCE_ROLE;
GRANT SELECT on INVENTAR to C##GUEST_FINANCE_ROLE;
GRANT SELECT on PRODUSE_DIN_INVENTAR to C##GUEST_FINANCE_ROLE;
GRANT SELECT on PRODUS to C##GUEST_FINANCE_ROLE;
GRANT SELECT on ANGAJAT to C##GUEST_FINANCE_ROLE;
GRANT SELECT on PRODUCATOR to C##GUEST_FINANCE_ROLE;
GRANT SELECT on LOCATIE to C##GUEST_FINANCE_ROLE;

GRANT C##ADMIN_ROLE to C##ADMINISTRATOR;
GRANT C##DOCTOR_ROLE to C##DOCTOR;
GRANT C##FINANCE_ROLE to C##CONTABIL;
GRANT C##GUEST_DOCTOR_ROLE to C##GUEST_DOCTOR;
GRANT C##GUEST_FINANCE_ROLE to C##GUEST_FINANTE;

-- 6. contextul aplicatiei

CREATE OR REPLACE PROCEDURE CONTEXT_TURA_ZI_NOAPTE IS
    curr_hour NUMBER(3);
BEGIN
    SELECT TO_NUMBER(TO_CHAR(sysdate, 'hh24'))
    INTO curr_hour
    FROM dual;

    DBMS_OUTPUT.PUT_LINE('THE HOUR IS: '|| curr_hour);

    IF curr_hour < 10 OR curr_hour > 20 THEN
        DBMS_OUTPUT.PUT_LINE('Se lucreaza in tura de noapte! Atentie la datele introduse!');
        DBMS_SESSION.SET_CONTEXT('APP_CONTEXT', 'ACC_NIGHT_SHIFT', 'YES');
    ELSE
        dbms_session.set_context('APP_CONTEXT', 'ACC_NIGHT_SHIFT', 'NO');
    END IF;
END;
/

CREATE CONTEXT APP_CONTEXT USING CONTEXT_TURA_ZI_NOAPTE;

BEGIN
    CONTEXT_TURA_ZI_NOAPTE();
end;

CREATE OR REPLACE TRIGGER TRIGGER_ACCESS
    AFTER LOGON ON DATABASE
DECLARE
BEGIN
    CONTEXT_TURA_ZI_NOAPTE();
END;
/

DECLARE
    night_shift_value VARCHAR2(3);
BEGIN
    SELECT SYS_CONTEXT('APP_CONTEXT','ACC_NIGHT_SHIFT') INTO night_shift_value
    FROM dual;

    DBMS_OUTPUT.PUT_LINE('Night Shift Value: ' || night_shift_value);

end;