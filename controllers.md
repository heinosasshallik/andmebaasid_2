## GET:
* Vaata laudade koondaruannet, küsi baasist vaadet laudade_koondaruanne
* Vaata lõpetatavaid laudu, küsi baasist vaadet aktiivsed_mitteaktiivsed_lauad
* Kõik lauad, küsi vaadet koik_lauad
* Laua detailid, küsi vaadet laua_detailid
* Lauaga seotud kategooriad, küsi vaadet laua_kategooriate_omamine

## PUT:
* Lõpeta laud, kutsu välja funktsioon f_lopeta_laud(p_lopetatava_laua_kood INT)
* Tuvasta kasutaja, kutsu funktsiooni f_on_tootaja(p_e_meil text, p_parool text)

## GET muudatusi:
* Laua detailid request tuleb koos id'ga, küsi vaatest laua_detailid ainult see 
laud, mille id kaasa anti
* Lauaga seotud kategooriate request tuleb koos id'ga, küsi vaatest 
laua_kategooriate_omamine selle id'ga tulemusi