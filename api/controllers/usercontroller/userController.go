package usercontroller

import (
	"github.com/appleboy/gin-jwt/v2"
	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/services/userservice"
	"log"
	"net/http"
)

func GetUserInfo(c *gin.Context) {
	claims := jwt.ExtractClaims(c)
	email := claims["email"]
	user, err := userservice.GetUserByEmail(email)
	if err != nil {
		log.Println(err)
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, &user)
}
