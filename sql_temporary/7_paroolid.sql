UPDATE isik
SET parool=public.crypt(parool,public.gen_salt('bf', 11));


ALTER TABLE isik
DROP CONSTRAINT ak_isik_e_meil;

CREATE UNIQUE INDEX ak_isik_e_meil 
ON isik (UPPER(e_meil));



DROP FUNCTION IF EXISTS f_on_tootaja;

CREATE OR REPLACE FUNCTION f_on_tootaja(p_e_meil text, p_parool text)
RETURNS boolean AS 
$$
DECLARE rslt boolean;
BEGIN
SELECT INTO rslt (parool = public.crypt(p_parool,parool)) 
FROM Tootaja 
INNER JOIN Isik ON Isik.isik_id = Tootaja.isik_id
WHERE Upper(e_meil)=Upper(p_e_meil) 
AND amet_kood BETWEEN 1 AND 2 
AND tootaja_seisundi_liik_kood IN (1, 2, 3)
AND isiku_seisundi_liik_kood = 1;
RETURN coalesce(rslt, FALSE);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_on_tootaja(p_kasutajanimi text, p_parool text) 
IS 'Selle funktsiooni abil autenditakse
töötajat. Parameetri p_e_meil oodatav väärtus on
tõstutundetu kasutajanimi ja p_parool oodatav väärtus on
tõstutundlik avatekstiline parool. Töötajal on õigus
süsteemi siseneda, vaid siis kui tema seisundiks on tööl, puhkusel
või haiguslehel.';

                                        
DROP EXTENSION IF EXISTS pgcrypto CASCADE;
