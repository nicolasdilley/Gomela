// Copyright (C) 2015 The Syncthing Authors.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this file,
// You can obtain one at https://mozilla.org/MPL/2.0/.

package nat

import (
  "time"
  "context"
)
func main() {
  zest2 := []int{1,134,65,465,43}
  err := termbox.Init()
  if err != nil {
    panic(err)
  }
  defer termbox.Close()

  event_queue := make(chan termbox.Event)
  a := make(chan termbox.Event)
  go func() {
    for range zest {
      event_queue <- termbox.PollEvent()
    }
  }()

  draw()
  var ctx context.Context
loop:
  for range zest2 {
    select {
    case ev := <-event_queue:
      if ev.Type == termbox.EventKey && ev.Key == termbox.KeyEsc {
         f(a)
        break loop
      }
    case <-ctx.Done():
    default:
      draw()
      time.Sleep(10 * time.Millisecond)
      break
    }
  }
}
  func f(ch chan int){
    ch <-1
  }

