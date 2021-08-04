// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/transport_test.go#L30
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestProtocolHandshake300 = [1] of {int};
	run TestProtocolHandshake30(child_TestProtocolHandshake300);
	run receiver(child_TestProtocolHandshake300)
stop_process:skip
}

proctype TestProtocolHandshake30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestProtocolHandshake75401 = [1] of {int};
	chan child_AnonymousTestProtocolHandshake49400 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestProtocolHandshake4940(wg,child_AnonymousTestProtocolHandshake49400);
	run receiver(child_AnonymousTestProtocolHandshake49400);
	run AnonymousTestProtocolHandshake7540(wg,child_AnonymousTestProtocolHandshake75401);
	run receiver(child_AnonymousTestProtocolHandshake75401);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestProtocolHandshake4940(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestProtocolHandshake7540(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	wg.update!-1;
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

proctype receiver(chan c) {
c?0
}

