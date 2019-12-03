package authmiddleware

import (
	"github.com/appleboy/gin-jwt/v2"
	"github.com/gin-gonic/gin"
	"log"
	"time"

	"github.com/heinosasshallik/andmebaasid_2/api/config"
	"github.com/heinosasshallik/andmebaasid_2/api/models/usermodels"
	"github.com/heinosasshallik/andmebaasid_2/api/services/userservice"
)

type login struct {
	Email    string `form:"email" json:"email" binding:"required"`
	Password string `form:"password" json:"password" binding:"required"`
}

var identityKey = "email"

func mapDataToJwtBody(data interface{}) jwt.MapClaims {
	if v, ok := data.(*usermodels.Isik); ok {
		return jwt.MapClaims{
			identityKey: v.Emeil,
		}
	}
	return jwt.MapClaims{}
}

func extractDataFromJwt(c *gin.Context) interface{} {
	claims := jwt.ExtractClaims(c)
	return &usermodels.Isik{
		Emeil: claims[identityKey].(string),
	}
}

func authenticateLogin(c *gin.Context) (interface{}, error) {
	var loginVals login
	if err := c.ShouldBind(&loginVals); err != nil {
		return "", jwt.ErrMissingLoginValues
	}
	email := loginVals.Email
	password := loginVals.Password

	if !userservice.CredentialsValid(email, password) {
		return nil, jwt.ErrFailedAuthentication
	}
	return &usermodels.Isik{
		Emeil: email,
	}, nil
}

func authorizeAccessToController(data interface{}, c *gin.Context) bool {
	if v, ok := data.(*usermodels.Isik); ok && v.Emeil != "" {
		return true
	}

	return false
}

func unauthorizedResponse(c *gin.Context, code int, message string) {
	c.JSON(code, gin.H{
		"code":    code,
		"message": message,
	})
}

func SetupAuthMiddleware(router *gin.Engine) *jwt.GinJWTMiddleware {
	var config = config.GetConfiguration()
	authMiddleware, err := jwt.New(&jwt.GinJWTMiddleware{
		Realm:           "laudade haldur",
		Key:             []byte(config.Authentication.JWTSecret),
		Timeout:         time.Hour,
		MaxRefresh:      time.Hour,
		IdentityKey:     identityKey,
		PayloadFunc:     mapDataToJwtBody,
		IdentityHandler: extractDataFromJwt,
		Authenticator:   authenticateLogin,
		Authorizator:    authorizeAccessToController,
		Unauthorized:    unauthorizedResponse,
		TokenLookup:     "header: Authorization",
		TokenHeadName:   "Bearer",
		TimeFunc:        time.Now,
	})

	if err != nil {
		log.Fatal("JWT Error:" + err.Error())
	}

	return authMiddleware
}
