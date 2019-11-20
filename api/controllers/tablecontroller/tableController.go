package tablecontroller

import (
	"github.com/gin-gonic/gin"
	"github.com/heinosasshallik/andmebaasid_2/api/services/tableservice"
	"log"
	"net/http"
	"strconv"
)

func GetSummaryReport(c *gin.Context) {
	summary, err := tableservice.GetSummaryReport()
	if err != nil {
		log.Println(err)
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, &summary)
}

func GetEndableTables(c *gin.Context) {
	endableTables, err := tableservice.GetEndableTables()
	if err != nil {
		log.Println(err)
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, &endableTables)
}

func GetAllTables(c *gin.Context) {
	tables, err := tableservice.GetAllTables()
	if err != nil {
		log.Println(err)
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, &tables)
}

func GetAllTablesDetailed(c *gin.Context) {
	tables, err := tableservice.GetAllTablesDetailed()
	if err != nil {
		log.Println(err)
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, &tables)
}

func GetCategories(c *gin.Context) {
	categories, err := tableservice.GetCategories()
	if err != nil {
		log.Println(err)
		c.AbortWithStatus(http.StatusInternalServerError)
		return
	}
	c.JSON(http.StatusOK, &categories)
}

func EndTable(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err == nil {
		c.AbortWithStatus(http.StatusBadRequest)
		return
	}
	categories := tableservice.EndTable(id)
	c.JSON(http.StatusOK, &categories)
}
