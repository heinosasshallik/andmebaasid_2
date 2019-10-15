DROP VIEW IF EXISTS laua_detailid;

CREATE VIEW laua_detailid AS
  SELECT
    Laud.laua_kood,
    Laud.laua_vorgu_korgus,
    Laud.max_mangijate_arv,
    Laud.reg_aeg,
    Laud.kommentaar,
    Laua_seisundi_liik.nimetus AS staatus,
    Laua_brand.nimetus AS brand,
    COALESCE(Isik.eesnimi || ' ', '') || COALESCE(Isik.perenimi, '') AS isiku_nimi,
    Isik.e_meil AS isiku_e_meil
  FROM
    Laua_seisundi_liik
  INNER JOIN (Laua_brand 
    INNER JOIN (Isik 
      INNER JOIN Laud ON Isik.isik_id = Laud.registreerija_id)
    USING (laua_brand_kood))
  USING (laua_seisundi_liik_kood);


COMMENT ON VIEW laua_detailid IS 'Laudade detailne ylevaade'
