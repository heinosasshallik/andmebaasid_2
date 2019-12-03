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

func getUserInfo(email string) (usermodels.Isik, error) {
	db := db.GetDB()
	var user usermodels.Isik
	row := db.QueryRow(`
		select
			isik_id,
			isikukood,
			riik_kood,
			e_meil,
			isiku_nimi
		from
			isiku_info
		where
			e_meil = $1`, email)
	err := row.Scan(
		&user.IsikID,
		&user.Isikukood,
		&user.RiikKood,
		&user.Emeil,
		&user.Nimi,
	)
	return user, err
}

func getWorkerInfo(userID int) (usermodels.Tootaja, error) {
	db := db.GetDB()
	var worker usermodels.Tootaja
	row := db.QueryRow(`
		select
			mentor_id,
			staatus
		from
			tootaja_info
		where
			isik_id = $1`, userID)
	err := row.Scan(
		&worker.MentorID,
		&worker.Staatus,
	)
	if err != nil && err != sql.ErrNoRows {
		return worker, err
	}

	return worker, nil
}

func getProfessions(userID int) ([]usermodels.Amet, error) {
	db := db.GetDB()
	var professions []usermodels.Amet
	rows, err := db.Query(`
		select
			amet_kood,
			nimetus
		from
			tootaja_ametid
		where
			isik_id = $1`, userID)

	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var row usermodels.Amet
		if err := rows.Scan(&row.AmetID, &row.Amet); err != nil {
			return nil, err
		}
		professions = append(professions, row)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return professions, nil
}

func GetUserByEmail(email string) (usermodels.Isik, error) {
	user, err := getUserInfo(email)
	if err != nil {
		return user, err
	}
	worker, err := getWorkerInfo(user.IsikID)
	if err != nil {
		return user, err
	}
	professions, err := getProfessions(user.IsikID)
	if err != nil {
		return user, err
	}
	worker.Ametid = professions
	user.TootajaInfo = worker
	return user, nil
}
