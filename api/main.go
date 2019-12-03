package main

import (
	"github.com/gin-gonic/gin"
	"log"

	"github.com/heinosasshallik/andmebaasid_2/api/config"
	TableController "github.com/heinosasshallik/andmebaasid_2/api/controllers/tablecontroller"
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	AuthMiddleware "github.com/heinosasshallik/andmebaasid_2/api/middleware/authmiddleware"
	CorsMiddleware "github.com/heinosasshallik/andmebaasid_2/api/middleware/corsmiddleware"
)

func main() {
	log.Println("Starting server..")

	config.Init()
	db.Init()

	router := gin.Default()

	CorsMiddleware.SetupCors(router)

	authController := AuthMiddleware.SetupAuthMiddleware(router)

	v1 := router.Group("/api/v1")
	{
		table := v1.Group("/table")
		{
			table.Use(authController.MiddlewareFunc())
			{
				table.GET("/all", TableController.GetAllTables)
				table.GET("/summary", TableController.GetSummaryReport)
				table.GET("/endable", TableController.GetEndableTables)
				table.GET("/details/:id", TableController.GetTableDetailed)
				table.GET("/categories/:id", TableController.GetCategories)
				table.PUT("/end/:id", TableController.EndTable)
			}
		}
		auth := v1.Group("/auth")
		{
			auth.POST("/login", authController.LoginHandler)
			auth.GET("/refresh_token", authController.RefreshHandler)
		}
	}

	router.Run(":3000")
}
