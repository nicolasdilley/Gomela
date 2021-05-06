
// https://github.com/syncthing/syncthing/blob/master/lib/model/bytesemaphore_test.go#L87
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestByteSempahoreGiveMore870 = [1] of {int};
	run TestByteSempahoreGiveMore87(child_TestByteSempahoreGiveMore870)
stop_process:skip
}

proctype TestByteSempahoreGiveMore87(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_give804 = [1] of {int};
	chan child_setCapacity943 = [1] of {int};
	chan child_take492 = [1] of {int};
	chan child_give801 = [1] of {int};
	chan child_take490 = [1] of {int};
	Mutexdef s_mut;
	run mutexMonitor(s_mut);
	run take49(s_mut,child_take490);
	child_take490?0;
	run give80(s_mut,child_give801);
	child_give801?0;
	run take49(s_mut,child_take492);
	child_take492?0;
	run setCapacity94(s_mut,child_setCapacity943);
	child_setCapacity943?0;
	run give80(s_mut,child_give804);
	child_give804?0;
	stop_process: skip;
	child!0
}
proctype take49(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_takeInner530 = [1] of {int};
	run takeInner53(s_mut,child_takeInner530);
	child_takeInner530?0;
	stop_process: skip;
	child!0
}
proctype takeInner53(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	s_mut.Lock!false;
	goto stop_process;
	stop_process: skip;
		s_mut.Unlock!false;
	child!0
}
proctype give80(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mut.Lock!false;
	s_mut.Unlock!false;
	stop_process: skip;
	child!0
}
proctype setCapacity94(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mut.Lock!false;
	s_mut.Unlock!false;
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

