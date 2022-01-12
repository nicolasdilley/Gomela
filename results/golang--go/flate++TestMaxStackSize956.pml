// num_comm_params=2
// num_mand_comm_params=2
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//compress/flate/deflate_test.go#L956
#define def_var_BestCompression966  ?? // mand BestCompression line 966
#define def_var_HuffmanOnly966  ?? // mand HuffmanOnly line 966
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestMaxStackSize9560 = [1] of {int};
	run TestMaxStackSize956(child_TestMaxStackSize9560);
	run receiver(child_TestMaxStackSize9560)
stop_process:skip
}

proctype TestMaxStackSize956(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestMaxStackSize9699690 = [1] of {int};
	Wgdef wg;
	int var_HuffmanOnly = def_var_HuffmanOnly966; // mand var_HuffmanOnly
	int var_BestCompression = def_var_BestCompression966; // mand var_BestCompression
	run wgMonitor(wg);
		for(i : 0.. var_BestCompression) {
		for10: skip;
		wg.update!1;
		run AnonymousTestMaxStackSize969969(wg,child_AnonymousTestMaxStackSize9699690);
		run receiver(child_AnonymousTestMaxStackSize9699690);
		for10_end: skip
	};
	for10_exit: skip;
		defer1: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestMaxStackSize969969(Wgdef wg;chan child) {
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

