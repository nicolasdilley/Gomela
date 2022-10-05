package main

import (
	"fmt"
	"gopkg.in/yaml.v3"
	"io/ioutil"
	"os"
)

var CONFIG_FILE = "./config.yaml" // the location of the config file

type Config struct {
	Go              []string `yaml:"go"`
	Comm_par_values []int    `yaml:"comm_par_values"`
}

func parseConfigFile() Config {
	// Open our yamlFile

	yamlFile, err := os.Open(CONFIG_FILE)
	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
	}

	// defer the closing of our yamlFile so that we can parse it later on
	defer yamlFile.Close()

	byteValue, _ := ioutil.ReadAll(yamlFile)

	var config Config

	yaml.Unmarshal(byteValue, &config)

	fmt.Println(config)

	return config
}