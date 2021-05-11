package promela

import (
    "go/ast"
    "unicode"
)

type Names []ast.Expr

func (s Names) Len() int      { return len(s) }
func (s Names) Swap(i, j int) { s[i], s[j] = s[j], s[i] }

func (s Names) Less(i, j int) bool {

    first := translateIdent(s[i]).Name
    second := translateIdent(s[j]).Name

    iRunes := []rune(first)
    jRunes := []rune(second)

    max := len(iRunes)
    if max > len(jRunes) {
        max = len(jRunes)
    }

    for idx := 0; idx < max; idx++ {
        ir := iRunes[idx]
        jr := jRunes[idx]

        lir := unicode.ToLower(ir)
        ljr := unicode.ToLower(jr)

        if lir != ljr {
            return lir < ljr
        }

        // the lowercase runes are the same, so compare the original
        if ir != jr {
            return ir < jr
        }
    }

    // If the strings are the same up to the length of the shortest string,
    // the shorter string comes first
    return len(iRunes) < len(jRunes)
}
