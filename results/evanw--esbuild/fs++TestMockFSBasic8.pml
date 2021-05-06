
// https://github.com/evanw/esbuild/blob/master/internal/fs/fs_mock_test.go#L8
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMockFSBasic80 = [1] of {int};
	run TestMockFSBasic8(child_TestMockFSBasic80)
stop_process:skip
}

proctype TestMockFSBasic8(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Kind254 = [1] of {int};
	chan child_Kind253 = [1] of {int};
	chan child_Kind252 = [1] of {int};
	Mutexdef packageEntry_mutex;
	Mutexdef readmeEntry_mutex;
	Mutexdef srcEntry_mutex;
	chan child_Kind251 = [1] of {int};
	chan child_Kind250 = [1] of {int};
	Mutexdef utilEntry_mutex;
	Mutexdef indexEntry_mutex;
	run mutexMonitor(indexEntry_mutex);
	run mutexMonitor(utilEntry_mutex);
	run Kind25(indexEntry_mutex,child_Kind250);
	child_Kind250?0;
	run Kind25(utilEntry_mutex,child_Kind251);
	child_Kind251?0;
	run mutexMonitor(srcEntry_mutex);
	run mutexMonitor(readmeEntry_mutex);
	run mutexMonitor(packageEntry_mutex);
	run Kind25(srcEntry_mutex,child_Kind252);
	child_Kind252?0;
	run Kind25(readmeEntry_mutex,child_Kind253);
	child_Kind253?0;
	run Kind25(packageEntry_mutex,child_Kind254);
	child_Kind254?0;
	stop_process: skip;
	child!0
}
proctype Kind25(Mutexdef e_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_mutex.Lock!false;
	goto stop_process;
	stop_process: skip;
		e_mutex.Unlock!false;
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

