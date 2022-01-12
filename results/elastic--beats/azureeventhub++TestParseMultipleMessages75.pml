// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/filebeat/input/azureeventhub/input_test.go#L75
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseMultipleMessages750 = [1] of {int};
	run TestParseMultipleMessages75(child_TestParseMultipleMessages750);
	run receiver(child_TestParseMultipleMessages750)
stop_process:skip
}

proctype TestParseMultipleMessages75(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseMultipleMessages2022 = [1] of {int};
	chan child_parseMultipleMessages2021 = [1] of {int};
	chan child_parseMultipleMessages2020 = [1] of {int};
	Mutexdef input_hub_senderMu;
	Mutexdef input_hub_receiverMu;
	Mutexdef input_hub_sender_sender_mu;
	Mutexdef input_processor_handlersMu;
	Mutexdef input_processor_hostMu;
	Mutexdef input_processor_scheduler_receiverMu;
	Mutexdef input_processor_client_senderMu;
	Mutexdef input_processor_client_receiverMu;
	Wgdef input_workerWg;
	Mutexdef input_workerOnce_m;
	int var_messages = -2; // opt var_messages
	run mutexMonitor(input_workerOnce_m);
	run wgMonitor(input_workerWg);
	run mutexMonitor(input_processor_client_receiverMu);
	run mutexMonitor(input_processor_client_senderMu);
	run mutexMonitor(input_processor_scheduler_receiverMu);
	run mutexMonitor(input_processor_hostMu);
	run mutexMonitor(input_processor_handlersMu);
	run mutexMonitor(input_hub_sender_sender_mu);
	run mutexMonitor(input_hub_receiverMu);
	run mutexMonitor(input_hub_senderMu);
	run parseMultipleMessages202(input_workerWg,input_hub_receiverMu,input_hub_sender_sender_mu,input_hub_senderMu,input_processor_client_receiverMu,input_processor_client_senderMu,input_processor_handlersMu,input_processor_hostMu,input_processor_scheduler_receiverMu,input_workerOnce_m,child_parseMultipleMessages2020);
	child_parseMultipleMessages2020?0;
	run parseMultipleMessages202(input_workerWg,input_hub_receiverMu,input_hub_sender_sender_mu,input_hub_senderMu,input_processor_client_receiverMu,input_processor_client_senderMu,input_processor_handlersMu,input_processor_hostMu,input_processor_scheduler_receiverMu,input_workerOnce_m,child_parseMultipleMessages2021);
	child_parseMultipleMessages2021?0;
	run parseMultipleMessages202(input_workerWg,input_hub_receiverMu,input_hub_sender_sender_mu,input_hub_senderMu,input_processor_client_receiverMu,input_processor_client_senderMu,input_processor_handlersMu,input_processor_hostMu,input_processor_scheduler_receiverMu,input_workerOnce_m,child_parseMultipleMessages2022);
	child_parseMultipleMessages2022?0;
	stop_process: skip;
	child!0
}
proctype parseMultipleMessages202(Wgdef a_workerWg;Mutexdef a_hub_receiverMu;Mutexdef a_hub_sender_sender_mu;Mutexdef a_hub_senderMu;Mutexdef a_processor_client_receiverMu;Mutexdef a_processor_client_senderMu;Mutexdef a_processor_handlersMu;Mutexdef a_processor_hostMu;Mutexdef a_processor_scheduler_receiverMu;Mutexdef a_workerOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_arrayObject = -2; // opt var_arrayObject
	

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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

