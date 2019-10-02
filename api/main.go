package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/config"
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	//TaskController "github.com/heinosasshallik/andmebaasid_2/api/controllers"
)

func main() {
	log.Println("Starting server..")

	config.Init()
	db.Init()

	router := gin.Default()

	/*v1 := r.Group("/api/v1")
	{

	}*/

	router.Run(":3000")
}
