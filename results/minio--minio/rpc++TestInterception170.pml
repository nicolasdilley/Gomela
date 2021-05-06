
// https://github.com/minio/minio/blob/master/pkg/rpc/server_test.go#L170
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInterception1700 = [1] of {int};
	run TestInterception170(child_TestInterception1700)
stop_process:skip
}

proctype TestInterception170(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP1545 = [1] of {int};
	chan child_RegisterAfterFunc1194 = [1] of {int};
	chan child_RegisterValidateRequestFunc1103 = [1] of {int};
	chan child_RegisterInterceptFunc912 = [1] of {int};
	chan child_RegisterCodec811 = [1] of {int};
	chan child_RegisterService1390 = [1] of {int};
	Mutexdef s_services_mutex;
	run mutexMonitor(s_services_mutex);
	run RegisterService139(s_services_mutex,child_RegisterService1390);
	child_RegisterService1390?0;
	run RegisterCodec81(s_services_mutex,child_RegisterCodec811);
	child_RegisterCodec811?0;
	run RegisterInterceptFunc91(s_services_mutex,child_RegisterInterceptFunc912);
	child_RegisterInterceptFunc912?0;
	run RegisterValidateRequestFunc110(s_services_mutex,child_RegisterValidateRequestFunc1103);
	child_RegisterValidateRequestFunc1103?0;
	run RegisterAfterFunc119(s_services_mutex,child_RegisterAfterFunc1194);
	child_RegisterAfterFunc1194?0;
	run ServeHTTP154(s_services_mutex,child_ServeHTTP1545);
	child_ServeHTTP1545?0;
	stop_process: skip;
	child!0
}
proctype RegisterService139(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_register570 = [1] of {int};
	run register57(s_services_mutex,child_register570);
	child_register570?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype register57(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	m_mutex.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
		m_mutex.Unlock!false;
	child!0
}
proctype RegisterCodec81(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RegisterInterceptFunc91(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RegisterValidateRequestFunc110(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RegisterAfterFunc119(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype ServeHTTP154(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get1345 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run get134(s_services_mutex,child_get1345);
	child_get1345?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype get134(Mutexdef m_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	m_mutex.Lock!false;
	m_mutex.Unlock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

