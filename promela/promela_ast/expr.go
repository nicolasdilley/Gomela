package promela_ast

// An expression in Promela that returns a value such as (i++, a < b etc)
type Expr interface {
	Stmt
}
