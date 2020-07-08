package main

import (
	"errors"

	"golang.org/x/crypto/ssh"
)

func ForwardToAgent(client *ssh.Client, keyring Agent) error {
	a := make(chan int)
	channels := client.HandleChannelOpen(channelType)
	if channels == nil {
		return errors.New("Agent: already have handler for " + channelType)
	}

	go func() {
		for ch := range channels {
			channel, reqs, err := ch.Accept()
			if err != nil {
				continue
			}
			go ssh.DiscardRequests(reqs)
			go func() {
				ServeAgent(keyring, channel)
				channel.Close()
			}()
		}
	}()
	return nil
}
