package db

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

var db *sql.DB
var err error

// Init creates a connection to postgres database and
// migrates any new models
func Init() {
	user := "postgres"
	password := "postgres"
	host := "127.0.0.1"
	port := "5432"
	database := "andmebaasid"

	dbinfo := fmt.Sprintf("user=%s password=%s host=%s port=%s dbname=%s sslmode=disable",
		user,
		password,
		host,
		port,
		database,
	)

	db, err = sql.Open("postgres", dbinfo)
	if err != nil {
		log.Fatal("Error: The data source arguments are not valid")
	}

	err = db.Ping()
	if err != nil {
		log.Fatal("Error: Could not establish a connection with the database")
	}

}

func GetDB() *sql.DB {
	return db
}

func CloseDB() {
	db.Close()
}
