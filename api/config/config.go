package config

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
)

type databaseConfiguration struct {
	User     string `json:"user"`
	Password string `json:"password"`
	Host     string `json:"host"`
	Port     string `json:"port"`
	Database string `json:"database"`
}

type authConfiguration struct {
	JWTSecret string `json:"jwtSecret"`
}

type configuration struct {
	Database       databaseConfiguration `json:"db"`
	Authentication authConfiguration     `json:"auth"`
}

var conf configuration
var configFile = "config/apex.json"

// Init : Parse the configuration file
func Init() {
	conf = configuration{}
	jsonFile, err := os.Open(configFile)
	if err != nil {
		log.Println(err)
	}
	defer jsonFile.Close()

	// Before unmarshalling we have to convert to byte value
	byteValue, _ := ioutil.ReadAll(jsonFile)

	json.Unmarshal(byteValue, &conf)
}

func GetConfiguration() configuration {
	return conf
}
