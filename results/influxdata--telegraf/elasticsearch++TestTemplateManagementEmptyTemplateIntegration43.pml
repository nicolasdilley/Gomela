// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/outputs/elasticsearch/elasticsearch_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTemplateManagementEmptyTemplateIntegration430 = [1] of {int};
	run TestTemplateManagementEmptyTemplateIntegration43(child_TestTemplateManagementEmptyTemplateIntegration430);
	run receiver(child_TestTemplateManagementEmptyTemplateIntegration430)
stop_process:skip
}

proctype TestTemplateManagementEmptyTemplateIntegration43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_manageTemplate3220 = [1] of {int};
	Mutexdef e_Client_mu;
	Mutexdef e_Client_connsMu;
	run mutexMonitor(e_Client_connsMu);
	run mutexMonitor(e_Client_mu);
	run manageTemplate322(e_Client_connsMu,e_Client_mu,child_manageTemplate3220);
	child_manageTemplate3220?0;
	stop_process: skip;
	child!0
}
proctype manageTemplate322(Mutexdef a_Client_connsMu;Mutexdef a_Client_mu;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

