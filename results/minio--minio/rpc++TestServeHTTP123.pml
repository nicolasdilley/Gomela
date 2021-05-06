
// https://github.com/minio/minio/blob/master/pkg/rpc/server_test.go#L123
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServeHTTP1230 = [1] of {int};
	run TestServeHTTP123(child_TestServeHTTP1230)
stop_process:skip
}

proctype TestServeHTTP123(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP1544 = [1] of {int};
	chan child_ServeHTTP1543 = [1] of {int};
	chan child_ServeHTTP1542 = [1] of {int};
	chan child_RegisterCodec811 = [1] of {int};
	chan child_RegisterService1390 = [1] of {int};
	Mutexdef s_services_mutex;
	run mutexMonitor(s_services_mutex);
	run RegisterService139(s_services_mutex,child_RegisterService1390);
	child_RegisterService1390?0;
	run RegisterCodec81(s_services_mutex,child_RegisterCodec811);
	child_RegisterCodec811?0;
	run ServeHTTP154(s_services_mutex,child_ServeHTTP1542);
	child_ServeHTTP1542?0;
	run ServeHTTP154(s_services_mutex,child_ServeHTTP1543);
	child_ServeHTTP1543?0;
	run ServeHTTP154(s_services_mutex,child_ServeHTTP1544);
	child_ServeHTTP1544?0;
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
proctype ServeHTTP154(Mutexdef s_services_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get1342 = [1] of {int};
	

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
	run get134(s_services_mutex,child_get1342);
	child_get1342?0;
	

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

