
// https://github.com/kubernetes/kubernetes/blob/master/pkg/credentialprovider/provider_test.go#L39
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCachingProvider390 = [1] of {int};
	run TestCachingProvider39(child_TestCachingProvider390)
stop_process:skip
}

proctype TestCachingProvider39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provide9311 = [1] of {int};
	chan child_Provide9310 = [1] of {int};
	chan child_Provide939 = [1] of {int};
	chan child_Provide938 = [1] of {int};
	chan child_Provide937 = [1] of {int};
	chan child_Provide936 = [1] of {int};
	chan child_Provide935 = [1] of {int};
	chan child_Provide934 = [1] of {int};
	chan child_Provide933 = [1] of {int};
	chan child_Provide932 = [1] of {int};
	chan child_Provide931 = [1] of {int};
	chan child_Provide930 = [1] of {int};
	Mutexdef cache_mu;
	run mutexMonitor(cache_mu);
	run Provide93(cache_mu,child_Provide930);
	child_Provide930?0;
	run Provide93(cache_mu,child_Provide931);
	child_Provide931?0;
	run Provide93(cache_mu,child_Provide932);
	child_Provide932?0;
	run Provide93(cache_mu,child_Provide933);
	child_Provide933?0;
	run Provide93(cache_mu,child_Provide934);
	child_Provide934?0;
	run Provide93(cache_mu,child_Provide935);
	child_Provide935?0;
	run Provide93(cache_mu,child_Provide936);
	child_Provide936?0;
	run Provide93(cache_mu,child_Provide937);
	child_Provide937?0;
	run Provide93(cache_mu,child_Provide938);
	child_Provide938?0;
	run Provide93(cache_mu,child_Provide939);
	child_Provide939?0;
	run Provide93(cache_mu,child_Provide9310);
	child_Provide9310?0;
	run Provide93(cache_mu,child_Provide9311);
	child_Provide9311?0;
	stop_process: skip;
	child!0
}
proctype Provide93(Mutexdef d_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		d_mu.Unlock!false;
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

