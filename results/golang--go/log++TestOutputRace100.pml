// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob//log/log_test.go#L100
#define def_var_file  -2 // opt file line 103
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOutputRace1000 = [1] of {int};
	run TestOutputRace100(child_TestOutputRace1000);
	run receiver(child_TestOutputRace1000)
stop_process:skip
}

proctype TestOutputRace100(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Output1611 = [1] of {int};
	chan child_AnonymousTestOutputRace1041020 = [1] of {int};
	Mutexdef l_mu;
	run mutexMonitor(l_mu);
		for(i : 0.. 100-1) {
		for10: skip;
		run AnonymousTestOutputRace104102(l_mu,child_AnonymousTestOutputRace1041020);
		run receiver(child_AnonymousTestOutputRace1041020);
		run Output161(l_mu,child_Output1611);
		child_Output1611?0;
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestOutputRace104102(Mutexdef l_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetFlags2510 = [1] of {int};
	run SetFlags251(l_mu,child_SetFlags2510);
	child_SetFlags2510?0;
	stop_process: skip;
	child!0
}
proctype SetFlags251(Mutexdef l_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_mu.Lock!false;
		defer1: skip;
	l_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Output161(Mutexdef l_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_formatHeader1031 = [1] of {int};
	int var_file = def_var_file;
	l_mu.Lock!false;
	

	if
	:: true -> 
		l_mu.Unlock!false;
		l_mu.Lock!false
	:: true;
	fi;
	run formatHeader103(l_mu,var_file,child_formatHeader1031);
	child_formatHeader1031?0;
	goto defer1;
		defer1: skip;
	l_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype formatHeader103(Mutexdef l_mu;int var_file;chan child) {
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

proctype receiver(chan c) {
c?0
}

