package main

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/config"
	Controller "github.com/heinosasshallik/andmebaasid_2/api/controllers"
	TableController "github.com/heinosasshallik/andmebaasid_2/api/controllers/tablecontroller"
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	"log"
	"time"
)

func main() {
	log.Println("Starting server..")

	config.Init()
	db.Init()

	router := gin.Default()
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:8080"},
		AllowMethods:     []string{"GET", "PUT"},
		AllowHeaders:     []string{"Content-Type"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		AllowOriginFunc: func(origin string) bool {
			return origin == "https://github.com"
		},
		MaxAge: 12 * time.Hour,
	}))

	v1 := router.Group("/api/v1")
	{
		table := v1.Group("/table")
		{
			table.GET("/summary", TableController.GetSummaryReport)
			table.GET("/endable", TableController.GetEndableTables)
			table.GET("/all", TableController.GetAllTables)
			table.GET("/details", TableController.GetAllTablesDetailed)
			table.GET("/categories", TableController.GetCategories)
			table.PUT("/:id/end", TableController.EndTable)
		}
		tasks := v1.Group("/test")
		{
			tasks.GET("/", Controller.GetUsers)
		}
	}

	router.Run(":3000")
}
