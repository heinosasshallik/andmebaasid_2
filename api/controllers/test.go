package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/services"
	"net/http"
)

func GetUsers(c *gin.Context) {
	users := services.GetUsers()
	c.JSON(http.StatusOK, &users)
}
