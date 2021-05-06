
// https://github.com/beego/beego/blob/master/client/httplib/httplib_test.go#L344
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewBeegoRequest3440 = [1] of {int};
	run TestNewBeegoRequest344(child_TestNewBeegoRequest3440)
stop_process:skip
}

proctype TestNewBeegoRequest344(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef req_setting_TLSClientConfig_mutex;
	run mutexMonitor(req_setting_TLSClientConfig_mutex);
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

