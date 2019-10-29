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

CREATE OR REPLACE PROCEDURE aktiveeri_laud(aktiveeritava_laua_kood INT)
LANGUAGE plpgsql    
AS $$
BEGIN
  UPDATE laud 
  SET laua_seisundi_liik_kood = 2
  WHERE laua_kood = aktiveeritava_laua_kood;
  COMMIT;
END;
$$;

COMMENT ON PROCEDURE aktiveeri_laud(aktiveeritava_laua_kood INT) IS 'Muudab laua oleku seisundi aktiivseks (OP3).';

DROP PROCEDURE IF EXISTS deaktiveeri_laud;

CREATE OR REPLACE PROCEDURE deaktiveeri_laud(deaktiveeritava_laua_kood INT)
LANGUAGE plpgsql    
AS $$
BEGIN
  UPDATE laud 
  SET laua_seisundi_liik_kood = 3
  WHERE 
    laua_kood = deaktiveeritava_laua_kood AND
    laua_seisundi_liik_kood = 2;
  COMMIT;
END;
$$;

COMMENT ON PROCEDURE deaktiveeri_laud(aktiveeritava_laua_kood INT) IS 'Muudab laua oleku seisundi mitteaktiivseks (OP4).';


