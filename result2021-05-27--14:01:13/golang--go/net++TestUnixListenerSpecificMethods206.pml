// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/protoconn_test.go#L206
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnixListenerSpecificMethods2060 = [1] of {int};
	run TestUnixListenerSpecificMethods206(child_TestUnixListenerSpecificMethods2060);
	run receiver(child_TestUnixListenerSpecificMethods2060)
stop_process:skip
}

proctype TestUnixListenerSpecificMethods206(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2690 = [1] of {int};
	chan child_File3035 = [1] of {int};
	chan child_AcceptUnix2434 = [1] of {int};
	chan child_Accept2563 = [1] of {int};
	chan child_SetDeadline2862 = [1] of {int};
	chan child_Addr2821 = [1] of {int};
	Mutexdef ln_unlinkOnce_m;
	run mutexMonitor(ln_unlinkOnce_m);
	run Addr282(ln_unlinkOnce_m,child_Addr2821);
	child_Addr2821?0;
	run SetDeadline286(ln_unlinkOnce_m,child_SetDeadline2862);
	child_SetDeadline2862?0;
	run Accept256(ln_unlinkOnce_m,child_Accept2563);
	child_Accept2563?0;
	run AcceptUnix243(ln_unlinkOnce_m,child_AcceptUnix2434);
	child_AcceptUnix2434?0;
	run File303(ln_unlinkOnce_m,child_File3035);
	child_File3035?0;
		defer1: skip;
		defer1: skip;
	run Close269(ln_unlinkOnce_m,child_Close2690);
	child_Close2690?0;
	stop_process: skip;
	child!0
}
proctype Close269(Mutexdef l_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close1741 = [1] of {int};
	chan child_ok2270 = [1] of {int};
	run ok227(l_unlinkOnce_m,child_ok2270);
	child_ok2270?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run close174(l_unlinkOnce_m,child_close1741);
	child_close1741?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ok227(Mutexdef ln_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype close174(Mutexdef ln_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Addr282(Mutexdef l_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetDeadline286(Mutexdef l_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ok2272 = [1] of {int};
	run ok227(l_unlinkOnce_m,child_ok2272);
	child_ok2272?0;
	

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
proctype Accept256(Mutexdef l_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_accept1664 = [1] of {int};
	chan child_ok2273 = [1] of {int};
	run ok227(l_unlinkOnce_m,child_ok2273);
	child_ok2273?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run accept166(l_unlinkOnce_m,child_accept1664);
	child_accept1664?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype accept166(Mutexdef ln_unlinkOnce_m;chan child) {
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
proctype AcceptUnix243(Mutexdef l_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_accept1665 = [1] of {int};
	chan child_ok2274 = [1] of {int};
	run ok227(l_unlinkOnce_m,child_ok2274);
	child_ok2274?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run accept166(l_unlinkOnce_m,child_accept1665);
	child_accept1665?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype File303(Mutexdef l_unlinkOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_file1946 = [1] of {int};
	chan child_ok2275 = [1] of {int};
	run ok227(l_unlinkOnce_m,child_ok2275);
	child_ok2275?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run file194(l_unlinkOnce_m,child_file1946);
	child_file1946?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype file194(Mutexdef ln_unlinkOnce_m;chan child) {
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

