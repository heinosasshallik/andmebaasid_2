INSERT INTO Isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus) VALUES (1, 'Elus');
INSERT INTO Isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus) VALUES (2, 'Surnud'); 

INSERT INTO Kliendi_seisundi_liik (kliendi_seisundi_liik_kood, nimetus) VALUES (1, 'Aktiivne');
INSERT INTO Kliendi_seisundi_liik (kliendi_seisundi_liik_kood, nimetus) VALUES (2, 'Mitteaktiivne'); 

INSERT INTO Laua_seisundi_liik (laua_seisundi_liik_kood, nimetus) VALUES (1, 'Ootel');
INSERT INTO Laua_seisundi_liik (laua_seisundi_liik_kood, nimetus) VALUES (2, 'Aktiivne');
INSERT INTO Laua_seisundi_liik (laua_seisundi_liik_kood, nimetus) VALUES (3, 'Mitteaktiivne');
INSERT INTO Laua_seisundi_liik (laua_seisundi_liik_kood, nimetus) VALUES (4, 'Lõpetatud'); 

INSERT INTO Laua_brand (laua_brand_kood, nimetus) VALUES (1, 'Butterfly'); 
INSERT INTO Laua_brand (laua_brand_kood, nimetus) VALUES (2, 'Stiga'); 

INSERT INTO Laua_kategooria_tyyp (laua_kategooria_tyyp_kood, nimetus) VALUES (1, 'Vanus');
INSERT INTO Laua_kategooria_tyyp (laua_kategooria_tyyp_kood, nimetus) VALUES (2, 'Seisukord');
INSERT INTO Laua_kategooria_tyyp (laua_kategooria_tyyp_kood, nimetus) VALUES (3, 'Kasutusjuht'); 

INSERT INTO Laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood) VALUES (1, 'Igapäevaseks kasutamiseks', 3);
INSERT INTO Laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood) VALUES (2, 'Võistlusteks', 3);
INSERT INTO Laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood) VALUES (3, 'Uus', 1);
INSERT INTO Laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood) VALUES (4, 'Vana', 1);
INSERT INTO Laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood) VALUES (5, 'Heas korras', 2);
INSERT INTO Laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood) VALUES (6, 'Vajab lähiajal hooldust', 2);

INSERT INTO Amet (amet_kood, nimetus, kirjeldus) VALUES (1, 'Juhataja', 'Vastutab eelarve ja arendustöö eest. Saab vaadata laudade koondaruannet, lõpetada laudu ja vaadata kõiki laudu.');
INSERT INTO Amet (amet_kood, nimetus, kirjeldus) VALUES (2, 'Laudade haldur', 'Tegemist on klienditeenindajaga. Saab laudu registreerida, unustada, aktiveerida, mitteaktiivseks muuta, vaadata.');

INSERT INTO Riik (riik_kood, nimetus) VALUES ('ENG', 'Inglismaa');
INSERT INTO Riik (riik_kood, nimetus) VALUES ('EST', 'Eesti');
INSERT INTO Riik (riik_kood, nimetus) VALUES ('FIN', 'Soome');
INSERT INTO Riik (riik_kood, nimetus) VALUES ('LAT', 'Läti');
INSERT INTO Riik (riik_kood, nimetus) VALUES ('RUS', 'Venemaa'); 

INSERT INTO Tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (1, 'Tööl');
INSERT INTO Tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (2, 'Puhkusel'); 
INSERT INTO Tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (3, 'Haiguslehel'); 
INSERT INTO Tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (4, 'Vallandatud'); 
INSERT INTO Tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (5, 'Töösuhe peataud');

INSERT INTO Isik (isikukood, riik_kood, e_meil, parool, isiku_seisundi_liik_kood, synni_kp, reg_aeg, eesnimi, perenimi, elukoht) 
VALUES ('3975163289', 'EST', 'piotr1@gmail.com', 'tere', 1, '1995-04-20 00:00:00', '2019-04-11 16:21:15', 'Peeter', 'Esimene', 'Raja 18');

INSERT INTO Isik (isikukood, riik_kood, e_meil, parool, isiku_seisundi_liik_kood, synni_kp, reg_aeg, eesnimi, perenimi, elukoht)
VALUES ('36498152648', 'RUS', 'maie@valdur.ee', 'olen', 1, '1976-09-15 00:00:00', '2019-04-11 16:21:21', 'Maie', 'Valdur', 'Vene 6');

INSERT INTO Isik (isikukood, riik_kood, e_meil, parool, isiku_seisundi_liik_kood, synni_kp, reg_aeg, eesnimi, perenimi, elukoht)
VALUES ('46498452648', 'EST', 'maali.m@gmail.com', 'maasikas', 1, '1976-09-15 00:00:00', '2019-04-11 16:21:21', 'Maali', 'Maasikas', 'Vene 8, Tallinn');

INSERT INTO Isik (isikukood, riik_kood, e_meil, parool, isiku_seisundi_liik_kood, synni_kp, reg_aeg, eesnimi, perenimi, elukoht)
VALUES ('5656566556', 'LAT', 'sadasd@asdas.ee', 'nõrk', 1, '1959-02-05 00:00:00', '2019-04-18 18:54:27', 'Valdur', 'Teine', 'Paala 3');

INSERT INTO Isik (isikukood, riik_kood, e_meil, parool, isiku_seisundi_liik_kood, synni_kp, reg_aeg, eesnimi, perenimi, elukoht)
VALUES ('5996865863', 'EST', 'rambo@mambo.ee', 'parool', 2, '1910-02-05 00:00:00', '2017-04-18 18:54:27', 'Onu', 'Uno', 'Raadi 785');

INSERT INTO Klient (isik_id, on_nous_tylitamisega, kliendi_seisundi_liik_kood) VALUES (1, false, 1);

INSERT INTO Tootaja (isik_id, amet_kood, tootaja_seisundi_liik_kood, mentor) VALUES (2, 1, 1, NULL);
INSERT INTO Tootaja (isik_id, amet_kood, tootaja_seisundi_liik_kood, mentor) VALUES (3, 1, 1, NULL);
INSERT INTO Tootaja (isik_id, amet_kood, tootaja_seisundi_liik_kood, mentor) VALUES (4, 2, 2, 2);

INSERT INTO Laud (laua_kood, laua_vorgu_korgus, max_mangijate_arv, registreerija_id, laua_seisundi_liik_kood, laua_brand_kood, reg_aeg, kommentaar)
VALUES (1, 153, 2, 2, 4, 1, '2019-03-29 16:16:02', NULL );

INSERT INTO Laud (laua_kood, laua_vorgu_korgus, max_mangijate_arv, registreerija_id, laua_seisundi_liik_kood, laua_brand_kood, reg_aeg, kommentaar)
VALUES (2, 153, 2, 2, 1, 1, '2019-03-29 16:24:31', NULL );

INSERT INTO Laud (laua_kood, laua_vorgu_korgus, max_mangijate_arv, registreerija_id, laua_seisundi_liik_kood, laua_brand_kood, reg_aeg, kommentaar)
VALUES (3, 153, 2, 2, 2, 1, '2019-03-29 16:26:00', NULL );

INSERT INTO Laud (laua_kood, laua_vorgu_korgus, max_mangijate_arv, registreerija_id, laua_seisundi_liik_kood, laua_brand_kood, reg_aeg, kommentaar)
VALUES (4, 76, 4, 3, 2, 2, '2019-04-10 12:01:32', 'See laud läks katki ja tehti ise korda. Ei vasta võistlusnõuetele.' );

INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (1, 1);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (1, 2);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (1, 3);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (1, 5);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (2, 2);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (2, 3);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (2, 5);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (3, 1);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (3, 4);
INSERT INTO Laua_kategooria_omamine (laua_kood, laua_kategooria_kood) VALUES (3, 6);
