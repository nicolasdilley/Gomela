// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob//pkg/ssh/ssh_test.go#L190
#define def_var_l_entries421  ?? // mand l.entries line 421
#define def_var_addressStrings  ?? // mand addrs line 414
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSSHTunnelListUpdate1900 = [1] of {int};
	run TestSSHTunnelListUpdate190(child_TestSSHTunnelListUpdate1900);
	run receiver(child_TestSSHTunnelListUpdate1900)
stop_process:skip
}

proctype TestSSHTunnelListUpdate190(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkTunnelsCorrect2229 = [1] of {int};
	chan child_Update4148 = [1] of {int};
	int var_addressStrings = def_var_addressStrings;
	chan child_checkTunnelsCorrect2227 = [1] of {int};
	chan child_Update4146 = [1] of {int};
	int var_addressStrings = def_var_addressStrings;
	chan child_checkTunnelsCorrect2225 = [1] of {int};
	chan child_Update4144 = [1] of {int};
	int var_addressStrings = def_var_addressStrings;
	chan child_checkTunnelsCorrect2223 = [1] of {int};
	chan child_Update4142 = [1] of {int};
	int var_addressStrings = def_var_addressStrings;
	chan child_checkTunnelsCorrect2221 = [1] of {int};
	chan child_Update4140 = [1] of {int};
	int var_addressStrings = def_var_addressStrings;
	Mutexdef l_tunnelsLock;
	run mutexMonitor(l_tunnelsLock);
	run Update414(l_tunnelsLock,var_addressStrings,child_Update4140);
	child_Update4140?0;
	run checkTunnelsCorrect222(l_tunnelsLock,child_checkTunnelsCorrect2221);
	child_checkTunnelsCorrect2221?0;
	run Update414(l_tunnelsLock,var_addressStrings,child_Update4142);
	child_Update4142?0;
	run checkTunnelsCorrect222(l_tunnelsLock,child_checkTunnelsCorrect2223);
	child_checkTunnelsCorrect2223?0;
	run Update414(l_tunnelsLock,var_addressStrings,child_Update4144);
	child_Update4144?0;
	run checkTunnelsCorrect222(l_tunnelsLock,child_checkTunnelsCorrect2225);
	child_checkTunnelsCorrect2225?0;
	run Update414(l_tunnelsLock,var_addressStrings,child_Update4146);
	child_Update4146?0;
	run checkTunnelsCorrect222(l_tunnelsLock,child_checkTunnelsCorrect2227);
	child_checkTunnelsCorrect2227?0;
	run Update414(l_tunnelsLock,var_addressStrings,child_Update4148);
	child_Update4148?0;
	run checkTunnelsCorrect222(l_tunnelsLock,child_checkTunnelsCorrect2229);
	child_checkTunnelsCorrect2229?0;
	stop_process: skip;
	child!0
}
proctype Update414(Mutexdef l_tunnelsLock;int var_addrs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousUpdate44702 = [1] of {int};
	chan child_AnonymousUpdate43100 = [1] of {int};
	int var_l_entries = def_var_l_entries421; // mand var_l_entries
	l_tunnelsLock.Lock!false;
		for(i : 0.. var_addrs-1) {
		for20: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				run AnonymousUpdate4310(l_tunnelsLock,child_AnonymousUpdate43100);
				run receiver(child_AnonymousUpdate43100)
			:: true;
			fi
		:: true;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
		for(i : 0.. var_l_entries-1) {
		for30: skip;
		

		if
		:: true -> 
			run AnonymousUpdate4470(l_tunnelsLock,child_AnonymousUpdate44702);
			run receiver(child_AnonymousUpdate44702)
		fi;
		for30_end: skip
	};
	for30_exit: skip;
		defer1: skip;
	l_tunnelsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousUpdate4310(Mutexdef l_tunnelsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createAndAddTunnel4610 = [1] of {int};
	run createAndAddTunnel461(l_tunnelsLock,child_createAndAddTunnel4610);
	child_createAndAddTunnel4610?0;
	stop_process: skip;
	child!0
}
proctype createAndAddTunnel461(Mutexdef l_tunnelsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		l_tunnelsLock.Lock!false;
		l_tunnelsLock.Unlock!false;
		goto stop_process
	:: true;
	fi;
	l_tunnelsLock.Lock!false;
	l_tunnelsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousUpdate4470(Mutexdef l_tunnelsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype checkTunnelsCorrect222(Mutexdef tunnelList_tunnelsLock;chan child) {
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

