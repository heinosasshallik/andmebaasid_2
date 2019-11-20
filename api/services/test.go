package services

import (
	"fmt"
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	"github.com/heinosasshallik/andmebaasid_2/api/models"
	"log"
)

func GetUsers() []models.Isik {
	var users []models.Isik
	db := db.GetDB()
	rows, err := db.Query("SELECT isik_id FROM isik;")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var user models.Isik
		if err := rows.Scan(&user.Isik_id); err != nil {
			log.Fatal(err)
		}
		users = append(users, user)
	}
	fmt.Println(users)
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
	return users
}