
DROP VIEW IF EXISTS ootel_mitteaktiivsed_lauad;

CREATE VIEW ootel_mitteaktiivsed_lauad AS
  SELECT L.laua_kood, LSS.nimetus as staatus, L.kommentaar
  FROM Laua_seisundi_liik AS LSS INNER JOIN Laud AS L ON LSS.laua_seisundi_liik_kood = L.laua_seisundi_liik_kood
  WHERE (((L.laua_seisundi_liik_kood) In (2,3)));

COMMENT ON VIEW ootel_mitteaktiivsed_lauad IS 'Kuvab ootel või mitteaktiivses seisundis laudade nimekirja, kus on kood, hetkeseisundi nimetus, kommentaar.'
