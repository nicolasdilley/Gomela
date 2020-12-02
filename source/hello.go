package main

import (
	"context"
	"errors"
	"fmt"
	"sync"

	"github.com/perkeep/perkeep/pkg/blob"
	"github.com/perkeep/perkeep/pkg/blobserver"
)

// StatBlobs on all BlobStatter reads sequentially, returning the first error.
func (sto *unionStorage) StatBlobs(ctx context.Context, blobs []blob.Ref, f func(blob.SizedRef) error) error {
	if err := ctx.Err(); err != nil {
		return err
	}
	// need to dedup the blobs
	maybeDup := make(chan blob.SizedRef)
	errCh := make(chan error, 1)
	var wg sync.WaitGroup
	var any bool
	for _, s := range sto.subsets {
		if bs, ok := s.(blobserver.BlobStatter); ok {
			any = true
			wg.Add(1)
			go func() {
				defer wg.Done()
				if err := bs.StatBlobs(ctx, blobs, func(sr blob.SizedRef) error {
					maybeDup <- sr
					return nil
				}); err != nil {
					errCh <- err
				}
			}()
		}
	}
	if !any {
		return errors.New("union: No BlobStatter reader configured")
	}

	var closeChanOnce sync.Once
	go func() {
		wg.Wait()
		closeChanOnce.Do(func() { close(maybeDup) })
	}()

	seen := make(map[blob.Ref]struct{}, len(blobs))
	for {
		select {
		case errCh <- 0:
			fmt.Println("2")
		case <-errCh:
			closeChanOnce.Do(func() { close(maybeDup) })
			return err
		case sr, ok := <-maybeDup:
			if !ok {
				return nil
			}
			if _, ok = seen[sr.Ref]; !ok {
				seen[sr.Ref] = struct{}{}
				if err := f(sr); err != nil {
					return err
				}
			}
		}
	}
}
