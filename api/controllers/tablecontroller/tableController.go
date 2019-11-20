package tablecontroller

import (
	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/services/tableservice"
	"net/http"
)

func GetSummaryReport(c *gin.Context) {
	summary := tableservice.GetSummaryReport()
	c.JSON(http.StatusOK, &summary)
}

func GetEndableTables(c *gin.Context) {
	endableTables := tableservice.GetEndableTables()
	c.JSON(http.StatusOK, &endableTables)
}