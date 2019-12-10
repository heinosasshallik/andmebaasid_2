DROP TRIGGER IF EXISTS laud_reg_aeg_muutmine_keelatud ON laud;
DROP TRIGGER IF EXISTS laud_registreerija_muutmine_keelatud ON laud;
DROP TRIGGER IF EXISTS laud_vale_seisundiliigi_muutus ON laud;

CREATE OR REPLACE FUNCTION laud_vale_seisundiliigi_muutus() RETURNS trigger AS $laud_vale_seisundiliigi_muutus$
    BEGIN
       RAISE EXCEPTION 'Vale seisundiliigi muutus';
    END;
$laud_vale_seisundiliigi_muutus$ LANGUAGE plpgsql;

CREATE TRIGGER laud_vale_seisundiliigi_muutus BEFORE UPDATE OF
laua_seisundi_liik_kood ON Laud
FOR EACH ROW
WHEN (NOT
((OLD.laua_seisundi_liik_kood=NEW.laua_seisundi_liik_kood) OR
(OLD.laua_seisundi_liik_kood=1 AND NEW.laua_seisundi_liik_kood=2) OR
(OLD.laua_seisundi_liik_kood=2 AND NEW.laua_seisundi_liik_kood=3) OR
(OLD.laua_seisundi_liik_kood=3 AND NEW.laua_seisundi_liik_kood=2) OR
(OLD.laua_seisundi_liik_kood IN (2, 3) AND NEW.laua_seisundi_liik_kood=4)))
EXECUTE PROCEDURE laud_vale_seisundiliigi_muutus(); 


CREATE OR REPLACE FUNCTION laud_registreerija_muutmine_keelatud() RETURNS trigger 
AS $laud_registreerija_muutmine_keelatud$
    BEGIN
         RAISE EXCEPTION '"registreerija_id" ei ole muudetav';       
    END; 
$laud_registreerija_muutmine_keelatud$ LANGUAGE plpgsql;
 
CREATE TRIGGER laud_registreerija_muutmine_keelatud BEFORE UPDATE OF
registreerija_id ON Laud 
FOR EACH ROW 
WHEN (OLD.registreerija_id <> NEW.registreerija_id)
EXECUTE PROCEDURE laud_registreerija_muutmine_keelatud(); 


CREATE OR REPLACE FUNCTION laud_reg_aeg_muutmine_keelatud() RETURNS trigger 
AS $laud_reg_aeg_muutmine_keelatud$
    BEGIN
         RAISE EXCEPTION '"reg_aeg" ei ole muudetav';
    END; 
$laud_reg_aeg_muutmine_keelatud$ LANGUAGE plpgsql;

CREATE TRIGGER laud_reg_aeg_muutmine_keelatud BEFORE UPDATE OF
reg_aeg ON Laud 
FOR EACH ROW 
WHEN (OLD.reg_aeg <> NEW.reg_aeg)
EXECUTE PROCEDURE laud_reg_aeg_muutmine_keelatud();


COMMENT ON FUNCTION laud_vale_seisundiliigi_muutus IS 'Tõstatab vale seisundiliigi muutuse puhul erindi, 
sest seisundiliigi muutused peavad olema kooskõlas
laua seisundidiagrammiga'; 

COMMENT ON FUNCTION laud_registreerija_muutmine_keelatud IS 'Tõstatab laua registreerija muutmise puhul erindi, sest
registreerijat ei tohiks saada muuta.';

COMMENT ON FUNCTION laud_reg_aeg_muutmine_keelatud IS 'Tõstatab laua registreerimisaja muutmise puhul erindi, sest laual 
saab olla ainult üks registreermisaeg.'; 

COMMENT ON TRIGGER laud_vale_seisundiliigi_muutus ON laud IS 'Keelab teha laua seisundiliigi muutusi, 
mis lähevad vastuollu andmebaasioperatsioonidega'; 

COMMENT ON TRIGGER laud_registreerija_muutmine_keelatud ON 
laud IS 'Keelab muuta laua tabelis olevate laudade registreerija id-d'; 

COMMENT ON TRIGGER laud_reg_aeg_muutmine_keelatud ON 
laud IS 'Keelab muuta laua tabelis olevate laudade registreermis aegu';
