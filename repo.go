package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"gopkg.in/src-d/go-git.v4"
	"gopkg.in/src-d/go-git.v4/plumbing/object"
)

// clone a repo and return its path
func CloneRepo(url string) (string, string) {

	var last_commit_hash string
	// Tempdir to clone the repository
	dir, err := ioutil.TempDir("", "clone-example")
	if err != nil {
		log.Fatal(err)
	}

	// Clones the repository into the given dir, just as a normal git clone does
	r, err := git.PlainClone(dir, false, &git.CloneOptions{
		URL:      "https://github.com/" + url,
		Progress: os.Stdout,
	})
	head, err := r.Head()
	if head != nil {
		cIter, err := r.Log(&git.LogOptions{From: head.Hash()})
		commits := []*object.Commit{}
		err = cIter.ForEach(func(c *object.Commit) error {
			commits = append(commits, c)
			return nil
		})

		last_commit_hash = fmt.Sprintf("%s", commits[0].Hash)
		if err != nil {
			log.Fatal(err)
		}
	}

	return dir, last_commit_hash
}
