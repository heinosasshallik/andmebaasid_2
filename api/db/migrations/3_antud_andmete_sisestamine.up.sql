INSERT INTO Riik (riik_kood, nimetus)
SELECT riik->>'Alpha-3 code' AS riik_kood,
riik->>'English short name lower case' AS nimetus 
FROM public.Riik_jsonb ON CONFLICT DO NOTHING;

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
 