package main

import (
 "fmt"
 "net/http"
 "os"
)

func main() { 
	
	name, err := os.Hostname()
	if err != nil {
		panic(err)
	}

  
 var PORT string
 if PORT = os.Getenv("PORT"); PORT == "" {
  PORT = "80"
 }

 http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Project Agile Talks 2019 - Infraestrutura como código: %s\n", name)
 })
 
 http.ListenAndServe(":" + PORT, nil)
}

