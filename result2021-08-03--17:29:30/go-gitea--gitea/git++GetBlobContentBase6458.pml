// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob/ed393779004335a0afcca0dfac48937db41fabd6/modules/git/blob.go#L58
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetBlobContentBase64580 = [1] of {int};
	run GetBlobContentBase6458(child_GetBlobContentBase64580);
	run receiver(child_GetBlobContentBase64580)
stop_process:skip
}

proctype GetBlobContentBase6458(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGetBlobContentBase6468650 = [1] of {int};
	Mutexdef pw_p_wrMu;
	Mutexdef pr_p_wrMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(pr_p_wrMu);
	run mutexMonitor(pw_p_wrMu);
	run AnonymousGetBlobContentBase646865(pr_p_wrMu,pw_p_wrMu,child_AnonymousGetBlobContentBase6468650);
	run receiver(child_AnonymousGetBlobContentBase6468650);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousGetBlobContentBase646865(Mutexdef pr_p_wrMu;Mutexdef pw_p_wrMu;chan child) {
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

proctype receiver(chan c) {
c?0
}

