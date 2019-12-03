/*
Laua aktiveerimine ning deaktiveerimine.

Laused testimiseks:
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4;
select f_aktiveeri_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 2
select f_deaktiveeri_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 3
*/

DROP FUNCTION IF EXISTS f_aktiveeri_laud;

CREATE OR REPLACE FUNCTION f_aktiveeri_laud(p_aktiveeritava_laua_kood INT)
RETURNS VOID AS $$
  UPDATE laud
  SET laua_seisundi_liik_kood = 2
  WHERE laua_kood = p_aktiveeritava_laua_kood;
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_aktiveeri_laud(p_aktiveeritava_laua_kood INT) IS 'Muudab laua oleku seisundi aktiivseks (OP3).';




DROP FUNCTION IF EXISTS f_deaktiveeri_laud;

CREATE OR REPLACE FUNCTION f_deaktiveeri_laud(p_deaktiveeritava_laua_kood INT)
RETURNS VOID AS $$
  UPDATE laud
  SET laua_seisundi_liik_kood = 3
  WHERE
    laua_kood = p_deaktiveeritava_laua_kood AND
    laua_seisundi_liik_kood = 2;
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_deaktiveeri_laud(p_deaktiveeritava_laua_kood INT) IS 'Muudab laua oleku seisundi mitteaktiivseks (OP4).';



/*
Laua lõpetmaine.

Laused testimiseks:
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 2
select f_lopeta_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 4
*/
DROP FUNCTION IF EXISTS f_lopeta_laud;

CREATE OR REPLACE FUNCTION f_lopeta_laud(p_lopetatava_laua_kood INT)
RETURNS VOID AS $$
    UPDATE laud
    SET laua_seisundi_liik_kood = 4
    WHERE laua_kood = p_lopetatava_laua_kood AND laua_seisundi_liik_kood <> 1;
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lopeta_laud(p_lopetatava_laua_kood INT) IS 'Muudab laua oleku seisundi lopetatuks (OP5).';

