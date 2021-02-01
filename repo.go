package main

import (
	"os"
	"strings"

	"github.com/go-git/go-git"
	"github.com/go-git/go-git/plumbing"
)

func CloneRepo(url string, commit string) (string, string, error) {

	// var last_commit_hash string

	// Tempdir to clone the repository

	var err error

	dir := "projects/" + strings.Replace(url, "/", "&", -1)
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

	err = w.Checkout(&git.CheckoutOptions{
		Hash: plumbing.NewHash(commit),
	})

	return dir, commit, err
}
