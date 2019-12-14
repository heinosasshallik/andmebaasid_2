/*
Genereeri 1100 rida andmeid tabelisse laud.
*/
INSERT INTO laud(laua_kood, laua_vorgu_korgus, max_mangijate_arv,
registreerija_id, laua_seisundi_liik_kood, laua_brand_kood, reg_aeg, kommentaar)
  SELECT
    genereeritud_laua_kood,
    genereeritud_laua_vorgu_korgus,
    genereeritud_max_mangijate_arv,
    genereeritud_registreerija_id,
    genereeritud_laua_seisundi_liik_kood,
    genereeritud_laua_brand_kood,
    genereeritud_reg_aeg,
    CASE WHEN naita_kommentaari THEN genereeritud_kommentaar ELSE NULL END AS sisestatav_kommentaar
  FROM (
    SELECT
      -- laua kood
      (SELECT (MAX(laua_kood) + generator) genereeritud_laua_kood FROM laud AS genereeritud_laua_kood),
      -- laua vorgu korgus
      (SELECT floor(random() * 300 + 1 + (generator*0))::int AS genereeritud_laua_vorgu_korgus),
      -- max mangijate arv
      (SELECT floor(random() * 5 + 2 + (generator*0))::int AS genereeritud_max_mangijate_arv),
      -- registreerija id
      (SELECT isik_id AS genereeritud_registreerija_id FROM tootaja WHERE amet_kood=2 ORDER BY random() + (generator*0) LIMIT 1),
      -- laua seisundi liik kood
      (SELECT laua_seisundi_liik_kood AS genereeritud_laua_seisundi_liik_kood FROM laua_seisundi_liik ORDER BY random() + (generator*0) LIMIT 1),
      -- laua brand kood
      (SELECT laua_brand_kood AS genereeritud_laua_brand_kood FROM laua_brand ORDER BY random() + (generator*0) LIMIT 1),
      -- registreerimise aeg
      (SELECT timestamp '2010-01-01 00:00:00' +
        (random() + (generator*0)) *
        (timestamp '2100-12-31 23:59:59' - timestamp '2010-01-01 00:00:00') AS genereeritud_reg_aeg),
      -- kommentaar
      (SELECT string_agg(x,' ') AS genereeritud_kommentaar
        FROM (
          SELECT sonad[1 + ((random() * 33)::int) % 20]
          FROM (
            SELECT '{laud,hea,on,vana,uus,must,parandamist,vajab,valge,roosa,varustusega,varustuseta,uskumatu,kirjeldamatu,vinge,sinine,kollane,katki,hoiustatud,kleepuv}'::text[] AS sonad
          ) sonade_list,
          generate_series(1, 6 + (generator*0))
        ) AS genereeritud_kommentaar(x)),
      -- naita kommentaari
      (SELECT ((random() * 100 + (generator*0)) < 20)::boolean AS naita_kommentaari)
   	FROM generate_series(1,1100) AS generator
  ) AS sisestatavad_read
ON CONFLICT DO NOTHING;

/*
Genereeri 15000 rida andmeid tabelisse laua_kategooria_omamine, sest tekib palju konflikte ja eesmärk on
sisestada edukalt vähemalt 4000 rida.
*/
INSERT INTO laua_kategooria_omamine(laua_kood, laua_kategooria_kood)
  SELECT
    genereeritud_laua_kood,
    genereeritud_laua_kategooria_kood
  FROM (
    SELECT
      -- laua kood
      (SELECT laua_kood AS genereeritud_laua_kood FROM laud ORDER BY random() + (generator*0) LIMIT 1),
      -- laua kategooria kood
      (SELECT laua_kategooria_kood AS genereeritud_laua_kategooria_kood FROM laua_kategooria ORDER BY random() + (generator*0) LIMIT 1)
    FROM generate_series(1,15000) as generator
  ) as sisestatavad_read
ON CONFLICT DO NOTHING;