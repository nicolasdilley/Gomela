package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

var CONFIG_FILE = "./config.json" // the location of the config file

type Config struct {
	Goroutines         []string `json:"goroutines"`
	comm_params_values []int    `json:"comm_param_values"`
}

func parseConfigFile() {
	// Open our jsonFile

	jsonFile, err := os.Open(CONFIG_FILE)
	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
	}

	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	var config Config

	json.Unmarshal(byteValue, &config)

	fmt.Println(config.Goroutines)
}