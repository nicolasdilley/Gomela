package main

import (
	"encoding/json"
	"io"
	"net/http"
	"time"

	"k8s.io/apimachinery/pkg/util/runtime"
)

func createStreams(req *http.Request, w http.ResponseWriter, opts *Options, supportedStreamProtocols []string, idleTimeout, streamCreationTimeout time.Duration) (*context, bool) {
	var ctx *context
	var ok bool
	if wsstream.IsWebSocketRequest(req) {
		ctx, ok = createWebSocketStreams(req, w, opts, idleTimeout)
	} else {
		ctx, ok = createHTTPStreamStreams(req, w, opts, supportedStreamProtocols, idleTimeout, streamCreationTimeout)
	}
	if !ok {
		return nil, false
	}

	if ctx.resizeStream != nil {
		ctx.resizeChan = make(chan remotecommand.TerminalSize)
		go handleResizeEvents(ctx.resizeStream, ctx.resizeChan)
	}

	return ctx, true
}

func handleResizeEvents(stream io.Reader, channel chan<- remotecommand.TerminalSize) {
	defer runtime.HandleCrash()
	defer close(channel)

	decoder := json.NewDecoder(stream)
	for {
		size := remotecommand.TerminalSize{}
		if err := decoder.Decode(&size); err != nil {
			break
		}
		channel <- size
	}
}
