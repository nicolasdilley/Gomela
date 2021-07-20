// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gohugoio/hugo/blob/64f88f3011de5a510d8e6d6bad8ac4a091b11c0c/hugolib/site_test.go#L897
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRefLinking8970 = [1] of {int};
	run TestRefLinking897(child_TestRefLinking8970);
	run receiver(child_TestRefLinking8970)
stop_process:skip
}

proctype TestRefLinking897(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getPage5320 = [1] of {int};
	Mutexdef site_relatedDocsHandler_mu;
	Mutexdef site_language_paramsMu;
	Mutexdef site_h_skipRebuildForFilenamesMu;
	Mutexdef site_h_runningMu;
	run mutexMonitor(site_h_runningMu);
	run mutexMonitor(site_h_skipRebuildForFilenamesMu);
	run mutexMonitor(site_language_paramsMu);
	run mutexMonitor(site_relatedDocsHandler_mu);
	run getPage532(site_h_runningMu,site_h_skipRebuildForFilenamesMu,site_language_paramsMu,site_relatedDocsHandler_mu,child_getPage5320);
	child_getPage5320?0;
	stop_process: skip;
	child!0
}
proctype getPage532(Mutexdef m_h_runningMu;Mutexdef m_h_skipRebuildForFilenamesMu;Mutexdef m_language_paramsMu;Mutexdef m_relatedDocsHandler_mu;chan child) {
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

