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
		"  :: ch.num_msgs > 0 -> // cannot send on closed channel\n" +
		"    end4: if\n" +
		"    :: ch.enq?0-> // cannot send on closed channel\n" +
		"      assert(1 == 0)\n" +
		"    :: ch.closing?true -> // cannot close twice a channel\n" +
		"      assert(2 == 0)\n" +
		"    :: ch.rcving?false;\n" +
		"    :: ch.sending?false -> // sending state of channel (closed)\n" +
		"      assert(1 == 0)\n" +
		"    :: ch.deq!true,ch.num_msgs -> \n" +
		"  		 ch.num_msgs = ch.num_msgs - 1\n" +
		"    fi;\n" +
		"  :: else ->" +
		"    end5: if\n" +
		"    :: ch.enq?0-> // cannot send on closed channel\n" +
		"      assert(1 == 0)\n" +
		"    :: ch.closing?true -> // cannot close twice a channel\n" +
		"      assert(2 == 0)\n" +
		"    :: ch.rcving?false;\n" +
		"    :: ch.sending?false -> // sending state of channel (closed)\n" +
		"      assert(1 == 0)\n" +
		"    :: ch.sync!true; \n" +
		"    fi;\n" +
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
		"int i;\n" +
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

func GenerateMutexMonitor() string {

	return "proctype mutexMonitor(Mutexdef m) {\n" +
		"bool locked = false;\n" +
		"do\n" +
		":: true ->\n" +
		"	if\n" +
		"	:: m.Counter > 0 ->\n" +
		"		if \n" +
		"		:: m.RUnlock?false -> \n" +
		"			m.Counter = m.Counter - 1;\n" +
		"		:: m.RLock?false -> \n" +
		"			m.Counter = m.Counter + 1;\n" +
		"		fi;\n" +
		"	:: locked ->\n" +
		"		m.Unlock?false;\n" +
		"		locked = false;\n" +
		"	:: else ->" +
		"	 end:	if\n" +
		"		:: m.Unlock?false ->\n" +
		"			assert(0==32);" +
		"		:: m.Lock?false ->\n" +
		"			locked =true;\n" +
		"		:: m.RUnlock?false ->\n" +
		"			assert(0==32);" +
		"		:: m.RLock?false ->\n" +
		"			m.Counter = m.Counter + 1;\n" +
		"		fi;\n" +
		"	fi;\n" +
		"od\n" +
		"}\n\n"
}

func GenerateReceiverProcess() string {

	return "proctype receiver(chan c) {\n" +
		"c?0\n" +
		"}\n\n"
}
