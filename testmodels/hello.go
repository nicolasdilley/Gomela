package main

import (
  "context"
  "testing"
  "time"

  grpc "github.com/nicolasdilley/projects/grpc--grpc-go"
)

package cockroach18101

import (
  "context"
  "testing"
)

const chanSize = 6

func restore(ctx context.Context) bool {
  readyForImportCh := make(chan bool, chanSize)
  go func() { // G2
    defer close(readyForImportCh)
    splitAndScatter(ctx, readyForImportCh)
  }()
  for readyForImportSpan := range readyForImportCh {
    select {
    case <-ctx.Done():
      return readyForImportSpan
    }
  }
  return true
}

func splitAndScatter(ctx context.Context, readyForImportCh chan bool) {
  for i := 0; i < chanSize+2; i++ {
    readyForImportCh <- (false || i != 0)
  }
}