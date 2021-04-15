package promela

import (
	"go/token"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
)

type ChanStruct struct {
	Name   *promela_ast.Ident
	Chan   token.Position
	Chans  []*promela_ast.Chandef // the chans of the struct (in,out and closed)
	Closed bool                   // Does the channel get closed at some point ?

	Size     promela_ast.Ident
	Buffered bool
}

type WaitGroupStruct struct {
	Name  *promela_ast.Ident
	Wait  token.Position
	Chans []*promela_ast.Chandef // the chans of the struct (add,done and wait)

	Counter int // The size of the counter
}

type MutexStruct struct {
	Name  *promela_ast.Ident
	Mutex token.Position
	Chans []*promela_ast.Chandef // the chans of the struct (add,done and wait)
}
