#define ub_for188_2  -2

// https://github.com/grpc/grpc-go/blob/master/test/bufconn/bufconn_test.go#L84
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPipeClose840 = [1] of {int};
	run TestPipeClose84(child_TestPipeClose840)
stop_process:skip
}

proctype TestPipeClose84(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Read1452 = [1] of {int};
	chan child_Write1821 = [1] of {int};
	chan child_Close2280 = [1] of {int};
	Mutexdef p_mu;
	run mutexMonitor(p_mu);
	run Close228(p_mu,child_Close2280);
	child_Close2280?0;
	run Write182(p_mu,child_Write1821);
	child_Write1821?0;
	run Read145(p_mu,child_Read1452);
	child_Read1452?0;
	stop_process: skip;
	child!0
}
proctype Close228(Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		p_mu.Unlock!false;
	child!0
}
proctype Write182(Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_empty1376 = [1] of {int};
	chan child_full1414 = [1] of {int};
	chan child_empty1373 = [1] of {int};
	chan child_full1411 = [1] of {int};
	p_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 0 != -2 && ub_for188_2 != -2 -> 
				for(i : 0.. ub_for188_2) {
			for13: skip;
			do
			:: true -> 
				for14: skip;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				run full141(p_mu,child_full1414);
				child_full1414?0;
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for14_end: skip
			od;
			for14_exit: skip;
			run empty137(p_mu,child_empty1376);
			child_empty1376?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				run full141(p_mu,child_full1411);
				child_full1411?0;
				

				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for11_end: skip
			od;
			for11_exit: skip;
			run empty137(p_mu,child_empty1373);
			child_empty1373?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
		p_mu.Unlock!false;
	child!0
}
proctype full141(Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype empty137(Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Read145(Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_full1414 = [1] of {int};
	chan child_empty1372 = [1] of {int};
	p_mu.Lock!false;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run empty137(p_mu,child_empty1372);
		child_empty1372?0;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	run full141(p_mu,child_full1414);
	child_full1414?0;
	goto stop_process;
	stop_process: skip;
		p_mu.Unlock!false;
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

