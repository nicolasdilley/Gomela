
// https://github.com/moby/moby/blob/master/daemon/logger/loggerutils/logfile_test.go#L248
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheckCapacityAndRotate2480 = [1] of {int};
	run TestCheckCapacityAndRotate248(child_TestCheckCapacityAndRotate2480)
stop_process:skip
}

proctype TestCheckCapacityAndRotate248(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3380 = [1] of {int};
	chan child_WriteLogEntry1543 = [1] of {int};
	chan child_WriteLogEntry1542 = [1] of {int};
	chan child_WriteLogEntry1541 = [1] of {int};
	Mutexdef l_notifyReaders_m;
	Mutexdef l_filesRefCounter_mu;
	Mutexdef l_rotateMu;
	Mutexdef l_mu;
	run mutexMonitor(l_mu);
	run mutexMonitor(l_rotateMu);
	run mutexMonitor(l_filesRefCounter_mu);
	run mutexMonitor(l_notifyReaders_m);
	run WriteLogEntry154(l_mu,l_rotateMu,l_filesRefCounter_mu,l_notifyReaders_m,child_WriteLogEntry1541);
	child_WriteLogEntry1541?0;
	run WriteLogEntry154(l_mu,l_rotateMu,l_filesRefCounter_mu,l_notifyReaders_m,child_WriteLogEntry1542);
	child_WriteLogEntry1542?0;
	run WriteLogEntry154(l_mu,l_rotateMu,l_filesRefCounter_mu,l_notifyReaders_m,child_WriteLogEntry1543);
	child_WriteLogEntry1543?0;
	stop_process: skip;
		run Close338(l_mu,l_rotateMu,l_filesRefCounter_mu,l_notifyReaders_m,child_Close3380);
	child_Close3380?0;
	child!0
}
proctype Close338(Mutexdef w_mu;Mutexdef w_rotateMu;Mutexdef w_filesRefCounter_mu;Mutexdef w_notifyReaders_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_mu.Lock!false;
	

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
		w_mu.Unlock!false;
	child!0
}
proctype WriteLogEntry154(Mutexdef w_mu;Mutexdef w_rotateMu;Mutexdef w_filesRefCounter_mu;Mutexdef w_notifyReaders_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkCapacityAndRotate1831 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	w_mu.Lock!false;
	

	if
	:: true -> 
		w_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	run checkCapacityAndRotate183(w_mu,w_rotateMu,w_filesRefCounter_mu,w_notifyReaders_m,child_checkCapacityAndRotate1831);
	child_checkCapacityAndRotate1831?0;
	

	if
	:: true -> 
		w_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	w_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkCapacityAndRotate183(Mutexdef w_mu;Mutexdef w_rotateMu;Mutexdef w_filesRefCounter_mu;Mutexdef w_notifyReaders_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouscheckCapacityAndRotate24201 = [1] of {int};
	

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
	w_rotateMu.Lock!false;
	

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
	run AnonymouscheckCapacityAndRotate2420(w_mu,w_rotateMu,w_filesRefCounter_mu,w_notifyReaders_m,child_AnonymouscheckCapacityAndRotate24201);
	goto stop_process;
	stop_process: skip;
		

	if
	:: true -> 
		w_rotateMu.Unlock!false
	:: true;
	fi;
	child!0
}
proctype AnonymouscheckCapacityAndRotate2420(Mutexdef w_mu;Mutexdef w_rotateMu;Mutexdef w_filesRefCounter_mu;Mutexdef w_notifyReaders_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_rotateMu.Unlock!false;
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

