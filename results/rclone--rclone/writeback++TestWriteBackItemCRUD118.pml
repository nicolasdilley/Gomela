
// https://github.com/rclone/rclone/blob/master/vfs/vfscache/writeback/writeback_test.go#L118
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWriteBackItemCRUD1180 = [1] of {int};
	run TestWriteBackItemCRUD118(child_TestWriteBackItemCRUD1180)
stop_process:skip
}

proctype TestWriteBackItemCRUD118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_string2736 = [1] of {int};
	chan child_checkInLookup10635 = [1] of {int};
	chan child_checkNotOnHeap9534 = [1] of {int};
	chan child__removeItem18733 = [1] of {int};
	chan child_string2732 = [1] of {int};
	chan child_checkInLookup10631 = [1] of {int};
	chan child_checkNotOnHeap9530 = [1] of {int};
	chan child__removeItem18729 = [1] of {int};
	chan child_string2728 = [1] of {int};
	chan child__peekItem19727 = [1] of {int};
	chan child_string2726 = [1] of {int};
	chan child__pushItem17725 = [1] of {int};
	chan child_string2724 = [1] of {int};
	chan child_checkInLookup10623 = [1] of {int};
	chan child_checkOnHeap8322 = [1] of {int};
	chan child__pushItem17721 = [1] of {int};
	chan child_string2720 = [1] of {int};
	chan child_checkInLookup10619 = [1] of {int};
	chan child_checkNotOnHeap9518 = [1] of {int};
	chan child__popItem16817 = [1] of {int};
	chan child_checkInLookup10616 = [1] of {int};
	chan child_checkOnHeap8315 = [1] of {int};
	chan child__addItem15414 = [1] of {int};
	chan child_checkNotInLookup11213 = [1] of {int};
	chan child_checkOnHeap8312 = [1] of {int};
	chan child__delItem16111 = [1] of {int};
	chan child_string2710 = [1] of {int};
	chan child_checkInLookup1069 = [1] of {int};
	chan child_checkOnHeap838 = [1] of {int};
	chan child__newItem1387 = [1] of {int};
	chan child_checkInLookup1066 = [1] of {int};
	chan child_checkOnHeap835 = [1] of {int};
	chan child__newItem1384 = [1] of {int};
	chan child_checkInLookup1063 = [1] of {int};
	chan child_checkOnHeap832 = [1] of {int};
	chan child__newItem1381 = [1] of {int};
	chan child__peekItem1970 = [1] of {int};
	Mutexdef wb_mu;
	run mutexMonitor(wb_mu);
	run _peekItem197(wb_mu,child__peekItem1970);
	child__peekItem1970?0;
	run _newItem138(wb_mu,child__newItem1381);
	child__newItem1381?0;
	run checkOnHeap83(wb_mu,child_checkOnHeap832);
	child_checkOnHeap832?0;
	run checkInLookup106(wb_mu,child_checkInLookup1063);
	child_checkInLookup1063?0;
	run _newItem138(wb_mu,child__newItem1384);
	child__newItem1384?0;
	run checkOnHeap83(wb_mu,child_checkOnHeap835);
	child_checkOnHeap835?0;
	run checkInLookup106(wb_mu,child_checkInLookup1066);
	child_checkInLookup1066?0;
	run _newItem138(wb_mu,child__newItem1387);
	child__newItem1387?0;
	run checkOnHeap83(wb_mu,child_checkOnHeap838);
	child_checkOnHeap838?0;
	run checkInLookup106(wb_mu,child_checkInLookup1069);
	child_checkInLookup1069?0;
	run string27(wb_mu,child_string2710);
	child_string2710?0;
	run _delItem161(wb_mu,child__delItem16111);
	child__delItem16111?0;
	run checkOnHeap83(wb_mu,child_checkOnHeap8312);
	child_checkOnHeap8312?0;
	run checkNotInLookup112(wb_mu,child_checkNotInLookup11213);
	child_checkNotInLookup11213?0;
	run _addItem154(wb_mu,child__addItem15414);
	child__addItem15414?0;
	run checkOnHeap83(wb_mu,child_checkOnHeap8315);
	child_checkOnHeap8315?0;
	run checkInLookup106(wb_mu,child_checkInLookup10616);
	child_checkInLookup10616?0;
	run _popItem168(wb_mu,child__popItem16817);
	child__popItem16817?0;
	run checkNotOnHeap95(wb_mu,child_checkNotOnHeap9518);
	child_checkNotOnHeap9518?0;
	run checkInLookup106(wb_mu,child_checkInLookup10619);
	child_checkInLookup10619?0;
	run string27(wb_mu,child_string2720);
	child_string2720?0;
	run _pushItem177(wb_mu,child__pushItem17721);
	child__pushItem17721?0;
	run checkOnHeap83(wb_mu,child_checkOnHeap8322);
	child_checkOnHeap8322?0;
	run checkInLookup106(wb_mu,child_checkInLookup10623);
	child_checkInLookup10623?0;
	run string27(wb_mu,child_string2724);
	child_string2724?0;
	run _pushItem177(wb_mu,child__pushItem17725);
	child__pushItem17725?0;
	run string27(wb_mu,child_string2726);
	child_string2726?0;
	run _peekItem197(wb_mu,child__peekItem19727);
	child__peekItem19727?0;
	run string27(wb_mu,child_string2728);
	child_string2728?0;
	run _removeItem187(wb_mu,child__removeItem18729);
	child__removeItem18729?0;
	run checkNotOnHeap95(wb_mu,child_checkNotOnHeap9530);
	child_checkNotOnHeap9530?0;
	run checkInLookup106(wb_mu,child_checkInLookup10631);
	child_checkInLookup10631?0;
	run string27(wb_mu,child_string2732);
	child_string2732?0;
	run _removeItem187(wb_mu,child__removeItem18733);
	child__removeItem18733?0;
	run checkNotOnHeap95(wb_mu,child_checkNotOnHeap9534);
	child_checkNotOnHeap9534?0;
	run checkInLookup106(wb_mu,child_checkInLookup10635);
	child_checkInLookup10635?0;
	run string27(wb_mu,child_string2736);
	child_string2736?0;
	stop_process: skip;
	child!0
}
proctype _peekItem197(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype _newItem138(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child__pushItem1773 = [1] of {int};
	chan child__addItem1542 = [1] of {int};
	chan child_SetID2431 = [1] of {int};
	run SetID243(wb_mu,child_SetID2431);
	child_SetID2431?0;
	run _addItem154(wb_mu,child__addItem1542);
	child__addItem1542?0;
	run _pushItem177(wb_mu,child__pushItem1773);
	child__pushItem1773?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetID243(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype _addItem154(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype _pushItem177(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype checkOnHeap83(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wb_mu.Lock!false;
	stop_process: skip;
		wb_mu.Unlock!false;
	child!0
}
proctype checkInLookup106(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wb_mu.Lock!false;
	stop_process: skip;
		wb_mu.Unlock!false;
	child!0
}
proctype string27(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wb_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		wb_mu.Unlock!false;
	child!0
}
proctype _delItem161(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype checkNotInLookup112(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wb_mu.Lock!false;
	stop_process: skip;
		wb_mu.Unlock!false;
	child!0
}
proctype _popItem168(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkNotOnHeap95(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wb_mu.Lock!false;
	stop_process: skip;
		wb_mu.Unlock!false;
	child!0
}
proctype _removeItem187(Mutexdef wb_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

