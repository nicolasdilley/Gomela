package promela

// // Return the Promela AST of a chan monitor proctype
// func GenerateSyncChanMonitor() *promela_ast.Proctype {

// 	procType := &promela_ast.Proctype{Name: promela_ast.Ident{Name: "sync_monitor"}, Active: false}
// 	procType.Params = []promela_ast.Param{promela_ast.Param{Name: "ch", Types: promela_types.Chandef}}

// 	closed := &promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "state"}, Types: promela_types.Bool, Rhs: &promela_ast.Ident{Name: "false"}}

// 	send_closed := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.sending"}, Rhs: &promela_ast.Ident{Name: "state"}}
// 	assert_false := promela_ast.CallExpr{Fun: promela_ast.Ident{Name: "assert"}, Args: []promela_ast.Expr{&promela_ast.Ident{Name: "false"}}}
// 	send_closed_guard := promela_ast.GuardStmt{Cond: &send_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
// 	send_in := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.in"}, Rhs: &promela_ast.Ident{Name: "0"}}
// 	send_in_guard := promela_ast.GuardStmt{Cond: &send_in, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}

// 	send_is_closed := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.is_closed"}, Rhs: &promela_ast.Ident{Name: "state"}}
// 	send_is_closed_guard := promela_ast.GuardStmt{Cond: &send_is_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
// 	receive_closed := &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "ch.closing"}, Rhs: &promela_ast.Ident{Name: "true"}}
// 	receive_closed_guard := promela_ast.GuardStmt{Cond: receive_closed, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assert_false}}}
// 	if_closed := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{send_closed_guard, receive_closed_guard, send_in_guard, send_is_closed_guard}}
// 	if_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "state"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.LabelStmt{Name: "end"}, if_closed}}}

// 	send_closed1 := promela_ast.SendStmt{Chan: &promela_ast.Ident{Name: "ch.sending"}, Rhs: &promela_ast.Ident{Name: "state"}}
// 	send_closed_guard1 := promela_ast.GuardStmt{Cond: &send_closed1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{}}}
// 	receive_closed1 := &promela_ast.RcvStmt{Chan: &promela_ast.Ident{Name: "ch.closing"}, Rhs: &promela_ast.Ident{Name: "true"}}
// 	assign_closed := promela_ast.AssignStmt{Lhs: &promela_ast.Ident{Name: "state"}, Rhs: &promela_ast.Ident{Name: "true"}}
// 	receive_closed_guard1 := promela_ast.GuardStmt{Cond: receive_closed1, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&assign_closed}}}
// 	if_not_closed := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{send_closed_guard1, receive_closed_guard1, send_is_closed_guard}}
// 	if_not_closed_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "else"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{&promela_ast.LabelStmt{Name: "end1"}, if_not_closed}}}

// 	if_stmt := &promela_ast.CondStmt{Guards: []promela_ast.GuardStmt{if_closed_guard, if_not_closed_guard}}
// 	do_guard := promela_ast.GuardStmt{Cond: &promela_ast.Ident{Name: "true"}, Body: &promela_ast.BlockStmt{List: []promela_ast.Stmt{if_stmt}}}
// 	do_stmt := &promela_ast.DoStmt{Guards: []promela_ast.GuardStmt{do_guard}}

// 	procType.Body = &promela_ast.BlockStmt{List: []promela_ast.Stmt{closed, do_stmt}}
// 	return procType

// }

func generateSyncChanMonitor() string {
	return "proctype sync_monitor(Chandef ch) {\n" +
		"do\n" +
		":: true\n" +
		"if\n" +
		":: ch.closed ->\n" +
		"end: if\n" +
		"  :: ch.enq?0-> // cannot send on closed channel\n" +
		"    assert(1 == 0)\n" +
		"  :: ch.closing?true -> // cannot close twice a channel\n" +
		"    assert(2 == 0)\n" +
		"  :: ch.sending?false -> // sending state of channel (closed)\n" +
		"    assert(1 == 0)\n" +
		"  :: ch.rcving?false;\n" +
		"  :: ch.sync!true; // can always receive on a closed chan\n" +
		"  fi;\n" +
		":: else -> \n" +
		"end1: if\n" +
		"    :: ch.rcving?false ->\n " +
		"      ch.sending?false;\n" +
		"    :: ch.closing?true ->\n" +
		"      ch.closed = true\n" +
		"    fi;\n" +
		"fi;\n" +
		"od\n" +
		"stop_process:\n" +
		"}\n\n"
}

func GenerateAsyncMonitor() string {
	return "proctype AsyncChan(Chandef ch) {\n" +
		"do\n" +
		":: true ->\n" +
		"if\n" +
		":: ch.closed -> \n" +
		"end: if\n" +
		"  :: ch.enq?0-> // cannot send on closed channel\n" +
		"    assert(1 == 0)\n" +
		"  :: ch.closing?true -> // cannot close twice a channel\n" +
		"    assert(2 == 0)\n" +
		"  :: ch.rcving?false;\n" +
		"  :: ch.sending?false -> // sending state of channel (closed)\n" +
		"    assert(1 == 0)\n" +
		"  :: ch.sync!true -> \n" +
		"		 ch.num_msgs = ch.num_msgs - 1\n" +
		"  fi;\n" +
		":: else ->\n" +
		"	if\n" +
		"	:: ch.num_msgs == ch.size ->\n" +
		"		end1: if\n" +
		"		  :: ch.deq!false,ch.num_msgs ->\n" +
		"		    ch.num_msgs = ch.num_msgs - 1\n" +
		"		  :: ch.closing?true -> // closing the channel\n" +
		"		    ch.closed = true\n" +
		"		   :: ch.rcving?false ->\n " +
		"		    ch.sending?false;\n" +
		"		fi;\n" +
		"	:: ch.num_msgs == 0 -> \n" +
		"end2:		if\n" +
		"		:: ch.enq?0 -> // a message has been received\n" +
		"			ch.num_msgs = ch.num_msgs + 1\n" +
		"		:: ch.closing?true -> // closing the channel\n" +
		"			ch.closed = true\n" +
		"		:: ch.rcving?false ->\n " +
		"		    ch.sending?false;\n" +
		"		fi;\n" +
		"		:: else -> \n" +
		"		end3: if\n" +
		"		  :: ch.enq?0->\n" +
		"		     ch.num_msgs = ch.num_msgs + 1\n" +
		"		  :: ch.deq!false,ch.num_msgs\n" +
		"		     ch.num_msgs = ch.num_msgs - 1\n" +
		"		  :: ch.closing?true -> // closing the channel\n" +
		"		     ch.closed = true\n" +
		"		  :: ch.rcving?false ->\n " +
		"		    ch.sending?false;\n" +
		"		fi;\n" +
		"	fi;\n" +
		"fi;\n" +
		"od;\n" +
		"}\n\n"
}

// Return the Promela AST of an empty async chan monitor proctype

// Return the Promela AST of an empty async chan monitor proctype
func GenerateFullChanMonitor() string {

	return "proctype fullChan(Chandef ch) {\n" +
		"end: if\n" +
		"  :: ch.deq!0 ->\n" +
		"    ch.num_msgs = ch.num_msgs - 1\n" +
		"    if\n" +
		"    :: ch.num_msgs == 0 ->\n" +
		"      run emptyChan(ch)\n" +
		"    :: else ->\n" +
		"      run neitherChan(ch)\n" +
		"    fi;\n" +
		"  :: ch.closing?true -> // closing the channel\n" +
		"      run closedChan(ch)\n" +
		"  :: ch.is_closed!false -> // sending channel is open \n" +
		"      run fullChan(ch)\n" +
		"  :: ch.sending?false ->\n" +
		"      run fullChan(ch)\n" +
		"fi;\n" +
		"}\n\n"
}

// Return the Promela AST of an empty async chan monitor proctype
func GenerateNeitherChanMonitor() string {

	return "proctype neitherChan(Chandef ch) {\n" +
		"end: if\n" +
		"  :: ch.enq?0->\n" +
		"     ch.num_msgs = ch.num_msgs + 1\n" +
		"     if\n" +
		"     :: ch.num_msgs == ch.size ->\n" +
		"        run fullChan(ch)\n" +
		"     :: else ->\n" +
		"        run neitherChan(ch)\n" +
		"    fi;\n" +
		"  :: ch.deq!0\n" +
		"     ch.num_msgs = ch.num_msgs - 1\n" +
		"     if\n" +
		"     :: ch.num_msgs == 0 ->\n" +
		"      run emptyChan(ch)\n" +
		"     :: else ->\n" +
		"      run neitherChan(ch)\n" +
		"     fi;\n" +
		"  :: ch.closing?true -> // closing the channel\n" +
		"      run closedChan(ch)\n" +
		"  :: ch.is_closed!false ->  // sending channel is open\n" +
		"     run neitherChan(ch)\n" +
		"  :: ch.sending?false ->  // sending channel is open\n" +
		"     run neitherChan(ch)\n" +
		"fi;\n" +
		"}\n\n"
}

// Return the Promela AST of a wg monitor proctype

// proctype wgmonitor(Wgdef s) {
//   int num
//   do
//   :: s.update?num ->
//     s.Counter = s.Counter + num
//     assert(s.Counter >= 0)
//   :: s.Counter == 0 ->
//     if
//     :: s.update?num ->
//     s.Counter = s.Counter + num
//     assert(s.Counter >= 0)
//     :: s.Wait?0;
//     fi
//   od
// }
func GenerateStructMonitor() string {

	return "proctype wgMonitor(Wgdef wg) {\n" +
		"bool closed;\n" +
		"int i;\n" +
		"bool state;\n" +
		"do\n" +
		"	:: wg.update?i ->\n" +
		"		wg.Counter = wg.Counter + i;\n" +
		"		assert(wg.Counter >= 0)\n" +
		"	:: wg.Counter == 0 ->\n" +
		"end: if\n" +
		"		:: wg.update?i ->\n" +
		"			wg.Counter = wg.Counter + i;\n" +
		"			assert(wg.Counter >= 0)\n" +
		"		:: wg.wait!0;\n" +
		"	fi\n" +
		"od\n" +
		"}\n\n"

}
