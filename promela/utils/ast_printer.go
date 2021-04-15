package utils

func GetTabs(num_tabs int) (tabs string) {
	for i := 0; i < num_tabs; i++ {
		tabs += "\t"
	}
	return tabs
}
