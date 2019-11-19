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
