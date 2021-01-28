package main

import (
	"context"
	"time"

	"perkeep.org/pkg/types/camtypes"
)

func (h *Handler) GetRecentPermanodes(ctx context.Context, req *RecentRequest) (*RecentResponse, error) {
	h.index.RLock()
	defer h.index.RUnlock()

	ch := make(chan camtypes.RecentPermanode)
	errch := make(chan error, 1)
	before := time.Now()
	if !req.Before.IsZero() {
		before = req.Before
	}
	go func() {
		// TODO(mpl): change index funcs to take signer keyID. dont care for now, just
		// fixing the essential search and describe ones.
		errch <- h.index.GetRecentPermanodes(ctx, ch, h.owner.BlobRef(), req.n(), before)
	}()

	dr := h.NewDescribeRequest()

	var recent []*RecentItem
	for res := range ch {
		dr.StartDescribe(ctx, res.Permanode, 2)
		recent = append(recent, &RecentItem{
			BlobRef: res.Permanode,
			Owner:   res.Signer,
			ModTime: types.Time3339(res.LastModTime),
		})
		testHookBug121() // http://perkeep.org/issue/121
	}

	if err := <-errch; err != nil {
		return nil, err
	}

	metaMap, err := dr.metaMap()
	if err != nil {
		return nil, err
	}

	res := &RecentResponse{
		Recent: recent,
		Meta:   metaMap,
	}
	return res, nil
}
