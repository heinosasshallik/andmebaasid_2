package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/config"
	// TODO: Separate controllers into different packages
	Controller "github.com/heinosasshallik/andmebaasid_2/api/controllers"
	"github.com/heinosasshallik/andmebaasid_2/api/db"
)

func main() {
	log.Println("Starting server..")

	config.Init()
	db.Init()

	router := gin.Default()

	v1 := router.Group("/api/v1")
	{
		tasks := v1.Group("/test")
		{
			tasks.GET("/", Controller.GetUsers)
		}
	}

	router.Run(":3000")
}
