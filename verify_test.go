package main

import (
	"testing"
)

func TestIsSuperSeededBy(t *testing.T) {
	result := isSuperSeededBy([]interface{}{1, 2, 3}, [][]interface{}{[]interface{}{-2, 2, 3}})

	if !result {
		t.Errorf("result was incorrect, got: %t, want: %t.", result, true)
	}

	result2 := isSuperSeededBy([]interface{}{1, 3, 3}, [][]interface{}{[]interface{}{-2, 2, 3}})

	if result2 {
		t.Errorf("result was incorrect, got: %t, want: %t.", result2, false)
	}
	result3 := isSuperSeededBy([]interface{}{1, 3, 3}, [][]interface{}{[]interface{}{-2, 2, 3}, []interface{}{-2, -2, 3}})

	if !result3 {
		t.Errorf("result was incorrect, got: %t, want: %t.", result3, true)
	}
	result4 := isSuperSeededBy([]interface{}{1, 3, 2}, [][]interface{}{[]interface{}{-2, 2, 3}, []interface{}{-2, -2, 3}})

	if result4 {
		t.Errorf("result was incorrect, got: %t, want: %t.", result4, false)
	}
}
