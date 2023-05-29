package promela_ast

// a guard statement is a statement that execute the body only when the Cond is executable
// Guard stmt in promela : (cond) -> body
type GuardStmt interface {
	Stmt
	GetBody() *BlockStmt
}
