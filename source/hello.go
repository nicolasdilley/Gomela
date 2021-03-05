// Copyright (C) 2015 The Syncthing Authors.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this file,
// You can obtain one at https://mozilla.org/MPL/2.0/.

package chartserver

import (
	"errors"
	"fmt"
	"strings"
	"sync"
)
func CaptureOutput(block func()) []string {
	oldSTDOUT := os.Stdout
	r, w, err := os.Pipe()
	if err != nil {
		panic(err)
	}

	os.Stdout = w
	defer func() {
		os.Stdout = oldSTDOUT
	}()

	//////
	// We use fmt.Fprintf() to write to the "github.com/fatih/color".Output file
	// to get colors on Windows machines.
	// That variable gets initialized with a reference to os.Stdout when that library is imported.
	// That means that when we muck with os.Stdout above, it doesn't get reflected in
	// the printing code for windows.
	// Instead, we can just redeclare that color.Output variable with a colorable version of our
	// redirect pipe.
	if runtime.GOOS == "windows" {
		color.Output = colorable.NewColorable(w)
	}
	//////

	doneWriting := make(chan bool)
	result := make(chan []string)

	go captureOutputAsyncronously(doneWriting, result, r)
	go a(doneWriting)
	block()
	w.Close()
	doneWriting <- true
	return <-result
}

/*
 The reason we're doing is that you can't write an infinite amount of bytes into a pipe.
 On some platforms, the limit is fairly high; on other platforms, the limit is infuriatingly small
 (looking at you, Windows). To counteract this, we need to read in a goroutine from one end of
 the pipe and return the result across a channel.
*/
func captureOutputAsyncronously(doneWriting <-chan bool, result chan<- []string, reader io.Reader) {
	var readingString string

	for {
		var buf bytes.Buffer
		io.Copy(&buf, reader)
		readingString += buf.String()

		_, ok := <-doneWriting
		if ok {
			// there is no guarantee that the writer did not
			// write more in between the read above and reading from this channel
			// so we absolute must read once more if we want all the bytes
			var buf bytes.Buffer
			io.Copy(&buf, reader)
			readingString += buf.String()
			break
		}
	}

	result <- strings.Split(readingString, "\n")
}

func a(ch chan int){
	if !ok {
		close(ch)
	}
}
