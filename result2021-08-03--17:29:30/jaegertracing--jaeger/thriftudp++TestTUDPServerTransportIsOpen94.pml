// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/cmd/agent/app/servers/thriftudp/transport_test.go#L94
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestTUDPServerTransportIsOpen940 = [1] of {int};
	run TestTUDPServerTransportIsOpen94(child_TestTUDPServerTransportIsOpen940);
	run receiver(child_TestTUDPServerTransportIsOpen940)
stop_process:skip
}

proctype TestTUDPServerTransportIsOpen94(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTUDPServerTransportIsOpen1121031 = [1] of {int};
	chan child_AnonymousTestTUDPServerTransportIsOpen1051030 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousTestTUDPServerTransportIsOpen105103(wg,child_AnonymousTestTUDPServerTransportIsOpen1051030);
	run receiver(child_AnonymousTestTUDPServerTransportIsOpen1051030);
	run AnonymousTestTUDPServerTransportIsOpen112103(wg,child_AnonymousTestTUDPServerTransportIsOpen1121031);
	run receiver(child_AnonymousTestTUDPServerTransportIsOpen1121031);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTUDPServerTransportIsOpen105103(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTUDPServerTransportIsOpen112103(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

