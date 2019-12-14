CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER minu_testandmete_server_apex FOREIGN DATA WRAPPER
postgres_fdw OPTIONS (host 'apex.ttu.ee', dbname 'testandmed',
port '5432');

CREATE USER MAPPING FOR t179501 SERVER
minu_testandmete_server_apex OPTIONS (user 't179501', password
'secret');

CREATE FOREIGN TABLE Riik_jsonb (
riik JSONB )
SERVER minu_testandmete_server_apex;

INSERT INTO Riik (riik_kood, nimetus)
SELECT riik->>'Alpha-3 code' AS riik_kood,
riik->>'English short name lower case' AS nimetus 
FROM public.Riik_jsonb ON CONFLICT DO NOTHING;

CREATE FOREIGN TABLE Isik_jsonb (
isik JSONB )
SERVER minu_testandmete_server_apex;

INSERT INTO Isik(isikukood, riik_kood, e_meil, parool, isiku_seisundi_liik_kood, 
synni_kp, eesnimi, perenimi, elukoht)
  SELECT isikukood, riik_kood, e_meil, parool, isiku_seisundi_liik_kood::smallint,
         synni_kp::date, eesnimi, perenimi, elukoht
  FROM (SELECT
    jsonb_array_elements(isik->'isikud')->>'isikukood' AS isikukood,
    isik->>'riik' AS riik_kood,
    jsonb_array_elements(isik->'isikud')->>'email' AS e_meil,
    jsonb_array_elements(isik->'isikud')->>'parool' AS parool,
    jsonb_array_elements(isik->'isikud')->>'seisund' AS isiku_seisundi_liik_kood,
    jsonb_array_elements(isik->'isikud')->>'synni_aeg' AS synni_kp,
    jsonb_array_elements(isik->'isikud')->>'eesnimi' AS eesnimi,
    jsonb_array_elements(isik->'isikud')->>'perekonnanimi' AS perenimi,
    jsonb_array_elements(isik->'isikud')->>'aadress' AS elukoht
    FROM isik_jsonb) AS lahteandmed
  WHERE isiku_seisundi_liik_kood::smallint=1;
 