package promela

import (
	"go/token"

	"git.cs.kent.ac.uk/nd315/gopology/promela/promela_ast"
	"git.cs.kent.ac.uk/nd315/gopology/promela/promela_types"
)

// Generating the processes for a chan struct
// active proctype ClosedChan() {
// 	int val;
// 	bool is_closed = false;
// 	int current_size = 0;
// 	int max_size = 5;

// 	do
// 	:: is_closed ->
// 		if
// 		::	ch.out!0;
// 		::	ch.in?val ->
// 			assert(false)
// 		:: ch.closed?true ->
// 			   assert(false)
// 		fi
// 	:: else ->
// 		if
// 		:: current_size == 0 ->
// 			if
// 			:: ch.in?val ->
// 			 current_size++
// 			:: ch.closed?true ->
// 				is_closed = true
// 			fi
// 		:: current_size > 0 && current_size < max_size ->
// 			if
// 			:: ch.in?val ->
// 			 current_size++
// 			:: ch.out!0 ->
// 			 current_size--
// 			:: ch.closed?true ->
// 				is_closed = true
// 			fi
// 		:: current_size == max_size ->
// 			if
// 			::	ch.out!val ->
// 			 current_size--
// 			:: ch.closed?true ->
// 				is_closed = true
// 			fi
// 		:: current_size > max_size ->
// 			assert(false) // Should never go over the max size
// 		fi
// 	od
// }
// func GenerateChanProcess(chan_struct ChanStruct) *promela_ast.Proctype {
// 	procType := &promela_ast.Proctype{Name: promela_ast.Ident{Name: chan_struct.Name.Name + "_chan"}, Active: true}

// 	procType.Body = generateClosedChan(chan_struct)

// 	return procType
// }

// proctype ch1_closed() {
// 	bool closed = false;

// end:	do
// 			:: true ->
// 				if
// 				:: closed ->
// 					if
// 					:: ch1.closed!closed ->
// 						assert(false)
// 					:: ch1.closed?true ->
// 						assert(false)
// 					fi
// 				:: else ->
// 					if
// 					:: ch1.closed!closed;
// 					:: ch1.closed?true->
// 						closed = true
// 					fi
// 				fi
// 		od
// }

func GenerateChanMonitor() *promela_ast.Proctype {

	procType := &promela_ast.Proctype{Name: promela_ast.Ident{Name: "chanMonitor"}, Active: false}
	procType.Params = []promela_ast.Param{promela_ast.Param{Name: "ch", Types: promela_types.Chandef}}

	closed := &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: "closed"}, Rhs: &promela_ast.Ident{Name: "false"}}

	send_closed := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.sending"}, Rhs: &promela_ast.Ident{Name: "closed"}}
	assert_false := promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "assert"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: "false"}}}
	send_closed_guard := promela_ast.GuardStmt{Cond: &send_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	send_in := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.in"}, Rhs: &promela_ast.Ident{Name: "0"}}
	send_in_guard := promela_ast.GuardStmt{Cond: &send_in, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	send_is_closed := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.is_closed"}, Rhs: &promela_ast.Ident{Name: "closed"}}
	send_is_closed_guard := promela_ast.GuardStmt{Cond: &send_is_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	receive_closed := &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "ch.closing"}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_closed_guard := promela_ast.GuardStmt{Cond: receive_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	if_closed := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{send_closed_guard, receive_closed_guard, send_in_guard, send_is_closed_guard}}
	if_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "closed"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.LabelStmt{Name: "end"}, if_closed}}}

	send_closed1 := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.sending"}, Rhs: &promela_ast.Ident{Name: "closed"}}
	send_closed_guard1 := promela_ast.GuardStmt{Cond: &send_closed1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	receive_closed1 := &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "ch.closing"}, Rhs: &promela_ast.Ident{Name: "true"}}
	assign_closed := promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: "closed"}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_closed_guard1 := promela_ast.GuardStmt{Cond: receive_closed1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assign_closed}}}
	if_not_closed := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{send_closed_guard1, receive_closed_guard1, send_is_closed_guard}}
	if_not_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.LabelStmt{Name: "end1"}, if_not_closed}}}

	if_stmt := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{if_closed_guard, if_not_closed_guard}}
	do_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{if_stmt}}}
	do_stmt := &promela_ast.DoStmt{Guards: []promela_ast.GuardStmt{do_guard}}

	procType.Body = &promela_ast.BlockStmt{List: []promela_ast.Stmt{closed, do_stmt}}
	return procType

}

func generateClosedChan(chan_struct ChanStruct) *promela_ast.BlockStmt {
	closed := &promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: "closed"}, Rhs: &promela_ast.Ident{Name: "false"}}

	send_closed := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".sending"}, Rhs: &promela_ast.Ident{Name: "closed"}}
	assert_false := promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "assert"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: "false"}}}
	send_closed_guard := promela_ast.GuardStmt{Cond: &send_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	send_in := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".in"}, Rhs: &promela_ast.Ident{Name: "0"}}
	send_in_guard := promela_ast.GuardStmt{Cond: &send_in, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	send_is_closed := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".is_closed"}, Rhs: &promela_ast.Ident{Name: "closed"}}
	send_is_closed_guard := promela_ast.GuardStmt{Cond: &send_is_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	receive_closed := &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".closing"}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_closed_guard := promela_ast.GuardStmt{Cond: receive_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	if_closed := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{send_closed_guard, receive_closed_guard, send_in_guard, send_is_closed_guard}}
	if_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "closed"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.LabelStmt{Name: "end"}, if_closed}}}

	send_closed1 := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".sending"}, Rhs: &promela_ast.Ident{Name: "closed"}}
	send_closed_guard1 := promela_ast.GuardStmt{Cond: &send_closed1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	receive_closed1 := &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: chan_struct.Name.Name + ".closing"}, Rhs: &promela_ast.Ident{Name: "true"}}
	assign_closed := promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: "closed"}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_closed_guard1 := promela_ast.GuardStmt{Cond: receive_closed1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assign_closed}}}
	if_not_closed := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{send_closed_guard1, receive_closed_guard1, send_is_closed_guard}}
	if_not_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.LabelStmt{Name: "end1"}, if_not_closed}}}

	if_stmt := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{if_closed_guard, if_not_closed_guard}}
	do_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{if_stmt}}}
	do_stmt := &promela_ast.DoStmt{Guards: []promela_ast.GuardStmt{do_guard}}

	return &promela_ast.BlockStmt{List: []promela_ast.Stmt{closed, do_stmt}}

}

func generateAsyncChan(chan_struct ChanStruct) *promela_ast.BlockStmt {
	chan_size := chan_struct.Size
	current_size := promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "current_size"}, Types: promela_types.Bool, Rhs: &promela_ast.Ident{Name: "0"}}
	max_size := promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "max_size"}, Types: promela_types.Bool, Rhs: &chan_size}
	do_stmt := promela_ast.DoStmt{}
	is_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.SelectorExpr{Sel: promela_ast.Ident{Name: "is_closed"}, X: &chan_struct.Name}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	if_is_closed := promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{}}
	send_out := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "out"}}, Rhs: &promela_ast.Ident{Name: "0,true"}}
	send_out_guard := promela_ast.GuardStmt{Cond: &send_out, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	receive_in := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "in"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	assert_false := promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "assert"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: "false"}}}
	receive_in_guard := promela_ast.GuardStmt{Cond: &receive_in, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	receive_close := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "closed"}}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_close_guard := promela_ast.GuardStmt{Cond: &receive_close, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	if_is_closed.Guards = append(if_is_closed.Guards, send_out_guard, receive_in_guard, receive_close_guard)
	is_closed_guard.Body.List = append(is_closed_guard.Body.List, &promela_ast.LabelStmt{Name: "end1"}, &if_is_closed)

	else_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	if_size := promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{}}

	size_is_zero_guard := promela_ast.GuardStmt{Cond: &promela_ast.BinaryExpr{Lhs: &promela_ast.Ident{Name: "current_size"}, Rhs: &promela_ast.Ident{Name: "0"}, Op: "=="}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	size_is_zero_if := promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{}}
	receive_in1 := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "in"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	send_ack := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "ack"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	size_plus_plus := promela_ast.IncDecStmt{X: &promela_ast.Ident{Name: "current_size"}, Op: "++"}
	receive_in_guard1 := promela_ast.GuardStmt{Cond: &receive_in1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&send_ack, &size_plus_plus}}}
	receive_close1 := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "closed"}}, Rhs: &promela_ast.Ident{Name: "true"}}
	closing := promela_ast.AssignStmt{Lhs: &promela_ast.SelectorExpr{Sel: promela_ast.Ident{Name: "is_closed"}, X: &chan_struct.Name}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_close_guard1 := promela_ast.GuardStmt{Cond: &receive_close1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&closing}}}
	size_is_zero_if.Guards = append(size_is_zero_if.Guards, receive_in_guard1, receive_close_guard1)
	size_is_zero_guard.Body.List = append(size_is_zero_guard.Body.List, &promela_ast.LabelStmt{Name: "end2"}, &size_is_zero_if)

	size_is_bigger_guard := promela_ast.GuardStmt{Cond: &promela_ast.BinaryExpr{
		Lhs: &promela_ast.BinaryExpr{Lhs: &promela_ast.Ident{Name: "current_size"}, Rhs: &promela_ast.Ident{Name: "0"}, Op: ">"},
		Rhs: &promela_ast.BinaryExpr{Lhs: &promela_ast.Ident{Name: "current_size"}, Op: "<", Rhs: &promela_ast.Ident{Name: "max_size"}}, Op: "&&"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	size_is_bigger_if := promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{}}
	receive_in2 := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "in"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	send_ack2 := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "ack"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	size_plus_plus1 := promela_ast.IncDecStmt{X: &promela_ast.Ident{Name: "current_size"}, Op: "++"}
	receive_in_guard2 := promela_ast.GuardStmt{Cond: &receive_in2, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&send_ack2, &size_plus_plus1}}}
	receive_close2 := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "closed"}}, Rhs: &promela_ast.Ident{Name: "true"}}
	send_out1 := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "out"}}, Rhs: &promela_ast.Ident{Name: "0,false"}}
	size_minus_minus := promela_ast.IncDecStmt{X: &promela_ast.Ident{Name: "current_size"}, Op: "--"}
	send_out_guard1 := promela_ast.GuardStmt{Cond: &send_out1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&size_minus_minus}}}
	closing1 := promela_ast.AssignStmt{Lhs: &promela_ast.SelectorExpr{Sel: promela_ast.Ident{Name: "is_closed"}, X: &chan_struct.Name}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_close_guard2 := promela_ast.GuardStmt{Cond: &receive_close2, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&closing1}}}
	size_is_bigger_if.Guards = append(size_is_bigger_if.Guards, receive_in_guard2, send_out_guard1, receive_close_guard2)
	size_is_bigger_guard.Body.List = append(size_is_bigger_guard.Body.List, &promela_ast.LabelStmt{Name: "end3"}, &size_is_bigger_if)

	size_is_max_guard := promela_ast.GuardStmt{Cond: &promela_ast.BinaryExpr{Lhs: &promela_ast.Ident{Name: "current_size"}, Rhs: &promela_ast.Ident{Name: "max_size"}, Op: "=="}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	size_is_max_if := promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{}}
	send_out2 := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "out"}}, Rhs: &promela_ast.Ident{Name: "0,false"}}
	size_minus_minus1 := promela_ast.IncDecStmt{X: &promela_ast.Ident{Name: "current_size"}, Op: "--"}
	send_out_guard2 := promela_ast.GuardStmt{Cond: &send_out2, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&size_minus_minus1}}}
	receive_close3 := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "closed"}}, Rhs: &promela_ast.Ident{Name: "true"}}
	closing2 := promela_ast.AssignStmt{Lhs: &promela_ast.SelectorExpr{Sel: promela_ast.Ident{Name: "is_closed"}, X: &chan_struct.Name}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_close_guard3 := promela_ast.GuardStmt{Cond: &receive_close3, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&closing2}}}
	size_is_max_if.Guards = append(size_is_max_if.Guards, send_out_guard2, receive_close_guard3)
	size_is_max_guard.Body.List = append(size_is_max_guard.Body.List, &promela_ast.LabelStmt{Name: "end4"}, &size_is_max_if)

	if_size.Guards = append(if_size.Guards, size_is_zero_guard, size_is_bigger_guard, size_is_max_guard)
	else_guard.Body.List = append(else_guard.Body.List, &if_size)
	do_stmt.Guards = []promela_ast.GuardStmt{is_closed_guard, else_guard}
	block_stmt := &promela_ast.BlockStmt{Block: token.Position{}, List: []promela_ast.Stmt{&current_size, &max_size, &promela_ast.LabelStmt{Name: "end"}, &do_stmt}}
	return block_stmt
}
func generateSyncChan(chan_struct ChanStruct) *promela_ast.BlockStmt {

	do_stmt := promela_ast.DoStmt{}
	is_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.SelectorExpr{Sel: promela_ast.Ident{Name: "is_closed"}, X: &chan_struct.Name}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	if_is_closed := promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{}}
	receive_in := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "in"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	assert_false := promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "assert"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: "false"}}}
	receive_in_guard := promela_ast.GuardStmt{Cond: &receive_in, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	send_out := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "out"}}, Rhs: &promela_ast.Ident{Name: "0,false"}}
	send_out_guard := promela_ast.GuardStmt{Cond: &send_out, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
	receive_close := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "closed"}}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_close_guard := promela_ast.GuardStmt{Cond: &receive_close, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
	if_is_closed.Guards = append(if_is_closed.Guards, receive_in_guard, send_out_guard, receive_close_guard)
	is_closed_guard.Body.List = append(is_closed_guard.Body.List, &promela_ast.LabelStmt{Name: "end1"}, &if_is_closed)

	else_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

	if_size := promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{}}

	receive_in1 := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "in"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	send_out1 := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "out"}}, Rhs: &promela_ast.Ident{Name: "0,true"}}
	send_ack := promela_ast.SendStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "ack"}}, Rhs: &promela_ast.Ident{Name: "0"}}
	receive_in_guard1 := promela_ast.GuardStmt{Cond: &receive_in1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&send_out1, &send_ack}}}

	receive_close1 := promela_ast.RcvStmt{Chan: &promela_ast.SelectorExpr{X: &chan_struct.Name, Sel: promela_ast.Ident{Name: "closed"}}, Rhs: &promela_ast.Ident{Name: "true"}}
	closing := promela_ast.AssignStmt{Lhs: &promela_ast.SelectorExpr{Sel: promela_ast.Ident{Name: "is_closed"}, X: &chan_struct.Name}, Rhs: &promela_ast.Ident{Name: "true"}}
	receive_close_guard1 := promela_ast.GuardStmt{Cond: &receive_close1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&closing}}}
	if_size.Guards = append(if_size.Guards, receive_in_guard1, receive_close_guard1)

	else_guard.Body.List = append(else_guard.Body.List, &promela_ast.LabelStmt{Name: "end2"}, &if_size)
	do_stmt.Guards = append(do_stmt.Guards, is_closed_guard, else_guard)
	block_stmt := &promela_ast.BlockStmt{Block: token.Position{}, List: []promela_ast.Stmt{&promela_ast.LabelStmt{Name: "end"}, &do_stmt}}
	return block_stmt
}
