package main

import (
	"os"
	"strings"

	"gopkg.in/src-d/go-git.v4"
	"gopkg.in/src-d/go-git.v4/plumbing"
	"gopkg.in/src-d/go-git.v4/storage/memory"
)

func CloneRepo(url string, commit string) (string, string, error) {

	// var last_commit_hash string

	// Tempdir to clone the repository
	var err error

	dir := PROJECTS_FOLDER + "/" + strings.Replace(url, "/", AUTHOR_PROJECT_SEP, -1)

	_, err1 := os.Stat(dir)

	if os.IsNotExist(err1) {

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
	}

	return dir, commit, err
}

func CloneRepoAndGetCommit(url string) string {
	var err error

	// Clones the repository into the given dir, just as a normal git clone does
	var r *git.Repository
	r, err = git.Clone(memory.NewStorage(), nil, &git.CloneOptions{
		URL:      "https://github.com/" + url,
		Progress: os.Stdout,
	})
	var head *plumbing.Reference

	head, err = r.Head()

	if err != nil {
		panic(err)
	}

	return head.Hash().String()
}
