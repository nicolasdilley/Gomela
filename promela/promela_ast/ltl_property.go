package promela_ast

type LTL_property struct {
	Name     string
	Property string
}

func (p *LTL_property) Print(num_tabs int) string {
	return "ltl " + p.Name + " { [](" + p.Property + ")}"
}
