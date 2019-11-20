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

func GetAllTables(c *gin.Context) {
	tables := tableservice.GetAllTables()
	c.JSON(http.StatusOK, &tables)
}

func GetAllTablesDetailed(c *gin.Context) {
	tables := tableservice.GetAllTablesDetailed()
	c.JSON(http.StatusOK, &tables)
}

func GetCategories(c *gin.Context) {
	categories := tableservice.GetCategories()
	c.JSON(http.StatusOK, &categories)
}
