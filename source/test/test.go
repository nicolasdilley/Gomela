package main

import (
	"fmt"
	"strings"
)

func (e *ServiceRouterConfigEntry) Normalize() error {
	if e == nil {
		return fmt.Errorf("config entry is nil")
	}

	e.Kind = ServiceRouter

	e.EnterpriseMeta.Normalize()

	for _, route := range e.Routes {
		if route.Match == nil || route.Match.HTTP == nil {
			continue
		}

		httpMatch := route.Match.HTTP
		if len(httpMatch.Methods) == 0 {
			continue
		}

		for j := 0; j < len(httpMatch.Methods); j++ {
			httpMatch.Methods[j] = strings.ToUpper(httpMatch.Methods[j])
		}
		if route.Destination != nil && route.Destination.Namespace == "" {
			route.Destination.Namespace = e.EnterpriseMeta.NamespaceOrDefault()
		}
	}

	return nil
}
