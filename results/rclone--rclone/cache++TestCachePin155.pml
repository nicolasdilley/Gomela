
// https://github.com/rclone/rclone/blob/master/lib/cache/cache_test.go#L155
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCachePin1550 = [1] of {int};
	run TestCachePin155(child_TestCachePin1550)
stop_process:skip
}

proctype TestCachePin155(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cacheExpire2016 = [1] of {int};
	chan child_Unpin1215 = [1] of {int};
	chan child_cacheExpire2014 = [1] of {int};
	chan child_Pin1163 = [1] of {int};
	chan child_cacheExpire2012 = [1] of {int};
	chan child_Pin1161 = [1] of {int};
	chan child_Get810 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Get81(c_mu,child_Get810);
	child_Get810?0;
	run Pin116(c_mu,child_Pin1161);
	child_Pin1161?0;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	run cacheExpire201(c_mu,child_cacheExpire2012);
	child_cacheExpire2012?0;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	run Pin116(c_mu,child_Pin1163);
	child_Pin1163?0;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	run cacheExpire201(c_mu,child_cacheExpire2014);
	child_cacheExpire2014?0;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	run Unpin121(c_mu,child_Unpin1215);
	child_Unpin1215?0;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	run cacheExpire201(c_mu,child_cacheExpire2016);
	child_cacheExpire2016?0;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Get81(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_used711 = [1] of {int};
	chan child_noCache400 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true -> 
		c_mu.Unlock!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		c_mu.Lock!false;
		run noCache40(c_mu,child_noCache400);
		child_noCache400?0
	:: true;
	fi;
	run used71(c_mu,child_used711);
	child_used711?0;
	goto stop_process;
	stop_process: skip;
		c_mu.Unlock!false;
	child!0
}
proctype noCache40(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype used71(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Pin116(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addPin1051 = [1] of {int};
	run addPin105(c_mu,child_addPin1051);
	child_addPin1051?0;
	stop_process: skip;
	child!0
}
proctype addPin105(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_used711 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true -> 
		run used71(c_mu,child_used711);
		child_used711?0
	:: true;
	fi;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype cacheExpire201(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	stop_process: skip;
		c_mu.Unlock!false;
	child!0
}
proctype Unpin121(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addPin1055 = [1] of {int};
	run addPin105(c_mu,child_addPin1055);
	child_addPin1055?0;
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

