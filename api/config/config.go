package config

import (
	"log"

	"github.com/tkanos/gonfig"
)

type databaseConfiguration struct {
	user     string
	password string
	host     string
	port     string
	database string
}

type Configuration struct {
	db databaseConfiguration
}

var configuration Configuration

func Init() {
	configuration = Configuration{}
	err := gonfig.GetConf("config/development.json", &configuration)
	if err != nil {
		log.Fatal(err)
	}
}

func GetConfiguration() Configuration {
	return configuration
}
