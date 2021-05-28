// num_comm_params=4
// num_mand_comm_params=0
// num_opt_comm_params=4

// git_link=https://github.com/kubernetes/kops/blob/e3fbc2ad043e58cfdcf934e015ef8d5d9e42273e/upup/pkg/fi/context.go#L117
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Render1170 = [1] of {int};
	run Render117(child_Render1170);
	run receiver(child_Render1170)
stop_process:skip
}

proctype Render117(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __mutex;
	int method_Type_NumIn__ = -2; // opt method_Type_NumIn__
	int vType_NumMethod__ = -2; // opt vType_NumMethod__
	int lines = -2; // opt lines
	int changeList = -2; // opt changeList
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
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
					goto stop_process
				:: true;
				fi;
				goto stop_process
			fi
		fi
	:: true;
	fi;
	run mutexMonitor(__mutex);
	

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

proctype receiver(chan c) {
c?0
}

