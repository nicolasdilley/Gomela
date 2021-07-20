// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/expression/builtin_test.go#L30
#define var_concurrency33  ?? // mand concurrency line 33
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_evalBuiltinFuncConcurrent300 = [1] of {int};
	run evalBuiltinFuncConcurrent30(child_evalBuiltinFuncConcurrent300);
	run receiver(child_evalBuiltinFuncConcurrent300)
stop_process:skip
}

proctype evalBuiltinFuncConcurrent30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousevalBuiltinFuncConcurrent37310 = [1] of {int};
	Mutexdef lock;
	Wgdef wg;
	int var_concurrency = var_concurrency33; // mand var_concurrency
	run wgMonitor(wg);
	wg.update!var_concurrency;
	run mutexMonitor(lock);
		for(i : 0.. var_concurrency-1) {
		for10: skip;
		run AnonymousevalBuiltinFuncConcurrent3731(wg,lock,child_AnonymousevalBuiltinFuncConcurrent37310);
		run receiver(child_AnonymousevalBuiltinFuncConcurrent37310);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousevalBuiltinFuncConcurrent3731(Wgdef wg;Mutexdef lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lock.Lock!false;
	lock.Unlock!false;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

