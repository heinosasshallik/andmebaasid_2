CREATE VIEW laudade_koondaruanne WITH (security_barrier) AS (
  SELECT  Laua_seisundi_liik.laua_seisundi_liik_kood AS laua_seisundi_liik_kood,
      UPPER(Laua_seisundi_liik.nimetus) AS staatus,
      COUNT(Laud.laua_kood) AS kogus
    FROM Laua_seisundi_liik
    LEFT JOIN Laud USING (laua_seisundi_liik_kood)
    GROUP BY Laua_seisundi_liik.laua_seisundi_liik_kood,
             Laua_seisundi_liik.nimetus
    ORDER BY COUNT(Laud.laua_kood) DESC, UPPER(Laua_seisundi_liik.nimetus)
);

CREATE VIEW laua_kategooriate_omamine WITH (security_barrier) AS (
  SELECT  Laua_kategooria_omamine.laua_kood,
        Laua_kategooria.nimetus || '(' || Laua_kategooria_tyyp.nimetus || ')' AS kategooria
    FROM Laua_kategooria_tyyp
    INNER JOIN (Laua_kategooria
                INNER JOIN Laua_kategooria_omamine
                USING (laua_kategooria_kood))
    USING (laua_kategooria_tyyp_kood)
  );

CREATE VIEW koik_lauad WITH (security_barrier) AS
  SELECT L.laua_kood, L.kommentaar, LSS.nimetus as staatus
  FROM Laua_seisundi_liik AS LSS INNER JOIN Laud AS L ON LSS.laua_seisundi_liik_kood = L.laua_seisundi_liik_kood
  ORDER BY L.laua_kood;

CREATE VIEW aktiivsed_mitteaktiivsed_lauad WITH (security_barrier) AS
  SELECT L.laua_kood, LSS.nimetus as staatus, L.kommentaar
  FROM Laua_seisundi_liik AS LSS INNER JOIN Laud AS L ON LSS.laua_seisundi_liik_kood = L.laua_seisundi_liik_kood
  WHERE (((L.laua_seisundi_liik_kood) In (2,3)));

CREATE VIEW laua_detailid WITH (security_barrier) AS
  SELECT
    Laud.laua_kood,
    Laud.laua_vorgu_korgus,
    Laud.max_mangijate_arv,
    Laud.reg_aeg,
    Laud.kommentaar,
    Laua_seisundi_liik.nimetus AS staatus,
    Laua_brand.nimetus AS brand,
    COALESCE(Isik.eesnimi || ' ', '') || COALESCE(Isik.perenimi, '') AS registreerija_nimi,
    Isik.e_meil AS registreerija_e_meil
  FROM
    Laua_seisundi_liik
  INNER JOIN (Laua_brand
    INNER JOIN (Isik
      INNER JOIN Laud ON Isik.isik_id = Laud.registreerija_id)
    USING (laua_brand_kood))
  USING (laua_seisundi_liik_kood);

CREATE VIEW tootajate_detailid WITH (security_barrier) AS
  SELECT
    Isik.isik_id,
    Isik.isikukood,
    Isik.riik_kood,
    Isik.e_meil,
    COALESCE(Isik.eesnimi || ' ', '') || COALESCE(Isik.perenimi, '') AS isiku_nimi,
    Tootaja.mentor as mentor_id,
    Tootaja_seisundi_liik.nimetus as tootaja_staatus,
    Amet.amet_kood,
    Amet.nimetus as amet_nimetus
  FROM
    Isik
  INNER JOIN Tootaja
    ON Isik.isik_id = Tootaja.isik_id
  INNER JOIN Tootaja_seisundi_liik
    ON Tootaja_seisundi_liik.tootaja_seisundi_liik_kood = Tootaja.tootaja_seisundi_liik_kood
  INNER JOIN Amet
    ON Amet.amet_kood = Tootaja.amet_kood;


COMMENT ON VIEW laudade_koondaruanne
IS 'Kuvab iga laua elutsükli seisundi kohta selle seisundi koodi, seisundi nimetuse (suurtähtedega)
ja hetkel selles seisundis olevate laudade arvu. Kui selles seisundis pole hetkel ühtegi lauda, siis
on arv 0. Seisundid on sorteeritud laudade arvu järgi kahanevalt. Kui mitmel seisundil on samasugune
laudade arv, siis need on sorteeritud suurtähtedega nime järgi tähestiku järjekorras.';
COMMENT ON VIEW laua_kategooriate_omamine
IS 'Kuvab lauad ja nendega seotud kategooriad ning kategooriate tüüpide nimetused.';
COMMENT ON VIEW koik_lauad
IS 'Kuvab laua koodi, kommentaari ja staatuse iga laua kohta.
Seda vaadet on vaja, et anda lühiülevaade laudadest.';
COMMENT ON VIEW aktiivsed_mitteaktiivsed_lauad
IS 'Kuvab aktiivses või mitteaktiivses seisundis laudade nimekirja,
kus on kood, hetkeseisundi nimetus ja kommentaar.';
COMMENT ON VIEW laua_detailid
IS 'Annab detailse ülevaate laua andmete, seisundi ning laua registreerija kohta.';
COMMENT ON VIEW tootajate_detailid
IS 'Tagastab detailse info töötajate kohta ilma konfidentsiaalsete andmeteta.
Seda vaadet kasutatakse, et kasutajale tema enda kohta infot näidata.';
