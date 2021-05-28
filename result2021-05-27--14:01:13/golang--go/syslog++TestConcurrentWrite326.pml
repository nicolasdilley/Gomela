// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/log/syslog/syslog_test.go#L326
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
	chan child_TestConcurrentWrite3260 = [1] of {int};
	run TestConcurrentWrite326(child_TestConcurrentWrite3260);
	run receiver(child_TestConcurrentWrite3260)
stop_process:skip
}

proctype TestConcurrentWrite326(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestConcurrentWrite3373270 = [1] of {int};
	Wgdef wg;
	Mutexdef w_mu;
	Wgdef srvWG;
	run wgMonitor(srvWG);
	run mutexMonitor(w_mu);
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestConcurrentWrite337327(srvWG,wg,w_mu,child_AnonymousTestConcurrentWrite3373270);
		run receiver(child_AnonymousTestConcurrentWrite3373270);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
		defer1: skip;
		defer1: skip;
	srvWG.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestConcurrentWrite337327(Wgdef srvWG;Wgdef wg;Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Info2390 = [1] of {int};
	run Info239(w_mu,child_Info2390);
	child_Info2390?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Info239(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeAndRetry2510 = [1] of {int};
	run writeAndRetry251(w_mu,child_writeAndRetry2510);
	child_writeAndRetry2510?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeAndRetry251(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_write2702 = [1] of {int};
	chan child_connect1491 = [1] of {int};
	chan child_write2700 = [1] of {int};
	w_mu.Lock!false;
	

	if
	:: true -> 
		run write270(w_mu,child_write2700);
		child_write2700?0;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	run connect149(w_mu,child_connect1491);
	child_connect1491?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run write270(w_mu,child_write2702);
	child_write2702?0;
	goto defer1;
		defer1: skip;
	w_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype write270(Mutexdef w_mu;chan child) {
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
proctype connect149(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

