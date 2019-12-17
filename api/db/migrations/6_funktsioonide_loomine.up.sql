/*
Laua aktiveerimine.

Laused testimiseks:
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4;
select f_aktiveeri_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 2
*/
CREATE OR REPLACE FUNCTION f_aktiveeri_laud(p_aktiveeritava_laua_kood INT)
RETURNS VOID AS $$
  UPDATE laud
  SET laua_seisundi_liik_kood = 2
  WHERE laua_kood = p_aktiveeritava_laua_kood;
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_aktiveeri_laud(p_aktiveeritava_laua_kood INT)
IS 'See funktsioon muudab laua oleku seisundi aktiivseks, realiseerides andmebaasioperatsiooni OP3.
Parameetri p_aktiveeritava_laua_kood oodatav väärtus on aktiveeritava laua identifikaator.';

/*
Laua deaktiveerimine.

Laused testimiseks:
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 2
select f_deaktiveeri_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 3
*/
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

COMMENT ON FUNCTION f_deaktiveeri_laud(p_deaktiveeritava_laua_kood INT)
IS 'Muudab laua oleku seisundi mitteaktiivseks, realiseerides andmebaasioperatsiooni OP4.
Parameetri p_deaktiveeritava_laua_kood oodatav väärtus on aktiveeritava laua identifikaator.';

/*
Laua lisamine kategooriasse

Laused testimiseks:
update laud set laua_seisundi_liik_kood = 1 where laua_kood = 2;
select f_lisa_laud_kategooriasse(2, 6)
*/
CREATE OR REPLACE FUNCTION f_lisa_laud_kategooriasse(p_laua_kood INT, p_kategooria_kood SMALLINT)
RETURNS VOID AS $$
  INSERT INTO laua_kategooria_omamine (
    laua_kood,
    laua_kategooria_kood
  )
  SELECT
    p_laua_kood,
    p_kategooria_kood
  WHERE
    EXISTS (
      SELECT laua_seisundi_liik_kood
      FROM laud
      WHERE
        laua_kood = p_laua_kood AND
        (
          laua_seisundi_liik_kood = 1 OR
          laua_seisundi_liik_kood = 3
        )
      FOR UPDATE
    );
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lisa_laud_kategooriasse(p_laua_kood INT, p_kategooria_kood SMALLINT)
IS 'Lisab laua kategooriasse, realiseerides andmebaasioperatsiooni OP7. Laud peab olema kas ootel või mitteaktiivne.
Parameetri p_laua_kood oodatav väärtus on aktiveeritava laua identifikaator ja parameetri p_kategooria_kood
oodatav väärtus on antud laua kategooria identifikaator.';

/*
Laua eemaldamine kategooriast

Laused testimiseks:
update laud set laua_seisundi_liik_kood = 1 where laua_kood = 2;
select f_eemalda_laud_kategooriast(2, 6)
*/
CREATE OR REPLACE FUNCTION f_eemalda_laud_kategooriast(p_laua_kood INT, p_kategooria_kood SMALLINT)
RETURNS VOID AS $$
  DELETE FROM
    laua_kategooria_omamine
  WHERE
    laua_kood = p_laua_kood AND
    laua_kategooria_kood = p_kategooria_kood AND
    EXISTS (
      SELECT laua_seisundi_liik_kood
      FROM laud
      WHERE
        laua_kood = p_laua_kood AND
        (
          laua_seisundi_liik_kood = 1 OR
          laua_seisundi_liik_kood = 3
        )
        FOR UPDATE
    );
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_eemalda_laud_kategooriast(p_laua_kood INT, p_kategooria_kood SMALLINT)
IS 'Eemaldab laua kategooriast, realiseerides andmebaasioperatiooni OP8. Laud peab olema kas ootel või mitteaktiivne.
Parameetri p_laua_kood oodatav väärtus on aktiveeritava laua identifikaator ja parameetri p_kategooria_kood
oodatav väärtus on antud laua kategooria identifikaator.';

/*
Unusta laud.
*/
CREATE OR REPLACE FUNCTION f_unusta_laud(p_laua_kood INT)
RETURNS VOID AS $$
  DELETE FROM laud
  WHERE
    laua_kood = p_laua_kood AND
    laua_seisundi_liik_kood = 1;
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_unusta_laud(p_laua_kood INT) IS 'Unustab laua, realiseerides andmebaasioperatiooni OP2.
Laud peab olema ootel staatuses. Parameetri p_laua_kood oodatav väärtus on aktiveeritava laua identifikaator.';

/*
Laua lõpetmaine.

Laused testimiseks:
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 2
select f_lopeta_laud(4);
select laua_kood, laua_seisundi_liik_kood from laud where laua_kood=4; -- kood on 4
*/
CREATE OR REPLACE FUNCTION f_lopeta_laud(p_lopetatava_laua_kood INT)
RETURNS VOID AS $$
    UPDATE laud
    SET laua_seisundi_liik_kood = 4
    WHERE laua_kood = p_lopetatava_laua_kood
    AND laua_seisundi_liik_kood IN (2,3);
$$  LANGUAGE SQL
    SECURITY DEFINER
    SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lopeta_laud(p_lopetatava_laua_kood INT)
IS 'Muudab laua oleku seisundi lõpetatuks, realiseerides andmebaasioperatiooni OP5.
Parameetri p_lopetatava_laua_kood oodatav väärtus on aktiveeritava laua identifikaator.';
