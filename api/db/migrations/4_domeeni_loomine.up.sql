START TRANSACTION;

DROP DOMAIN IF EXISTS d_nimetus;
CREATE DOMAIN d_nimetus VARCHAR(50) NOT NULL 
CONSTRAINT chk_nimetus_ei_ole_tyhi_ei_koosne_tyhikutest CHECK (VALUE!~'^[[:space:]]*$');

ALTER TABLE Amet DROP CONSTRAINT CHK_Amet_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Riik DROP CONSTRAINT CHK_Riik_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Laua_brand DROP CONSTRAINT CHK_Laua_brand_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Laua_kategooria_tyyp DROP CONSTRAINT CHK_Laua_kategooria_tyyp_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Laua_kategooria DROP CONSTRAINT CHK_Laua_kategooria_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Laua_seisundi_liik DROP CONSTRAINT CHK_Laua_seisundi_liik_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Isiku_seisundi_liik DROP CONSTRAINT CHK_Isiku_seisundi_liik_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Tootaja_seisundi_liik DROP CONSTRAINT CHK_Tootaja_seisundi_nimetus_ei_koosne_tyhikutest_pole_tyhi;
ALTER TABLE Kliendi_seisundi_liik DROP CONSTRAINT CHK_Kliendi_seisundi_nimetus_ei_koosne_tyhikutest_pole_tyhi;

ALTER TABLE Amet ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Riik ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Laua_brand ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Laua_kategooria_tyyp ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Laua_kategooria ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Laua_seisundi_liik ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Isiku_seisundi_liik ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Tootaja_seisundi_liik ALTER COLUMN nimetus DROP NOT NULL;
ALTER TABLE Kliendi_seisundi_liik ALTER COLUMN nimetus DROP NOT NULL;

ALTER TABLE Amet ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Riik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Laua_brand ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Laua_kategooria_tyyp ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Laua_kategooria ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Laua_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Isiku_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Tootaja_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Kliendi_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;

COMMIT;



