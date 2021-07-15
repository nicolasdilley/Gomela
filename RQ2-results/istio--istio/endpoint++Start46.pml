
// https://github.com/istio/istio/blob/master/pkg/test/echo/server/endpoint/tcp.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Start460 = [1] of {int};
	run Start46(child_Start460)
stop_process:skip
}

proctype Start46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStart78551 = [1] of {int};
	chan child_listenOnAddressTLS400 = [1] of {int};
	Mutexdef config_mutex;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run mutexMonitor(config_mutex);
		run listenOnAddressTLS40(config_mutex,child_listenOnAddressTLS400);
		child_listenOnAddressTLS400?0
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run AnonymousStart7855(config_mutex,child_AnonymousStart78551);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype listenOnAddressTLS40(Mutexdef cfg_mutex;chan child) {
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
proctype AnonymousStart7855(Mutexdef config_mutex;chan child) {
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

