package db

import (
	"os"
    "fmt"
    "log"
  _ "github.com/lib/pq"
    "github.com/jinzhu/gorm"
  _ "github.com/jinzhu/gorm/dialects/postgres"
    "github.com/heinosasshallik/andmebaasid_2/api/models"
)

var db *gorm.DB
var err error

func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}

// Init creates a connection to postgres database and 
// migrates any new models
func Init() {
	user := "postgres"
	password := "postgres"
	host := "127.0.0.1"
	port := "5432"
	database := "tasks"

  dbinfo := fmt.Sprintf("user=%s password=%s host=%s port=%s dbname=%s sslmode=disable",
    user,
    password,
    host,
    port,
    database,
  )

  db, err = gorm.Open("postgres", dbinfo)
  if err != nil {
    log.Println("Failed to connect to database")
    panic(err)
  }
  log.Println("Database connected")

  if !db.HasTable(&models.Task{}) {
    err := db.CreateTable(&models.Task{})
    if err != nil {
      log.Println("Table already exists")
    }
  }

  db.AutoMigrate(&models.Task{})
}

//GetDB ...
func GetDB() *gorm.DB {
  return db
}

func CloseDB() {
  db.Close()
}
