package main

import (
	"fmt"
	"log"
	"path/filepath"
	"strings"
	"sync"
)

func (c *LintCmd) Execute(args []string) error {
	if len(c.Args.Paths) == 0 {
		c.Args.Paths = []string{"."}
	}

	issuec := make(chan string)
	quitc := make(chan struct{})
	go func() {
		for {
			select {
			case issue := <-issuec:
				colorable.Println(issue)
			case <-quitc:
				return
			}
		}
	}()

	lrepo, lrepoErr := OpenLocalRepo()
	if lrepoErr != nil {
		log.Printf("warning: while opening current dir's repo: %s", lrepoErr)
	}

	var wg sync.WaitGroup
	for _, path := range c.Args.Paths {
		w := fs.Walk(path)
		for w.Step() {
			if err := w.Err(); err != nil {
				return err
			}
			if fi := w.Stat(); fi.Mode().IsRegular() {
				suffix, typ := buildstore.DataType(fi.Name())
				if suffix != "" {
					absPath, err := filepath.Abs(w.Path())
					if err != nil {
						return err
					}

					var unitType, unitName string
					if !c.NoCheckResolve {
						if !strings.Contains(absPath, buildstore.BuildDataDirName) {
							return fmt.Errorf("couldn't infer which source unit %s corresponds to, because its absolute path is not under any %s dir; either run with --no-check-resolve to skip checking that internal refs resolve to valid defs (which requires knowing what source unit each output file is from), or run 'srclib lint' against .srclib-cache or subdirectories of it", w.Path(), buildstore.BuildDataDirName)
						}
						unitType = strings.TrimSuffix(fi.Name(), "."+suffix+".json")
						// Infer source unit name from file path (the
						// path components after .srclib-cache until
						// the basename).
						pcs := strings.Split(absPath, string(filepath.Separator))
						for i, pc := range pcs {
							if pc == buildstore.BuildDataDirName && len(pcs) > i+2 {
								unitName = filepath.ToSlash(filepath.Join(pcs[i+2 : len(pcs)-1]...))
								break
							}
						}
					}

					var commitID string
					if !c.NoCheckFiles {
						// Infer commit ID from file path (the path component after .srclib-cache).
						pcs := strings.Split(absPath, string(filepath.Separator))
						for i, pc := range pcs {
							if pc == buildstore.BuildDataDirName && len(pcs) > i+1 {
								commitID = pcs[i+1]
								break
							}
						}
					}
					if commitID == "" && !c.NoCheckFiles {
						return fmt.Errorf("couldn't infer which commit ID %s was built from, which is necessary to check that file/dir fields refer to actual files; either run with --no-check-files to skip the file/dir check or pass paths that contain '.../.srclib-cache/COMMITID/...' (which allows this command to infer the commit ID)", w.Path())
					}

					// Ensure that commitID matches the local repo's commit ID.
					if commitID != "" && !c.NoCheckFiles {
						if lrepo != nil && lrepo.CommitID != commitID {
							return fmt.Errorf("%s was built from commit %s, but the current repo working tree HEAD is commit %s; these must be the same to check that file/dir fields refer to actual files in the repo that their specific commit, so you must either (1) only run lint against build data files for commit %s; (2) run with --no-check-files to skip the file/dir check; or (3) check out commit %s in this repo", w.Path(), commitID, lrepo.CommitID, lrepo.CommitID, commitID)
						}
					}

					checkFilesExist := !c.NoCheckFiles

					wg.Add(1)
					go func(path string) {
						defer wg.Done()

						var issues []string
						var err error
						switch typ.(type) {
						case unit.SourceUnit:
							issues, err = lintSourceUnit(lrepo.RootDir, path, checkFilesExist)
						case *graph.Output:
							issues, err = lintGraphOutput(lrepo.RootDir, c.Repo, unitType, unitName, path, checkFilesExist)
						case []*dep.ResolvedDep:
							issues, err = lintDepresolveOutput(lrepo.RootDir, path, checkFilesExist)
						}
						for _, issue := range prependLabelToStrings(path, issues) {
							issuec <- issue
						}
						if err != nil {
							log.Fatalf(colorable.Redbg("ERR")+" %s: %s", path, err)
						}
					}(w.Path())
				}
			}
		}
	}

	wg.Wait()
	close(quitc)

	return nil
}
