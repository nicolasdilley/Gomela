// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/netutil/conn_test.go#L24
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_createSocketPair240 = [1] of {int};
	run createSocketPair24(child_createSocketPair240);
	run receiver(child_createSocketPair240)
stop_process:skip
}

proctype createSocketPair24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouscreateSocketPair48331 = [1] of {int};
	chan child_AnonymouscreateSocketPair37330 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
	wg.update!1;
	run AnonymouscreateSocketPair3733(wg,child_AnonymouscreateSocketPair37330);
	run receiver(child_AnonymouscreateSocketPair37330);
	wg.update!1;
	run AnonymouscreateSocketPair4833(wg,child_AnonymouscreateSocketPair48331);
	run receiver(child_AnonymouscreateSocketPair48331);
	wg.wait?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouscreateSocketPair3733(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymouscreateSocketPair4833(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

