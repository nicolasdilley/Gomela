
// https://github.com/ehang-io/nps/blob/master/client/control.go#L184
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewConn1840 = [1] of {int};
	run NewConn184(child_NewConn1840)
stop_process:skip
}

proctype NewConn184(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetUdpSession3640 = [1] of {int};
	Mutexdef sess_mu;
	Mutexdef sess_socketWriteErrorOnce_m;
	Mutexdef sess_socketReadErrorOnce_m;
	Mutexdef sess_dieOnce_m;
	Mutexdef sess_l_socketReadErrorOnce_m;
	Mutexdef sess_l_dieOnce_m;
	Mutexdef sess_l_sessionLock;
	run mutexMonitor(sess_l_sessionLock);
	run mutexMonitor(sess_l_dieOnce_m);
	run mutexMonitor(sess_l_socketReadErrorOnce_m);
	run mutexMonitor(sess_dieOnce_m);
	run mutexMonitor(sess_socketReadErrorOnce_m);
	run mutexMonitor(sess_socketWriteErrorOnce_m);
	run mutexMonitor(sess_mu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			

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
			:: true;
			fi
		fi
	:: true -> 
		

		if
		:: true -> 
			run SetUdpSession364(sess_l_sessionLock,sess_l_dieOnce_m,sess_l_socketReadErrorOnce_m,sess_dieOnce_m,sess_socketReadErrorOnce_m,sess_socketWriteErrorOnce_m,sess_mu,child_SetUdpSession3640);
			child_SetUdpSession3640?0
		:: true;
		fi
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetUdpSession364(Mutexdef sess_l_sessionLock;Mutexdef sess_l_dieOnce_m;Mutexdef sess_l_socketReadErrorOnce_m;Mutexdef sess_dieOnce_m;Mutexdef sess_socketReadErrorOnce_m;Mutexdef sess_socketWriteErrorOnce_m;Mutexdef sess_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

