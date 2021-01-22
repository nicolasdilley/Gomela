package main

import (
	"io/ioutil"
	"os"

	"github.com/go-git/go-git"
	"github.com/go-git/go-git/plumbing"
)

// clone a repo and return its path
func CloneRepo(url string, commit string) (string, string, error) {

	// var last_commit_hash string

	// Tempdir to clone the repository
	dir, err := ioutil.TempDir("", "clone-example")

	// Clones the repository into the given dir, just as a normal git clone does
	var r *git.Repository
	r, err = git.PlainClone(dir, false, &git.CloneOptions{
		URL:      "https://github.com/" + url,
		Progress: os.Stdout,
	})
	// var head *plumbing.Reference

	// head, err = r.Head()

	var w *git.Worktree
	w, err = r.Worktree()
	// if head != nil {
	// 	var cIter object.CommitIter
	// 	cIter, err = r.Log(&git.LogOptions{From: head.Hash()})
	// 	commits := []*object.Commit{}
	// 	err = cIter.ForEach(func(c *object.Commit) error {
	// 		commits = append(commits, c)
	// 		return nil
	// 	})

	// 	last_commit_hash = fmt.Sprintf("%s", commits[0].Hash)
	// }

	err = w.Checkout(&git.CheckoutOptions{
		Hash: plumbing.NewHash(commit),
	})

	return dir, commit, err
}
