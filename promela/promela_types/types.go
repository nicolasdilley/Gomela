package promela_types

type Types struct {
	Name string
}

var (
	Bool     Types = Types{Name: "bool"}
	Int      Types = Types{Name: "int"}
	Chandef  Types = Types{Name: "Chandef"}
	Wgdef    Types = Types{Name: "Wgdef"}
	Mutexdef Types = Types{Name: "Mutexdef"}
	Chan     Types = Types{Name: "chan"}
)
