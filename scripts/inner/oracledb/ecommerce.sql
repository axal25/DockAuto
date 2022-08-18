SET TERMOUT ON;
SET SERVEROUTPUT ON;
SET ERRORLOGGING ON;
SET AUTOPRINT ON;
SET ECHO ON;
SET HEADING ON;

WHENEVER SQLERROR EXIT SQL.SQLCODE;

ALTER SESSION SET CONTAINER=ecommerce;

CREATE TABLE ecommerce.countries
(
    id             number(3)            NOT NULL,
    name           varchar2(50)         NOT NULL,
    short_name     varchar2(10 char)    NOT NULL,
    CONSTRAINT countries_pk PRIMARY KEY (id)
);

--CREATE PUBLIC SYNONYM ecommerce
--FOR ecommerce.countries;

INSERT ALL
    INTO ecommerce.countries VALUES (0, 'POLAND', 'PL')
    INTO ecommerce.countries VALUES (1, 'UNITED STATES OF AMERICA', 'USA')
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.region_types
(
    id   number(3)    NOT NULL,
    name varchar2(50) NOT NULL,
    CONSTRAINT region_types_pk PRIMARY KEY (id)
);

INSERT ALL
    INTO ecommerce.region_types VALUES (0, 'STATE')
    INTO ecommerce.region_types VALUES (1, 'VOIVODESHIP')
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.regions
(
    id         number(3)            NOT NULL,
    id_country number(3)            NOT NULL,
    name      varchar2(50 char)    NOT NULL,
    short_name      varchar2(3 char)     NOT NULL,
    CONSTRAINT regions_pk PRIMARY KEY (id),
    CONSTRAINT regions_country_fk FOREIGN KEY (id_country) REFERENCES ecommerce.countries (id)
);

INSERT ALL
    INTO ecommerce.regions VALUES (0, 0, 'Alabama', 'AL')
    INTO ecommerce.regions VALUES (1, 0, 'Alaska', 'AK')
    INTO ecommerce.regions VALUES (2, 0, 'Arizona', 'AZ')
    INTO ecommerce.regions VALUES (3, 0, 'Arkansas', 'AR')
    INTO ecommerce.regions VALUES (4, 0, 'California', 'CA')
    INTO ecommerce.regions VALUES (5, 0, 'Colorado', 'CO')
    INTO ecommerce.regions VALUES (6, 0, 'Connecticut', 'CT')
    INTO ecommerce.regions VALUES (7, 0, 'Delaware', 'DE')
    INTO ecommerce.regions VALUES (8, 0, 'Florida', 'FL')
    INTO ecommerce.regions VALUES (9, 0, 'Georgia', 'GA')
    INTO ecommerce.regions VALUES (10, 0, 'Hawaii', 'HI')
    INTO ecommerce.regions VALUES (11, 0, 'Idaho', 'ID')
    INTO ecommerce.regions VALUES (12, 0, 'Illinois', 'IL')
    INTO ecommerce.regions VALUES (13, 0, 'Indiana', 'IN')
    INTO ecommerce.regions VALUES (14, 0, 'Iowa', 'IA')
    INTO ecommerce.regions VALUES (15, 0, 'Kansas', 'KS')
    INTO ecommerce.regions VALUES (16, 0, 'Kentucky', 'KY')
    INTO ecommerce.regions VALUES (17, 0, 'Louisiana', 'LA')
    INTO ecommerce.regions VALUES (18, 0, 'Maine', 'ME')
    INTO ecommerce.regions VALUES (19, 0, 'Maryland', 'MD')
    INTO ecommerce.regions VALUES (20, 0, 'Massachusetts', 'MA')
    INTO ecommerce.regions VALUES (21, 0, 'Michigan', 'MI')
    INTO ecommerce.regions VALUES (22, 0, 'Minnesota', 'MN')
    INTO ecommerce.regions VALUES (23, 0, 'Mississippi', 'MS')
    INTO ecommerce.regions VALUES (24, 0, 'Missouri', 'MO')
    INTO ecommerce.regions VALUES (25, 0, 'Montana', 'MT')
    INTO ecommerce.regions VALUES (26, 0, 'Nebraska', 'NE')
    INTO ecommerce.regions VALUES (27, 0, 'Nevada', 'NV')
    INTO ecommerce.regions VALUES (28, 0, 'New Hampshire', 'NH')
    INTO ecommerce.regions VALUES (29, 0, 'New Jersey', 'NJ')
    INTO ecommerce.regions VALUES (30, 0, 'New Mexico', 'NM')
    INTO ecommerce.regions VALUES (31, 0, 'New York', 'NY')
    INTO ecommerce.regions VALUES (32, 0, 'North Carolina', 'NC')
    INTO ecommerce.regions VALUES (33, 0, 'North Dakota', 'ND')
    INTO ecommerce.regions VALUES (34, 0, 'Ohio', 'OH')
    INTO ecommerce.regions VALUES (35, 0, 'Oklahoma', 'OK')
    INTO ecommerce.regions VALUES (36, 0, 'Oregon', 'OR')
    INTO ecommerce.regions VALUES (37, 0, 'Pennsylvania', 'PA')
    INTO ecommerce.regions VALUES (38, 0, 'Rhode Island', 'RI')
    INTO ecommerce.regions VALUES (39, 0, 'South Carolina', 'SC')
    INTO ecommerce.regions VALUES (40, 0, 'South Dakota', 'SD')
    INTO ecommerce.regions VALUES (41, 0, 'Tennessee', 'TN')
    INTO ecommerce.regions VALUES (42, 0, 'Texas', 'TX')
    INTO ecommerce.regions VALUES (43, 0, 'Utah', 'UT')
    INTO ecommerce.regions VALUES (44, 0, 'Vermont', 'VT')
    INTO ecommerce.regions VALUES (45, 0, 'Virginia', 'VA')
    INTO ecommerce.regions VALUES (46, 0, 'Washington', 'WA')
    INTO ecommerce.regions VALUES (47, 0, 'West Virginia', 'WV')
    INTO ecommerce.regions VALUES (48, 0, 'Wisconsin', 'WI')
    INTO ecommerce.regions VALUES (49, 0, 'Wyoming', 'WY')
    INTO ecommerce.regions VALUES (50, 1, 'Lower Silesian', 'D')
    INTO ecommerce.regions VALUES (51, 1, 'Kuyavian-Pomeranian', 'C')
    INTO ecommerce.regions VALUES (52, 1, 'Lublin', 'L')
    INTO ecommerce.regions VALUES (53, 1, 'Lubusz', 'F')
    INTO ecommerce.regions VALUES (54, 1, 'Łódź', 'E')
    INTO ecommerce.regions VALUES (55, 1, 'Lesser Poland', 'K')
    INTO ecommerce.regions VALUES (56, 1, 'Masovian', 'W')
    INTO ecommerce.regions VALUES (57, 1, 'Opole', 'O')
    INTO ecommerce.regions VALUES (58, 1, 'Subcarpathian', 'R')
    INTO ecommerce.regions VALUES (59, 1, 'Podlaskie', 'B')
    INTO ecommerce.regions VALUES (60, 1, 'Pomeranian', 'G')
    INTO ecommerce.regions VALUES (61, 1, 'Silesian', 'S')
    INTO ecommerce.regions VALUES (62, 1, 'Holy Cross', 'T')
    INTO ecommerce.regions VALUES (63, 1, 'Warmian-Masurian', 'N')
    INTO ecommerce.regions VALUES (64, 1, 'Greater Poland', 'P')
    INTO ecommerce.regions VALUES (65, 1, 'West Pomeranian', 'Z')
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.pl_regions
(
    id          number(3)           NOT NULL,
    id_region   number(3)           NOT NULL,
    name        varchar2(50 char)   NOT NULL,
    short_name  varchar2(3 char)    NOT NULL,
    CONSTRAINT pl_regions_pk PRIMARY KEY (id),
    CONSTRAINT pl_regions_region_fk FOREIGN KEY (id_region) REFERENCES ecommerce.regions (id)
);

INSERT ALL
    INTO ecommerce.pl_regions VALUES (50, 0, 'Dolnośląskie', 'DŚ')
    INTO ecommerce.pl_regions VALUES (51, 0, 'Kujawsko-Pomorskie', 'KP')
    INTO ecommerce.pl_regions VALUES (52, 0, 'Lubelskie', 'LB')
    INTO ecommerce.pl_regions VALUES (53, 0, 'Lubuskie', 'LS')
    INTO ecommerce.pl_regions VALUES (54, 0, 'Łódzkie', 'ŁD')
    INTO ecommerce.pl_regions VALUES (55, 0, 'Małopolskie', 'MP')
    INTO ecommerce.pl_regions VALUES (56, 0, 'Mazowieckie', 'MZ')
    INTO ecommerce.pl_regions VALUES (57, 0, 'Opolskie', 'OP')
    INTO ecommerce.pl_regions VALUES (58, 0, 'Podkarpackie', 'PK')
    INTO ecommerce.pl_regions VALUES (59, 0, 'Podlaskie', 'PL')
    INTO ecommerce.pl_regions VALUES (60, 0, 'Pomorskie', 'PM')
    INTO ecommerce.pl_regions VALUES (61, 0, 'Śląskie', 'ŚL')
    INTO ecommerce.pl_regions VALUES (62, 0, 'Świętokrzyskie', 'ŚK')
    INTO ecommerce.pl_regions VALUES (63, 0, 'Warmińsko-Mazurskie', 'WM')
    INTO ecommerce.pl_regions VALUES (64, 0, 'Wielkopolskie', 'WP')
    INTO ecommerce.pl_regions VALUES (65, 0, 'Zachodniopomorskie', 'ZP')
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.addresses
(
    id           number(10)   NOT NULL,
    id_country   number(3)    NOT NULL,
    id_region    number(3)    NOT NULL,
    city         varchar2(50) NOT NULL,
    zip_code     varchar2(10) NOT NULL,
    street_name  varchar2(50) NOT NULL,
    street_no    varchar2(20),
    residence_no varchar2(5),
    CONSTRAINT addresses_pk PRIMARY KEY (id),
    CONSTRAINT addresses_country_fk FOREIGN KEY (id_country) REFERENCES ecommerce.countries (id),
    CONSTRAINT addresses_region_fk FOREIGN KEY (id_region) REFERENCES ecommerce.regions (id)
);

INSERT ALL
    INTO ecommerce.addresses VALUES (0, 1, 54, 'Cracow', '30-211', 'Piastowska', '26 A', '2A')
    INTO ecommerce.addresses VALUES (1, 1, 54, 'Cracow', '30-210', 'Mahatmy Gandhiego', '3-38', '10B')
    INTO ecommerce.addresses VALUES (2, 0, 7, 'Miami', 'FL 33129', 'SW 21st Rd', '298', null)
    INTO ecommerce.addresses VALUES (3, 0, 26, 'Las Vegas', 'NV 89118', 'S Mann St', '5368-5340', null)
    INTO ecommerce.addresses VALUES (4, 0, 3, 'California', 'CA 94025', 'Menlo Park, Hacker Way #15', '1', null)
    INTO ecommerce.addresses VALUES (5, 0, 13, 'Altoona', 'IA 50009', 'Share Way NW', '100', null)
    INTO ecommerce.addresses VALUES (6, 0, 41, 'Austin', 'TX 78701', 'W 6th St', '300', null)
    INTO ecommerce.addresses VALUES (7, 0, 19, 'Cambridge', 'MA 02142', 'Binney St', '100', null)
    INTO ecommerce.addresses VALUES (8, 0, 26, 'Chicago', 'IL 60606', 'N Upper Wacker Dr', '191', null)
    INTO ecommerce.addresses VALUES (9, 1, 55, 'Cracow', '31-974', 'Ujastek', '1', null)
    INTO ecommerce.addresses VALUES (10, 1, 55, 'Cracow', '30-199', 'Balicka', '27', null)
    INTO ecommerce.addresses VALUES (11, 1, 55, 'Cracow', '31-123', 'Krupnicza', '31', '2A')
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.persons
(
    id          number(10)   NOT NULL,
    first_name  varchar2(50) NOT NULL,
    second_name varchar2(50),
    surname     varchar2(50) NOT NULL,
    CONSTRAINT persons_pk PRIMARY KEY (id)
);

INSERT ALL
    INTO ecommerce.persons VALUES (0, 'Jacek', 'Wiktor', 'Chmielowski')
    INTO ecommerce.persons VALUES (1, 'Marzena', 'Wiktoria', 'Chmielowska - Olesińska')
    INTO ecommerce.persons VALUES (2, 'Anna', 'Aleksandra', 'Rachowska')
    INTO ecommerce.persons VALUES (3, 'Samantha', 'Victoria', 'Smith')
    INTO ecommerce.persons VALUES (4, 'John', 'Howke', 'Winchester')
    INTO ecommerce.persons VALUES (5, 'Anastasia', 'Letty', 'Winchester - Butcher')
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.person_addresses
(
    id          number(10) NOT NULL,
    id_person   number(10) NOT NULL,
    id_address  number(10) NOT NULL,
    CONSTRAINT person_addresses_pk PRIMARY KEY (id),
    CONSTRAINT person_addresses_person_fk FOREIGN KEY (id_person) REFERENCES ecommerce.persons (id),
    CONSTRAINT person_addresses_address_fk FOREIGN KEY (id_address) REFERENCES ecommerce.addresses (id)
);

INSERT ALL
    INTO ecommerce.person_addresses VALUES (0, 0, 0)
    INTO ecommerce.person_addresses VALUES (1, 1, 0)
    INTO ecommerce.person_addresses VALUES (2, 2, 1)
    INTO ecommerce.person_addresses VALUES (3, 3, 2)
    INTO ecommerce.person_addresses VALUES (4, 4, 3)
    INTO ecommerce.person_addresses VALUES (5, 5, 3)
    INTO ecommerce.person_addresses VALUES (6, 5, 11)
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.economic_sectors
(
    id   number(10)   NOT NULL,
    name varchar2(50) NOT NULL,
    CONSTRAINT economic_sectors_pk PRIMARY KEY (id)
);

INSERT ALL
    INTO ecommerce.economic_sectors VALUES (0, 'Agricultural')
    INTO ecommerce.economic_sectors VALUES (1, 'Industrial')
    INTO ecommerce.economic_sectors VALUES (2, 'Service')
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.organizations
(
    id         number(10)    NOT NULL,
    name       varchar2(100) NOT NULL,
    id_sector  number(10)    NOT NULL,
    CONSTRAINT organizations_pk PRIMARY KEY (id),
    CONSTRAINT organizations_sector_fk FOREIGN KEY (id_sector) REFERENCES ecommerce.economic_sectors (id)
);

INSERT ALL
    INTO ecommerce.organizations VALUES (0, 'Krakowski Ośrodek Doradztwa Rolniczego w Słomnikach', 0)
    INTO ecommerce.organizations VALUES (1, 'ArcelorMittal Distribution Solutions Poland Sp. z o.o.', 1)
    INTO ecommerce.organizations VALUES (2, 'Facebook', 2)
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.organization_addresses
(
    id              number(10) NOT NULL,
    id_organization number(10) NOT NULL,
    id_address      number(10) NOT NULL,
    CONSTRAINT organization_addresses_pk PRIMARY KEY (id),
    CONSTRAINT organization_addresses_organization FOREIGN KEY (id_organization) REFERENCES ecommerce.organizations (id),
    CONSTRAINT organization_addresses_address_fk FOREIGN KEY (id_address) REFERENCES ecommerce.addresses (id)
);

INSERT ALL
    INTO ecommerce.organization_addresses VALUES (0, 0, 10)
    INTO ecommerce.organization_addresses VALUES (1, 1, 9)
    INTO ecommerce.organization_addresses VALUES (2, 2, 4)
    INTO ecommerce.organization_addresses VALUES (3, 2, 5)
    INTO ecommerce.organization_addresses VALUES (4, 2, 6)
    INTO ecommerce.organization_addresses VALUES (5, 2, 7)
    INTO ecommerce.organization_addresses VALUES (6, 2, 8)
SELECT 1
FROM DUAL;

CREATE TABLE ecommerce.employees
(
    id              number(10) NOT NULL,
    id_person       number(10) NOT NULL,
    id_organization number(10) NOT NULL,
    position        number(10) NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY (id),
    CONSTRAINT employees_person_fk FOREIGN KEY (id_person) REFERENCES ecommerce.persons (id),
    CONSTRAINT employees_organization_fk FOREIGN KEY (id_organization) REFERENCES ecommerce.organizations (id)
);

CREATE TABLE ecommerce.customers
(
    id              number(10) NOT NULL,
    id_person       number(10) NOT NULL,
    id_organization number(10) NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY (id),
    CONSTRAINT customers_person_fk FOREIGN KEY (id_person) REFERENCES ecommerce.persons (id),
    CONSTRAINT customers_organization_fk FOREIGN KEY (id_organization) REFERENCES ecommerce.organizations (id)
);

INSERT ALL
    INTO ecommerce.customers VALUES (0, 0, 0)
    INTO ecommerce.customers VALUES (1, 1, 1)
    INTO ecommerce.customers VALUES (2, 2, 1)
    INTO ecommerce.customers VALUES (3, 3, 2)
    INTO ecommerce.customers VALUES (4, 4, 2)
    INTO ecommerce.customers VALUES (5, 5, 2)
    INTO ecommerce.customers VALUES (6, 5, 1)
SELECT 1
FROM DUAL;

COMMIT;

SET TERMOUT OFF;
SET SERVEROUTPUT OFF;
SET ERRORLOGGING OFF;
SET AUTOPRINT OFF;
SET ECHO OFF;
SET HEADING OFF;