DROP TRIGGER IF EXISTS trig_laud_reg_aeg_muutmine_keelatud ON laud;
DROP TRIGGER IF EXISTS trig_laud_registreerija_muutmine_keelatud ON laud;
DROP TRIGGER IF EXISTS trig_laud_vale_seisundiliigi_muutus ON laud;

DROP FUNCTION IF EXISTS f_aktiveeri_laud(p_aktiveeritava_laua_kood Laud.laua_kood%TYPE) CASCADE;
DROP FUNCTION IF EXISTS f_deaktiveeri_laud(p_deaktiveeritava_laua_kood Laud.laua_kood%TYPE) CASCADE;
DROP FUNCTION IF EXISTS f_lisa_laud_kategooriasse(p_laua_kood Laud.laua_kood%TYPE, p_kategooria_kood Laua_kategooria.laua_kategooria_kood%TYPE) CASCADE;
DROP FUNCTION IF EXISTS f_eemalda_laud_kategooriast(p_laua_kood Laud.laua_kood%TYPE, p_kategooria_kood Laua_kategooria.laua_kategooria_kood%TYPE) CASCADE;
DROP FUNCTION IF EXISTS f_unusta_laud(p_laua_kood Laud.laua_kood%TYPE) CASCADE;
DROP FUNCTION IF EXISTS f_lopeta_laud(p_deaktiveeritava_laua_kood Laud.laua_kood%TYPE) CASCADE;
DROP FUNCTION IF EXISTS f_on_juhataja(p_e_meil text, p_parool text) CASCADE;
DROP FUNCTION IF EXISTS f_laud_vale_seisundiliigi_muutus() CASCADE;
DROP FUNCTION IF EXISTS f_laud_registreerija_muutmine_keelatud() CASCADE;
DROP FUNCTION IF EXISTS f_laud_reg_aeg_muutmine_keelatud() CASCADE;

DROP INDEX IF EXISTS IXFK_Laua_kategooria_Laua_kategooria_tyyp;
DROP INDEX IF EXISTS IXFK_Isik_Isiku_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Isik_riik;
DROP INDEX IF EXISTS IXFK_Klient_Kliendi_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Tootaja_mentor;
DROP INDEX IF EXISTS IXFK_Tootaja_Amet;
DROP INDEX IF EXISTS IXFK_Tootaja_Tootaja_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Laud_Laua_brand;
DROP INDEX IF EXISTS IXFK_Laud_Tootaja;
DROP INDEX IF EXISTS IXFK_Laud_Laua_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Laua_kategooria_omamine_Laua_kategooria;

DROP INDEX IF EXISTS ak_isik_e_meil;

DROP VIEW IF EXISTS laudade_koondaruanne;
DROP VIEW IF EXISTS laua_kategooriate_omamine;
DROP VIEW IF EXISTS koik_lauad;
DROP VIEW IF EXISTS aktiivsed_mitteaktiivsed_lauad;
DROP VIEW IF EXISTS laua_detailid;
DROP VIEW IF EXISTS tootajate_detailid;

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

DROP DOMAIN IF EXISTS d_nimetus;

DROP EXTENSION IF EXISTS pgcrypto CASCADE;
DROP EXTENSION IF EXISTS postgres_fdw CASCADE;

DROP USER IF EXISTS t179501_juhataja;

REVOKE CONNECT ON DATABASE t179501 FROM t179501_juhataja;

REVOKE USAGE ON SCHEMA public FROM t179501_juhataja;

REVOKE SELECT ON
aktiivsed_mitteaktiivsed_lauad,
tootajate_detailid,
koik_lauad,
laua_detailid,
laua_kategooriate_omamine,
laudade_koondaruanne
FROM t179501_juhataja;

REVOKE EXECUTE ON FUNCTION
f_lopeta_laud(p_deaktiveeritava_laua_kood Laud.laua_kood%TYPE),
f_on_juhataja(p_e_meil text, p_parool text)
FROM t179501_juhataja;

