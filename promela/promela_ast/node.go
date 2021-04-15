package promela_ast

import "go/token"

// node represent all the node in the ast tree
// a node as a line number, a filename
type Node interface {
	GoNode() token.Position // The go node to which this promela node refers to
	Print(tabs int) string
	Clone() Stmt
}
