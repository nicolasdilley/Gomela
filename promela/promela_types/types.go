package promela_types

type Types struct {
	Name string
}

var (
	Bool    Types = Types{Name: "bool"}
	Int     Types = Types{Name: "int"}
	Chandef Types = Types{Name: "Chandef"}
	Chan    Types = Types{Name: "chan"}
)
