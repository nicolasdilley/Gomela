// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/ingress-nginx/blob//internal/net/ssl/ssl.go#L500
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewTLSListener5000 = [1] of {int};
	run NewTLSListener500(child_NewTLSListener5000);
	run receiver(child_NewTLSListener5000)
stop_process:skip
}

proctype NewTLSListener500(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_load5300 = [1] of {int};
	Mutexdef l_lock;
	run mutexMonitor(l_lock);
	run load530(l_lock,child_load5300);
	child_load5300?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype load530(Mutexdef tl_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	tl_lock.Lock!false;
		defer1: skip;
	tl_lock.Unlock!false;
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

