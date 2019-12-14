CREATE USER t179501_juhataja WITH PASSWORD 'erandlikultTugevParool';

REVOKE CONNECT, TEMP ON DATABASE t179501 FROM PUBLIC;
REVOKE CREATE, USAGE ON SCHEMA public FROM PUBLIC;
REVOKE USAGE ON LANGUAGE plpgsql FROM PUBLIC;
REVOKE USAGE ON DOMAIN d_nimetus FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION
f_aktiveeri_laud(p_aktiveeritava_laua_kood Laud.laua_kood%TYPE),
f_deaktiveeri_laud(p_deaktiveeritava_laua_kood Laud.laua_kood%TYPE),
f_lopeta_laud(p_deaktiveeritava_laua_kood Laud.laua_kood%TYPE),
f_lisa_laud_kategooriasse(p_laua_kood Laud.laua_kood%TYPE, p_kategooria_kood Laua_kategooria.laua_kategooria_kood%TYPE),
f_eemalda_laud_kategooriast(p_laua_kood Laud.laua_kood%TYPE, p_kategooria_kood Laua_kategooria.laua_kategooria_kood%TYPE),
f_unusta_laud(p_laua_kood Laud.laua_kood%TYPE),
f_on_juhataja(p_e_meil text, p_parool text),
f_laud_vale_seisundiliigi_muutus(),
f_laud_registreerija_muutmine_keelatud(),
f_laud_reg_aeg_muutmine_keelatud()
FROM PUBLIC;
REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;

GRANT CONNECT ON DATABASE t179501 TO t179501_juhataja;
GRANT USAGE ON SCHEMA public TO t179501_juhataja;
GRANT SELECT ON
aktiivsed_mitteaktiivsed_lauad,
tootajate_detailid,
koik_lauad,
laua_detailid,
laua_kategooriate_omamine,
laudade_koondaruanne
TO t179501_juhataja;
GRANT EXECUTE ON FUNCTION
f_lopeta_laud(p_deaktiveeritava_laua_kood Laud.laua_kood%TYPE),
f_on_juhataja(p_e_meil text, p_parool text)
TO t179501_juhataja;
ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;
