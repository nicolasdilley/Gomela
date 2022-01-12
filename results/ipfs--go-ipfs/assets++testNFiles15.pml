// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/ipfs/go-ipfs/blob//assets/assets_test.go#L15
#define def_var_fs  ?? // mand fs line 15
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_testNFiles150 = [1] of {int};
	run testNFiles15(def_var_fs,child_testNFiles150);
	run receiver(child_testNFiles150)
stop_process:skip
}

proctype testNFiles15(int var_fs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestNFiles24240 = [1] of {int};
	Wgdef wg;
	run wgMonitor(wg);
		for(i : 0.. var_fs-1) {
		for10: skip;
		wg.update!1;
		run AnonymoustestNFiles2424(wg,child_AnonymoustestNFiles24240);
		run receiver(child_AnonymoustestNFiles24240);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymoustestNFiles2424(Wgdef wg;chan child) {
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

