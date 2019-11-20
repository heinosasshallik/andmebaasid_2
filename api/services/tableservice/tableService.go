package tableservice

import (
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	"github.com/heinosasshallik/andmebaasid_2/api/models/tablemodels"
	"log"
)

func GetSummaryReport() []tablemodels.SummaryRow {
	var summaryReport []tablemodels.SummaryRow
	db := db.GetDB()
	rows, err := db.Query("select laua_seisundi_liik_kood, staatus, kogus from laudade_koondaruanne")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var row tablemodels.SummaryRow
		if err := rows.Scan(&row.LauaSeisundiLiikKood, &row.Staatus, &row.Kogus); err != nil {
			log.Fatal(err)
		}
		summaryReport = append(summaryReport, row)
	}
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
	return summaryReport
}

func GetEndableTables() []tablemodels.Laud {
	var endableTables []tablemodels.Laud
	db := db.GetDB()
	rows, err := db.Query("select laua_kood, staatus, kommentaar from aktiivsed_mitteaktiivsed_lauad")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var table tablemodels.Laud
		if err := rows.Scan(&table.LauaKood, &table.Staatus, &table.Kommentaar); err != nil {
			log.Fatal(err)
		}
		endableTables = append(endableTables, table)
	}
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
	return endableTables
}

func GetAllTables() []tablemodels.Laud {
	var tables []tablemodels.Laud
	db := db.GetDB()
	rows, err := db.Query("select laua_kood, staatus, kommentaar from koik_lauad")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var table tablemodels.Laud
		if err := rows.Scan(&table.LauaKood, &table.Staatus, &table.Kommentaar); err != nil {
			log.Fatal(err)
		}
		tables = append(tables, table)
	}
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
	return tables
}

func GetAllTablesDetailed() []tablemodels.Laud {
	var tables []tablemodels.Laud
	db := db.GetDB()
	rows, err := db.Query(`
		select 
			laua_kood,
			laua_vorgu_korgus,
			max_mangijate_arv,
			reg_aeg,
			kommentaar,
			staatus,
			brand,
			isiku_nimi,
			isiku_e_meil
		from
			laua_detailid
	`)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var table tablemodels.Laud
		if err := rows.Scan(
			&table.LauaKood,
			&table.LauaVorguKorgus,
			&table.MaxMangijateArv,
			&table.RegAeg,
			&table.Kommentaar,
			&table.Staatus,
			&table.Brand,
			&table.IsikuNimi,
			&table.IsikuEmail,
		); err != nil {
			log.Fatal(err)
		}
		tables = append(tables, table)
	}
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
	return tables
}
