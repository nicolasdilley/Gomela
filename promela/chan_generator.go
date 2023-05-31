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
	return `
proctype sync_monitor(Chandef ch) {
	do
	:: true ->
		if
		:: ch.closed;
			end: if
		  	:: ch.enq!false; // cannot send on closed channel
		  	:: ch.closing!true; // cannot close twice a channel
		  	:: ch.sending!false; // sending state of channel (closed)
		  	:: ch.rcving?false;
		  	:: ch.sync!true; // can always receive on a closed chan
		  	fi;
		:: else ->
			end1: if
		  	:: ch.rcving?false -> ch.sending!true;
		  	:: ch.closing!false -> ch.closed = true;
		  	fi;
		fi;
	od;
	stop_process: skip;
}
`
}

func GenerateAsyncMonitor() string {
	return `
proctype async_monitor(Chandef ch) {
	do
	:: true ->
		if
		:: ch.closed -> 
			end: if
		  	:: ch.num_msgs > 0 -> // cannot send on closed channel
		  	  end4: if
		  	  :: ch.enq!false; // cannot send on closed channel
		  	  :: ch.closing!true; // cannot close twice a channel
		  	  :: ch.rcving?false;
		  	  :: ch.sending!false; // sending state of channel (closed)
		  	  :: ch.deq!true,ch.num_msgs -> ch.num_msgs = ch.num_msgs - 1
		  	  fi;
		  	:: else ->
		  	  end5: if
		  	  	:: ch.enq!false; // cannot send on closed channel
		  	  	:: ch.closing!true; // cannot close twice a channel
		  	  	:: ch.rcving?false;
		  	  	:: ch.sending!false; // sending state of channel (closed)
		  	  	:: ch.sync!true; 
		  	  	fi;
		  	fi;
		:: else ->
			if
			:: ch.num_msgs == ch.size ->
				end1: if
				  :: ch.deq!false,ch.num_msgs -> ch.num_msgs = ch.num_msgs - 1;
				  :: ch.closing!false -> ch.closed = true; // closing the channel
				  :: ch.rcving?false -> ch.sending!true;
					fi;
			:: ch.num_msgs == 0 -> 
				end2: if
				:: ch.enq!true -> ch.num_msgs = ch.num_msgs + 1; // a message has been received
				:: ch.closing!false -> ch.closed = true; // closing the channel
				:: ch.rcving?false -> ch.sending!true;
				fi;
			:: else -> 
				end3: if
				  :: ch.enq!true -> ch.num_msgs = ch.num_msgs + 1;
				  :: ch.deq!false,ch.num_msgs -> ch.num_msgs = ch.num_msgs - 1;
				  :: ch.closing!false -> ch.closed = true; // closing the channel
				  :: ch.rcving?false -> ch.sending!true;
					fi;
				fi;
		fi;
	od;
}
`
}

// Return the Promela AST of a wg monitor proctype

//	proctype wg_monitor(Wgdef s) {
//	  int num
//	  do
//	  :: s.update?num ->
//	    s.Counter = s.Counter + num
//	    assert(s.Counter >= 0)
//	  :: s.Counter == 0 ->
//	    if
//	    :: s.update?num ->
//	    s.Counter = s.Counter + num
//	    assert(s.Counter >= 0)
//	    :: s.Wait?0;
//	    fi
//	  od
//	}
func GenerateStructMonitor() string {
	return `
proctype wg_monitor(Wgdef wg) {
	int i;
	end: do
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			wg.update_ack!(wg.Counter >= 0);
		:: wg.Counter == 0;
	end1: if
			:: wg.update?i ->
				wg.Counter = wg.Counter + i;
				wg.update_ack!(wg.Counter >= 0);
			:: wg.wait!0;
		fi
	od
}
`
}

func GenerateMutexMonitor() string {
	return `
proctype mutex_monitor(Mutexdef m) {
	bool locked = false;
	end: do
	:: true ->
		if
		:: m.Counter > 0 ->
			if
			:: m.RUnlock!true;
				m.Counter = m.Counter - 1;
			:: m.RLock!true;
				m.Counter = m.Counter + 1;
			fi;
		:: locked ->
			m.Unlock!true;
			locked = false;
		:: else ->
			end1: if
				:: m.Unlock!false;
				:: m.Lock!true -> locked =true;
				:: m.RUnlock!false;
				:: m.RLock!true -> m.Counter = m.Counter + 1;
				fi;
		fi;
	od
}
`
}

func GenerateReceiverProcess() string {
	return `
proctype receiver(chan c) {
	c?0
}
`
}
