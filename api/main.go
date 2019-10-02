package main

import (
  "log"
  "github.com/gin-gonic/gin"
  "github.com/heinosasshallik/andmebaasid_2/api/db"
  TaskController "github.com/heinosasshallik/andmebaasid_2/api/controllers"
)

func main() {
  log.Println("Starting server..")

  db.Init();

  r := gin.Default()

  v1 := r.Group("/api/v1")
  {
    
  }

  r.Run()
}
