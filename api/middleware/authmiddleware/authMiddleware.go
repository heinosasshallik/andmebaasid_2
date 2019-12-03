package authmiddleware

import (
	"errors"
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

	user, err := userservice.GetUserByEmail(email)
	if err != nil {
		return nil, jwt.ErrFailedAuthentication
	}

	if userservice.CredentialsValid(email, password) {
		if !isJuhataja(user) {
			return nil, errors.New("Ainult juhatajad saavad kasutada seda rakendust.")
		}
		log.Println("TEST2")
		return &usermodels.Isik{
			Emeil:       email,
			TootajaInfo: user.TootajaInfo,
		}, nil
	}
	return nil, jwt.ErrFailedAuthentication

}

func isJuhataja(user usermodels.Isik) bool {
	for _, job := range user.TootajaInfo.Ametid {
		if job.AmetID == 1 {
			return true
		}
	}
	return false
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
		Realm:           "juhataja",
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
