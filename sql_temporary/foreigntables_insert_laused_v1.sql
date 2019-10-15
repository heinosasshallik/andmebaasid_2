INSERT INTO Isik(riik_kood, isikukood, eesnimi, perenimi, reg_aeg,
e_meil, synni_kp, isiku_seisundi_liik_kood, parool, elukoht)
SELECT riik_kood, isikukood, eesnimi, perenimi, reg_aeg, e_meil,
synni_kp::date, isiku_seisundi_liik_kood::smallint, parool,
elukoht
FROM (SELECT isik->>'riik' AS riik_kood, 
jsonb_array_elements(isik->'isikud')->>'isikukood' AS isikukood,
jsonb_array_elements(isik->'isikud')->>'eesnimi' AS eesnimi,
jsonb_array_elements(isik->'isikud')->>'perekonnanimi' AS
perenimi,  
current_timestamp(0) AS reg_aeg,
jsonb_array_elements(isik->'isikud')->>'email' AS e_meil,
jsonb_array_elements(isik->'isikud')->>'synni_aeg' AS synni_kp,
jsonb_array_elements(isik->'isikud')->>'seisund' AS
isiku_seisundi_liik_kood,
jsonb_array_elements(isik->'isikud')->>'parool' AS parool,
jsonb_array_elements(isik->'isikud')->>'aadress' AS elukoht
FROM isik_jsonb) AS lahteandmed; 


INSERT INTO Riik (riik_kood, nimetus) 
SELECT riik->>'Alpha-3 code' AS riik_kood,
riik->>'English short name lower case' AS nimetus 
FROM Riik_jsonb ON CONFLICT DO NOTHING;
