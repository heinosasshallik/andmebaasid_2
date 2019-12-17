package tableservice

import (
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	"github.com/heinosasshallik/andmebaasid_2/api/models/tablemodels"
)

func GetSummaryReport() ([]tablemodels.SummaryRow, error) {
	var summaryReport []tablemodels.SummaryRow
	db := db.GetDB()
	rows, err := db.Query("select laua_seisundi_liik_kood, staatus, kogus from laudade_koondaruanne")
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var row tablemodels.SummaryRow
		if err := rows.Scan(&row.LauaSeisundiLiikKood, &row.Staatus, &row.Kogus); err != nil {
			return nil, err
		}
		summaryReport = append(summaryReport, row)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return summaryReport, nil
}

func GetEndableTables() ([]tablemodels.Laud, error) {
	var endableTables []tablemodels.Laud
	db := db.GetDB()
	rows, err := db.Query("select laua_kood, staatus, kommentaar from aktiivsed_mitteaktiivsed_lauad")
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var table tablemodels.Laud
		if err := rows.Scan(&table.LauaKood, &table.Staatus, &table.Kommentaar); err != nil {
			return nil, err
		}
		endableTables = append(endableTables, table)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return endableTables, nil
}

func GetAllTables() ([]tablemodels.Laud, error) {
	var tables []tablemodels.Laud
	db := db.GetDB()
	rows, err := db.Query("select laua_kood, staatus, kommentaar from koik_lauad")
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var table tablemodels.Laud
		if err := rows.Scan(&table.LauaKood, &table.Staatus, &table.Kommentaar); err != nil {
			return nil, err
		}
		tables = append(tables, table)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return tables, nil
}

func GetTableDetailed(id int) (tablemodels.Laud, error) {
	var table tablemodels.Laud
	db := db.GetDB()
	row := db.QueryRow(`
		select 
			laua_kood,
			laua_vorgu_korgus,
			max_mangijate_arv,
			reg_aeg,
			kommentaar,
			staatus,
			brand,
			registreerija_nimi,
			registreerija_e_meil
		from
			laua_detailid
		where
			laua_kood = $1
	`, id)
	err := row.Scan(
		&table.LauaKood,
		&table.LauaVorguKorgus,
		&table.MaxMangijateArv,
		&table.RegAeg,
		&table.Kommentaar,
		&table.Staatus,
		&table.Brand,
		&table.IsikuNimi,
		&table.IsikuEmail,
	)
	return table, err
}

func GetCategories(id int) (tablemodels.Laud, error) {
	var table tablemodels.Laud
	db := db.GetDB()
	rows, err := db.Query(`
	select
		kategooria
	from
		laua_kategooriate_omamine
	where
		laua_kood = $1
	`, id)
	if err != nil {
		return table, err
	}
	defer rows.Close()
	for rows.Next() {
		var category string
		if err := rows.Scan(&category); err != nil {
			return table, err
		}
		table.Kategooriad = append(table.Kategooriad, category)
	}
	table.LauaKood = id

	return table, err
}

func EndTable(id int) (int, error) {
	db := db.GetDB()
	rows, err := db.Query("select f_lopeta_laud($1)", id)
	if err != nil {
		return id, err
	}
	defer rows.Close()
	return id, nil
}
