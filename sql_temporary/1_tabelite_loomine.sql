START TRANSACTION;

DROP TABLE IF EXISTS Amet CASCADE;

DROP TABLE IF EXISTS Isiku_seisundi_liik CASCADE;

DROP TABLE IF EXISTS Laua_brand CASCADE;

DROP TABLE IF EXISTS Laua_kategooria CASCADE;

DROP TABLE IF EXISTS Laua_kategooria_tyyp CASCADE;

DROP TABLE IF EXISTS Laua_seisundi_liik CASCADE;

DROP TABLE IF EXISTS Tootaja_seisundi_liik CASCADE;

DROP TABLE IF EXISTS Kliendi_seisundi_liik CASCADE;

DROP TABLE IF EXISTS Riik CASCADE;

DROP TABLE IF EXISTS Isik CASCADE;

DROP TABLE IF EXISTS Klient CASCADE;

DROP TABLE IF EXISTS Tootaja CASCADE;

DROP TABLE IF EXISTS Laud CASCADE;

DROP TABLE IF EXISTS Laua_kategooria_omamine CASCADE;

CREATE TABLE Amet (
	amet_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	kirjeldus text,
	CONSTRAINT PK_Amet PRIMARY KEY (amet_kood),
	CONSTRAINT AK_Amet_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Amet_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$'),
	CONSTRAINT CHK_Amet_kirjeldus_ei_koosne_tyhikutest_pole_tyhi CHECK (kirjeldus!~'^[[:space:]]*$')
) WITH (fillfactor=90);

CREATE TABLE Riik (
	riik_kood char(3) NOT NULL,
	nimetus varchar(50) NOT NULL,
	CONSTRAINT PK_Riik PRIMARY KEY (riik_kood),
	CONSTRAINT AK_Riik_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Riik_kood_kolm_tahemarki CHECK (riik_kood~'^[A-Z]{3}$'),
	CONSTRAINT CHK_Riik_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$')
);

CREATE TABLE Laua_brand (
	laua_brand_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	CONSTRAINT PK_Laua_brand PRIMARY KEY (laua_brand_kood),
	CONSTRAINT AK_Laua_brand_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Laua_brand_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$')
);

CREATE TABLE Laua_kategooria_tyyp (
	laua_kategooria_tyyp_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	CONSTRAINT PK_Laua_kategooria_tyyp PRIMARY KEY (laua_kategooria_tyyp_kood),
	CONSTRAINT AK_Laua_kategooria_tyyp_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Laua_kategooria_tyyp_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$')
);

CREATE TABLE Laua_kategooria (
	laua_kategooria_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	laua_kategooria_tyyp_kood smallint NOT NULL,
	CONSTRAINT PK_Laua_kategooria PRIMARY KEY (laua_kategooria_kood),
	CONSTRAINT AK_Laua_kategooria_nimetus_laua_kategooria_tyyp_kood UNIQUE (nimetus,laua_kategooria_tyyp_kood),
	CONSTRAINT CHK_Laua_kategooria_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$'),
	CONSTRAINT FK_Laua_kategooria_Laua_kategooria_tyyp FOREIGN KEY (laua_kategooria_tyyp_kood) REFERENCES Laua_kategooria_tyyp (laua_kategooria_tyyp_kood) ON DELETE No Action ON UPDATE Cascade
);

CREATE TABLE Laua_seisundi_liik (
	laua_seisundi_liik_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	CONSTRAINT PK_Laua_seisundi_liik PRIMARY KEY (laua_seisundi_liik_kood),
	CONSTRAINT AK_Laua_seisundi_liik_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Laua_seisundi_liik_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$')
);

CREATE TABLE Isiku_seisundi_liik (
	isiku_seisundi_liik_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	CONSTRAINT PK_Isiku_seisundi_liik PRIMARY KEY (isiku_seisundi_liik_kood),
	CONSTRAINT AK_Isiku_seisundi_liik_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Isiku_seisundi_liik_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$')
);

CREATE TABLE Tootaja_seisundi_liik (
	tootaja_seisundi_liik_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	CONSTRAINT PK_Tootaja_seisundi_liik PRIMARY KEY (tootaja_seisundi_liik_kood),
	CONSTRAINT AK_Tootaja_seisundi_liik_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Tootaja_seisundi_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$')
);

CREATE TABLE Kliendi_seisundi_liik (
	kliendi_seisundi_liik_kood smallint NOT NULL,
	nimetus varchar(50) NOT NULL,
	CONSTRAINT PK_Kliendi_seisundi_liik PRIMARY KEY (kliendi_seisundi_liik_kood),
	CONSTRAINT AK_Kliendi_seisundi_liik_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Kliendi_seisundi_nimetus_ei_koosne_tyhikutest_pole_tyhi CHECK (nimetus!~'^[[:space:]]*$')
);

CREATE TABLE Isik (
	isik_id serial NOT NULL,
	isikukood varchar(50) NOT NULL,
	riik_kood char(3) NOT NULL,
	e_meil varchar(254) NOT NULL,
	parool varchar(60) NOT NULL,
	isiku_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	synni_kp date NOT NULL,
	reg_aeg timestamp with time zone NOT NULL DEFAULT current_timestamp(0),
	eesnimi text,
	perenimi text,
	elukoht text,
	CONSTRAINT PK_Isik PRIMARY KEY (isik_id),
	CONSTRAINT AK_Isik_e_meil UNIQUE (e_meil),
	CONSTRAINT AK_Isik_isikukood_riik_kood UNIQUE (isikukood,riik_kood),
	CONSTRAINT CHK_Isik_isikukood_ei_koosne_tyhikutest_pole_tyhi CHECK (isikukood!~'^[[:space:]]*$'),
	CONSTRAINT CHK_Isik_e_meil_sisaldab_tapselt_yhte_at_marki CHECK (e_meil LIKE '%@%' AND e_meil NOT LIKE '%@%@%'),
	CONSTRAINT CHK_Isik_synni_kp_aja_vahemik_1900_2100 CHECK (synni_kp>='1900-01-01' AND synni_kp<'2101-01-01'),
	CONSTRAINT CHK_Isik_reg_aeg_vahemik_2010_2100 CHECK (reg_aeg>='2010-01-01' AND reg_aeg<'2101-01-01'),
	CONSTRAINT CHK_Isik_eesnimi_ei_koosne_tyhikutest_pole_tyhi CHECK (eesnimi!~'^[[:space:]]*$'),
	CONSTRAINT CHK_Isik_perenimi_ei_koosne_tyhikutest_pole_tyhi CHECK (perenimi!~'^[[:space:]]*$'),
	CONSTRAINT CHK_Isik_elukoht_ei_koosne_tyhikutest_pole_tyhi CHECK (elukoht!~'^[[:space:]]*$'),
	CONSTRAINT CHK_Isik_parool_ei_koosne_tyhikutest_pole_tyhi CHECK (parool!~'^[[:space:]]*$'),
	CONSTRAINT CHK_Isik_eesnimi_voi_perenimi_kohustuslik CHECK (eesnimi IS NOT NULL OR perenimi IS NOT NULL),
	CONSTRAINT CHK_Isik_elukoht_ei_koosne_ainult_numbritest CHECK (elukoht!~'^[[:digit:]]*$'),
	CONSTRAINT CHK_Isik_synni_kp_varem_kui_reg_aeg CHECK (NOT(reg_aeg<synni_kp)),
	CONSTRAINT CHK_Isik_eesnimi_max_pikkus_800 CHECK (length(eesnimi)<801),
	CONSTRAINT CHK_Isik_perenimi_max_pikkus_800 CHECK (length(perenimi)<801),
	CONSTRAINT CHK_Isik_elukoht_max_pikkus_900 CHECK (length(perenimi)<901),
	CONSTRAINT FK_Isik_Isiku_seisundi_liik FOREIGN KEY (isiku_seisundi_liik_kood) REFERENCES Isiku_seisundi_liik (isiku_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Isik_riik FOREIGN KEY (riik_kood) REFERENCES Riik (riik_kood) ON DELETE No Action ON UPDATE Cascade
) WITH (fillfactor=90);

CREATE TABLE Klient (
	isik_id integer NOT NULL,
	kliendi_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	on_nous_tylitamisega boolean NOT NULL DEFAULT false,
	CONSTRAINT PK_Klient PRIMARY KEY (isik_id),
	CONSTRAINT FK_Klient_Kliendi_seisundi_liik FOREIGN KEY (kliendi_seisundi_liik_kood) REFERENCES Kliendi_seisundi_liik (kliendi_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Klient_Isik FOREIGN KEY (isik_id) REFERENCES Isik (isik_id) ON DELETE Cascade ON UPDATE No Action
) WITH (fillfactor=90);

CREATE TABLE Tootaja (
	isik_id integer NOT NULL,
	amet_kood smallint NOT NULL,
	tootaja_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	mentor integer,
	CONSTRAINT PK_Tootaja PRIMARY KEY (isik_id),
	CONSTRAINT CHK_Tootaja_pole_iseenda_mentor CHECK (isik_id<>mentor),
	CONSTRAINT FK_Tootaja_mentor FOREIGN KEY (mentor) REFERENCES Tootaja (isik_id) ON DELETE Set Null ON UPDATE No Action,
	CONSTRAINT FK_Tootaja_Amet FOREIGN KEY (amet_kood) REFERENCES Amet (amet_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Tootaja_Tootaja_seisundi_liik FOREIGN KEY (tootaja_seisundi_liik_kood) REFERENCES Tootaja_seisundi_liik (tootaja_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Tootaja_Isik FOREIGN KEY (isik_id) REFERENCES Isik (isik_id) ON DELETE Cascade ON UPDATE No Action
) WITH (fillfactor=90);

CREATE TABLE Laud (
	laua_kood integer NOT NULL,
	laua_vorgu_korgus smallint NOT NULL DEFAULT 153,
	max_mangijate_arv smallint NOT NULL DEFAULT 2,
	registreerija_id integer NOT NULL,
	laua_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	laua_brand_kood smallint NOT NULL,
	reg_aeg timestamp with time zone NOT NULL DEFAULT current_timestamp(0),
	kommentaar text,
	CONSTRAINT PK_Laud PRIMARY KEY (laua_kood),
	CONSTRAINT CHK_Laud_Laua_vorgu_korgus_vahemik_1_300 CHECK (laua_vorgu_korgus>0 AND laua_vorgu_korgus<301),
	CONSTRAINT CHK_Laud_Max_mangijate_arv_vahemik_2_6 CHECK (max_mangijate_arv>1 AND max_mangijate_arv<7),
	CONSTRAINT CHK_Laud_Reg_aeg_vahemik_2010_2100 CHECK (reg_aeg>='2010-01-01' AND reg_aeg<'2101-01-01'),
	CONSTRAINT CHK_Laud_Kommentaar_ei_koosne_tyhikutest_pole_tyhi CHECK (kommentaar!~'^[[:space:]]*$'),
	CONSTRAINT FK_Laud_Laua_brand FOREIGN KEY (laua_brand_kood) REFERENCES Laua_brand (laua_brand_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Laud_Laua_seisundi_liik FOREIGN KEY (laua_seisundi_liik_kood) REFERENCES Laua_seisundi_liik (laua_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Laud_Tootaja FOREIGN KEY (registreerija_id) REFERENCES Tootaja (isik_id) ON DELETE No Action ON UPDATE No Action
) WITH (fillfactor=90);

CREATE TABLE Laua_kategooria_omamine (
	laua_kood integer NOT NULL,
	laua_kategooria_kood smallint NOT NULL,
	CONSTRAINT PK_Laua_kategooria_omamine PRIMARY KEY (laua_kood,laua_kategooria_kood),
	CONSTRAINT FK_Laua_kategooria_omamine_Laua_kategooria FOREIGN KEY (laua_kategooria_kood) REFERENCES Laua_kategooria (laua_kategooria_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Laua_kategooria_omamine_Laud FOREIGN KEY (laua_kood) REFERENCES Laud (laua_kood) ON DELETE Cascade ON UPDATE Cascade
);

CREATE INDEX IXFK_Laua_kategooria_Laua_kategooria_tyyp ON Laua_kategooria (laua_kategooria_tyyp_kood ASC);

CREATE INDEX IXFK_Isik_Isiku_seisundi_liik ON Isik (isiku_seisundi_liik_kood ASC);

CREATE INDEX IXFK_Isik_riik ON Isik (riik_kood ASC);

CREATE INDEX IXFK_Klient_Kliendi_seisundi_liik ON Klient (kliendi_seisundi_liik_kood ASC);

CREATE INDEX IXFK_Tootaja_mentor ON Tootaja (mentor ASC);

CREATE INDEX IXFK_Tootaja_Amet ON Tootaja (amet_kood ASC);

CREATE INDEX IXFK_Tootaja_Tootaja_seisundi_liik ON Tootaja (tootaja_seisundi_liik_kood ASC);

CREATE INDEX IXFK_Laud_Laua_brand ON Laud (laua_brand_kood ASC);

CREATE INDEX IXFK_Laud_Tootaja ON Laud (registreerija_id ASC);

CREATE INDEX IXFK_Laud_Laua_seisundi_liik ON Laud (laua_seisundi_liik_kood ASC);

CREATE INDEX IXFK_Laua_kategooria_omamine_Laua_kategooria ON Laua_kategooria_omamine (laua_kategooria_kood ASC);

COMMIT;