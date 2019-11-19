package main

import (
	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/config"
	Controller "github.com/heinosasshallik/andmebaasid_2/api/controllers"
	TableController "github.com/heinosasshallik/andmebaasid_2/api/controllers/tablecontroller"
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	"log"
)

func main() {
	log.Println("Starting server..")

	config.Init()
	db.Init()

	router := gin.Default()

	v1 := router.Group("/api/v1")
	{
		table := v1.Group("/table")
		{
			table.GET("/summary", TableController.GetSummaryReport)
		}
		tasks := v1.Group("/test")
		{
			tasks.GET("/", Controller.GetUsers)
		}
	}

	router.Run(":3000")
}
