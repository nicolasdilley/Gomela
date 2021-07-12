// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/traefik/traefik/blob/080cf98e512f6fcb93838de76a6aa34ff147dee4/pkg/server/service/loadbalancer/wrr/wrr_test.go#L48
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBalancerNoService480 = [1] of {int};
	run TestBalancerNoService48(child_TestBalancerNoService480);
	run receiver(child_TestBalancerNoService480)
stop_process:skip
}

proctype TestBalancerNoService48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP1050 = [1] of {int};
	Mutexdef balancer_mutex;
	run mutexMonitor(balancer_mutex);
	run ServeHTTP105(balancer_mutex,child_ServeHTTP1050);
	child_ServeHTTP1050?0;
	stop_process: skip;
	child!0
}
proctype ServeHTTP105(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_nextServer840 = [1] of {int};
	int var_b_handlersb_handlers = -2; // opt var_b_handlersb_handlers
	run nextServer84(b_mutex,child_nextServer840);
	child_nextServer840?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype nextServer84(Mutexdef b_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mutex.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	b_mutex.Unlock!false;
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

