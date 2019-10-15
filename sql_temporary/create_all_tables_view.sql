DROP VIEW IF EXISTS koik_lauad;

CREATE VIEW koik_lauad AS
  SELECT L.laua_kood, L.kommentaar, LSS.nimetus
  FROM Laua_seisundi_liik AS LSS INNER JOIN Laud AS L ON LSS.laua_seisundi_liik_kood = L.laua_seisundi_liik_kood
  ORDER BY L.laua_kood;

COMMENT ON VIEW koik_lauad IS 'Koikide laudade nimekiri'
