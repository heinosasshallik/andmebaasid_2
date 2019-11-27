package main

import (
	"github.com/appleboy/gin-jwt/v2"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"log"
	"time"

	"github.com/heinosasshallik/andmebaasid_2/api/config"
	TableController "github.com/heinosasshallik/andmebaasid_2/api/controllers/tablecontroller"
	"github.com/heinosasshallik/andmebaasid_2/api/db"
	"github.com/heinosasshallik/andmebaasid_2/api/models/usermodels"
)

type login struct {
	Email    string `form:"email" json:"email" binding:"required"`
	Password string `form:"password" json:"password" binding:"required"`
}

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

	// the jwt middleware
	var identityKey = "email"
	authMiddleware, err := jwt.New(&jwt.GinJWTMiddleware{
		Realm:       "test zone",
		Key:         []byte("secret key"),
		Timeout:     time.Hour,
		MaxRefresh:  time.Hour,
		IdentityKey: identityKey,
		PayloadFunc: func(data interface{}) jwt.MapClaims {
			if v, ok := data.(*usermodels.Isik); ok {
				return jwt.MapClaims{
					identityKey: v.Emeil,
				}
			}
			return jwt.MapClaims{}
		},
		IdentityHandler: func(c *gin.Context) interface{} {
			claims := jwt.ExtractClaims(c)
			return &usermodels.Isik{
				Emeil: claims[identityKey].(string),
			}
		},
		Authenticator: func(c *gin.Context) (interface{}, error) {
			var loginVals login
			if err := c.ShouldBind(&loginVals); err != nil {
				return "", jwt.ErrMissingLoginValues
			}
			email := loginVals.Email
			password := loginVals.Password

			if (email == "admin" && password == "admin") || (email == "test" && password == "test") {
				return &usermodels.Isik{
					Emeil: email,
				}, nil
			}

			return nil, jwt.ErrFailedAuthentication
		},
		Authorizator: func(data interface{}, c *gin.Context) bool {
			if v, ok := data.(*usermodels.Isik); ok && v.Emeil == "admin" {
				return true
			}

			return false
		},
		Unauthorized: func(c *gin.Context, code int, message string) {
			c.JSON(code, gin.H{
				"code":    code,
				"message": message,
			})
		},
		// TokenLookup is a string in the form of "<source>:<name>" that is used
		// to extract token from the request.
		// Optional. Default value "header:Authorization".
		// Possible values:
		// - "header:<name>"
		// - "query:<name>"
		// - "cookie:<name>"
		// - "param:<name>"
		TokenLookup: "header: Authorization",
		// TokenLookup: "query:token",
		// TokenLookup: "cookie:token",

		// TokenHeadName is a string in the header. Default value is "Bearer"
		TokenHeadName: "Bearer",

		// TimeFunc provides the current time. You can override it to use another time value. This is useful for testing or if your server uses a different time zone than your tokens.
		TimeFunc: time.Now,
	})

	if err != nil {
		log.Fatal("JWT Error:" + err.Error())
	}

	v1 := router.Group("/api/v1")
	{
		table := v1.Group("/table")
		{
			table.Use(authMiddleware.MiddlewareFunc())
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
			auth.POST("/login", authMiddleware.LoginHandler)
			auth.GET("/refresh_token", authMiddleware.RefreshHandler)
		}
	}

	router.Run(":3000")
}
