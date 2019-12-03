package corsmiddleware

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"time"
)

func SetupCors(router *gin.Engine) {
	router.Use(cors.New(cors.Config{
		AllowOrigins:  []string{"http://localhost:8080"},
		AllowMethods:  []string{"GET", "PUT"},
		AllowHeaders:  []string{"Content-Type"},
		ExposeHeaders: []string{"Content-Length"},
		MaxAge:        12 * time.Hour,
	}))
}
