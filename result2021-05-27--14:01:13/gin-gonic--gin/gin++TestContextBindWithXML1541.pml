// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gin-gonic/gin/blob/5452a1d3ef0982ffea95fb9e88e5425b0928c431/context_test.go#L1541
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextBindWithXML15410 = [1] of {int};
	run TestContextBindWithXML1541(child_TestContextBindWithXML15410);
	run receiver(child_TestContextBindWithXML15410)
stop_process:skip
}

proctype TestContextBindWithXML1541(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BindXML6130 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run BindXML613(c_mu,child_BindXML6130);
	child_BindXML6130?0;
	stop_process: skip;
	child!0
}
proctype BindXML613(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MustBindWith6450 = [1] of {int};
	run MustBindWith645(c_mu,child_MustBindWith6450);
	child_MustBindWith6450?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MustBindWith645(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ShouldBindWith7020 = [1] of {int};
	run ShouldBindWith702(c_mu,child_ShouldBindWith7020);
	child_ShouldBindWith7020?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ShouldBindWith702(Mutexdef c_mu;chan child) {
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

