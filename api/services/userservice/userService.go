package userservice

import (
	"database/sql"
	"log"

	"github.com/heinosasshallik/andmebaasid_2/api/db"
	"github.com/heinosasshallik/andmebaasid_2/api/models/usermodels"
)

func CredentialsValid(email string, password string) bool {
	var result bool
	db := db.GetDB()
	row := db.QueryRow("select f_on_tootaja($1, $2)", email, password)
	err := row.Scan(&result)
	if err != nil {
		log.Println(err)
		return false
	}
	return result
}

func GetWorkerInfo(email string) (usermodels.Tootaja, error) {
	db := db.GetDB()
	var worker usermodels.Tootaja
	row := db.QueryRow(`
		select
			isik_id,
			isikukood,
			riik_kood,
			e_meil,
			isiku_nimi,
			mentor_id,
			tootaja_staatus,
			amet_kood,
			amet_nimetus
		from
			tootajate_detailid
		where
			e_meil = $1`, email)
	err := row.Scan(
		&worker.IsikID,
		&worker.Isikukood,
		&worker.RiikKood,
		&worker.Emeil,
		&worker.Nimi,
		&worker.MentorID,
		&worker.Staatus,
		&worker.AmetID,
		&worker.Amet,
	)
	if err != nil && err != sql.ErrNoRows {
		return worker, err
	}

	return worker, nil
}
