
// https://github.com/rclone/rclone/blob/master/lib/readers/repeatable_test.go#L12
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRepeatableReader120 = [1] of {int};
	run TestRepeatableReader12(child_TestRepeatableReader120)
stop_process:skip
}

proctype TestRepeatableReader12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Seek2512 = [1] of {int};
	chan child_Seek2511 = [1] of {int};
	chan child_Seek2510 = [1] of {int};
	chan child_Read539 = [1] of {int};
	chan child_Seek258 = [1] of {int};
	chan child_Seek257 = [1] of {int};
	chan child_Seek256 = [1] of {int};
	chan child_Read535 = [1] of {int};
	chan child_Read534 = [1] of {int};
	chan child_Read533 = [1] of {int};
	chan child_Seek252 = [1] of {int};
	chan child_Read531 = [1] of {int};
	chan child_Read530 = [1] of {int};
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	run Read53(r_mu,child_Read530);
	child_Read530?0;
	run Read53(r_mu,child_Read531);
	child_Read531?0;
	run Seek25(r_mu,child_Seek252);
	child_Seek252?0;
	run Read53(r_mu,child_Read533);
	child_Read533?0;
	run Read53(r_mu,child_Read534);
	child_Read534?0;
	run Read53(r_mu,child_Read535);
	child_Read535?0;
	run Seek25(r_mu,child_Seek256);
	child_Seek256?0;
	run Seek25(r_mu,child_Seek257);
	child_Seek257?0;
	run Seek25(r_mu,child_Seek258);
	child_Seek258?0;
	run Read53(r_mu,child_Read539);
	child_Read539?0;
	run Seek25(r_mu,child_Seek2510);
	child_Seek2510?0;
	run Seek25(r_mu,child_Seek2511);
	child_Seek2511?0;
	run Seek25(r_mu,child_Seek2512);
	child_Seek2512?0;
	stop_process: skip;
	child!0
}
proctype Read53(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		r_mu.Unlock!false;
	child!0
}
proctype Seek25(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mu.Lock!false;
	

	if
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto stop_process
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
	goto stop_process;
	stop_process: skip;
		r_mu.Unlock!false;
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

