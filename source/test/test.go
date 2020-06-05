package main

import "sync"

type Test struct {
	wg sync.WaitGroup
}

func main() {

	if err := (db.Event{
		ProjectID:   &project.ID,
		ObjectType:  &objType,
		ObjectID:    &insertIDInt,
		Description: &desc,
	}.Insert()); err != nil {
		panic(err)
	}

}
