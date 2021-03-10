package main

// cacheReader will split the stream of a reader to be cached at the same time it is read by the original source
func (f *Fs) cacheReader(u io.Reader, src fs.ObjectInfo, originalRead func(inn io.Reader)) {
  // create the pipe and tee reader
  pr, pw := io.Pipe()
  tr := io.TeeReader(u, pw)

  // create channel to synchronize
  done := make(chan bool)
  defer close(done)

  go func() {
    // notify the cache reader that we're complete after the source FS finishes
    defer func() {
      done <- true

    }()
  }()

  go func() {

    // signal complete
    done <- true
  }()

  // wait until both are done
  for c := 0; c < 2; c++ {
    <-done
  }
}
