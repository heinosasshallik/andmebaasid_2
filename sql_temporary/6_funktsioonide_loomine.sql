/*
Laua aktiveerimine ning deaktiveerimine.

Laused testimiseks:
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4;
call aktiveeri_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 2
call deaktiveeri_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 3
*/

DROP PROCEDURE IF EXISTS aktiveeri_laud;

CREATE OR REPLACE PROCEDURE aktiveeri_laud(p_aktiveeritava_laua_kood INT)
AS $$
BEGIN
  UPDATE laud 
  SET laua_seisundi_liik_kood = 2
  WHERE laua_kood = p_aktiveeritava_laua_kood;
  COMMIT;
END;
$$  LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON PROCEDURE aktiveeri_laud(p_aktiveeritava_laua_kood INT) IS 'Muudab laua oleku seisundi aktiivseks (OP3).';




DROP PROCEDURE IF EXISTS deaktiveeri_laud;

CREATE OR REPLACE PROCEDURE deaktiveeri_laud(p_deaktiveeritava_laua_kood INT)
AS $$
BEGIN
  UPDATE laud 
  SET laua_seisundi_liik_kood = 3
  WHERE 
    laua_kood = p_deaktiveeritava_laua_kood AND
    laua_seisundi_liik_kood = 2;
  COMMIT;
END;
$$  LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON PROCEDURE deaktiveeri_laud(p_deaktiveeritava_laua_kood INT) IS 'Muudab laua oleku seisundi mitteaktiivseks (OP4).';



/*
Laua lõpetmaine.

Laused testimiseks:
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 2
call lopeta_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 4
*/
DROP PROCEDURE IF EXISTS lopeta_laud;

CREATE OR REPLACE PROCEDURE lopeta_laud(p_lopetatava_laua_kood INT)
AS $$
BEGIN
    UPDATE laud 
    SET laua_seisundi_liik_kood = 4
    WHERE laua_kood = p_lopetatava_laua_kood AND laua_seisundi_liik_kood <> 1;
    COMMIT;
END;
$$  LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON PROCEDURE lopeta_laud(p_lopetatava_laua_kood INT) IS 'Muudab laua oleku seisundi lopetatuks (OP5).';

